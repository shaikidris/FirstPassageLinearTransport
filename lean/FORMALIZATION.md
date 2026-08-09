# Paper-to-Lean theorem map

The package formalizes the shortcut map

```text
T(n) = n / 2              when n is even
T(n) = (3*n + 1) / 2      when n is odd
```

and uses the manuscript's missing-count definition of natural density one.
It imports Mathlib only and does not import the frozen V1/CEP development.

## Literal referee dictionary

The public `Main.lean` surface uses named definitions so its theorem types
remain readable, but each name is concrete and unfolds as follows.

| Public symbol | Literal meaning |
|---|---|
| `shortcut n` | `if n % 2 = 0 then n / 2 else (3*n + 1) / 2` |
| `orbit k n` | `(shortcut^[k]) n` |
| `rawCollatz n` | `if n % 2 = 0 then n / 2 else 3*n + 1` |
| `rawOrbit j n` | `(rawCollatz^[j]) n` |
| `badCount S X` | the cardinality of `{n in [1,X] | n notin S}` |
| `NaturalDensityOne S` | `badCount S X / X -> 0` as `X -> infinity` |
| `HasStretchedLogDescent delta n` | `exists k, orbit k n <= exp ((log n)^(1-delta))` |
| `HasFixedPowerDescent alpha n` | `exists k, orbit k n <= n^alpha` |

These are definitions, not hypotheses supplied to the headline theorems.
The manuscript separates the landing constant `C_tar` from the exceptional
prefactor `C_exc`.  The public Lean theorem returns one positive constant
`C` chosen as their maximum, which is a stronger statement and implies the
separated manuscript formulation by taking `C_tar = C_exc = C`.  Likewise,
the manuscript's Section 6 coefficient `D_hi` is the field `D` of
`ShrinkingBarrierRunData`; the renamed paper symbol only prevents collision
with density and loss notation.

