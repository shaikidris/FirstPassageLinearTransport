#!/usr/bin/env python3
"""Partition Lean source modules by recursive theorem-library reachability.

The scanner has two independent inputs:

* the literal local import graph, rooted at the canonical ``Main``, the
  retained all-prefix theorem, and the historical legacy root; and
* ``PaperDependencyAudit.trace``, whose compiled kernel/source graph classifies
  declarations inside mixed canonical modules.

The default mode is read-only.  ``--apply-modules`` relocates only complete
top-level modules that are outside the canonical import closure but required
by exactly one retained optional library.  It updates Lean imports and Lake
module globs transactionally, then rebuilds all three libraries.  It never
deletes a declaration and never treats unreachability as permission to remove
standalone mathematics.

``--apply-declarations`` consumes exact source ranges emitted by Lean, removes
outside-cone declaration blocks from mixed canonical files, and preserves them
under ``Extras/Unreachable``.  The generated extras import their canonical
source modules, so retained declarations remain available without redefinition.
All edits are rolled back if any canonical, extras, alternate, or legacy build
fails.
"""

from __future__ import annotations

import argparse
import json
import re
import shutil
import subprocess
import sys
import tempfile
from dataclasses import asdict, dataclass
from pathlib import Path
from typing import Iterable


PROJECT_PREFIX = "FirstPassageLinearTransport"
ROOTS = {
    "canonical": ("FirstPassageLinearTransport.Main",),
    "alternate": ("FirstPassageLinearTransport.Alternates.AllPrefix.Main",),
    "legacy": ("FirstPassageLinearTransport.Legacy",),
}
AUDIT_MODULES = {
    "FirstPassageLinearTransport.Alternates.AllPrefix.Audit",
    "FirstPassageLinearTransport.PaperAudit",
    "FirstPassageLinearTransport.PaperDependencyAudit",
    "FirstPassageLinearTransport.TimeoutEndpointAudit",
    "FirstPassageLinearTransport.V3CutVertexAudit",
}
EXTRAS_ROOT = "FirstPassageLinearTransport.Extras.Unreachable"
IMPORT_RE = re.compile(
    r"^(?P<prefix>\s*(?:(?:public|private)\s+)?import\s+)"
    r"(?P<module>[A-Za-z0-9_'.]+)(?P<suffix>\s*)$",
    re.MULTILINE,
)


@dataclass(frozen=True)
class ModuleInfo:
    name: str
    path: str
    imports: tuple[str, ...]


@dataclass(frozen=True)
class DeclarationInfo:
    classification: str
    kind: str
    module: str
    line: int
    name: str
    start_line: int | None = None
    start_column: int | None = None
    end_line: int | None = None
    end_column: int | None = None


@dataclass(frozen=True)
class MoveInfo:
    classification: str
    old_module: str
    new_module: str
    old_path: str
    new_path: str


def module_name(lean_root: Path, source: Path) -> str:
    return ".".join(source.relative_to(lean_root).with_suffix("").parts)


def module_path(lean_root: Path, name: str) -> Path:
    return lean_root.joinpath(*name.split(".")).with_suffix(".lean")


def parse_imports(text: str) -> tuple[str, ...]:
    return tuple(match.group("module") for match in IMPORT_RE.finditer(text))


def discover_modules(lean_root: Path) -> dict[str, ModuleInfo]:
    modules: dict[str, ModuleInfo] = {}
    package_root = lean_root / PROJECT_PREFIX
    for source in sorted(package_root.rglob("*.lean")):
        name = module_name(lean_root, source)
        modules[name] = ModuleInfo(
            name=name,
            path=str(source.relative_to(lean_root.parent)),
            imports=parse_imports(source.read_text(encoding="utf-8")),
        )
    return modules


def closure(modules: dict[str, ModuleInfo], roots: Iterable[str]) -> set[str]:
    pending = list(roots)
    seen: set[str] = set()
    while pending:
        current = pending.pop()
        if current in seen:
            continue
        if current not in modules:
            raise SystemExit(f"local root/import has no source file: {current}")
        seen.add(current)
        pending.extend(
            dependency
            for dependency in modules[current].imports
            if dependency in modules and dependency not in seen
        )
    return seen


