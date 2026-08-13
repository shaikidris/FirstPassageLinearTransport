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
- `PolylogTarget.lean`, `AsymptoticBounds.lean`: route-neutral target and
  asymptotic conversion lemmas shared by the canonical timeout proof and the
  retained all-prefix implementation;
- `TwoRegimeOrbitCeiling.lean`: high/low intermediate-orbit propagation and
  the complete fixed-tolerance fixed-polylogarithmic theorem;
- `TimeSupportTransport.lean`: arbitrary-target transport on an explicit
  finite set of cumulative times, charged by the support cardinality;
- `ShrinkingBarrierCore.lean`, `ShrinkingBarrierRun.lean`,
  `ShrinkingTimeSupport.lean`, `ShrinkingSchedules.lean`: the literal
  rank-dependent certification chain and its
  `O(sqrt (M log M))` feasible-time support;
- `ShrinkingFirstBad.lean`, `ShrinkingProfile.lean`,
  `ShrinkingHighDensity.lean`, `ShrinkingTailAsymptotics.lean`,
  `ShrinkingPolylogProfile.lean`: support-sensitive first-bad transport and
  the half-power terminal profile;
- `ShrinkingParameters.lean`, `ShrinkingExecution.lean`,
  `ShrinkingOrbitCeiling.lean`, `ShrinkingNaturalDensityDescent.lean`: strict
  endpoint selection, literal termination, same-witness ceiling, and the
  assembled quantitative natural-density theorem;
- `SharpEntropyBarrier.lean`, `MovingLowParameters.lean`,
  `MovingLowDensity.lean`: the internal sharp-prefactor and moving
  landing-density producer;
- `MovingTimeSupport.lean`: the literal moving stopped run, direct passage
  along decreasing thresholds, exact certified landing shell, decreasing
  rank potential,
  and uniform `O(sqrt (M log M))` feasible-time support without a
  `1 / (1 - rLo)` loss;
- `MovingFirstBad.lean`, `MovingProfile.lean`: direct support-sensitive moving
  first-bad transport and the conditional terminal-profile socket;
- `MovingSharpTail.lean`, `MovingSharpProfile.lean`: exact-rate summation of
  the `q^(-1/2)` landing profile and its conditional moving first-bad consumer;
- `MovingLowSetup.lean`, `MovingEndpointParameters.lean`,
  `MovingEndpointProfile.lean`, `MovingEndpointAsymptotics.lean`: quantitative
  startup, literal sharp shell profile, and exact `Delta_M` closure;
- `MovingExecution.lean`, `MovingOrbitCeiling.lean`: retained all-prefix
  execution and same-witness orbit ceiling;
- `MovingEndpointScalars.lean`, `MovingEndpointAssembly.lean`: scalar
  identities and the shared density assembly;
- `Alternates/AllPrefix/`: the optional V3.1 witness, natural-density
  theorem, public wrapper, and axiom audit;
- `TimeoutCore.lean` through `TimeoutEndpointNaturalDensity.lean`: primary
  V3.2 formalization of the manuscript's first-timeout low phase, sharp shell
  profile, exact dyadic-endpoint discharge, same-witness ceiling, and public
  natural-density theorem.

`Main.lean` exposes only the V3.2 timeout moving-endpoint theorem for every
bounded exponent profile whose exact rank buffer diverges. The V3.1
all-prefix theorem is a separately built formal alternate. `Main` also
exposes the fixed-exponent
specialization for every
`A > 1 / (2 * (1 - H₂(log₃ 2))) = 9.9911133419...` and retains the older
fixed-tolerance theorem internally together with the stretched-logarithmic,
fixed-power, raw-clock, and graded-clock statements as companions.  The
graded declaration is mapped to Corollary 1.5, while remaining outside
the dependency cone of the two headline theorems.

The package imports Mathlib directly and has no dependency on
`CollatzEndpointTransport`, `TwoACF`, or the frozen CET/CEP theorem chain.

Build the canonical production cone and its audits:

```bash
lake build
```

Build the narrower public axiom-audit target:

```bash
lake build FirstPassageLinearTransport.PaperAudit
```

Build the optional all-prefix library and its axiom audit:

```bash
lake build FirstPassageLinearTransportAlternates
```

Build the separate timeout-producer axiom-audit target:

```bash
lake build FirstPassageLinearTransport.TimeoutEndpointAudit
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

These checks are not scope-equivalent. The default library has an explicit,
import-closed module list and reconstructs the canonical paper cone plus its
audits; the explicit alternate build reconstructs the retained cross-check.
`PaperDependencyAudit` checks theorem provenance and
source-elaboration reachability; `PaperAudit` reports public trusted axioms;
`Alternates/AllPrefix/Audit` reports the trust surface of the retained moving
producer, time-support theorem, exact-rate sharp profile, and assembly.
`TimeoutEndpointAudit` independently reports the canonical timeout producer
and its final assembly.

The exact public declarations and package layout are documented in
`FirstPassageLinearTransport/README.md`. The manuscript-to-Lean map is in
`FORMALIZATION.md`.