| Manuscript item | Principal Lean declaration | Module |
|---|---|---|
| Theorem 1.1, optimized fixed-polylogarithmic descent | `FirstPassageLinearTransport.QuantitativeCollatzMain.collatz_first_passage_fixed_polylogarithmic_natural_density_descent` | `Main.lean` |
| Theorem 1.1, endpoint exponent identity | `FirstPassageLinearTransport.timeSupportCriticalExponent_eq_entropy` | `ShrinkingParameters.lean` |
| Theorem 1.1, clock identity | `FirstPassageLinearTransport.fixedPolylogClockCritical_eq_paper` | `FixedPolylogParameters.lean` |
| Theorem 1.1, strict parameter selection | `FirstPassageLinearTransport.exists_shrinkingPolylogParameterPackage` | `ShrinkingParameters.lean` |
| Theorem 1.1, support-sensitive time transport | `FirstPassageLinearTransport.lossFiltered_arbitraryTarget_transport_atTimes_uniform` | `TimeSupportTransport.lean` |
| Theorem 1.1, square-root feasible-time support | `FirstPassageLinearTransport.shrinkingFeasibleTimes_card_lt_sqrt` | `ShrinkingSchedules.lean` |
| Theorem 1.1, support-sensitive first-bad profile | `FirstPassageLinearTransport.eventually_shrinkingFailureEnvelope_density_polylog_le` | `ShrinkingPolylogProfile.lean` |
| Theorem 1.1, literal terminal witness | `FirstPassageLinearTransport.shrinkingSource_lands_below_horizon` | `ShrinkingExecution.lean` |
| Theorem 1.1, same-witness orbit ceiling | `FirstPassageLinearTransport.ShrinkingRecertificationRun.orbit_le_start_power`; `eventually_shrinkingPolylogGood_has_shellLanding_with_orbitCeiling` | `ShrinkingOrbitCeiling.lean` |
| Theorem 1.1, assembled quantitative theorem | `FirstPassageLinearTransport.shrinkingFixedPolylogNaturalDensityDescent` | `ShrinkingNaturalDensityDescent.lean` |
| Theorem 1.1, finite-startup absorption and direct no-witness count | `FirstPassageLinearTransport.eventually_badCount_le_polylog_of_tail_subset`; `naturalDensityOne_of_eventually_badCount_le_polylog` | `FiniteStartup.lean`; `Main.lean` |
| Shortcut orbit and density definitions | `FirstPassageLinearTransport.shortcut`; `orbit`; `PowerDense`; `NaturalDensityOne` | `Basic.lean` |
| Lemma 2.1, varying dyadic summation | `FirstPassageLinearTransport.naturalDensityOne_assembleDyadic` | `VaryingDensity.lean` |
| Lemma 2.1, quantitative stretched dyadic summation | `FirstPassageLinearTransport.QuantitativeDensity.badCount_assembleDyadic_le_stretched_log` | `StretchedExceptionalCount.lean` |
| Proposition 2.2, parity-vector bijection | `FirstPassageLinearTransport.parityCode_bijective` | `Parity.lean` |
| Proposition 2.3, exact affine iterate | `FirstPassageLinearTransport.exact_affine_iterate` | `Parity.lean` |
| Lemma 3.1, maximal Boolean barrier | `FirstPassageLinearTransport.barrierHitCount_le_exp`; `card_shellMaximalParityBad_le` | `Barrier.lean` |
| Lemma 3.2, uniform affine correction | `FirstPassageLinearTransport.orbit_envelope_of_maximalBarrier` | `Envelope.lean` |
| Proposition 3.3, dense barrier set | `FirstPassageLinearTransport.initialWindowGood_powerDense`; `extendedWindow_powerDense` | `BarrierDensity.lean`; `Pullback.lean` |
| Lemma 4.1, first-passage band | `FirstPassageLinearTransport.firstPassage_band` | `FirstPassage.lean` |
| Lemma 4.1, reverse product and bounds | `FirstPassageLinearTransport.reverse_product_identity`; `firstPassage_reverse_bounds` | `FirstPassage.lean` |
| Lemma 4.2, loss-filtered odd-count rigidity and tagged-fiber bound | `FirstPassageLinearTransport.lossFiltered_oddCount_rigidity`; `lossFilteredTaggedFiber_bound` | `LossTransport.lean` |
| Proposition 4.3, exact and uniform loss-filtered target transport | `FirstPassageLinearTransport.lossFiltered_arbitraryTarget_transport`; `lossFiltered_arbitraryTarget_transport_uniform`; `lossFiltered_arbitraryTarget_transport_restricted` | `LossTransport.lean` |
| Lemma 5.1, nested direct first passage | `FirstPassageLinearTransport.IsFirstPassage.nested` | `NestedRecertification.lean` |
| Reverse-loss concatenation and threshold rescaling | `FirstPassageLinearTransport.reverseLossTotal_add`; `scaledReverseLoss_add_rescaled`; `scaledReverseLoss_le_half_time` | `NestedRecertification.lean` |
| Lemma 5.2, finite all-block rank-scaled loss budget | `FirstPassageLinearTransport.CertifiedRankChain.directFirstPassage`; `CertifiedRankChain.scaledReverseLoss_le` | `RankScaledLoss.lean` |
| Lemma 3.1, exact entropy-sharp Boolean barrier rate | `FirstPassageLinearTransport.barrierHitCount_le_exact_cosh`; `booleanLegendreRate_optimizer`; `barrierHitCount_le_binaryEntropy` | `EntropyBarrier.lean` |
| Lemma 3.2, adjustable deterministic envelope and correction absorption | `FirstPassageLinearTransport.adjustableBarrier_phase`; `adjustableBarrier_phase_two`; `adjustableBarrier_correction_absorb`; `orbit_envelope_of_adjustableBarrier` | `AdjustableEnvelope.lean` |
| Proposition 3.3, eventual adjustable startup and entropy-sharp shell count | `FirstPassageLinearTransport.eventually_adjustableBarrier_startups`; `shellInitialWindowBad_subset_adjustable`; `eventually_card_shellInitialWindowBad_adjustable_le` | `AdjustableBarrierDensity.lean` |
| Theorem 5.3, exact finite first-bad aggregation interface | `FirstPassageLinearTransport.landingBad_subset_insert_shellBad`; `firstBadLandingEnvelope_card_le`; `firstBadFailureEnvelope_card_le` | `FirstBadEnvelope.lean` |
| Lemmas 5.1--5.2, stopped-map to rank-chain adapter | `FirstPassageLinearTransport.parentRank_le_rationalTargetBudget`; `CertifiedRankChain.first_of_stage`; `CertifiedRankChain.next_of_stage`; `generatedFirstBadSources_subset_envelope` | `RecertificationStep.lean`; `FirstBadEnvelope.lean` |
| Theorem 5.3, recursive-run semantic inclusion | `FirstPassageLinearTransport.RecertificationRun.toCertifiedRankChain`; `RecertificationRun.endpoint_mem_landingBad`; `RecertificationRun.toGeneratedFirstBadLanding` | `RecertificationRun.lean` |
| Theorem 5.3, terminal rank-tail summation | `FirstPassageLinearTransport.weighted_exp_Icc_le`; `terminal_rank_sum_le` | `TerminalTail.lean`; `TerminalProfile.lean` |
| Theorem 5.3, generated first-bad terminal profile | `FirstPassageLinearTransport.generatedFirstBadSources_density_terminalProfile`; `eventually_interval_card_landingBad_adjustable_le` | `TerminalProfile.lean` |
| Section 6, literal shrinking run and first-bad envelope | `FirstPassageLinearTransport.ShrinkingRecertificationRun`; `shrinkingTargetTolerance`; `shrinkingSeparatedFailureEnvelope` | `ShrinkingBarrierRun.lean`; `ShrinkingFirstBad.lean`; `ShrinkingProfile.lean` |
| Lemma 6.1, deterministic landing shell, cumulative corridor, and square-root feasible-time support | `FirstPassageLinearTransport.ShrinkingRecertificationRun.certified_endpoint_shell_eq`; `ShrinkingRecertificationRun.deviation_add_potential_le`; `shrinkingFeasibleTimes_card_lt_sqrt` | `ShrinkingBarrierRun.lean`; `ShrinkingTimeSupport.lean`; `ShrinkingSchedules.lean` |
| Proposition 6.2, shrinking high-rank density | `FirstPassageLinearTransport.shrinkingHighTolerance_eq_formula`; `shrinkingHighTolerance_sq_mul`; `card_shellInitialWindowBad_shrinking_le`; `card_landingBad_shrinking_high_density_le` | `ShrinkingHighDensity.lean` |
| Theorem 6.3, support-sensitive terminal profile | `FirstPassageLinearTransport.shrinkingSeparatedFailureEnvelope_density_terminalProfile`; `eventually_shrinkingFailureEnvelope_density_polylog_le` | `ShrinkingProfile.lean`; `ShrinkingPolylogProfile.lean` |
| Section 7, height-sensitive clock | `FirstPassageLinearTransport.stageLength_le_heightSensitiveHorizon`; `heightSensitiveHorizon_real_lt` | `HeightSensitiveClock.lean` |
| Exact raw/shortcut conversion and raw budget | `FirstPassageLinearTransport.rawOrbit_rawTime_eq_orbit`; `eventuallyShellRawClockLt` | `RawDynamics.lean`; `RawClockBudget.lean` |
| Theorem 1.2, endpoint-rate stretched-log exceptional count | `FirstPassageLinearTransport.QuantitativeCollatzMain.collatz_first_passage_quantitative_stretched_exceptional_count`; `collatz_first_passage_stretched_log_descent_with_orbit_ceiling` | `QuantitativeNaturalDensityDescent.lean`; `OrbitCeiling.lean`; `Main.lean` |
| Corollary 1.3, raw `10.44 log n` clock | `FirstPassageLinearTransport.QuantitativeCollatzMain.collatz_first_passage_raw_stretched_log_natural_density_descent` | `RawNaturalDensityDescent.lean`; `Main.lean` |
| Corollary 1.4, quantitative fixed-power exceptional count | `FirstPassageLinearTransport.QuantitativeCollatzMain.collatz_first_passage_quantitative_fixed_power_exceptional_count` | `QuantitativeNaturalDensityDescent.lean`; `Main.lean` |
| Corollary 1.4, graded fixed-power clock | `FirstPassageLinearTransport.firstPassageLinearTransportGradedPower`; `FirstPassageLinearTransport.QuantitativeCollatzMain.collatz_first_passage_graded_power_natural_density_descent` | `GradedClock.lean`; `GradedPowerDescent.lean`; `Main.lean` |

