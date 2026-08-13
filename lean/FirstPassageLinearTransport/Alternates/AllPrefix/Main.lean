/-
Copyright (c) 2026 Idris Ali Shaik. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Idris Ali Shaik
-/
import FirstPassageLinearTransport.Alternates.AllPrefix.NaturalDensity

import FirstPassageLinearTransport.Extras.Unreachable
/-!
# Retained all-prefix moving-endpoint alternate

This module exposes the former V3.1 all-prefix realization separately from the
canonical timeout theorem. It is not imported by `FirstPassageLinearTransport.Main`
and is not part of the default Lake target.
-/

namespace FirstPassageLinearTransport

namespace Alternates.AllPrefix

open Filter
open scoped Real Topology

/-- **All-prefix alternate moving-endpoint theorem.** Let `A M` be any
exponent profile bounded above by one fixed positive constant. If its exact
rank buffer tends to infinity, then every shortcut-clock coefficient above
`2 / log(4/3)` and every separately fixed `beta > 0` give the same literal
landing, clock, ceiling, and shell-error conclusion as the canonical timeout
theorem. The proof here uses the retained all-prefix moving certificate. -/
theorem collatz_first_passage_all_prefix_moving_polylogarithmic_natural_density_descent
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

end Alternates.AllPrefix

end FirstPassageLinearTransport