def trace_messages(path: Path) -> list[str]:
    raw = path.read_text(encoding="utf-8", errors="replace")
    if path.suffix == ".trace":
        payload = json.loads(raw)
        return [entry.get("message", "") for entry in payload.get("log", [])]
    return raw.splitlines()


def diagnostic_payload(message: str) -> str:
    return message.rsplit(": ", 1)[-1].strip()


def parse_declarations(trace: Path) -> list[DeclarationInfo]:
    prefixes = {
        "MAIN_SOURCE_DECLARATION": "main",
        "PAPER_ONLY_SOURCE_DECLARATION": "paper_only",
        "COMPANION_ONLY_SOURCE_DECLARATION": "companion_only",
        "UNREACHABLE_SOURCE_DECLARATION": "outside",
    }
    rows: list[DeclarationInfo] = []
    for message in trace_messages(trace):
        fields = diagnostic_payload(message).split("\t")
        if len(fields) not in (4, 5) or fields[0] not in prefixes:
            continue
        module, line_text = fields[2].rsplit(":", 1)
        range_values: tuple[int | None, int | None, int | None, int | None] = (
            None, None, None, None
        )
        if len(fields) == 5 and fields[4].startswith("RANGE="):
            match = re.fullmatch(
                r"RANGE=(\d+):(\d+)-(\d+):(\d+)", fields[4]
            )
            if not match:
                raise SystemExit(f"malformed declaration range: {fields[4]}")
            range_values = tuple(int(value) for value in match.groups())
        rows.append(
            DeclarationInfo(
                classification=prefixes[fields[0]],
                kind=fields[1],
                module=module,
                line=int(line_text),
                name=fields[3],
                start_line=range_values[0],
                start_column=range_values[1],
                end_line=range_values[2],
                end_column=range_values[3],
            )
        )
    return rows


def classify_modules(
    modules: dict[str, ModuleInfo],
) -> tuple[dict[str, set[str]], dict[str, str]]:
    closures = {group: closure(modules, roots) for group, roots in ROOTS.items()}
    classification: dict[str, str] = {}
    for name in modules:
        if name in closures["canonical"]:
            classification[name] = "canonical"
        elif name == EXTRAS_ROOT or name.startswith(EXTRAS_ROOT + "."):
            classification[name] = "archive"
        elif name in closures["alternate"]:
            classification[name] = "alternate_only"
        elif name in closures["legacy"]:
            classification[name] = "legacy_only"
        elif name in AUDIT_MODULES:
            classification[name] = "audit"
        elif name.startswith(f"{PROJECT_PREFIX}.Alternates."):
            classification[name] = "alternate_only"
        elif name.startswith(f"{PROJECT_PREFIX}.Legacy."):
            classification[name] = "legacy_only"
        else:
            classification[name] = "unclassified"
    return closures, classification


def relocation_plan(
    repo: Path,
    lean_root: Path,
    modules: dict[str, ModuleInfo],
    classification: dict[str, str],
) -> list[MoveInfo]:
    moves: list[MoveInfo] = []
    package = PROJECT_PREFIX
    declared_roots = {root for roots in ROOTS.values() for root in roots}
    for name, group in sorted(classification.items()):
        # Root aggregators define the public entry points of their libraries.
        # They are classifications roots, never implementation payloads.
        if name in declared_roots:
            continue
        source = module_path(lean_root, name)
        relative = source.relative_to(lean_root / package)
        if len(relative.parts) != 1:
            continue
        stem = source.stem
        if group == "alternate_only":
            new_module = f"{package}.Alternates.AllPrefix.Implementation.{stem}"
        elif group == "legacy_only":
            new_module = f"{package}.Legacy.Implementation.{stem}"
        else:
            continue
        target = module_path(lean_root, new_module)
        moves.append(
            MoveInfo(
                classification=group,
                old_module=name,
                new_module=new_module,
                old_path=str(source.relative_to(repo)),
                new_path=str(target.relative_to(repo)),
            )
        )
    return moves


def is_environment_registered(lean_root: Path, row: DeclarationInfo) -> bool:
    """Whether elaboration may consume the declaration through an attribute table."""
    if row.start_line is None:
        return False
    source = module_path(lean_root, row.module)
    lines = source.read_text(encoding="utf-8").splitlines()
    if not (0 < row.start_line <= len(lines)):
        return False
    command = lines[row.start_line - 1].lstrip()
    return command.startswith("@[") or bool(
        re.match(r"(?:(?:noncomputable|local)\s+)*instance\b", command)
    )


