# FirstPassageLinearTransport kernel-hardening audit — 2026-08-13

## Scope

- Private source: `/Users/shaik.i/research/collatz/FirstPassageLinearTransport`
- Baseline commit: `a23fa3a3354ecc595d01b0193c06de5434cd21cd`
- Audited theorem source: the live working-tree Lean files frozen into
  `/private/tmp/fplt-frozen415`.
- Frozen toolchain: Lean `v4.15.0`, Mathlib `v4.15.0`.

The live repository was not uploaded to an external service. The checker and
all proof artifacts remained local.

## Results

1. **Exploit-pattern scan: pass.** Project theorem sources contain no
   `addDecl`, `addDeclCore`, `addDeclWithoutChecking`, `.inductDecl`,
   `.thmDecl`, `.defnDecl`, raw `mkProj`/`mkBVar`/`mkLambda`/`mkForall`,
   `run_tac`, `native_decide`, project `axiom`, `unsafe`, `sorry`, or `admit`.
   The only project metaprogramming in the audit surface is read-only
   environment/dependency inspection.

2. **Frozen source build: pass.** `lake --old build
   FirstPassageLinearTransport.Main` completed all 5,932 jobs successfully.

3. **Axiom/dependency audit: pass.** `PaperAudit` and
   `PaperDependencyAudit` built successfully. Every listed load-bearing and
   public declaration depends only on `propext`, `Classical.choice`, and
   `Quot.sound`.

4. **Secondary kernel replay: pass.** A local build of `lean4lean` at commit
   `9787817957f50eafb47702f4d23a482f2d6783c2`, adjusted to use Lean 4.15,
   replayed all 97 project `.olean` modules successfully. In particular it
   accepted the arithmetic core, transport chain, timeout chain, and public
   `Main` module.

5. **Source concordance: pass for theorem sources.** After the frozen build,
   every `.lean` source in the frozen audit tree matched the live theorem
   source. Only `FORMALIZATION.md` and `lakefile.lean` changed concurrently;
   neither affected the checked theorem-source concordance.

6. **Patched-kernel migration probe: incomplete, not a proof failure.** An
   isolated Lean 4.33 / Mathlib 4.33 port passed several foundational modules
   after mechanical compatibility edits, then reached additional API/tactic
   migration work in `EntropyBarrier`, `Envelope`, and `Transport`. The probe
   was stopped under the predeclared bounded-migration rule. No theorem was
   rejected on mathematical grounds.

7. **Independent `nanoda`/Comparator certificate: not completed.** Current
   pinned exporter/comparator revisions are not source-compatible with Lean
   4.15, while a full 4.33 migration is larger than this audit. Do not describe
   this audit as a `nanoda` or Comparator validation.

## Important limitation

`lean4lean` is a useful second implementation/replay, but its own documentation
states that it is derived from Lean's C++ kernel and may share implementation
bugs. The strongest defense against issue #14576 in this audit is therefore
the combination of:

- absence of raw declaration construction and the exploit primitives in the
  project source;
- successful ordinary rebuild and axiom audit;
- successful replay of every project module by the secondary checker.

The gold-standard future hardening step is a completed port to a patched Lean
release followed by `leanchecker --fresh` and an independent
`lean4export`/`nanoda` or Comparator certificate.

## Preserved upstream reproducer

The public issue #14576 reproducer is retained locally, outside this
mathematical repository, at
`/Users/shaik.i/research/exploits/lean-kernel-14576/lean14576_repro.lean`.
Usage notes and the original audit evidence are stored in the same directory.
The reproducer must never be imported into the mathematical package.
