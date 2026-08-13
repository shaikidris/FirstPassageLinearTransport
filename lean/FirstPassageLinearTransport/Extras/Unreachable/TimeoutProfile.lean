/-
Copyright (c) 2026 Idris Ali Shaik. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Idris Ali Shaik
-/
/- Generated source-preserving extraction: declarations in this module are outside the canonical referee-facing roots. -/
import FirstPassageLinearTransport.TimeoutFirstBad
import FirstPassageLinearTransport.MovingSharpTail

import FirstPassageLinearTransport.TimeoutProfile
/-!
# Sharp timeout terminal profile

The timeout target has no dyadic-endpoint atom.  Its rankwise density is the
sharp entropy tail alone, and support-sensitive transport leaves exactly the
`sqrt L * exp (-b L)` terminal factor.
-/

namespace FirstPassageLinearTransport

open scoped BigOperators Real

noncomputable section


/-- Exact sharp sum of all low first-timeout ranks. -/
theorem timeout_low_firstBad_sharp_sum_le
    {P : TimeoutHighRunData} {K₀ : ℝ} {rStar : ℚ}
    {L M S : ℕ}
    (hrStar : 0 < rStar) (hStarHi : rStar ≤ P.rHi)
    (hStarLo : (rStar : ℝ) ≤ movingLowRatio K₀ L)
    (hM : 1 ≤ M) (hLS : L ≤ S) (hSM : S < M) (hL : 2 ≤ L)
    (hnextPos : ∀ p ∈ Finset.Icc L S,
      0 < timeoutTargetRank K₀ L (p - 1))
    (hnextLt : ∀ p ∈ Finset.Icc L S,
      timeoutTargetRank K₀ L (p - 1) < p)
    (hsmall : ∀ p ∈ Finset.Icc L S,
      ((((p + 2 : ℕ) : ℚ) / rStar) /
        ((2 ^ p : ℕ) : ℚ)) ≤ 1 / 3)
    {H C b₀ b : ℝ}
    (hTimes : ∀ p ∈ Finset.Icc L S,
      ((timeoutFeasibleTimes P K₀ L M S p).card : ℝ) ≤ H)
    (hTarget : ∀ p ∈ Finset.Icc L S,
      ((timeoutLandingBad K₀ L p).card : ℝ) / (2 : ℝ) ^ p ≤
        (C / Real.sqrt ((p - 1 : ℕ) : ℝ)) *
          Real.exp (-(b * ((p - 1 : ℕ) : ℝ))))
    (hb₀ : 0 < b₀) (hb₀b : b₀ ≤ b) :
    ∑ p in Finset.Icc L S,
        ((timeoutFirstBadSourcesAtRank P K₀ L M S p).card : ℝ) /
          (2 : ℝ) ^ M ≤
      H * (1 + 6 / (rStar : ℝ)) * C *
        (3 * Real.sqrt L * Real.exp (-(b * ((L - 1 : ℕ) : ℝ))) *
          weightedTailConstant b₀ (b₀ / 2)) := by
  have hterm : ∀ p ∈ Finset.Icc L S,
      ((timeoutFirstBadSourcesAtRank P K₀ L M S p).card : ℝ) /
          (2 : ℝ) ^ M ≤
        H * (1 + 6 / (rStar : ℝ)) * C *
          (((p + 1 : ℕ) : ℝ) /
            Real.sqrt ((p - 1 : ℕ) : ℝ) *
              Real.exp (-(b * ((p - 1 : ℕ) : ℝ)))) := by
    intro p hpI
    have hpI' := Finset.mem_Icc.mp hpI
    have hp1 : 1 ≤ p := by omega
    have hpM : p < M := hpI'.2.trans_lt hSM
    have hbase := timeoutFirstBadSourcesAtRank_density_le
      (S := S) hrStar hStarHi hStarLo hM hp1
      (hnextPos p hpI) (hnextLt p hpI) hpM (hsmall p hpI)
      (hTimes p hpI) (hTarget p hpI)
    calc
      ((timeoutFirstBadSourcesAtRank P K₀ L M S p).card : ℝ) /
          (2 : ℝ) ^ M ≤
        H * (1 + 6 / (rStar : ℝ)) * ((p + 1 : ℕ) : ℝ) *
          ((C / Real.sqrt ((p - 1 : ℕ) : ℝ)) *
            Real.exp (-(b * ((p - 1 : ℕ) : ℝ)))) := hbase
      _ = H * (1 + 6 / (rStar : ℝ)) * C *
          (((p + 1 : ℕ) : ℝ) /
            Real.sqrt ((p - 1 : ℕ) : ℝ) *
              Real.exp (-(b * ((p - 1 : ℕ) : ℝ)))) := by ring
  have htail := sharp_entropy_tail_exact_rate_Icc_le hb₀ hb₀b hL hLS
  calc
    ∑ p in Finset.Icc L S,
        ((timeoutFirstBadSourcesAtRank P K₀ L M S p).card : ℝ) /
          (2 : ℝ) ^ M ≤
      ∑ p in Finset.Icc L S,
        H * (1 + 6 / (rStar : ℝ)) * C *
          (((p + 1 : ℕ) : ℝ) /
            Real.sqrt ((p - 1 : ℕ) : ℝ) *
              Real.exp (-(b * ((p - 1 : ℕ) : ℝ)))) :=
        Finset.sum_le_sum hterm
    _ = H * (1 + 6 / (rStar : ℝ)) * C *
        (∑ p in Finset.Icc L S,
          ((p + 1 : ℕ) : ℝ) / Real.sqrt ((p - 1 : ℕ) : ℝ) *
            Real.exp (-(b * ((p - 1 : ℕ) : ℝ)))) := by
      rw [Finset.mul_sum]
    _ ≤ H * (1 + 6 / (rStar : ℝ)) * C *
        (3 * Real.sqrt L * Real.exp (-(b * ((L - 1 : ℕ) : ℝ))) *
          weightedTailConstant b₀ (b₀ / 2)) := by
      have hcoef0 : 0 ≤ H * (1 + 6 / (rStar : ℝ)) * C := by
        have hH0 : 0 ≤ H := by
          have hcard0 : 0 ≤
              ((timeoutFeasibleTimes P K₀ L M S L).card : ℝ) := by positivity
          exact hcard0.trans (hTimes L (Finset.mem_Icc.mpr ⟨le_rfl, hLS⟩))
        have hC0 : 0 ≤ C := by
          have htarget0 : 0 ≤
              ((timeoutLandingBad K₀ L L).card : ℝ) / (2 : ℝ) ^ L := by positivity
          have hbound := hTarget L (Finset.mem_Icc.mpr ⟨le_rfl, hLS⟩)
          have hsqrtPos : 0 < Real.sqrt ((L - 1 : ℕ) : ℝ) :=
            Real.sqrt_pos.2 (by exact_mod_cast (show 0 < L - 1 by omega))
          have hexpPos := Real.exp_pos (-(b * ((L - 1 : ℕ) : ℝ)))
          by_contra hCneg
          have : (C / Real.sqrt ((L - 1 : ℕ) : ℝ)) *
              Real.exp (-(b * ((L - 1 : ℕ) : ℝ))) < 0 := by
            exact mul_neg_of_neg_of_pos (div_neg_of_neg_of_pos
              (lt_of_not_ge hCneg) hsqrtPos) hexpPos
          linarith
        positivity
      exact mul_le_mul_of_nonneg_left htail hcoef0


end

end FirstPassageLinearTransport
