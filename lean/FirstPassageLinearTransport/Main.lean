/-
Copyright (c) 2026 Idris Ali Shaik. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Idris Ali Shaik
-/
import FirstPassageLinearTransport.PowerDescent
import FirstPassageLinearTransport.GradedPowerDescent
import FirstPassageLinearTransport.RawNaturalDensityDescent
import FirstPassageLinearTransport.QuantitativeNaturalDensityDescent
import FirstPassageLinearTransport.OrbitCeiling
import FirstPassageLinearTransport.TwoRegimeOrbitCeiling
import FirstPassageLinearTransport.ShrinkingNaturalDensityDescent
import FirstPassageLinearTransport.MovingEndpointNaturalDensity
import FirstPassageLinearTransport.TimeoutEndpointNaturalDensity
import FirstPassageLinearTransport.FiniteStartup

/-!
# Referee-facing first-passage transport API

Public API for the standalone first-passage linear-transport theorem. Every
dependency is internal to this package or Mathlib; the frozen CET/CEP project
is not imported.

The statements below mention only the literal shortcut and raw Collatz maps,
the package's natural-density-one predicate, the stretched-logarithmic and
fixed-power thresholds, the quantitative exceptional count, and the explicit
shortcut and raw clocks. All parity coding, first-passage fibers,
arbitrary-target transport, bootstrap schedules, and scalar asymptotics remain
behind the imported implementation.

## Literal semantic dictionary

The public theorem types use the following concrete definitions; none is an
abstract map or an unproved input.

* `shortcut n = if n % 2 = 0 then n / 2 else (3 * n + 1) / 2`;
* `orbit k n = (shortcut^[k]) n`;
* `rawCollatz n = if n % 2 = 0 then n / 2 else 3 * n + 1`;
* `rawOrbit j n = (rawCollatz^[j]) n`;
* `badCount S X` counts the positive integers `n <= X` outside `S`;
* `NaturalDensityOne S` means `badCount S X / X` tends to zero as
  `X` tends to infinity;
* `HasStretchedLogDescent delta n` means that some literal shortcut iterate
  is at most `exp ((log n)^(1-delta))`;
* `HasFixedPowerDescent alpha n` means that some literal shortcut iterate is
  at most `n^alpha`.

Thus the declarations below are unconditional statements about the displayed
Collatz maps, with every parameter range, clock, target, and density notion
fixed in their types.
-/

namespace FirstPassageLinearTransport

namespace QuantitativeCollatzMain

open Filter
open scoped Real Topology

/-- **All-prefix alternate moving-endpoint theorem.** This retained V3.1
realization has the same public conclusion as the primary timeout theorem
below.  Let `A M` be any exponent profile bounded above by one fixed positive
constant.  If its exact rank
buffer tends to infinity, then for every shortcut-clock coefficient above
`2 / log(4/3)` and every separately fixed `beta > 0`:

* the simultaneous landing/clock/ceiling witnesses form a natural-density-one
  set;
* their literal exceptional proportion on shell `M` is bounded by the exact
  critical-buffer term plus one fixed negative power of `M`;
* the same iterate supplies the landing, the logarithmic clock, and the whole
  pre-witness orbit ceiling.

Here `movingRankBuffer A M` is definitionally
`(1-H₂(log₃2)) ceil(A M log₂(M+2)) - 1/2 log₂(M+2)
 - log₂(log(M+3))`; no abstract orbit or target predicate occurs in the