The graded declaration is a paper companion but is not a dependency of
Theorems 1.1 or 1.2.  Its finite-depth pullback remains isolated from the
optimized shrinking-barrier headline chain.

Paper counters are intentionally confined to this map and
`PaperDependencyAudit.lean`. Ordinary modules and declaration documentation
use semantic names so manuscript renumbering cannot stale the source.

`PaperDependencyAudit.lean` reports kernel reachability, `.ilean`
source-elaboration reachability, transitive milestone edges, and the reverse
complement of retained source theorems. `PaperAudit.lean` separately runs
`#print axioms` on the mapped load-bearing and public declarations. The
public, cut-vertex, dependency, and full-package builds passed on
2026-08-08, completing the independent source-reconstruction gate for this
worktree state.

## V3 synchronization boundary

The declarations in `LossTransport.lean`, `NestedRecertification.lean`,
`RankScaledLoss.lean`, `EntropyBarrier.lean`, and `AdjustableEnvelope.lean` are
compiled V3 cut-vertex proofs. `AdjustableBarrierDensity.lean` additionally
proves the startup hypotheses eventually and counts the resulting shell
complement with the binary-entropy rate. `FirstBadEnvelope.lean` performs the
exact finite union and transport estimate while keeping each target
cardinality visible. `RecertificationStep.lean` connects literal stopped-map
blocks to that certified rank chain, and `RecertificationRun.lean` closes the
whole-run induction and bad-endpoint inclusion. `TerminalTail.lean` and
`TerminalProfile.lean` absorb the linear rank loss, sum the dyadic and entropy
tails, and connect the result to the exact generated first-bad source count.
This profile does not use the paused LC.28 checkpoint-congestion hypothesis.
`TwoRegimeRun.lean`, `TwoRegimeProfile.lean`, `TwoRegimeClock.lean`, and
`TwoRegimeExecution.lean` retain the finite fixed-tolerance two-regime
assembly and its first-bad execution theorem.
`TwoRegimeSchedules.lean`, `TwoRegimeTailAsymptotics.lean`, and
`TwoRegimePolylogProfile.lean` now close the canonical schedule, all five
asymptotic tail terms, the shellwise fixed-power exceptional profile, and the
assembly of the resulting shell good sets into one natural-density-one set.
`PolylogExceptionalCount.lean` additionally proves the exact dyadic
shell-to-prefix summation, the resulting quantitative prefix count, and the
change from the explicit base-two scale to the manuscript's
natural-logarithm normalization. `FixedPolylogParameters.lean` proves the
exact entropy formula for `A_FP`, the paper clock identity for `c_*`, and
constructs a complete rational two-regime parameter package for every strict
paper parameter triple. `TwoRegimePolylogExecution.lean` retains the literal
terminal run, converts its terminal rank to the manuscript's natural-log
target, and assembles the quantitative density-one landing theorem.
`TwoRegimeOrbitCeiling.lean` retains that chain's simultaneous landing, clock,
and orbit bound. The strengthened headline instead passes through
`TimeSupportTransport.lean` and the `Shrinking*.lean` chain. The latter proves
that feasible cumulative times have cardinality `O(sqrt (M log M))`, converts
this into a half-power terminal loss, selects every strict
`A > 1/(2*(1-H₂(log₃ 2)))`, and proves the literal terminal witness, orbit
ceiling, quantitative prefix count, and natural-density-one assembly.
`Main.lean` exposes this stronger strict endpoint. `FiniteStartup.lean`
absorbs the finite eventual-witness startup, so the public theorem's
`badCount` is literally over the integers lacking its
clock/landing/orbit-ceiling witness, rather than over an auxiliary good set.
Its strict landing inequality is stronger than the corresponding weak
inequality. The frozen V2.3.1 family and the fixed-tolerance V3 chain remain
as companion mathematics.
