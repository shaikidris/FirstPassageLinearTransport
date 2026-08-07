# FirstPassageLinearTransport Lean package

**Author:** Idris Ali Shaik

The verified development is split by mathematical role.

- `Basic.lean`, `Density.lean`, `VaryingDensity.lean`: shortcut dynamics and
  density interfaces.
- `Parity.lean`: parity-vector bijection and exact affine iterate.
- `Barrier.lean`, `Envelope.lean`, `BarrierDensity.lean`: maximal barrier,
  deterministic orbit envelope, and dense initial window.
- `FirstPassage.lean`, `Transport.lean`: first-passage reversal, rigidity,
  tagged fibers, and arbitrary-target linear transport.
- `LossTransport.lean`, `NestedRecertification.lean`, `RankScaledLoss.lean`:
  loss-filtered transport, nested first-passage collapse, and the all-block
  rank-scaled reverse-loss budget.
- `EntropyBarrier.lean`, `AdjustableEnvelope.lean`,
  `AdjustableBarrierDensity.lean`: exact entropy optimization, adjustable
  orbit envelope, startup discharge, and entropy-sharp shell tail.
- `FirstBadEnvelope.lean`, `RecertificationStep.lean`,
  `RecertificationRun.lean`, `TerminalTail.lean`, `TerminalProfile.lean`:
  literal first-bad aggregation and its optimized terminal profile.
- `TwoRegimeRun.lean`, `TwoRegimeProfile.lean`, `TwoRegimeClock.lean`,
  `TwoRegimeExecution.lean`, `TwoRegimeSchedules.lean`,
  `TwoRegimeTailAsymptotics.lean`, `TwoRegimePolylogProfile.lean`:
  high/low re-certification, clock, schedules, and quantitative shell profile.
- `FixedPolylogParameters.lean`, `TwoRegimePolylogExecution.lean`,
  `TwoRegimeOrbitCeiling.lean`: endpoint selection, terminal witness,
  natural-log target, and same-witness orbit ceiling.
- `Pullback.lean`, `Parameters.lean`, `Bootstrap.lean`: stopped-map pullback,
  stage construction, and repeated bootstrap.
- `Scalar.lean`, `Constants.lean`, `HeadlineParameters.lean`: scalar
  asymptotics, exact clock constants, and strict headline parameters.
- `GlobalAssembly.lean`, `BootstrapSchedule.lean`,
  `StretchedLogLanding.lean`, `ClockBudget.lean`,
  `NaturalDensityDescent.lean`: shell assembly, exceptional-mass decay,
  stretched-log landing, explicit clock, and internal final assembly.
- `PowerDescent.lean`: fixed-power consequence of the timed
  stretched-logarithmic theorem.
- `Main.lean`: minimal referee-facing theorem API.
- `PaperDependencyAudit.lean`: compiled-declaration and `.ilean` source
  dependency report with reverse reachability.
- `PaperAudit.lean`: public `#print axioms` report.

The exact fixed-polylogarithmic headline declaration is
`FirstPassageLinearTransport.QuantitativeCollatzMain.collatz_first_passage_fixed_polylogarithmic_natural_density_descent`.
It quantifies over every
`A > 1/(1-H₂(log₃ 2))`, `c > 2/log(4/3)`, and `beta > 0`, and supplies one
natural-density-one set, a positive exceptional exponent, the quantitative
prefix count, a literal shortcut landing below `C*(log n)^A`, and the
same-witness ceiling `orbit j n <= n^(1+beta)`.

The companion exact timed stretched-log declaration is
`FirstPassageLinearTransport.QuantitativeCollatzMain.collatz_first_passage_stretched_log_natural_density_descent`.
The unclocked consequence is
`FirstPassageLinearTransport.QuantitativeCollatzMain.collatz_first_passage_stretched_log_natural_density_descent_unclocked`.
The timed fixed-power consequence is
`FirstPassageLinearTransport.QuantitativeCollatzMain.collatz_first_passage_fixed_power_natural_density_descent`.

The timed theorem quantifies over every real `delta` with `0 < delta < 1` and
produces a natural-density-one set on which every sufficiently large member
has a literal shortcut-Collatz iterate below
`exp ((log n)^(1-delta))` before `(6953/1000) * log n` shortcut steps. The
endpoint `delta = 1` is not claimed.

The paused LC.28 checkpoint-congestion route is not imported by the headline
chain and is not part of this package's default target.