def build_manifest(repo: Path, trace: Path) -> dict[str, object]:
    lean_root = repo / "lean"
    modules = discover_modules(lean_root)
    closures, classification = classify_modules(modules)
    declarations = parse_declarations(trace)
    moves = relocation_plan(repo, lean_root, modules, classification)
    counts = {
        group: sum(1 for value in classification.values() if value == group)
        for group in sorted(set(classification.values()))
    }
    outside_by_module: dict[str, int] = {}
    environment_registered: list[DeclarationInfo] = []
    for row in declarations:
        if row.classification == "outside":
            if is_environment_registered(lean_root, row):
                environment_registered.append(row)
            else:
                outside_by_module[row.module] = outside_by_module.get(row.module, 0) + 1
    return {
        "roots": {key: list(value) for key, value in ROOTS.items()},
        "closure_sizes": {key: len(value) for key, value in closures.items()},
        "module_class_counts": counts,
        "modules": [asdict(modules[name]) | {"classification": classification[name]}
                    for name in sorted(modules)],
        "module_moves": [asdict(move) for move in moves],
        "declarations": [asdict(row) for row in declarations],
        "environment_registered_declarations": [
            asdict(row) for row in environment_registered
        ],
        "outside_declarations_by_module": dict(sorted(outside_by_module.items())),
    }


def render_summary(manifest: dict[str, object]) -> str:
    lines = [
        "# Lean reachability partition",
        "",
        "The module graph is recursive from the declared canonical, alternate,",
        "and legacy roots. Declaration rows come from compiled kernel and `.ilean`",
        "source-reference reachability, not textual name matching.",
        "",
        "## Module closures",
        "",
    ]
    for group, size in manifest["closure_sizes"].items():
        lines.append(f"- `{group}`: {size} modules")
    lines.extend([
        "",
        "These closure sizes overlap: the optional libraries reuse the canonical",
        "foundation.  The disjoint physical source classification is:",
        "",
    ])
    for group, size in manifest["module_class_counts"].items():
        lines.append(f"- `{group}`: {size} source modules")
    lines.extend(["", "## Planned physical module moves", ""])
    moves = manifest["module_moves"]
    if moves:
        for move in moves:
            lines.append(
                f"- `{move['old_module']}` → `{move['new_module']}` "
                f"({move['classification']})"
            )
    else:
        lines.append("- none")
    lines.extend(["", "## Mixed canonical declaration queue", ""])
    outside = manifest["outside_declarations_by_module"]
    if outside:
        for module, count in sorted(outside.items(), key=lambda item: (-item[1], item[0])):
            lines.append(f"- `{module}`: {count} outside-cone declarations")
    else:
        lines.append("- none")
    lines.extend(["", "## Environment-registered canonical declarations", ""])
    registered = manifest["environment_registered_declarations"]
    if registered:
        for row in registered:
            lines.append(f"- `{row['name']}` ({row['kind']})")
    else:
        lines.append("- none")
    return "\n".join(lines) + "\n"


def rewrite_module_references(text: str, mapping: dict[str, str]) -> str:
    def replace_import(match: re.Match[str]) -> str:
        old = match.group("module")
        return f"{match.group('prefix')}{mapping.get(old, old)}{match.group('suffix')}"

    text = IMPORT_RE.sub(replace_import, text)
    for old, new in sorted(mapping.items(), key=lambda item: -len(item[0])):
        text = text.replace(f"`{old}", f"`{new}")
    return text


def run_checked(command: list[str], cwd: Path) -> None:
    print(f"+ {' '.join(command)}", flush=True)
    process = subprocess.run(command, cwd=cwd, text=True, capture_output=True)
    if process.returncode:
        tail = "\n".join((process.stdout + process.stderr).splitlines()[-120:])
        raise RuntimeError(f"command failed ({process.returncode}): {' '.join(command)}\n{tail}")


