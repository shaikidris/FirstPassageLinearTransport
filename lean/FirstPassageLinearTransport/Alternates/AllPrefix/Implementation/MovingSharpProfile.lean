/-
Copyright (c) 2026 Idris Ali Shaik. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Idris Ali Shaik
-/
import FirstPassageLinearTransport.Alternates.AllPrefix.Implementation.MovingFirstBad
import FirstPassageLinearTransport.Alternates.AllPrefix.Implementation.MovingProfile
import FirstPassageLinearTransport.MovingSharpTail
import FirstPassageLinearTransport.Alternates.AllPrefix.Implementation.MovingLowDensity

import FirstPassageLinearTransport.Extras.Unreachable
/-!
# Sharp moving terminal profile

This module keeps the Boolean-walk prefactor `q^{-1/2}` through the low-rank
first-bad sum.  It is the correct cut vertex for the V3.1 buffer

```text
Δ_M = κ_* L - ½ log₂ M - log₂ log M,
```

whereas `MovingProfile.movingSeparatedFailureEnvelope_density_terminalProfile`
routes the low density through the coarser `terminalTailBound` and therefore
spends an extra polynomial factor.

The exact-rate theorem below is still conditional on high/low target densities
and time-support cardinality; it does not yet discharge uniform low-stage
startup `pLo.M0 ≤ L` or assemble the public moving headline.  Those later
cut vertices remain separate in `proof-state.md`.
-/

namespace FirstPassageLinearTransport

open scoped BigOperators Real

noncomputable section

/-- Convert the sharp landing-shell density into the summand shape consumed by
`exact_sharp_critical_low_series_Icc_le`. -/
theorem landingBad_sharp_density_le
    {q : ℕ} (_hq : 2 ≤ q) {t C b : ℝ}
    (_hC : 0 ≤ C)
    (hcard :
      ((landingBad q t).card : ℝ) / (2 : ℝ) ^ q ≤
        1 / (2 : ℝ) ^ q +
          (C / Real.sqrt ((q - 1 : ℕ) : ℝ)) *
            Real.exp (-(b * ((q - 1 : ℕ) : ℝ)))) :
    ((landingBad q t).card : ℝ) / (2 : ℝ) ^ q ≤
      Real.exp (-(Real.log 2 * (q : ℝ))) +
        (C / Real.sqrt ((q - 1 : ℕ) : ℝ)) *
          Real.exp (-(b * ((q - 1 : ℕ) : ℝ))) := by
  have hpow : 1 / (2 : ℝ) ^ q = Real.exp (-(Real.log 2 * (q : ℝ))) := by
    simpa using one_div_two_pow_eq_exp q
  exact hcard.trans_eq (by rw [hpow])

/-- Rankwise first-bad density under a sharp low landing bound. -/
theorem movingFirstBadSourcesAtRank_sharp_density_le
    {P : ShrinkingBarrierRunData} {rLo tLo : ℝ}
    (pLo : StageSetup rLo tLo) {rStar : ℚ}
    (hrStar : 0 < rStar) (hStarHi : rStar ≤ P.rHi)
    (hStarLo : (rStar : ℝ) ≤ rLo)
    (htLoA : tLo < a0) {M S q : ℕ} (hM : 1 ≤ M)
    (hqM : q < M) (hq2 : 2 ≤ q)
    (hsmall : ((((q + 2 : ℕ) : ℚ) / rStar) /
      ((2 ^ q : ℕ) : ℚ)) ≤ 1 / 3)
    {H C b : ℝ}
    (hTimes : ((movingFeasibleTimes P pLo M S q).card : ℝ) ≤ H)
    (hC : 0 ≤ C)
    (hTarget :
      ((landingBad q (movingTargetTolerance P tLo M S q)).card : ℝ) /
        (2 : ℝ) ^ q ≤
          1 / (2 : ℝ) ^ q +
            (C / Real.sqrt ((q - 1 : ℕ) : ℝ)) *
              Real.exp (-(b * ((q - 1 : ℕ) : ℝ)))) :
    ((movingFirstBadSourcesAtRank P pLo M S q).card : ℝ) /
        (2 : ℝ) ^ M ≤
      H * (1 + 6 / (rStar : ℝ)) * ((q + 1 : ℕ) : ℝ) *
        (Real.exp (-(Real.log 2 * (q : ℝ))) +
          (C / Real.sqrt ((q - 1 : ℕ) : ℝ)) *
            Real.exp (-(b * ((q - 1 : ℕ) : ℝ)))) := by
  have hd := landingBad_sharp_density_le hq2 hC hTarget
  exact movingFirstBadSourcesAtRank_density_le (S := S) pLo
    hrStar hStarHi hStarLo htLoA hM hqM hsmall hTimes hd