conclusion.  Its low-rank proof uses the all-prefix moving certificate. -/
theorem collatz_first_passage_moving_polylogarithmic_natural_density_descent
    {A : ℕ → ℝ} {Amax c beta : ℝ}
    (hAmax : 0 < Amax)
    (hUpper : ∀ M : ℕ, A M ≤ Amax)
    (hc : 2 / Real.log (4 / 3) < c)
    (hbeta : 0 < beta)
    (hbuffer : Tendsto (movingRankBuffer A) atTop atTop) :
    ∃ C eps : ℝ,
      0 < C ∧ 0 < eps ∧
      NaturalDensityOne
        {n : ℕ | ∃ k : ℕ,
          (k : ℝ) < c * Real.log n ∧
          (orbit k n : ℝ) <
            C * (Real.log n) ^ (A (Nat.log 2 n)) ∧
          ∀ j : ℕ, j ≤ k →
            (orbit j n : ℝ) ≤ (n : ℝ) ^ (1 + beta)} ∧
      (∀ᶠ M : ℕ in atTop,
        shellExceptionalRatio
          {n : ℕ | ∃ k : ℕ,
            (k : ℝ) < c * Real.log n ∧
            (orbit k n : ℝ) < C * (Real.log n) ^ (A M) ∧
            ∀ j : ℕ, j ≤ k →
              (orbit j n : ℝ) ≤ (n : ℝ) ^ (1 + beta)} M ≤
          C * ((2 : ℝ) ^ (-(movingRankBuffer A M)) +
            (((M : ℝ) + 2) ^ (-eps)))) := by
  have hc' : fixedPolylogClockCritical < c := by
    simpa [fixedPolylogClockCritical_eq_paper] using hc
  obtain ⟨C, eps, hC, heps, hDense, hShell, _hWitness⟩ :=
    movingEndpointLiteralNaturalDensityDescent hAmax hc' hbeta hbuffer
      (Eventually.of_forall hUpper)
  refine ⟨C, eps, hC, heps, ?_, ?_⟩
  · simpa [assembleDyadic, movingEndpointWitnessGood] using hDense
  · simpa [movingEndpointWitnessGood] using hShell

/-- **Timeout-endpoint first-passage theorem.** This is a separate low-rank
realization of the preceding public statement.  Its low phase uses one
first-timeout event and exact dyadic-endpoint halving, rather than the
all-prefix moving low-stage certificate.  It reuses the common endpoint
parameters, scalar asymptotics, and dyadic natural-density assembly. -/
theorem collatz_first_passage_timeout_moving_polylogarithmic_natural_density_descent
    {A : ℕ → ℝ} {Amax c beta : ℝ}
    (hAmax : 0 < Amax)
    (hUpper : ∀ M : ℕ, A M ≤ Amax)
    (hc : 2 / Real.log (4 / 3) < c)
    (hbeta : 0 < beta)
    (hbuffer : Tendsto (movingRankBuffer A) atTop atTop) :
    ∃ C eps : ℝ,
      0 < C ∧ 0 < eps ∧
      NaturalDensityOne
        {n : ℕ | ∃ k : ℕ,
          (k : ℝ) < c * Real.log n ∧
          (orbit k n : ℝ) <
            C * (Real.log n) ^ (A (Nat.log 2 n)) ∧
          ∀ j : ℕ, j ≤ k →
            (orbit j n : ℝ) ≤ (n : ℝ) ^ (1 + beta)} ∧
      (∀ᶠ M : ℕ in atTop,
        shellExceptionalRatio
          {n : ℕ | ∃ k : ℕ,
            (k : ℝ) < c * Real.log n ∧
            (orbit k n : ℝ) < C * (Real.log n) ^ (A M) ∧
            ∀ j : ℕ, j ≤ k →
              (orbit j n : ℝ) ≤ (n : ℝ) ^ (1 + beta)} M ≤
          C * ((2 : ℝ) ^ (-(movingRankBuffer A M)) +
            (((M : ℝ) + 2) ^ (-eps)))) := by
  have hc' : fixedPolylogClockCritical < c := by
    simpa [fixedPolylogClockCritical_eq_paper] using hc
  obtain ⟨C, eps, hC, heps, hDense, hShell, _hWitness⟩ :=
    timeoutEndpointLiteralNaturalDensityDescent hAmax hc' hbeta hbuffer
      (Eventually.of_forall hUpper)
  refine ⟨C, eps, hC, heps, ?_, ?_⟩
  · simpa [assembleDyadic, timeoutEndpointWitnessGood] using hDense
  · simpa [timeoutEndpointWitnessGood] using hShell

/-- **Fixed-exponent polylogarithmic first-passage theorem.** This is the
formal specialization corresponding to manuscript Corollary 1.2(1).  For every
strict target exponent above
`1 / (2 * (1 - H₂(log₃ 2)))`, every shortcut-clock coefficient above
`2 / log(4/3)`, and every separately fixed `beta > 0`, one explicit
natural-density-one set has all of the following properties:

* a quantitative `O(X (log X)^(-kappa))` count of integers without the
  displayed witness;
