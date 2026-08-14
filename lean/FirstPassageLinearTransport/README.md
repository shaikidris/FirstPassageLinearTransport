# FirstPassageLinearTransport module guide

The canonical public surface is `Main.lean`. Its dependency cone is divided
by mathematical role:

- `Basic`, `RawDynamics`, `Density`, and `VaryingDensity`: literal dynamics
  and natural-density interfaces;
- `Parity`, `FirstPassage`, `Transport`, and `LossTransport`: parity coding,
  affine iterates, reverse first passage, fibers, and target transport;
- `Barrier*`, `Envelope*`, and `EntropyBarrier`: probabilistic counting
  estimates and deterministic orbit envelopes;
- `NestedRecertification`, `RankScaledLoss`, and `Recertification*`:
  decreasing-threshold direct passage and loss telescoping;
- `Shrinking*`, `TimeSupport*`, and `Terminal*`: compressed feasible-time
  support and support-sensitive aggregation;
- `Timeout*`: the canonical first-timeout realization and endpoint profile;
- `MovingEndpoint*`, `Polylog*`, and `FixedPolylogParameters`: endpoint
  parameter selection and target conversion;
- `ClockBudget`, `RawClockBudget`, `OrbitCeiling`, and
  `TimeoutOrbitCeiling`: witnessing clocks and intermediate-orbit bounds;
- `GlobalAssembly`, `NaturalDensityDescent`,
  `QuantitativeNaturalDensityDescent`, and
  `ShrinkingNaturalDensityDescent`: shell-to-prefix and density-one assembly;
- `PowerDescent` and `GradedPowerDescent`: fixed-power companions.

The three canonical audit roots are:

- `PaperAudit.lean`: public and load-bearing `#print axioms` report;
- `TimeoutEndpointAudit.lean`: detailed canonical timeout-chain axiom report;
- `PaperDependencyAudit.lean`: declaration and source dependency report.

Optional alternate and historical implementations are isolated under
`Alternates/` and `Legacy/` and in separate non-default Lake libraries. They
are retained for comparison and regression checks, but are not imported by
`Main.lean`.

For release identity, public theorem names, and reproduction commands, see
[`../FORMALIZATION.md`](../FORMALIZATION.md).