def refresh_trace_if_stale(repo: Path, trace: Path, force_existing: bool) -> None:
    if force_existing:
        if not trace.exists():
            raise SystemExit(f"dependency trace not found: {trace}")
        return
    package_root = repo / "lean" / PROJECT_PREFIX
    newest_source = max(
        (path.stat().st_mtime for path in package_root.rglob("*.lean")),
        default=0,
    )
    if not trace.exists() or trace.stat().st_mtime < newest_source:
        run_checked(
            ["lake", "build", "FirstPassageLinearTransport.PaperDependencyAudit"],
            repo / "lean",
        )


def declaration_intervals(
    lines: list[str], rows: Iterable[DeclarationInfo]
) -> list[tuple[int, int]]:
    """Return merged zero-based, end-exclusive full-line declaration spans."""
    intervals: list[tuple[int, int]] = []
    for row in rows:
        if row.start_line is None or row.end_line is None:
            raise RuntimeError(
                f"missing exact source range for {row.name}; rebuild PaperDependencyAudit"
            )
        if row.start_line <= 0 or row.end_line < row.start_line:
            raise RuntimeError(f"invalid source range for {row.name}")
        start = row.start_line - 1
        stop = row.end_line

        # Lean's declaration range begins at attributes/theorem syntax, not at
        # the attached doc comment. Move a contiguous `/-- ... -/` with its
        # declaration so extraction never reattaches documentation incorrectly.
        probe = start - 1
        while probe >= 0 and not lines[probe].strip():
            probe -= 1
        if probe >= 0 and lines[probe].rstrip().endswith("-/"):
            doc_start = probe
            while doc_start >= 0 and "/--" not in lines[doc_start]:
                doc_start -= 1
            if doc_start >= 0 and "/--" in lines[doc_start]:
                start = doc_start
        intervals.append((start, stop))

    merged: list[tuple[int, int]] = []
    for start, stop in sorted(intervals):
        if merged and start <= merged[-1][1]:
            merged[-1] = (merged[-1][0], max(stop, merged[-1][1]))
        else:
            merged.append((start, stop))
    return merged


def without_intervals(lines: list[str], intervals: Iterable[tuple[int, int]]) -> list[str]:
    removed: set[int] = set()
    for start, stop in intervals:
        removed.update(range(start, stop))
    return [line for index, line in enumerate(lines) if index not in removed]


def insert_import(text: str, module: str) -> str:
    if re.search(rf"^\s*import\s+{re.escape(module)}\s*$", text, re.MULTILINE):
        return text
    imports = list(IMPORT_RE.finditer(text))
    if not imports:
        raise RuntimeError(f"cannot insert import {module}: source has no imports")
    position = imports[-1].end()
    return text[:position] + f"\nimport {module}" + text[position:]


def extras_lake_block() -> str:
    return f'''\n/-- Source-preserving archive of declarations outside the referee-facing roots.
Generated by `audits/partition_lean_reachability.py`; excluded from the default
canonical build. -/
lean_lib FirstPassageLinearTransportExtras where
  roots := #[`{EXTRAS_ROOT}]
  moreLeanArgs := #["-DmaxHeartbeats=20000000"]
  globs := #[.submodules `FirstPassageLinearTransport.Extras]\n'''


