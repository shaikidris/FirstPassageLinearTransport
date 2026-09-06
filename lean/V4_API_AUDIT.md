# Version 4 Lean API audit

**Date:** 5 September 2026
**Branch:** `revision/v4-ballot-strengthening`
**Classification:** `CLOSURE`
**Target:** the literal dependency chain of Theorem 1.1 and Corollary
1.2(1),(4), not an exploratory stronger theorem.

## Target-sanity card

- **Strongest existing result.**  The Version 3 cone already checks exact
  parity coding, affine shortcut iteration, reverse first-passage transport,
  the `O(sqrt(M log M))` feasible-time support, timeout execution, natural
  density assembly, and the old fixed-exponent endpoint theorem.
- **New mathematical input.**  Appendix B's prefix-sensitive finite ballot
  estimate replaces the terminal-only timeout count
  `m^(-1/2) exp(-b m)` by `m^(-3/2) exp(-b m)`.
- **Why this changes the endpoint.**  Reverse transport contributes one
  factor of the landing rank.  The new local prefactor therefore leaves a
  rank term of order `p^(-1/2) exp(-b p)`, whose tail begins at
  `L^(-1/2) exp(-b L)`.  After multiplication by the feasible-time support,
  this removes the compulsory secondary logarithm from the Version 3
  buffer.
- **Public-strength delta.**  Version 4 additionally exposes centered
  shortcut and raw clocks, a common physical landing, and a relative
  `n * R(n)` ceiling for both trajectories.  None of those conclusions is a
  wrapper around the existing one-sided Version 3 witness.
- **Nonclaims.**  The pure critical target with a bounded multiplier,
  pointwise Collatz convergence, exclusion of cycles/divergence, and orbit
  control after the selected witness remain outside the target.

## Existing interfaces that can be reused unchanged

| Paper role | Existing Lean owner | Reusable declaration/interface |
|---|---|---|
| Exact parity law | `Parity.lean`, `Barrier.lean` | `parityEquiv`, `boolParityEquiv`, `card_dyadicShell_filter_mod_mem` |
| Exact affine iterate | `Parity.lean` | `exact_affine_iterate_scaled` |
| Literal timeout and total execution | `TimeoutCore.lean`, `TimeoutExecution.lean` | `LowStageTimeout`, `timeoutSource_terminal_or_failure` |
| First-timeout pullback | `TimeoutFirstBad.lean` | `timeoutFirstBadSourcesAtRank_card_le` |
| Compressed cumulative times | `TimeoutTimeSupport.lean` | `eventually_timeoutFeasibleTimes_card_lt_sqrt` |
| Exact raw/shortcut landing identity | `RawDynamics.lean` | `rawTime`, `rawOrbit_rawTime_eq_orbit` |
| Dyadic-to-natural-density assembly | `VaryingDensity.lean` | `naturalDensityOne_assembleDyadic` and shell-prefix summation interfaces |
| Entropy/Stirling infrastructure | `SharpEntropyBarrier.lean` | factorial bounds, binomial prefactor, exact entropy normalization |

## Interfaces that are genuinely missing

