# Lean supplementary development

**Author:** Idris Ali Shaik

This directory contains the independent Lean 4 formalization accompanying the
first-passage linear-transport manuscript. It is pinned to Lean `v4.15.0`; the
exact Mathlib revision is recorded in `lake-manifest.json`.

The frozen V2.3.1 public theorem family remains in `Main.lean` as companion
mathematics. The V3 headline is added through semantic modules with literal
Collatz definitions:

- `LossTransport.lean`: exact additive reverse loss, loss-filtered rigidity,
  tagged fibers, and arbitrary-target transport;
- `NestedRecertification.lean`: direct first-passage collapse and exact loss
  concatenation/rescaling;
- `RankScaledLoss.lean`: the finite all-block budget `(q+2)/r`;
- `EntropyBarrier.lean`: exact `log cosh` optimization and the binary-entropy
  maximal-barrier rate;
- `AdjustableEnvelope.lean`: the exact adjustable barrier exponent, both
  main-term phase bounds, affine-correction absorption under an explicit
  startup condition, and the resulting deterministic orbit envelope;
- `AdjustableBarrierDensity.lean`: eventual discharge of both startup
  inequalities and the entropy-sharp count for actual orbit-envelope failures;
- `FirstBadEnvelope.lean`: exact bad landing bands, their upper-endpoint
  boundary term, the finite rank-by-rank loss-filtered transport union, and
  generated-chain witness inclusion;
- `RecertificationStep.lean`: the literal stopped map initializes and extends
  the rational rank-loss chain with the exact floor-target budget;
- `RecertificationRun.lean`: whole-run induction and exact placement of a
  failed endpoint in the first-bad landing target.
- `TerminalTail.lean`: absorption of the linear rank loss into arbitrary
  strict exponential-rate margins and finite geometric-tail summation;
- `TerminalProfile.lean`: the generated first-bad source profile obtained by
  combining exact transport with the dyadic boundary and entropy tails.
- `TwoRegimePolylogExecution.lean`: the literal terminal witness, explicit
  natural-log target conversion, density-one assembly, and quantitative
  exceptional-count consumer;
- `TwoRegimeOrbitCeiling.lean`: high/low intermediate-orbit propagation and
  the complete fixed-polylogarithmic headline theorem.

`Main.lean` exposes the V3 fixed-polylogarithmic theorem first and retains the
stretched-logarithmic, fixed-power, raw-clock, and graded-clock statements as
companions.

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
