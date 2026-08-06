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