def apply_declaration_extraction(repo: Path, manifest: dict[str, object], verify: bool) -> None:
    declarations = [DeclarationInfo(**row) for row in manifest["declarations"]]
    lean_root = repo / "lean"
    outside = [
        row for row in declarations
        if row.classification == "outside" and not is_environment_registered(lean_root, row)
    ]
    if not outside:
        print("No outside-cone declarations require extraction.")
        return
    if any(row.start_line is None for row in declarations):
        raise RuntimeError(
            "declaration trace has no exact ranges; rebuild PaperDependencyAudit first"
        )

    package_root = lean_root / PROJECT_PREFIX
    by_module: dict[str, list[DeclarationInfo]] = {}
    for row in declarations:
        by_module.setdefault(row.module, []).append(row)

    targets: dict[Path, str] = {}
    canonical_edits: dict[Path, str] = {}
    extra_modules: list[str] = []
    for module, rows in sorted(by_module.items()):
        outside_rows = [
            row for row in rows
            if row.classification == "outside" and not is_environment_registered(lean_root, row)
        ]
        if not outside_rows:
            continue
        source = module_path(lean_root, module)
        original_lines = source.read_text(encoding="utf-8").splitlines(keepends=True)
        outside_intervals = declaration_intervals(original_lines, outside_rows)
        retained_intervals = declaration_intervals(
            original_lines, [row for row in rows if row not in outside_rows]
        )
        canonical_edits[source] = "".join(
            without_intervals(original_lines, outside_intervals)
        )

        stem = module.rsplit(".", 1)[-1]
        extra_module = f"{EXTRAS_ROOT}.{stem}"
        extra_path = module_path(lean_root, extra_module)
        if extra_path.exists():
            raise RuntimeError(f"refusing to overwrite existing extraction {extra_path}")
        extra_text = "".join(without_intervals(original_lines, retained_intervals))
        extra_text = insert_import(extra_text, module)
        marker = (
            "/- Generated source-preserving extraction: declarations in this "
            "module are outside the canonical referee-facing roots. -/\n"
        )
        first_import = IMPORT_RE.search(extra_text)
        if first_import:
            extra_text = extra_text[:first_import.start()] + marker + extra_text[first_import.start():]
        targets[extra_path] = extra_text
        extra_modules.append(extra_module)

    aggregator = module_path(lean_root, EXTRAS_ROOT)
    aggregator_text = "\n".join(f"import {module}" for module in sorted(extra_modules))
    aggregator_text += (
        "\n\n/-! Declarations mechanically extracted from mixed canonical modules.\n"
        "This library is preserved for regression and research use and is not in\n"
        "the canonical `Main` build. -/\n"
    )
    targets[aggregator] = aggregator_text

    # Optional implementations may consume extracted declarations. Importing
    # one archive root in every non-canonical source is intentionally simple
    # and keeps the canonical dependency graph untouched.
    optional_sources = sorted((package_root / "Alternates").rglob("*.lean"))
    optional_sources += sorted((package_root / "Legacy").rglob("*.lean"))
    optional_sources += [package_root / "Legacy.lean"]
    v3_audit = package_root / "V3CutVertexAudit.lean"
    if v3_audit.exists():
        optional_sources.append(v3_audit)

    lakefile = lean_root / "lakefile.lean"
    editable = sorted(set(canonical_edits) | set(optional_sources) | {lakefile})
    original = {path: path.read_bytes() for path in editable}
    created: list[Path] = []
    try:
        for path, text in canonical_edits.items():
            path.write_text(text, encoding="utf-8")
        for path in optional_sources:
            path.write_text(insert_import(path.read_text(encoding="utf-8"), EXTRAS_ROOT), encoding="utf-8")
        lake_text = lakefile.read_text(encoding="utf-8")
        if "lean_lib FirstPassageLinearTransportExtras" not in lake_text:
            marker = "/-- Optional retained V3.1 route."
            position = lake_text.find(marker)
            if position < 0:
                raise RuntimeError("cannot find alternate-library insertion marker in lakefile")
            lake_text = lake_text[:position] + extras_lake_block() + "\n" + lake_text[position:]
            lakefile.write_text(lake_text, encoding="utf-8")
        for path, text in targets.items():
            path.parent.mkdir(parents=True, exist_ok=True)
            path.write_text(text, encoding="utf-8")
            created.append(path)

        if verify:
            run_checked(["lake", "build"], lean_root)
            run_checked(["lake", "build", "FirstPassageLinearTransportExtras"], lean_root)
            run_checked(["lake", "build", "FirstPassageLinearTransportAlternates"], lean_root)
            run_checked(["lake", "build", "FirstPassageLinearTransportLegacy"], lean_root)
            refreshed = build_manifest(
                repo,
                lean_root / ".lake/build/lib/FirstPassageLinearTransport/PaperDependencyAudit.trace",
            )
            if refreshed["outside_declarations_by_module"]:
                raise RuntimeError(
                    "canonical audit still reports outside declarations after extraction: "
                    f"{refreshed['outside_declarations_by_module']}"
                )
    except Exception:
        for path, content in original.items():
            path.parent.mkdir(parents=True, exist_ok=True)
            path.write_bytes(content)
        for path in created:
            if path.exists() and path not in original:
                path.unlink()
        raise


