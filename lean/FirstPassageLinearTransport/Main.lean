/-
Copyright (c) 2026 Idris Ali Shaik. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Idris Ali Shaik
-/
import FirstPassageLinearTransport.PowerDescent

/-!
# Referee-facing first-passage transport API

Public API for the standalone first-passage linear-transport theorem. Every
dependency is internal to this package or Mathlib; the frozen CET/CEP project
is not imported.

The statements below mention only the literal shortcut Collatz map, the
package's natural-density-one predicate, the stretched-logarithmic threshold,
and the explicit `6.953 * log n` shortcut-step clock. All parity coding,
first-passage fibers, arbitrary-target transport, bootstrap schedules, and
scalar asymptotics remain behind the imported implementation.
-/

namespace FirstPassageLinearTransport

namespace QuantitativeCollatzMain

open Filter

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

end QuantitativeCollatzMain

end FirstPassageLinearTransport
