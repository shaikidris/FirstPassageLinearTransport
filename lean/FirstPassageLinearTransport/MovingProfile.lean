/-
Copyright (c) 2026 Idris Ali Shaik. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Idris Ali Shaik
-/
import FirstPassageLinearTransport.MovingFirstBad
import FirstPassageLinearTransport.TerminalProfile

/-!
# Support-sensitive moving-barrier terminal profile

Rankwise first-bad densities are multiplied by the moving feasible-time
cardinality rather than a linear horizon.  High- and low-rank targets remain
separate so the moving low tolerance is never substituted into the high phase.
The common reverse-loss ratio is an arbitrary positive rational dominated by
both regimes; it is never required to approach one with the low schedule.
-/

namespace FirstPassageLinearTransport

open scoped BigOperators

noncomputable section

/-- Real rankwise density estimate after support-sensitive transport and the
linear rank multiplier. -/
theorem movingFirstBadSourcesAtRank_density_le
    {P : ShrinkingBarrierRunData} {rLo tLo : ℝ}
    (pLo : StageSetup rLo tLo) {rStar : ℚ}
    (hrStar : 0 < rStar) (hStarHi : rStar ≤ P.rHi)
    (hStarLo : (rStar : ℝ) ≤ rLo)
    (htLoA : tLo < a0) {M S q : ℕ} (hM : 1 ≤ M)
    (hqM : q < M)
    (hsmall : ((((q + 2 : ℕ) : ℚ) / rStar) /
      ((2 ^ q : ℕ) : ℚ)) ≤ 1 / 3)
    {H d : ℝ}
    (hTimes : ((movingFeasibleTimes P pLo M S q).card : ℝ) ≤ H)
    (hTarget :
      ((landingBad q (movingTargetTolerance P tLo M S q)).card : ℝ) /
        (2 : ℝ) ^ q ≤ d) :
    ((movingFirstBadSourcesAtRank P pLo M S q).card : ℝ) /
        (2 : ℝ) ^ M ≤
      H * (1 + 6 / (rStar : ℝ)) * ((q + 1 : ℕ) : ℝ) * d := by
  have hrR : (0 : ℝ) < (rStar : ℝ) := by exact_mod_cast hrStar
  have hcardQ := movingFirstBadSourcesAtRank_card_le (S := S) pLo
    hrStar hStarHi hStarLo htLoA hM hqM hsmall
  have hcard :
      ((movingFirstBadSourcesAtRank P pLo M S q).card : ℝ) ≤
        ((movingFeasibleTimes P pLo M S q).card : ℝ) *
          (1 + 3 * (((q + 2 : ℕ) : ℝ) / (rStar : ℝ))) *
            (2 : ℝ) ^ M / (2 : ℝ) ^ q *
          ((landingBad q (movingTargetTolerance P tLo M S q)).card : ℝ) := by
    exact_mod_cast hcardQ
  have hpowM : 0 < (2 : ℝ) ^ M := by positivity
  have hmult := rank_transport_multiplier_le hrR q
  have hTimes0 : 0 ≤
      ((movingFeasibleTimes P pLo M S q).card : ℝ) := by positivity
  calc
    ((movingFirstBadSourcesAtRank P pLo M S q).card : ℝ) /
        (2 : ℝ) ^ M ≤
      (((movingFeasibleTimes P pLo M S q).card : ℝ) *
          (1 + 3 * (((q + 2 : ℕ) : ℝ) / (rStar : ℝ))) *
            (2 : ℝ) ^ M / (2 : ℝ) ^ q *
          ((landingBad q (movingTargetTolerance P tLo M S q)).card : ℝ)) /
            (2 : ℝ) ^ M := div_le_div_of_nonneg_right hcard hpowM.le
    _ = ((movingFeasibleTimes P pLo M S q).card : ℝ) *
        (1 + 3 * (((q + 2 : ℕ) : ℝ) / (rStar : ℝ))) *
        (((landingBad q (movingTargetTolerance P tLo M S q)).card : ℝ) /
          (2 : ℝ) ^ q) := by field_simp; ring
    _ ≤ ((movingFeasibleTimes P pLo M S q).card : ℝ) *
        ((1 + 6 / (rStar : ℝ)) * ((q + 1 : ℕ) : ℝ)) *
        (((landingBad q (movingTargetTolerance P tLo M S q)).card : ℝ) /
          (2 : ℝ) ^ q) := by
      -- `hmult` supplies the rank-transport comparison used by `gcongr`.
      have := hmult
      gcongr
    _ ≤ H * (1 + 6 / (rStar : ℝ)) * ((q + 1 : ℕ) : ℝ) * d := by
      have hH0 : 0 ≤ H := hTimes0.trans hTimes
      have hC : 0 ≤ 1 + 6 / (rStar : ℝ) := by positivity
      have hq0 : 0 ≤ ((q + 1 : ℕ) : ℝ) := by positivity
      have hT0 : 0 ≤
          ((landingBad q (movingTargetTolerance P tLo M S q)).card : ℝ) /
            (2 : ℝ) ^ q := by positivity
      calc
        ((movingFeasibleTimes P pLo M S q).card : ℝ) *
            ((1 + 6 / (rStar : ℝ)) * ((q + 1 : ℕ) : ℝ)) *
            (((landingBad q (movingTargetTolerance P tLo M S q)).card : ℝ) /
              (2 : ℝ) ^ q) ≤
          H * ((1 + 6 / (rStar : ℝ)) * ((q + 1 : ℕ) : ℝ)) *
            (((landingBad q (movingTargetTolerance P tLo M S q)).card : ℝ) /
              (2 : ℝ) ^ q) := by
          gcongr
        _ ≤ H * ((1 + 6 / (rStar : ℝ)) * ((q + 1 : ℕ) : ℝ)) * d := by
          gcongr
        _ = H * (1 + 6 / (rStar : ℝ)) * ((q + 1 : ℕ) : ℝ) * d := by ring