def apply_module_moves(repo: Path, manifest: dict[str, object], verify: bool) -> None:
    moves = [MoveInfo(**row) for row in manifest["module_moves"]]
    if not moves:
        print("No module moves are required.")
        return
    mapping = {move.old_module: move.new_module for move in moves}
    lean_root = repo / "lean"
    sources = sorted((lean_root / PROJECT_PREFIX).rglob("*.lean"))
    editable = sources + [lean_root / "lakefile.lean"]
    original = {path: path.read_bytes() for path in editable}
    created: list[Path] = []
    try:
        for path in editable:
            text = path.read_text(encoding="utf-8")
            rewritten = rewrite_module_references(text, mapping)
            if rewritten != text:
                path.write_text(rewritten, encoding="utf-8")
        for move in moves:
            source = repo / move.old_path
            target = repo / move.new_path
            if target.exists():
                raise RuntimeError(f"refusing to overwrite {target}")
            target.parent.mkdir(parents=True, exist_ok=True)
            source.rename(target)
            created.append(target)
        if verify:
            run_checked(["lake", "build"], lean_root)
            run_checked(["lake", "build", "FirstPassageLinearTransportAlternates"], lean_root)
            run_checked(["lake", "build", "FirstPassageLinearTransportLegacy"], lean_root)
    except Exception:
        for path, content in original.items():
            path.parent.mkdir(parents=True, exist_ok=True)
            path.write_bytes(content)
        for target in created:
            if target.exists() and target not in original:
                target.unlink()
        raise


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--repo",
        type=Path,
        default=Path(__file__).resolve().parents[1],
        help="FirstPassageLinearTransport repository root",
    )
    parser.add_argument(
        "--trace",
        type=Path,
        help="PaperDependencyAudit log/trace; defaults to the current Lake trace",
    )
    parser.add_argument("--json", type=Path, help="write the machine-readable manifest")
    parser.add_argument("--markdown", type=Path, help="write the human-readable summary")
    parser.add_argument(
        "--check",
        action="store_true",
        help="fail if a module/declaration is still movable or unclassified",
    )
    parser.add_argument(
        "--apply-modules",
        action="store_true",
        help="transactionally move complete alternate/legacy-only top-level modules",
    )
    parser.add_argument(
        "--apply-declarations",
        action="store_true",
        help="transactionally extract outside-cone declarations from mixed files",
    )
    parser.add_argument(
        "--no-verify",
        action="store_true",
        help="skip post-move Lake builds (not recommended)",
    )
    parser.add_argument(
        "--use-existing-trace",
        action="store_true",
        help="do not refresh a missing/stale compiled dependency trace",
    )
    args = parser.parse_args()

    repo = args.repo.resolve()
    trace = args.trace or (
        repo / "lean/.lake/build/lib/FirstPassageLinearTransport/PaperDependencyAudit.trace"
    )
    refresh_trace_if_stale(repo, trace, force_existing=args.use_existing_trace)
    manifest = build_manifest(repo, trace)
    summary = render_summary(manifest)
    if args.json:
        args.json.parent.mkdir(parents=True, exist_ok=True)
        args.json.write_text(json.dumps(manifest, indent=2) + "\n", encoding="utf-8")
    if args.markdown:
        args.markdown.parent.mkdir(parents=True, exist_ok=True)
        args.markdown.write_text(summary, encoding="utf-8")
    print(summary, end="")
    if args.apply_modules:
        apply_module_moves(repo, manifest, verify=not args.no_verify)
    if args.apply_declarations:
        apply_declaration_extraction(repo, manifest, verify=not args.no_verify)
    if args.check:
        if args.apply_modules or args.apply_declarations:
            manifest = build_manifest(repo, trace)
        failures: list[str] = []
        if manifest["module_moves"]:
            failures.append(f"{len(manifest['module_moves'])} module moves remain")
        movable = sum(manifest["outside_declarations_by_module"].values())
        if movable:
            failures.append(f"{movable} movable outside-cone declarations remain")
        unclassified = manifest["module_class_counts"].get("unclassified", 0)
        if unclassified:
            failures.append(f"{unclassified} modules are unclassified")
        if failures:
            raise SystemExit("reachability partition check failed: " + "; ".join(failures))


if __name__ == "__main__":
    main()
