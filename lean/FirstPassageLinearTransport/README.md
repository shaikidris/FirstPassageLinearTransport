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
  natural-log target, and same-witness orbit ceiling for the retained
  fixed-tolerance comparison chain.
- `TimeSupportTransport.lean`: loss-filtered target transport on an explicit
  finite time support.
- `ShrinkingBarrierCore.lean`, `ShrinkingBarrierRun.lean`,
  `ShrinkingTimeSupport.lean`, `ShrinkingSchedules.lean`: the rank-dependent
  barrier run, its narrow duration corridors, and the resulting
  `O(sqrt (M log M))` cumulative-time support.
- `ShrinkingFirstBad.lean`, `ShrinkingProfile.lean`,
  `ShrinkingHighDensity.lean`, `ShrinkingTailAsymptotics.lean`,
  `ShrinkingPolylogProfile.lean`: exact support-sensitive first-bad counting
  and the half-power terminal profile.
- `ShrinkingParameters.lean`, `ShrinkingExecution.lean`,
  `ShrinkingOrbitCeiling.lean`, `ShrinkingNaturalDensityDescent.lean`:
  endpoint parameters, literal recursive execution, orbit ceiling, prefix
  count, and density-one assembly for the strengthened headline.
- `SharpEntropyBarrier.lean`, `MovingLowParameters.lean`,
  `MovingLowDensity.lean`: sharp compact-regime prefactor, moving parameters,
  rounding, and the literal moving landing-density producer.
- `MovingTimeSupport.lean`: literal moving high/low stopped runs, direct nested
  first passage, certified shell collapse, the decreasing low-rank potential,
  and the uniform square-root-logarithmic cumulative-time support.
- `MovingFirstBad.lean`, `MovingProfile.lean`: moving first-bad transport on
  the compressed time support, common reverse-loss budget for any rational
  `rStar` dominated by both regimes, and the conditional support-sensitive
  terminal profile.
- `MovingSharpTail.lean`, `MovingSharpProfile.lean`: exact-rate
  `q^(-1/2)` terminal summation and its conditional moving first-bad profile;
  no strict `b' < b` rate loss is used by the endpoint-sensitive consumer.
- `MovingEndpointScalars.lean`, `MovingEndpointAssembly.lean`: moving scalar
  schedules and the conditional natural-density consumer.  Uniform moving
  startup, the eventual `Delta_M` shell-density and same-witness producer,
  and the public moving headline remain open.
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
- `MovingEndpointAudit.lean`: internal moving-producer and conditional-assembly
  `#print axioms` report.

The exact fixed-polylogarithmic headline declaration is
`FirstPassageLinearTransport.QuantitativeCollatzMain.collatz_first_passage_fixed_polylogarithmic_natural_density_descent`.
It quantifies over every
`A > 1/(2*(1-H₂(log₃ 2)))`, `c > 2/log(4/3)`, and `beta > 0`, and supplies one
natural-density-one set, a positive exceptional exponent, the quantitative
prefix count, a literal shortcut landing below `C*(log n)^A`, and the
same-witness ceiling `orbit j n <= n^(1+beta)`.

The previous fixed-tolerance endpoint `1/(1-H₂(log₃ 2))` is retained only as
an internal comparison theorem. The factor-two improvement is supplied by
the proved square-root feasible-time support, not by a changed density notion
or by an unformalized analytic assumption.

The companion exact timed stretched-log declaration is
`FirstPassageLinearTransport.QuantitativeCollatzMain.collatz_first_passage_stretched_log_natural_density_descent`.
The unclocked consequence is
`FirstPassageLinearTransport.QuantitativeCollatzMain.collatz_first_passage_stretched_log_natural_density_descent_unclocked`.
The timed fixed-power consequence is
`FirstPassageLinearTransport.QuantitativeCollatzMain.collatz_first_passage_fixed_power_natural_density_descent`.
The graded-power declaration is retained as additional formal
companion mathematics in Appendix A and is not part of either headline
dependency chain.

The V3.1 moving endpoint is proved in the manuscript but is not yet a public
Lean theorem. The internal analytic producer, moving feasible-time support,
direct first-bad transport, and exact-rate conditional sharp profile are
formalized. Uniform moving-stage startup and the eventual `Delta_M`
shell-density/same-witness producer must still discharge the profile
hypotheses before `MovingEndpointAssembly.lean` can supply the public theorem.

The timed theorem quantifies over every real `delta` with `0 < delta < 1` and
produces a natural-density-one set on which every sufficiently large member
has a literal shortcut-Collatz iterate below
`exp ((log n)^(1-delta))` before `(6953/1000) * log n` shortcut steps. The
endpoint `delta = 1` is not claimed.

The paused LC.28 checkpoint-congestion route is not imported by the headline
chain and is not part of this package's default target.