* a literal shortcut iterate below `C (log n)^A` before `c log n` steps;
* every intermediate shortcut iterate through that witness is at most
  `n^(1+beta)`.
-/
theorem collatz_first_passage_fixed_polylogarithmic_natural_density_descent
    {A c beta : ℝ}
    (hA : 1 / (2 * (1 - binaryEntropyBaseTwo logThreeTwo)) < A)
    (hc : 2 / Real.log (4 / 3) < c)
    (hbeta : 0 < beta) :
    ∃ C kappa : ℝ,
      0 < C ∧ 0 < kappa ∧
      NaturalDensityOne
        {n : ℕ | ∃ k : ℕ,
          (k : ℝ) < c * Real.log n ∧
          (orbit k n : ℝ) < C * (Real.log n) ^ A ∧
          ∀ j : ℕ, j ≤ k →
            (orbit j n : ℝ) ≤ (n : ℝ) ^ (1 + beta)} ∧
      (∀ᶠ X : ℕ in atTop,
        (badCount
          {n : ℕ | ∃ k : ℕ,
            (k : ℝ) < c * Real.log n ∧
            (orbit k n : ℝ) < C * (Real.log n) ^ A ∧
            ∀ j : ℕ, j ≤ k →
              (orbit j n : ℝ) ≤ (n : ℝ) ^ (1 + beta)} X : ℝ) ≤
          C * X * (Real.log X) ^ (-kappa)) := by
  have hA' : timeSupportCriticalExponent < A := by
    simpa [timeSupportCriticalExponent_eq_entropy] using hA
  have hc' : fixedPolylogClockCritical < c := by
    simpa [fixedPolylogClockCritical_eq_paper] using hc
  obtain ⟨S, Cexc, kappa, hCexc, hkappa, hSdense, hCount, hLanding⟩ :=
    shrinkingFixedPolylogNaturalDensityDescent hA' hc' hbeta
  let Cbase := max Cexc (fixedPolylogTargetConstant A)
  have hCbase : 0 < Cbase := hCexc.trans_le (le_max_left _ _)
  have hCountBase : ∀ᶠ X : ℕ in atTop,
      (badCount S X : ℝ) ≤
        Cbase * X * (Real.log X) ^ (-kappa) := by
    filter_upwards [hCount, eventually_ge_atTop (1 : ℕ)] with X hCount hX
    have hlogX : 0 ≤ Real.log X :=
      Real.log_nonneg (by exact_mod_cast hX)
    exact hCount.trans (by
      calc
        Cexc * X * (Real.log X) ^ (-kappa) ≤
            Cbase * X * (Real.log X) ^ (-kappa) := by
          gcongr
          exact le_max_left _ _)
  have hLandingBase : ∀ᶠ n : ℕ in atTop, n ∈ S →
      ∃ k : ℕ,
        (k : ℝ) < c * Real.log n ∧
        (orbit k n : ℝ) < Cbase * (Real.log n) ^ A ∧
        ∀ j : ℕ, j ≤ k →
          (orbit j n : ℝ) ≤ (n : ℝ) ^ (1 + beta) := by
    filter_upwards [hLanding, eventually_ge_atTop (1 : ℕ)]
      with n hLanding hn hnS
    obtain ⟨k, hk, hdrop, hceiling⟩ := hLanding hnS
    refine ⟨k, hk, hdrop.trans_le ?_, hceiling⟩
    have hlogn : 0 ≤ Real.log n :=
      Real.log_nonneg (by exact_mod_cast hn)
    exact mul_le_mul_of_nonneg_right (le_max_right _ _)
      (Real.rpow_nonneg hlogn A)
  rcases (eventually_atTop.1 hLandingBase) with ⟨N, hN⟩
  let C := Cbase + N + 1
  let kappaFinal := min kappa 1
  let W : Set ℕ :=
    {n : ℕ | ∃ k : ℕ,
      (k : ℝ) < c * Real.log n ∧
      (orbit k n : ℝ) < C * (Real.log n) ^ A ∧
      ∀ j : ℕ, j ≤ k →
        (orbit j n : ℝ) ≤ (n : ℝ) ^ (1 + beta)}
  have hCbaseC : Cbase ≤ C := by
    dsimp [C]
    have hN0 : (0 : ℝ) ≤ N := by positivity
    linarith
  have hSW : ∀ n : ℕ, N ≤ n → n ∈ S → n ∈ W := by
    intro n hn hnS
    obtain ⟨k, hk, hdrop, hceiling⟩ := hN n hn hnS
    refine ⟨k, hk, hdrop.trans_le ?_, hceiling⟩
    have hlogn : 0 ≤ Real.log n := by
      by_cases hn0 : n = 0
      · subst n
        simp
      · exact Real.log_nonneg (by exact_mod_cast (Nat.one_le_iff_ne_zero.2 hn0))
    exact mul_le_mul_of_nonneg_right hCbaseC (Real.rpow_nonneg hlogn A)
  have hCountW : ∀ᶠ X : ℕ in atTop,
      (badCount W X : ℝ) ≤
        C * X * (Real.log X) ^ (-kappaFinal) := by
    simpa [C, kappaFinal] using
      (eventually_badCount_le_polylog_of_tail_subset N hCbase.le hkappa
        hSW hCountBase)
  have hC : 0 < C := hCbase.trans_le hCbaseC
  have hkappaFinal : 0 < kappaFinal := by
    exact lt_min hkappa zero_lt_one
  have hWdense : NaturalDensityOne W :=
    naturalDensityOne_of_eventually_badCount_le_polylog hC.le hkappaFinal hCountW
  refine ⟨C, kappaFinal, hC, hkappaFinal, ?_, ?_⟩
  · simpa [W] using hWdense
  · simpa [W] using hCountW