/-- Conditional master profile for the moving envelope.  Hypotheses are the
initial high failure, high-target density, low-target density, compressed
time support, and a common reverse-loss ratio dominated by both regimes. -/
theorem movingSeparatedFailureEnvelope_density_terminalProfile
    {P : ShrinkingBarrierRunData} {rLo tLo : ℝ}
    (pLo : StageSetup rLo tLo) {rStar : ℚ}
    (hrStar : 0 < rStar) (hStarHi : rStar ≤ P.rHi)
    (hStarLo : (rStar : ℝ) ≤ rLo)
    (htLoA : tLo < a0)
    {M L S : ℕ} {H dHi bLo bLo' c' : ℝ}
    (hM : 1 ≤ M) (hLS : L ≤ S) (hSM : S < M) (hL1 : 1 ≤ L)
    (hH0 : 0 ≤ H)
    (hsmall : ∀ q ∈ Finset.Icc L (M - 1),
      ((((q + 2 : ℕ) : ℚ) / rStar) /
        ((2 ^ q : ℕ) : ℚ)) ≤ 1 / 3)
    (hTimes : ∀ q ∈ Finset.Icc L (M - 1),
      ((movingFeasibleTimes P pLo M S q).card : ℝ) ≤ H)
    (hInitial :
      ((shellInitialWindowBad M (shrinkingHighTolerance P M M)).card : ℝ) /
        (2 : ℝ) ^ M ≤ dHi)
    (hHigh : ∀ q ∈ Finset.Icc (S + 1) (M - 1),
      ((landingBad q (shrinkingHighTolerance P M (q - 1))).card : ℝ) /
        (2 : ℝ) ^ q ≤ dHi)
    (hLow : ∀ q ∈ Finset.Icc L S,
      ((landingBad q tLo).card : ℝ) ≤
        1 + (2 : ℝ) ^ q * Real.exp (-(((q - 1 : ℕ) : ℝ) * bLo)))
    (hbLo' : 0 < bLo') (hLoRate : bLo' < bLo)
    (hc' : 0 < c') (hc2 : c' < Real.log 2) :
    ((movingSeparatedFailureEnvelope P pLo M L S).card : ℝ) /
        (2 : ℝ) ^ M ≤
      dHi + H * (1 + 6 / (rStar : ℝ)) *
        (((M : ℝ) + 1) ^ 2 * dHi + terminalTailBound bLo bLo' c' L) := by
  have hcardNat := movingSeparatedFailureEnvelope_card_le P pLo M L S
  have hcard :
      ((movingSeparatedFailureEnvelope P pLo M L S).card : ℝ) ≤
        ((shellInitialWindowBad M (shrinkingHighTolerance P M M)).card : ℝ) +
        ∑ q in Finset.Icc (S + 1) (M - 1),
          ((movingFirstBadSourcesAtRank P pLo M S q).card : ℝ) +
        ∑ q in Finset.Icc L S,
          ((movingFirstBadSourcesAtRank P pLo M S q).card : ℝ) := by
    exact_mod_cast hcardNat
  have hpowM : 0 < (2 : ℝ) ^ M := by positivity
  have hrR : (0 : ℝ) < (rStar : ℝ) := by exact_mod_cast hrStar
  have hHighEach : ∀ q ∈ Finset.Icc (S + 1) (M - 1),
      ((movingFirstBadSourcesAtRank P pLo M S q).card : ℝ) /
          (2 : ℝ) ^ M ≤
        H * (1 + 6 / (rStar : ℝ)) * ((q + 1 : ℕ) : ℝ) * dHi := by
    intro q hq
    have hqi := Finset.mem_Icc.mp hq
    have hSq : S ≤ q := Nat.le_of_succ_le hqi.1
    have hqAll : q ∈ Finset.Icc L (M - 1) :=
      Finset.mem_Icc.mpr ⟨hLS.trans hSq, hqi.2⟩
    have hqM : q < M := Nat.lt_of_le_pred (by omega) hqi.2
    apply movingFirstBadSourcesAtRank_density_le (S := S) pLo
      hrStar hStarHi hStarLo htLoA hM hqM (hsmall q hqAll)
      (hTimes q hqAll)
    rw [movingTargetTolerance_eq_high P tLo hqi.1]
    exact hHigh q hq
  have hLowEach : ∀ q ∈ Finset.Icc L S,
      ((movingFirstBadSourcesAtRank P pLo M S q).card : ℝ) /
          (2 : ℝ) ^ M ≤
        H * (1 + 6 / (rStar : ℝ)) * ((q + 1 : ℕ) : ℝ) *
          (Real.exp (-(Real.log 2 * (q : ℝ))) +
            Real.exp bLo * Real.exp (-(bLo * (q : ℝ)))) := by
    intro q hq
    have hqi := Finset.mem_Icc.mp hq
    have hqM : q < M := hqi.2.trans_lt hSM
    have hqAll : q ∈ Finset.Icc L (M - 1) :=
      Finset.mem_Icc.mpr ⟨hqi.1, Nat.le_pred_of_lt hqM⟩
    apply movingFirstBadSourcesAtRank_density_le (S := S) pLo
      hrStar hStarHi hStarLo htLoA hM hqM (hsmall q hqAll)
      (hTimes q hqAll)
    rw [movingTargetTolerance_eq_low P tLo (hL1.trans hqi.1) hqi.2]
    exact landingBad_density_le (hL1.trans hqi.1) (hLow q hq)
  have hHighSum :
      ∑ q in Finset.Icc (S + 1) (M - 1),
          ((movingFirstBadSourcesAtRank P pLo M S q).card : ℝ) /
            (2 : ℝ) ^ M ≤
        H * (1 + 6 / (rStar : ℝ)) * ((M : ℝ) + 1) ^ 2 * dHi := by
    have hdHi0 : 0 ≤ dHi := by
      have hnonneg : 0 ≤
          ((shellInitialWindowBad M (shrinkingHighTolerance P M M)).card : ℝ) /
            (2 : ℝ) ^ M := by positivity
      linarith
    calc
      _ ≤ ∑ _q in Finset.Icc (S + 1) (M - 1),
          H * (1 + 6 / (rStar : ℝ)) * ((M : ℝ) + 1) * dHi := by
        apply Finset.sum_le_sum
        intro q hq
        have hqi := Finset.mem_Icc.mp hq
        have hq1 : ((q + 1 : ℕ) : ℝ) ≤ (M : ℝ) + 1 := by
          have hle : q + 1 ≤ M + 1 := by
            have : q ≤ M - 1 := hqi.2
            have hqM : q < M := Nat.lt_of_le_of_lt this (Nat.sub_lt (by omega) (by omega))
            omega
          exact_mod_cast hle
        have hbase := hHighEach q hq
        exact hbase.trans (by
          have hnonneg : 0 ≤ H * (1 + 6 / (rStar : ℝ)) := by positivity
          gcongr)
      _ ≤ H * (1 + 6 / (rStar : ℝ)) * ((M : ℝ) + 1) ^ 2 * dHi := by
        rw [Finset.sum_const, nsmul_eq_mul]
        have hcardI : ((Finset.Icc (S + 1) (M - 1)).card : ℝ) ≤
            (M : ℝ) + 1 := by
          rw [Nat.card_Icc]
          have hle : M - 1 + 1 - (S + 1) ≤ M + 1 := by omega
          exact_mod_cast hle
        have hcoef0 : 0 ≤ H * (1 + 6 / (rStar : ℝ)) *
            ((M : ℝ) + 1) * dHi := by positivity
        calc
          ((Finset.Icc (S + 1) (M - 1)).card : ℝ) *
              (H * (1 + 6 / (rStar : ℝ)) * ((M : ℝ) + 1) * dHi) ≤
            ((M : ℝ) + 1) *
              (H * (1 + 6 / (rStar : ℝ)) * ((M : ℝ) + 1) * dHi) :=
            mul_le_mul_of_nonneg_right hcardI hcoef0
          _ = _ := by ring
  have hLowSum :
      ∑ q in Finset.Icc L S,
          ((movingFirstBadSourcesAtRank P pLo M S q).card : ℝ) /
            (2 : ℝ) ^ M ≤
        H * (1 + 6 / (rStar : ℝ)) * terminalTailBound bLo bLo' c' L := by
    calc
      _ ≤ ∑ q in Finset.Icc L S,
          H * (1 + 6 / (rStar : ℝ)) * ((q + 1 : ℕ) : ℝ) *
            (Real.exp (-(Real.log 2 * (q : ℝ))) +
              Real.exp bLo * Real.exp (-(bLo * (q : ℝ)))) := by
        exact Finset.sum_le_sum hLowEach
      _ = H * (1 + 6 / (rStar : ℝ)) *
          (∑ q in Finset.Icc L S, ((q + 1 : ℕ) : ℝ) *
            (Real.exp (-(Real.log 2 * (q : ℝ))) +
              Real.exp bLo * Real.exp (-(bLo * (q : ℝ))))) := by
        rw [Finset.mul_sum]
        apply Finset.sum_congr rfl
        intro q hq
        ring
      _ ≤ H * (1 + 6 / (rStar : ℝ)) * terminalTailBound bLo bLo' c' L := by
        have htail := terminal_rank_sum_le hbLo' hLoRate hc' hc2 L S
        have hcoef0 : 0 ≤ H * (1 + 6 / (rStar : ℝ)) := by positivity
        exact mul_le_mul_of_nonneg_left htail hcoef0
  have hdiv :
      ((movingSeparatedFailureEnvelope P pLo M L S).card : ℝ) /
          (2 : ℝ) ^ M ≤
        ((shellInitialWindowBad M (shrinkingHighTolerance P M M)).card : ℝ) /
            (2 : ℝ) ^ M +
          ∑ q in Finset.Icc (S + 1) (M - 1),
            ((movingFirstBadSourcesAtRank P pLo M S q).card : ℝ) /
              (2 : ℝ) ^ M +
          ∑ q in Finset.Icc L S,
            ((movingFirstBadSourcesAtRank P pLo M S q).card : ℝ) /
              (2 : ℝ) ^ M := by
    have := div_le_div_of_nonneg_right hcard hpowM.le
    simpa [add_div, Finset.sum_div] using this
  calc
    _ ≤ ((shellInitialWindowBad M (shrinkingHighTolerance P M M)).card : ℝ) /
            (2 : ℝ) ^ M +
          ∑ q in Finset.Icc (S + 1) (M - 1),
            ((movingFirstBadSourcesAtRank P pLo M S q).card : ℝ) /
              (2 : ℝ) ^ M +
          ∑ q in Finset.Icc L S,
            ((movingFirstBadSourcesAtRank P pLo M S q).card : ℝ) /
              (2 : ℝ) ^ M := hdiv
    _ ≤ dHi +
        H * (1 + 6 / (rStar : ℝ)) * ((M : ℝ) + 1) ^ 2 * dHi +
        H * (1 + 6 / (rStar : ℝ)) * terminalTailBound bLo bLo' c' L :=
      add_le_add (add_le_add hInitial hHighSum) hLowSum
    _ = dHi + H * (1 + 6 / (rStar : ℝ)) *
        (((M : ℝ) + 1) ^ 2 * dHi + terminalTailBound bLo bLo' c' L) := by ring

end

end FirstPassageLinearTransport