/-- Conditional sharp low-rank contribution at the exact landing rate.
The constant is uniform for every actual entropy rate `b ≥ b₀`; the output
retains `b` itself and therefore preserves the critical endpoint buffer. -/
theorem moving_low_firstBad_sharp_exact_sum_canonical_le
    {P : ShrinkingBarrierRunData} {rLo tLo : ℝ}
    (pLo : StageSetup rLo tLo) {rStar : ℚ}
    (hrStar : 0 < rStar) (hStarHi : rStar ≤ P.rHi)
    (hStarLo : (rStar : ℝ) ≤ rLo)
    (htLoA : tLo < a0)
    {M L S : ℕ} {H C b₀ b : ℝ}
    (hM : 1 ≤ M) (hLS : L ≤ S) (hSM : S < M) (hL : 2 ≤ L)
    (hH0 : 0 ≤ H) (hC : 0 ≤ C)
    (hsmall : ∀ q ∈ Finset.Icc L S,
      ((((q + 2 : ℕ) : ℚ) / rStar) /
        ((2 ^ q : ℕ) : ℚ)) ≤ 1 / 3)
    (hTimes : ∀ q ∈ Finset.Icc L S,
      ((movingFeasibleTimes P pLo M S q).card : ℝ) ≤ H)
    (hLow : ∀ q ∈ Finset.Icc L S,
      ((landingBad q tLo).card : ℝ) / (2 : ℝ) ^ q ≤
        1 / (2 : ℝ) ^ q +
          (C / Real.sqrt ((q - 1 : ℕ) : ℝ)) *
            Real.exp (-(b * ((q - 1 : ℕ) : ℝ))))
    (hb₀ : 0 < b₀) (hb₀b : b₀ ≤ b) :
    ∑ q in Finset.Icc L S,
          ((movingFirstBadSourcesAtRank P pLo M S q).card : ℝ) /
            (2 : ℝ) ^ M ≤
        H * (1 + 6 / (rStar : ℝ)) *
          exactSharpCriticalLowSeriesConstant b₀ C *
          (((L + 1 : ℕ) : ℝ) * Real.exp (-(Real.log 2 * (L : ℝ))) +
            Real.sqrt L * Real.exp (-(b * ((L - 1 : ℕ) : ℝ)))) := by
  obtain ⟨_hK0, hseries⟩ :=
    exactSharpCriticalLowSeriesConstant_spec hb₀ hC
  let K0 := exactSharpCriticalLowSeriesConstant b₀ C
  have hrR : (0 : ℝ) < (rStar : ℝ) := by exact_mod_cast hrStar
  have hcoef0 : 0 ≤ H * (1 + 6 / (rStar : ℝ)) := by positivity
  have hterm : ∀ q ∈ Finset.Icc L S,
      ((movingFirstBadSourcesAtRank P pLo M S q).card : ℝ) /
          (2 : ℝ) ^ M ≤
        H * (1 + 6 / (rStar : ℝ)) * ((q + 1 : ℕ) : ℝ) *
          (Real.exp (-(Real.log 2 * (q : ℝ))) +
            (C / Real.sqrt ((q - 1 : ℕ) : ℝ)) *
              Real.exp (-(b * ((q - 1 : ℕ) : ℝ)))) := by
    intro q hq
    have hqi := Finset.mem_Icc.mp hq
    have hqM : q < M := hqi.2.trans_lt hSM
    have hq2 : 2 ≤ q := hL.trans hqi.1
    have hTol : movingTargetTolerance P tLo M S q = tLo :=
      movingTargetTolerance_eq_low P tLo (le_trans (by norm_num) hq2) hqi.2
    have hT := hLow q hq
    rw [← hTol] at hT
    exact movingFirstBadSourcesAtRank_sharp_density_le (S := S) pLo
      hrStar hStarHi hStarLo htLoA hM hqM hq2 (hsmall q hq)
      (hTimes q hq) hC hT
  calc
    ∑ q in Finset.Icc L S,
        ((movingFirstBadSourcesAtRank P pLo M S q).card : ℝ) /
          (2 : ℝ) ^ M ≤
      ∑ q in Finset.Icc L S,
        H * (1 + 6 / (rStar : ℝ)) * ((q + 1 : ℕ) : ℝ) *
          (Real.exp (-(Real.log 2 * (q : ℝ))) +
            (C / Real.sqrt ((q - 1 : ℕ) : ℝ)) *
              Real.exp (-(b * ((q - 1 : ℕ) : ℝ)))) :=
      Finset.sum_le_sum hterm
    _ = H * (1 + 6 / (rStar : ℝ)) *
        ∑ q in Finset.Icc L S,
          ((q + 1 : ℕ) : ℝ) *
            (Real.exp (-(Real.log 2 * (q : ℝ))) +
              (C / Real.sqrt ((q - 1 : ℕ) : ℝ)) *
                Real.exp (-(b * ((q - 1 : ℕ) : ℝ)))) := by
      rw [Finset.mul_sum]
      apply Finset.sum_congr rfl
      intro q hq
      ring
    _ ≤ H * (1 + 6 / (rStar : ℝ)) *
        (K0 * (((L + 1 : ℕ) : ℝ) *
            Real.exp (-(Real.log 2 * (L : ℝ))) +
          Real.sqrt L * Real.exp (-(b * ((L - 1 : ℕ) : ℝ))))) := by
      gcongr
      exact hseries hb₀b hL hLS
    _ = H * (1 + 6 / (rStar : ℝ)) * K0 *
        (((L + 1 : ℕ) : ℝ) * Real.exp (-(Real.log 2 * (L : ℝ))) +
          Real.sqrt L * Real.exp (-(b * ((L - 1 : ℕ) : ℝ)))) := by
      ring