/-- **Timed first-passage natural-density descent.** For every fixed
`0 < delta < 1`, a natural-density-one set of positive integers has a literal
shortcut-Collatz iterate below `exp ((log n)^(1-delta))` before
`6.953 * log n` shortcut steps. -/
theorem collatz_first_passage_stretched_log_natural_density_descent
    {delta : ℝ} (hdelta0 : 0 < delta) (hdelta1 : delta < 1) :
    ∃ S : Set ℕ,
      NaturalDensityOne S ∧
        ∀ᶠ n : ℕ in atTop,
          n ∈ S →
            ∃ k : ℕ,
              (k : ℝ) < (6953 / 1000 : ℝ) * Real.log n ∧
                (orbit k n : ℝ) ≤
                  Real.exp ((Real.log n) ^ (1 - delta)) := by
  simpa [HasTimedStretchedLogDescent] using
    (firstPassageLinearTransportMain hdelta0 hdelta1)

/-- The corresponding unclocked stretched-logarithmic descent statement. -/
theorem collatz_first_passage_stretched_log_natural_density_descent_unclocked
    {delta : ℝ} (hdelta0 : 0 < delta) (hdelta1 : delta < 1) :
    ∃ S : Set ℕ,
      NaturalDensityOne S ∧
        ∀ᶠ n : ℕ in atTop,
          n ∈ S →
            ∃ k : ℕ,
              (orbit k n : ℝ) ≤
                Real.exp ((Real.log n) ^ (1 - delta)) := by
  obtain ⟨S, hSdense, hS⟩ :=
    collatz_first_passage_stretched_log_natural_density_descent
      hdelta0 hdelta1
  refine ⟨S, hSdense, ?_⟩
  filter_upwards [hS] with n hn hnS
  obtain ⟨k, _hclock, hlanding⟩ := hn hnS
  exact ⟨k, hlanding⟩

/-- **Fixed-power consequence.** For every fixed `alpha > 0`, a
natural-density-one set has a shortcut-Collatz iterate at most `n ^ alpha`
before `6.953 * log n` shortcut steps. -/
theorem collatz_first_passage_fixed_power_natural_density_descent
    {alpha : ℝ} (halpha : 0 < alpha) :
    ∃ S : Set ℕ,
      NaturalDensityOne S ∧
        ∀ᶠ n : ℕ in atTop,
          n ∈ S →
            ∃ k : ℕ,
              (k : ℝ) < (6953 / 1000 : ℝ) * Real.log n ∧
                (orbit k n : ℝ) ≤ (n : ℝ) ^ alpha :=
  firstPassageLinearTransportFixedPower halpha

