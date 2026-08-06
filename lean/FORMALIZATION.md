# Paper-to-Lean theorem map

The package formalizes the shortcut map

```text
T(n) = n / 2              when n is even
T(n) = (3*n + 1) / 2      when n is odd
```

and uses the manuscript's missing-count definition of natural density one.
It imports Mathlib only and does not import the frozen V1/CEP development.

| Manuscript item | Principal Lean declaration | Module |
|---|---|---|
| Shortcut orbit and density definitions | `FirstPassageLinearTransport.shortcut`; `orbit`; `PowerDense`; `NaturalDensityOne` | `Basic.lean` |
| Lemma 2.1, varying dyadic summation | `FirstPassageLinearTransport.naturalDensityOne_assembleDyadic` | `VaryingDensity.lean` |
| Proposition 2.2, parity-vector bijection | `FirstPassageLinearTransport.parityCode_bijective` | `Parity.lean` |
| Proposition 2.3, exact affine iterate | `FirstPassageLinearTransport.exact_affine_iterate` | `Parity.lean` |
| Lemma 3.1, maximal Boolean barrier | `FirstPassageLinearTransport.barrierHitCount_le_exp`; `card_shellMaximalParityBad_le` | `Barrier.lean` |
| Lemma 3.2, uniform affine correction | `FirstPassageLinearTransport.orbit_envelope_of_maximalBarrier` | `Envelope.lean` |
| Proposition 3.3, dense barrier set | `FirstPassageLinearTransport.initialWindowGood_powerDense`; `extendedWindow_powerDense` | `BarrierDensity.lean`; `Pullback.lean` |
| Lemma 4.1, first-passage band | `FirstPassageLinearTransport.firstPassage_band` | `FirstPassage.lean` |
| Lemma 4.1, reverse product and bounds | `FirstPassageLinearTransport.reverse_product_identity`; `firstPassage_reverse_bounds` | `FirstPassage.lean` |
| Lemma 4.2, odd-count rigidity | `FirstPassageLinearTransport.oddCount_rigidity` | `FirstPassage.lean` |
| Lemma 4.3, tagged-fiber bound | `FirstPassageLinearTransport.taggedFiber_bound` | `FirstPassage.lean` |
| Proposition 4.4, arbitrary-target transport | `FirstPassageLinearTransport.arbitraryTarget_linear_transport`; `arbitraryTarget_linear_transport_restricted` | `Transport.lean` |
| Theorem 5.1, dense-set pullback | `FirstPassageLinearTransport.firstPassagePullback_powerDense` | `Pullback.lean` |
| Repeated stopped-map bootstrap | `FirstPassageLinearTransport.bootstrapSet_powerDense`; `bootstrapC_exp_bound` | `Bootstrap.lean` |
| Literal orbit concatenation | `FirstPassageLinearTransport.stageOrbit_eq_orbit_stageClock` | `Bootstrap.lean` |
| Logarithmic shell error tends to zero | `FirstPassageLinearTransport.shellBootstrapRatioTendstoZero` | `BootstrapSchedule.lean` |
| Stretched-logarithmic landing | `FirstPassageLinearTransport.eventuallyShellLanding` | `StretchedLogLanding.lean` |
| Geometric clock and exact constant | `FirstPassageLinearTransport.clockGeomLeInvOneSub`; `log_four_thirds_gt_296_div_1029`; `eventuallyShellClockLt6953` | `BootstrapSchedule.lean`; `Constants.lean`; `ClockBudget.lean` |
| Strict compatible parameter selection | `FirstPassageLinearTransport.exists_headlineScalars`; `exists_stageSetup` | `HeadlineParameters.lean`; `Parameters.lean` |
| Internal final assembly | `FirstPassageLinearTransport.firstPassageLinearTransportMain` | `NaturalDensityDescent.lean` |
| Theorem 1.1, timed form | `FirstPassageLinearTransport.QuantitativeCollatzMain.collatz_first_passage_stretched_log_natural_density_descent` | `Main.lean` |
| Theorem 1.1, unclocked consequence | `FirstPassageLinearTransport.QuantitativeCollatzMain.collatz_first_passage_stretched_log_natural_density_descent_unclocked` | `Main.lean` |
| Post-freeze fixed-power timed consequence | `FirstPassageLinearTransport.QuantitativeCollatzMain.collatz_first_passage_fixed_power_natural_density_descent` | `PowerDescent.lean`; `Main.lean` |

Paper counters are intentionally confined to this map and
`PaperDependencyAudit.lean`. Ordinary modules and declaration documentation
use semantic names so manuscript renumbering cannot stale the source.

`PaperDependencyAudit.lean` reports kernel reachability, `.ilean`
source-elaboration reachability, transitive milestone edges, and the reverse
complement of retained source theorems. `PaperAudit.lean` separately runs
`#print axioms` on the mapped load-bearing and public declarations. A clean
`lake build` remains the independent source-reconstruction gate.
