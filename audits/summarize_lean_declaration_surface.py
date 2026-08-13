#!/usr/bin/env python3
"""Summarize the declaration-level Lean reachability audit.

The input is the stdout/stderr log produced by

    lake env lean FirstPassageLinearTransport/PaperDependencyAudit.lean

or by building that audit target.  The script deliberately does not decide
that an unreachable declaration is removable; it produces the evidence table
used for the subsequent mathematical/API classification.
"""

from __future__ import annotations

import argparse
import re
from collections import defaultdict
from dataclasses import dataclass
from pathlib import Path


SUMMARY_KEYS = (
    "RETAINED_PRIMARY_SOURCE_DECLARATIONS",
    "MAIN_REACHABLE_SOURCE_DECLARATIONS",
    "PAPER_ONLY_REACHABLE_SOURCE_DECLARATIONS",
    "COMPANION_ONLY_REACHABLE_SOURCE_DECLARATIONS",
    "UNREACHABLE_SOURCE_DECLARATIONS",
)


@dataclass(frozen=True)
class ModuleRow:
    module: str
    source_primary: int
    main: int
    paper_only: int
    companion_only: int
    unreachable: int


@dataclass(frozen=True)
class DeclarationRow:
    kind: str
    module_line: str
    declaration: str


def payload(line: str) -> str:
    """Strip Lake/Lean's source-location prefix from one diagnostic line."""
    return line.rsplit(": ", 1)[-1].strip()


def parse_log(path: Path) -> tuple[dict[str, int], list[ModuleRow], dict[str, list[DeclarationRow]]]:
    summaries: dict[str, int] = {}
    modules: list[ModuleRow] = []
    declarations: dict[str, list[DeclarationRow]] = defaultdict(list)
    field_re = re.compile(r"([A-Z_]+)=(\d+)")

    for raw_line in path.read_text(encoding="utf-8", errors="replace").splitlines():
        line = payload(raw_line)
        fields = line.split("\t")
        if not fields:
            continue
        if fields[0] in SUMMARY_KEYS and len(fields) == 2:
            summaries[fields[0]] = int(fields[1])
        elif fields[0] == "DECLARATION_REACHABILITY_MODULE":
            values = {key: int(value) for key, value in field_re.findall(line)}
            modules.append(
                ModuleRow(
                    module=fields[1],
                    source_primary=values["SOURCE_PRIMARY"],
                    main=values["MAIN"],
                    paper_only=values["PAPER_ONLY"],
                    companion_only=values["COMPANION_ONLY"],
                    unreachable=values["UNREACHABLE"],
                )
            )
        elif fields[0] in {
            "PAPER_ONLY_SOURCE_DECLARATION",
            "COMPANION_ONLY_SOURCE_DECLARATION",
            "UNREACHABLE_SOURCE_DECLARATION",
        } and len(fields) == 4:
            declarations[fields[0]].append(
                DeclarationRow(fields[1], fields[2], fields[3])
            )
    return summaries, modules, declarations


def render(
    summaries: dict[str, int],
    modules: list[ModuleRow],
    declarations: dict[str, list[DeclarationRow]],
    include_details: bool,
) -> str:
    missing = [key for key in SUMMARY_KEYS if key not in summaries]
    if missing:
        raise SystemExit(f"missing audit summaries: {', '.join(missing)}")

    lines = [
        "# Lean declaration-surface summary",
        "",
        "Generated from `PaperDependencyAudit.lean`. Unreachable means outside",
        "the declared public, manuscript-cut-vertex, and mapped companion cones; it",
        "does not by itself authorize deletion.",
        "",
        "## Declaration totals",
        "",
        "| Class | Source declarations |",
        "|---|---:|",
        f"| Public `Main` cone | {summaries['MAIN_REACHABLE_SOURCE_DECLARATIONS']} |",
        f"| Manuscript cut vertices only | {summaries['PAPER_ONLY_REACHABLE_SOURCE_DECLARATIONS']} |",
        f"| Mapped companion roots only | {summaries['COMPANION_ONLY_REACHABLE_SOURCE_DECLARATIONS']} |",
        f"| Outside all retained cones | {summaries['UNREACHABLE_SOURCE_DECLARATIONS']} |",
        f"| Total primary source declarations | {summaries['RETAINED_PRIMARY_SOURCE_DECLARATIONS']} |",
        "",
    ]

    fully_outside = sorted(
        (
            row
            for row in modules
            if row.main == 0
            and row.paper_only == 0
            and row.companion_only == 0
            and row.unreachable == row.source_primary
        ),
        key=lambda row: (-row.unreachable, row.module),
    )
    mixed = sorted(
        (row for row in modules if 0 < row.unreachable < row.source_primary),
        key=lambda row: (-row.unreachable, row.module),
    )

    lines.extend([
        "## Modules wholly outside retained declaration cones",
        "",
        "| Module | Declarations |",
        "|---|---:|",
    ])
    lines.extend(f"| `{row.module}` | {row.unreachable} |" for row in fully_outside)
    lines.extend([
        "",
        "## Mixed modules requiring declaration-level review",
        "",
        "| Module | Main | Paper only | Companion only | Outside | Total |",
        "|---|---:|---:|---:|---:|---:|",
    ])
    lines.extend(
        f"| `{row.module}` | {row.main} | {row.paper_only} | "
        f"{row.companion_only} | {row.unreachable} | {row.source_primary} |"
        for row in mixed
    )

    if include_details:
        lines.extend(["", "## Exact outside-cone declarations", ""])
        outside = declarations["UNREACHABLE_SOURCE_DECLARATION"]
        by_module: dict[str, list[DeclarationRow]] = defaultdict(list)
        for row in outside:
            by_module[row.module_line.split(":", 1)[0]].append(row)
        for module in sorted(by_module):
            lines.extend([f"### `{module}`", ""])
            for row in sorted(by_module[module], key=lambda item: item.module_line):
                lines.append(f"- `{row.kind}` `{row.declaration}` ({row.module_line})")
            lines.append("")

    return "\n".join(lines).rstrip() + "\n"


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("log", type=Path, help="Lean dependency-audit log")
    parser.add_argument("--output", type=Path, help="write Markdown here")
    parser.add_argument("--details", action="store_true", help="include exact outside-cone declarations")
    args = parser.parse_args()

    summary = render(*parse_log(args.log), include_details=args.details)
    if args.output:
        args.output.write_text(summary, encoding="utf-8")
    else:
        print(summary, end="")


if __name__ == "__main__":
    main()