/-- **Quantitative stretched-logarithmic exceptional count.** Every strict
power `sigma < 1 - delta` is retained, with the explicit prefactor `5`. -/
theorem collatz_first_passage_quantitative_stretched_exceptional_count
    {delta sigma : ℝ}
    (hdelta0 : 0 < delta) (hdelta1 : delta < 1)
    (hsigma0 : 0 < sigma) (hsigma : sigma < 1 - delta) :
    ∃ c : ℝ, 0 < c ∧ ∀ᶠ X : ℕ in atTop,
      (badCount {n | HasStretchedLogDescent delta n} X : ℝ) ≤
        5 * X * Real.exp (-c * (Real.log X) ^ sigma) :=
  firstPassageLinearTransportQuantitativeStretched
    hdelta0 hdelta1 hsigma0 hsigma

/-- **Raw Collatz clock.** The same stretched-logarithmic target is reached
before `10.44 * log n` literal raw Collatz steps. -/
theorem collatz_first_passage_raw_stretched_log_natural_density_descent
    {delta : ℝ} (hdelta0 : 0 < delta) (hdelta1 : delta < 1) :
    ∃ S : Set ℕ,
      NaturalDensityOne S ∧
        ∀ᶠ n : ℕ in atTop,
          n ∈ S →
            ∃ j : ℕ,
              (j : ℝ) < (261 / 25 : ℝ) * Real.log n ∧
                (rawOrbit j n : ℝ) ≤
                  Real.exp ((Real.log n) ^ (1 - delta)) :=
  firstPassageLinearTransportRawMain hdelta0 hdelta1

/-- **Shortcut clock with intermediate-orbit ceiling.** For separately fixed
`beta > 0`, the same witness satisfies the stretched-logarithmic landing and
every shortcut iterate through it remains below `n^(1+beta)`. -/
theorem collatz_first_passage_stretched_log_descent_with_orbit_ceiling
    {delta beta : ℝ}
    (hdelta0 : 0 < delta) (hdelta1 : delta < 1) (hbeta : 0 < beta) :
    ∃ S : Set ℕ,
      NaturalDensityOne S ∧
        ∀ᶠ n : ℕ in atTop,
          n ∈ S →
            ∃ k : ℕ,
              (k : ℝ) < (6953 / 1000 : ℝ) * Real.log n ∧
                (orbit k n : ℝ) ≤
                  Real.exp ((Real.log n) ^ (1 - delta)) ∧
                ∀ j : ℕ, j ≤ k →
                  (orbit j n : ℝ) ≤ (n : ℝ) ^ (1 + beta) :=
  firstPassageLinearTransportOrbitCeiling hdelta0 hdelta1 hbeta

/-- **Quantitative fixed-power exceptional count.** Every fixed positive
power target retains every strict logarithmic rate exponent `sigma < 1`. -/
theorem collatz_first_passage_quantitative_fixed_power_exceptional_count
    {alpha sigma : ℝ} (halpha : 0 < alpha)
    (hsigma0 : 0 < sigma) (hsigma1 : sigma < 1) :
    ∃ c : ℝ, 0 < c ∧ ∀ᶠ X : ℕ in atTop,
      (badCount {n | HasFixedPowerDescent alpha n} X : ℝ) ≤
        5 * X * Real.exp (-c * (Real.log X) ^ sigma) :=
  firstPassageLinearTransportQuantitativeFixedPower
    halpha hsigma0 hsigma1

/-- **Smooth graded shortcut clock.** Reaching `n^alpha` pays only the
fraction `1-alpha` of the full limiting clock, up to arbitrary slack. -/
theorem collatz_first_passage_graded_power_natural_density_descent
    {alpha epsilon : ℝ}
    (halpha0 : 0 < alpha) (halpha1 : alpha < 1)
    (hepsilon : 0 < epsilon) :
    ∃ S : Set ℕ,
      NaturalDensityOne S ∧
        ∀ᶠ n : ℕ in atTop,
          n ∈ S →
            ∃ k : ℕ,
              (k : ℝ) <
                  (2 * (1 - alpha) / Real.log (4 / 3) + epsilon) *
                    Real.log n ∧
                (orbit k n : ℝ) ≤ (n : ℝ) ^ alpha :=
  firstPassageLinearTransportGradedPower halpha0 halpha1 hepsilon

end QuantitativeCollatzMain

end FirstPassageLinearTransport
