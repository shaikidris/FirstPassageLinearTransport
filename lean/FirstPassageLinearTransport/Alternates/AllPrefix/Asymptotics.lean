/-
Copyright (c) 2026 Idris Ali Shaik. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Idris Ali Shaik
-/
import FirstPassageLinearTransport.MovingEndpointAsymptotics
import FirstPassageLinearTransport.Alternates.AllPrefix.Implementation.MovingEndpointProfile

import FirstPassageLinearTransport.Extras.Unreachable
/-!
# All-prefix moving endpoint shell error

Final scalar-to-set adapter for the retained all-prefix realization.  The
canonical timeout route uses the scalar inequalities from
`MovingEndpointAsymptotics` but does not import this generated-set theorem.
-/

namespace FirstPassageLinearTransport

open Filter
open scoped Real Topology

/-- The all-prefix literal moving shell family satisfies the exact error
profile consumed by the common natural-density assembly. -/
theorem exists_eventually_movingEndpointGood_shellError
    {Amax c beta : ℝ}
    (P : MovingEndpointParameterPackage Amax c beta)
    {A : ℕ → ℝ}
    (hbuffer : Tendsto (movingRankBuffer A) atTop atTop)
    (hUpper : ∀ᶠ M : ℕ in atTop, A M ≤ Amax) :
    ∃ C : ℝ, 0 < C ∧
      ∀ᶠ M : ℕ in atTop,
        shellExceptionalRatio (movingEndpointGood P A M) M ≤
          C * ((2 : ℝ) ^ (-(movingRankBuffer A M)) +
            (((M : ℝ) + 2) ^ (-P.epsilon))) := by
  obtain ⟨C, D, hC, hD, hRaw⟩ :=
    exists_eventually_movingEndpointGood_rawProfile P hbuffer hUpper
  refine ⟨movingEndpointProfileConstant P C D, ?_, ?_⟩
  · unfold movingEndpointProfileConstant
    dsimp only
    have hK : 0 < 1 + quadraticWindowShellConstant := by
      linarith [quadraticWindowShellConstant_pos]
    have hT : 0 ≤ movingTimeSupportConstant P.run P.Cswitch + 1 := by
      have hrHi0 : 0 < (P.run.rHi : ℝ) := P.run.pHi.r_pos
      have hsqrtSq := Real.sq_sqrt hrHi0.le
      have hsqrt0 := Real.sqrt_nonneg (P.run.rHi : ℝ)
      have hsqrt1 : Real.sqrt (P.run.rHi : ℝ) < 1 := by
        nlinarith [P.run.pHi.r_lt_one]
      have hden : 0 < 1 - Real.sqrt (P.run.rHi : ℝ) := sub_pos.mpr hsqrt1
      have hnum : 0 ≤ P.run.D + P.run.tau + 3 := by
        linarith [P.run.D_pos, P.run.pHi.eta_pos]
      have hfrac : 0 ≤
          (P.run.D + P.run.tau + 3) /
            (1 - Real.sqrt (P.run.rHi : ℝ)) := div_nonneg hnum hden.le
      have hinner : 0 ≤
          (P.run.D + P.run.tau + 3) /
              (1 - Real.sqrt (P.run.rHi : ℝ)) +
            (P.Cswitch + 5) ^ 2 := by positivity
      have hratio : 0 ≤ 2 / driftGap :=
        div_nonneg (by norm_num) driftGap_pos.le
      dsimp [movingTimeSupportConstant]
      nlinarith [mul_nonneg hratio hinner]
    have hR : 0 ≤ 1 + 6 / (P.run.rStar : ℝ) := by
      have hr : (0 : ℝ) < (P.run.rStar : ℝ) := by
        exact_mod_cast P.run.rStar_pos
      positivity
    have hQ : 0 ≤ exactSharpCriticalLowSeriesConstant
        (firstPassageEndpointRate / 2) (C / 2) :=
      (exactSharpCriticalLowSeriesConstant_spec
        (div_pos firstPassageEndpointRate_pos (by norm_num))
        (by positivity : 0 ≤ C / 2)).1.le
    positivity
  · have hScalar := eventually_movingEndpointRawProfile_le_shellError
      P hC hD hbuffer hUpper
    filter_upwards [hRaw, hScalar] with M hRaw hScalar
    exact hRaw.trans hScalar

end FirstPassageLinearTransport
