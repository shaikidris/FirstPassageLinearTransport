# Lean supplementary development

**Author:** Idris Ali Shaik

This directory contains the independent Lean 4 formalization accompanying the
first-passage linear-transport manuscript. It is pinned to Lean `v4.15.0`; the
exact Mathlib revision is recorded in `lake-manifest.json`.

The package imports Mathlib directly and has no dependency on
`CollatzEndpointTransport`, `TwoACF`, or the frozen CET/CEP theorem chain.

Build every retained production and audit module:

```bash
lake build
```

Build the narrower public axiom-audit target:

```bash
lake build FirstPassageLinearTransport.PaperAudit
```

Print the declaration/source dependency report directly:

```bash
lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false \
  -DmaxHeartbeats=20000000 \
  FirstPassageLinearTransport/PaperDependencyAudit.lean
```

Print the public axiom report directly:

```bash
lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false \
  -DmaxHeartbeats=20000000 \
  FirstPassageLinearTransport/PaperAudit.lean
```

These checks are not scope-equivalent. The full build reconstructs every
retained source module; `PaperDependencyAudit` checks theorem provenance and
source-elaboration reachability; `PaperAudit` reports trusted axioms.

The exact public declarations and package layout are documented in
`FirstPassageLinearTransport/README.md`. The manuscript-to-Lean map is in
`FORMALIZATION.md`.