| ID | Missing checked statement | Why Version 3 is insufficient | Planned owner |
|---|---|---|---|
| B1 | Finite centered survival estimate for the tilted two-letter walk | no survival/prefix probability theorem exists | `FiniteBallot.lean`; **checked** by `lowerSurvivalMass_le_centered_explicit` and `lowerSurvivalMass_le_centered` |
| B2 | Uniform binomial atom at the fixed tilted parameter | current sharp theorem controls an upper tail under fair mass, not a tilted atom | `FiniteBallot.lean`; **checked** uniformly on the Collatz window by `exists_tiltedBinomialMass_le_sqrt` |
| B3 | Fair mass of words satisfying every fixed logarithmic prefix barrier is `O(m^(-3/2) 2^(-kappa_* m))` | `barrierHitCount_le_binaryEntropy` controls hitting a symmetric linear barrier and has no ballot prefactor | `FiniteBallot.lean`; **checked** through `exists_sum_collatzQuarterSplitFullWordMass_le`, including exact three-block coordinates and the full-word adapter |
| T1 | A literal affine timeout lies in B3's fixed-barrier language uniformly for `L <= m <= C L` | current `timeoutShellBad_subset_terminalOddUpperShell` uses only the terminal prefix | `TimeoutDensity.lean`; **checked** by `timeout_word_survives_uniform_barrier` and `exists_timeoutShellBad_ballot_fixed_constant` |
| T2 | Rankwise timeout pullback summed with terminal factor `L^(-1/2) exp(-bL)` | Version 3's `timeout_low_firstBad_sharp_sum_canonical_le` ends in `sqrt L exp(-bL)` | `TimeoutProfile.lean`; **checked** by `timeout_low_firstBad_ballot_sum_canonical_le` and its literal-shell consumer `exists_timeout_low_firstBad_ballot_sum_canonical_le` |
| H1 | Finite multiplicative maximum with exception `R^(-1)` and its shell adapter | current ceiling is the fixed-power `n^(1+beta)` envelope | **checked**: finite-word producer `normalized_multiplicativeHitCount_le_inv`, exact shell count `normalized_card_shellMultiplicativeHit_quarter_le`, and common first-block shortcut/raw bound `initial_shortcut_raw_height_of_not_mem_shellMultiplicativeHit` |
| C1 | Two-sided centered shortcut clock and centered raw clock for the assembled timeout run | current public endpoint gives only `k < c log n`; raw budget is only one-sided | **checked** in `TimeoutRawClock.lean`, `TimeoutTrajectoryProfile.lean`, and the endpoint consumer |
| S1 | Strengthened shell-good predicate carrying common landing, both clocks, and both ceilings | current `timeoutEndpointGood` carries only the failure-envelope complement | **checked** in the timeout endpoint profile/witness modules |
| A1 | Exact fixed-`A` endpoint-rate and arbitrary nonmonotone `U,R` consumers | current assembly spends a strict exponent and has no arbitrary shell-minorant interface | **checked** in `CriticalEndpointConsequences.lean` |

## Dependency decision

The first proof edit must be the finite Boolean-word layer.  It must not
replace B1--B3 by a theorem parameter, an opaque structure field, a project
axiom, or a manuscript-derived assumption.  The timeout and public theorem
layers remain unchanged until that producer compiles.

The exact Lean signatures of the three selected roots will be frozen only
after the strengthened shell-witness structure is defined.  Freezing them
earlier would either duplicate a long conjunction three times or hide a
material claim behind an unreviewed predicate.

## Baseline

- Toolchain: Lean `v4.15.0`, matching the current research repository.
- Dependency cache: isolated in this worktree; the public repository is not
  used for proof search or modified.
- Baseline target: `FirstPassageLinearTransport.TimeoutEndpointAudit`.
- Baseline result: the isolated worktree dependency replay was started and
  interrupted after target 2637/5927 only to prioritize the first new module;
  no failure occurred before interruption.
- Version 4 module command:
  `lake build +FirstPassageLinearTransport.FiniteBallot:olean`.  The leading `+`
  is intentional to select the module unambiguously.  Because the inherited
  `Basic.lean` imports the Mathlib umbrella, the first isolated build still
  replays the pinned Mathlib dependency.
- Current producer result: `FiniteBallot.lean` checks Appendix B.1--B.4's
  principal upper-bound interfaces, including exact fair-to-critical product
  weights, the tilted three-block envelope, quarter-scale arithmetic, unique
  full-word coordinates, canonical terminal bins, and the summed
  `m^(-3/2)` full-word estimate.  `TimeoutDensity.lean` now checks the actual
  affine-prefix containment, the uniform low-window barrier, exact shell
  parity transport, and the fixed-parameter timeout bound
  `D / (m * sqrt m) * exp(-firstPassageEndpointRate * m)`.  The four new
  audit roots report exactly `propext`, `Classical.choice`, and `Quot.sound`.
  `TimeoutProfile.lean` now transports that density through the exact
  first-bad pullback and sums it with terminal factor
  `L^(-1/2) * exp(-firstPassageEndpointRate * L)`; its three audit roots have
  the same standard axiom report.  `OrbitCeiling.lean` now checks the exact
  shell `4/R` exception and the common shortcut/raw first-block height
  adapter, again with the same standard axioms.  The strengthened shell
  assembly, centered clocks, trajectory tubes, critical consumers, reciprocal
  obstructions, fixed-polylogarithmic lower order, and strict-exponent
  stretched relative-height theorem now also pass `V4EndpointAudit.lean` with
  exactly the same three standard axioms.  The remaining proof-facing
  obligations are the endpoint-rate/arbitrary-clock stretched theorem,
  literal secondary-/tertiary-log sharpness packaging, the graded-power
  Version 4 companion, and the constant-slack prefix-entropy consumer.
