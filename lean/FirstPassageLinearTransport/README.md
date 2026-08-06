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

The exact timed Main Theorem declaration is
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

No unfinished or optional research library is part of this package's default
target.