/-- Existential compatibility wrapper for the canonical low-rank profile. -/
theorem moving_low_firstBad_sharp_exact_sum_le
    {P : ShrinkingBarrierRunData} {rLo tLo : ℝ}
    (pLo : StageSetup rLo tLo) {rStar : ℚ}
    (hrStar : 0 < rStar) (hStarHi : rStar ≤ P.rHi)
    (hStarLo : (rStar : ℝ) ≤ rLo)
    (htLoA : tLo < a0)
    {M L S : ℕ} {H C b₀ b : ℝ}
    (hM : 1 ≤ M) (hLS : L ≤ S) (hSM : S < M) (hL : 2 ≤ L)
    (hH0 : 0 ≤ H) (hC : 0 ≤ C)
    (hsmall : ∀ q ∈ Finset.Icc L S,
      ((((q + 2 : ℕ) : ℚ) / rStar) /
        ((2 ^ q : ℕ) : ℚ)) ≤ 1 / 3)
    (hTimes : ∀ q ∈ Finset.Icc L S,
      ((movingFeasibleTimes P pLo M S q).card : ℝ) ≤ H)
    (hLow : ∀ q ∈ Finset.Icc L S,
      ((landingBad q tLo).card : ℝ) / (2 : ℝ) ^ q ≤
        1 / (2 : ℝ) ^ q +
          (C / Real.sqrt ((q - 1 : ℕ) : ℝ)) *
            Real.exp (-(b * ((q - 1 : ℕ) : ℝ))))
    (hb₀ : 0 < b₀) (hb₀b : b₀ ≤ b) :
    ∃ K : ℝ, 0 < K ∧
      ∑ q in Finset.Icc L S,
          ((movingFirstBadSourcesAtRank P pLo M S q).card : ℝ) /
            (2 : ℝ) ^ M ≤
        H * (1 + 6 / (rStar : ℝ)) * K *
          (((L + 1 : ℕ) : ℝ) * Real.exp (-(Real.log 2 * (L : ℝ))) +
            Real.sqrt L * Real.exp (-(b * ((L - 1 : ℕ) : ℝ)))) := by
  refine ⟨exactSharpCriticalLowSeriesConstant b₀ C,
    (exactSharpCriticalLowSeriesConstant_spec hb₀ hC).1, ?_⟩
  exact moving_low_firstBad_sharp_exact_sum_canonical_le pLo hrStar
    hStarHi hStarLo htLoA hM hLS hSM hL hH0 hC hsmall hTimes hLow
    hb₀ hb₀b


end

end FirstPassageLinearTransport
