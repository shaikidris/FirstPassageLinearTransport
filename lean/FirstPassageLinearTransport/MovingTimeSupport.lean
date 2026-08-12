/-
Copyright (c) 2026 Idris Ali Shaik. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Idris Ali Shaik
-/
import FirstPassageLinearTransport.MovingLowParameters
import FirstPassageLinearTransport.ShrinkingSchedules

/-!
# Feasible cumulative times for a moving low-rank barrier

The fixed-parameter support theorem uses a geometric low-rank potential.  That
potential is unsuitable when the low contraction ratio approaches one.  This
module keeps the high-rank square-root potential and replaces the low branch
by a strict-rank-descent budget.  Its cost is quadratic in the logarithmic
switch rank and contains no factor `1 / (1 - rLo)`.

This module proves only the time-support component of the moving-endpoint
profile.  It does not prove the moving target-transport or tail assembly.
-/

namespace FirstPassageLinearTransport

open Filter
open scoped Real Topology

noncomputable section

private theorem moving_abs_add_sub_one_le (a b : ℝ) :
    |a + b - 1| ≤ |a| + |b| + 1 := by
  calc
    |a + b - 1| ≤ |a + b| + 1 := by
      simpa using (abs_sub_le (a + b) 0 (1 : ℝ))
    _ ≤ |a| + |b| + 1 := by
      linarith [abs_add a b]

/-- Floor target rank for a real contraction parameter. -/
def realTargetRank (r : ℝ) (m : ℕ) : ℕ :=
  ⌊r * (m : ℝ)⌋₊

@[simp] theorem targetScale_eq_pow_realTargetRank (r : ℝ) (m : ℕ) :
    targetScale r m = 2 ^ realTargetRank r m := rfl

private theorem realTargetRank_cast_le
    {r : ℝ} (hr0 : 0 ≤ r) (m : ℕ) :
    (realTargetRank r m : ℝ) ≤ r * (m : ℝ) := by
  exact Nat.floor_le (mul_nonneg hr0 (Nat.cast_nonneg m))

theorem realTargetRank_lt_parent
    {r : ℝ} (hr0 : 0 ≤ r) (hr1 : r < 1) {m : ℕ} (hm : 0 < m) :
    realTargetRank r m < m := by
  have hnonneg : 0 ≤ r * (m : ℝ) := mul_nonneg hr0 (Nat.cast_nonneg m)
  rw [realTargetRank, Nat.floor_lt hnonneg]
  have hmR : (0 : ℝ) < m := by exact_mod_cast hm
  nlinarith

/-- A stopped-map run with the fixed shrinking high phase and an arbitrary
real low-stage package.  The low package may vary with the outer shell; no
uniform gap between its contraction ratio and one is stored or used. -/
inductive MovingRecertificationRun
    (P : ShrinkingBarrierRunData) {rLo tLo : ℝ}
    (pLo : StageSetup rLo tLo) (M S n : ℕ) : ℕ → ℕ → Prop
  | first
      (hSM : S ≤ M) (hM0 : P.pHi.M0 ≤ M)
      (hnShell : n ∈ dyadicShell M)
      (hnGood : n ∈ initialWindowGood (shrinkingHighTolerance P M M)) :
      MovingRecertificationRun P pLo M S n
        (stageLength (shrinkingHighSetup P M M) n)
        (rationalTargetRank P.rHi M)
  | nextHi {elapsed qPrev m : ℕ}
      (hrun : MovingRecertificationRun P pLo M S n elapsed qPrev)
      (hSm : S ≤ m) (hm0 : P.pHi.M0 ≤ m)
      (hsourceShell : orbit elapsed n ∈ dyadicShell m)
      (hsourceGood : orbit elapsed n ∈
        initialWindowGood (shrinkingHighTolerance P M m))
      (hgap : rationalTargetRank P.rHi m < qPrev) :
      MovingRecertificationRun P pLo M S n
        (elapsed + stageLength (shrinkingHighSetup P M m) (orbit elapsed n))
        (rationalTargetRank P.rHi m)
  | nextLo {elapsed qPrev m : ℕ}
      (hrun : MovingRecertificationRun P pLo M S n elapsed qPrev)
      (hmS : m < S) (hm0 : pLo.M0 ≤ m)
      (hsourceShell : orbit elapsed n ∈ dyadicShell m)
      (hsourceGood : orbit elapsed n ∈ initialWindowGood tLo)
      (hgap : realTargetRank rLo m < qPrev) :
      MovingRecertificationRun P pLo M S n
        (elapsed + stageLength pLo (orbit elapsed n))
        (realTargetRank rLo m)

theorem MovingRecertificationRun.elapsed_pos
    {P : ShrinkingBarrierRunData} {rLo tLo : ℝ}
    {pLo : StageSetup rLo tLo} {M S n elapsed q : ℕ}
    (hrun : MovingRecertificationRun P pLo M S n elapsed q) :
    0 < elapsed := by
  cases hrun with
  | first hSM hM0 hnShell hnGood =>
      exact stageLength_pos (shrinkingHighSetup P M M) hM0 hnShell hnGood
  | nextHi hrun hSm hm0 hsourceShell hsourceGood hgap =>
      have hstage := stageLength_pos (shrinkingHighSetup P M _) hm0
        hsourceShell hsourceGood
      omega
  | nextLo hrun hmS hm0 hsourceShell hsourceGood hgap =>
      have hstage := stageLength_pos pLo hm0 hsourceShell hsourceGood
      omega

theorem MovingRecertificationRun.currentRank_pos
    {P : ShrinkingBarrierRunData} {rLo tLo : ℝ}
    {pLo : StageSetup rLo tLo} {M S n elapsed q : ℕ}
    (hrun : MovingRecertificationRun P pLo M S n elapsed q) :
    0 < q := by
  cases hrun with
  | first hSM hM0 hnShell hnGood =>
      have ht := P.pHi.target_one_lt M hM0
      rw [targetScale_rat] at ht
      by_contra hq
      have : rationalTargetRank P.rHi M = 0 := Nat.eq_zero_of_not_pos hq
      simp [this] at ht
  | @nextHi elapsed qPrev m hrun hSm hm0 hsourceShell hsourceGood hgap =>
      have ht := P.pHi.target_one_lt m hm0
      rw [targetScale_rat] at ht
      by_contra hq
      have : rationalTargetRank P.rHi m = 0 := Nat.eq_zero_of_not_pos hq
      simp [this] at ht
  | @nextLo elapsed qPrev m hrun hmS hm0 hsourceShell hsourceGood hgap =>
      have ht := pLo.target_one_lt m hm0
      rw [targetScale_eq_pow_realTargetRank] at ht
      by_contra hq
      have : realTargetRank rLo m = 0 := Nat.eq_zero_of_not_pos hq
      simp [this] at ht

/-- Nested first passage is independent of the moving low contraction ratio. -/
theorem MovingRecertificationRun.directFirstPassage
    {P : ShrinkingBarrierRunData} {rLo tLo : ℝ}
    {pLo : StageSetup rLo tLo} {M S n elapsed q : ℕ}
    (hrun : MovingRecertificationRun P pLo M S n elapsed q) :
    IsFirstPassage (2 ^ q) n elapsed := by
  induction hrun with
  | first hSM hM0 hnShell hnGood =>
      simpa [targetScale_rat] using
        stageLength_isFirstPassage (shrinkingHighSetup P M M)
          hM0 hnShell hnGood
  | nextHi hrun hSm hm0 hsourceShell hsourceGood hgap ih =>
      have hthreshold : 2 ^ rationalTargetRank P.rHi _ < 2 ^ _ :=
        Nat.pow_lt_pow_right (by omega) hgap
      exact ih.nested hthreshold (by
        simpa [targetScale_rat] using
          stageLength_isFirstPassage (shrinkingHighSetup P M _)
            hm0 hsourceShell hsourceGood)
  | nextLo hrun hmS hm0 hsourceShell hsourceGood hgap ih =>
      have hthreshold : 2 ^ realTargetRank rLo _ < 2 ^ _ :=
        Nat.pow_lt_pow_right (by omega) hgap
      exact ih.nested hthreshold (by
        simpa [targetScale_eq_pow_realTargetRank] using
          stageLength_isFirstPassage pLo hm0 hsourceShell hsourceGood)

/-- A certified intermediate landing lies in shell `q - 1`, including for a
moving real low-stage ratio. -/
theorem MovingRecertificationRun.certified_endpoint_shell_eq
    {P : ShrinkingBarrierRunData} {rLo tLo : ℝ}
    {pLo : StageSetup rLo tLo} {M S n elapsed q m : ℕ}
    (hrun : MovingRecertificationRun P pLo M S n elapsed q)
    {t : ℝ} (htA : t < a0)
    (hgood : orbit elapsed n ∈ initialWindowGood t)
    (hshell : orbit elapsed n ∈ dyadicShell m) :
    m = q - 1 := by
  have hband := firstPassage_band hrun.elapsed_pos hrun.directFirstPassage
  have hlowerBand : 2 ^ (q - 1) < orbit elapsed n := by
    have hmul : 2 ^ (q - 1) * 2 < orbit elapsed n * 2 := by
      calc
        2 ^ (q - 1) * 2 = 2 ^ ((q - 1) + 1) := by rw [pow_succ]
        _ = 2 ^ q := by rw [Nat.sub_add_cancel hrun.currentRank_pos]
        _ < 2 * orbit elapsed n := hband.1
        _ = orbit elapsed n * 2 := by omega
    exact lt_of_mul_lt_mul_right hmul (by norm_num)
  have hlower := certified_landing_mem_lower_shell hrun.currentRank_pos htA
    ⟨hlowerBand, hband.2⟩ hgood
  have hlogm := log_two_eq_of_mem_dyadicShell hshell
  have hlogq := log_two_eq_of_mem_dyadicShell hlower
  omega

/-- Uniform cost assigned to one strict low-rank drop. -/
def movingLowStepCost (S : ℕ) : ℝ :=
  (S : ℝ) + 4

/-- Moving time-width potential.  The low branch is proportional to the
current rank, so it decreases under strict rank descent.  The high branch
carries the complete low-phase reserve. -/
def movingTimePotential
    (P : ShrinkingBarrierRunData) (M S q : ℕ) : ℝ :=
  if S < q then
    ((P.D + P.tau + 3) *
        Real.sqrt (Real.log ((M : ℝ) + 2)) * Real.sqrt q) /
          (1 - Real.sqrt (P.rHi : ℝ)) +
      movingLowStepCost S * (S : ℝ)
  else
    movingLowStepCost S * (q : ℝ)

private theorem moving_sqrt_rat_lt_one
    {r : ℚ} (hr1 : r < 1) :
    Real.sqrt (r : ℝ) < 1 := by
  rw [Real.sqrt_lt' (by norm_num : (0 : ℝ) < 1)]
  norm_num
  exact_mod_cast hr1

private theorem movingTimePotential_nonneg
    (P : ShrinkingBarrierRunData) (M S q : ℕ) :
    0 ≤ movingTimePotential P M S q := by
  have hdHi : 0 < 1 - Real.sqrt (P.rHi : ℝ) := sub_pos.mpr
    (moving_sqrt_rat_lt_one
      (by exact_mod_cast P.pHi.r_lt_one : P.rHi < 1))
  have hcoefHi : 0 ≤ P.D + P.tau + 3 := by
    nlinarith [P.D_pos, P.pHi.eta_pos]
  have hcost : 0 ≤ movingLowStepCost S := by
    unfold movingLowStepCost
    positivity
  unfold movingTimePotential
  split_ifs <;> positivity

private theorem movingLow_durationError_le
    {t : ℝ} (_ht0 : 0 ≤ t) (ht1 : t ≤ 1)
    {S m : ℕ} (hmS : m < S) :
    durationError t m ≤ movingLowStepCost S := by
  unfold durationError movingLowStepCost
  have hmR : (m : ℝ) + 1 ≤ S := by exact_mod_cast hmS
  have hm0 : (0 : ℝ) ≤ m := Nat.cast_nonneg m
  nlinarith [mul_le_mul_of_nonneg_right ht1 hm0]

/-- One rank step pays its full corridor-width cost.  The low clause uses
only strict rank descent and never divides by `1 - rLo`. -/
theorem movingTimePotential_step
    (P : ShrinkingBarrierRunData) {tLo : ℝ}
    (htLo0 : 0 ≤ tLo) (htLo1 : tLo ≤ 1)
    {M S qPrev m q : ℕ}
    (hM : 1 ≤ M) (hm : 1 ≤ m) (hmPrev : qPrev = m + 1)
    (hq : if S ≤ m then
        (q : ℝ) ≤ (P.rHi : ℝ) * (m : ℝ)
      else q < m) :
    (if S ≤ m then durationError (shrinkingHighTolerance P M m) m
      else durationError tLo m) + movingTimePotential P M S q ≤
        movingTimePotential P M S qPrev := by
  subst qPrev
  have hrHi0 : (0 : ℝ) ≤ P.rHi := P.pHi.r_pos.le
  have hsHi1 := moving_sqrt_rat_lt_one
    (by exact_mod_cast P.pHi.r_lt_one : P.rHi < 1)
  have hdHi : 0 < 1 - Real.sqrt (P.rHi : ℝ) := sub_pos.mpr hsHi1
  have hcoefHi : 0 < P.D + P.tau + 3 := by
    nlinarith [P.D_pos, P.pHi.eta_pos]
  have hlog0 : 0 ≤ Real.sqrt (Real.log ((M : ℝ) + 2)) := Real.sqrt_nonneg _
  have hcost0 : 0 ≤ movingLowStepCost S := by
    unfold movingLowStepCost
    positivity
  by_cases hmHigh : S ≤ m
  · have hqBound : (q : ℝ) ≤ (P.rHi : ℝ) * (m : ℝ) := by
      simpa [hmHigh] using hq
    have hprevHigh : S < m + 1 := by omega
    have hcost := durationError_shrinkingHigh_le P hM hm
    by_cases hqHigh : S < q
    · have hsqrtq : Real.sqrt (q : ℝ) ≤
          Real.sqrt (P.rHi : ℝ) * Real.sqrt (m : ℝ) := by
        have hs := Real.sqrt_le_sqrt hqBound
        rw [Real.sqrt_mul hrHi0] at hs
        exact hs
      have hsqrtm : Real.sqrt (m : ℝ) ≤ Real.sqrt ((m + 1 : ℕ) : ℝ) :=
        Real.sqrt_le_sqrt (by norm_num)
      rw [if_pos hmHigh]
      simp only [movingTimePotential, if_pos hqHigh, if_pos hprevHigh]
      have hscaled :
          (P.D + P.tau + 3) * Real.sqrt (Real.log ((M : ℝ) + 2)) *
              Real.sqrt (m : ℝ) +
              ((P.D + P.tau + 3) * Real.sqrt (Real.log ((M : ℝ) + 2)) *
                Real.sqrt (q : ℝ)) / (1 - Real.sqrt (P.rHi : ℝ)) ≤
            ((P.D + P.tau + 3) * Real.sqrt (Real.log ((M : ℝ) + 2)) *
              Real.sqrt ((m + 1 : ℕ) : ℝ)) /
                (1 - Real.sqrt (P.rHi : ℝ)) := by
        apply (le_div_iff₀ hdHi).2
        rw [add_mul, div_mul_cancel₀ _ hdHi.ne']
        have hmulq := mul_le_mul_of_nonneg_left hsqrtq
          (mul_nonneg hcoefHi.le hlog0)
        have hmulm := mul_le_mul_of_nonneg_left hsqrtm
          (mul_nonneg hcoefHi.le hlog0)
        nlinarith
      linarith
    · have hqLow : q ≤ S := by omega
      rw [if_pos hmHigh]
      simp only [movingTimePotential, if_neg hqHigh, if_pos hprevHigh]
      have hlowReserve :
          movingLowStepCost S * (q : ℝ) ≤
            movingLowStepCost S * (S : ℝ) :=
        mul_le_mul_of_nonneg_left (by exact_mod_cast hqLow) hcost0
      have hsqrtm : Real.sqrt (m : ℝ) ≤ Real.sqrt ((m + 1 : ℕ) : ℝ) :=
        Real.sqrt_le_sqrt (by norm_num)
      have hhighPay :
          (P.D + P.tau + 3) * Real.sqrt (Real.log ((M : ℝ) + 2)) *
              Real.sqrt (m : ℝ) ≤
            ((P.D + P.tau + 3) * Real.sqrt (Real.log ((M : ℝ) + 2)) *
              Real.sqrt ((m + 1 : ℕ) : ℝ)) /
              (1 - Real.sqrt (P.rHi : ℝ)) := by
        have hbase := mul_le_mul_of_nonneg_left hsqrtm
          (mul_nonneg hcoefHi.le hlog0)
        have hdenLe : 1 - Real.sqrt (P.rHi : ℝ) ≤ 1 := by
          linarith [Real.sqrt_nonneg (P.rHi : ℝ)]
        have hdiv :
            (P.D + P.tau + 3) * Real.sqrt (Real.log ((M : ℝ) + 2)) *
                Real.sqrt ((m + 1 : ℕ) : ℝ) ≤
              ((P.D + P.tau + 3) * Real.sqrt (Real.log ((M : ℝ) + 2)) *
                Real.sqrt ((m + 1 : ℕ) : ℝ)) /
                (1 - Real.sqrt (P.rHi : ℝ)) := by
          apply (le_div_iff₀ hdHi).2
          nlinarith [mul_nonneg (mul_nonneg hcoefHi.le hlog0)
            (Real.sqrt_nonneg ((m + 1 : ℕ) : ℝ))]
        exact hbase.trans hdiv
      linarith
  · have hmLow : m < S := Nat.lt_of_not_ge hmHigh
    have hprevLow : ¬ S < m + 1 := by omega
    have hqBound : q < m := by simpa [hmHigh] using hq
    have hqLow : ¬ S < q := by omega
    have hlocal := movingLow_durationError_le htLo0 htLo1 hmLow
    rw [if_neg hmHigh]
    simp only [movingTimePotential, if_neg hqLow, if_neg hprevLow]
    have hqR : (q : ℝ) + 1 ≤ m := by exact_mod_cast hqBound
    unfold movingLowStepCost at hlocal ⊢
    push_cast
    nlinarith

/-- Every moving run stays in one common interval around the linear-drift
center `(M + 1) - q`. -/
theorem MovingRecertificationRun.deviation_add_potential_le
    {P : ShrinkingBarrierRunData} {rLo tLo : ℝ}
    {pLo : StageSetup rLo tLo} {M S n elapsed q : ℕ}
    (htLoA : tLo < a0) (hM : 1 ≤ M)
    (hrun : MovingRecertificationRun P pLo M S n elapsed q) :
    |driftGap * (elapsed : ℝ) - (((M + 1 : ℕ) : ℝ) - (q : ℝ))| +
        movingTimePotential P M S q ≤
      movingTimePotential P M S (M + 1) := by
  induction hrun with
  | first hSM hM0 hnShell hnGood =>
      have hlen := stageLength_le_shell (shrinkingHighSetup P M M)
        hM0 hnShell hnGood
      have hpos := stageLength_pos (shrinkingHighSetup P M M)
        hM0 hnShell hnGood
      have hfp : IsFirstPassage (2 ^ rationalTargetRank P.rHi M) n
          (stageLength (shrinkingHighSetup P M M) n) := by
        simpa [targetScale_rat] using
          stageLength_isFirstPassage (shrinkingHighSetup P M M)
            hM0 hnShell hnGood
      have herr := certified_firstPassage_duration_error
        (shrinkingHighTolerance_pos P M M).le
        (shrinkingHighTolerance_le_tau P M M |>.trans P.pHi.eta_le_one)
        hnShell hnGood hlen hpos hfp
      have hq := realTargetRank_cast_le
        (by exact_mod_cast P.pHi.r_pos.le : (0 : ℝ) ≤ (P.rHi : ℝ)) M
      have hstep := movingTimePotential_step P
        P.pHi.eta_pos.le P.pHi.eta_le_one
        (S := S) (qPrev := M + 1) (m := M)
        (q := rationalTargetRank P.rHi M) hM hM rfl (by
        simpa [hSM, realTargetRank, rationalTargetRank] using hq)
      rw [if_pos hSM] at hstep
      have habs :
          |driftGap * (stageLength (shrinkingHighSetup P M M) n : ℝ) -
              (((M + 1 : ℕ) : ℝ) -
                (rationalTargetRank P.rHi M : ℝ))| ≤
            durationError (shrinkingHighTolerance P M M) M := by
        have hshift :
            driftGap * (stageLength (shrinkingHighSetup P M M) n : ℝ) -
                (((M + 1 : ℕ) : ℝ) -
                  (rationalTargetRank P.rHi M : ℝ)) =
              (driftGap * (stageLength (shrinkingHighSetup P M M) n : ℝ) -
                ((M : ℝ) - (rationalTargetRank P.rHi M : ℝ))) - 1 := by
          push_cast
          ring
        rw [hshift]
        calc
          |(driftGap * (stageLength (shrinkingHighSetup P M M) n : ℝ) -
              ((M : ℝ) - (rationalTargetRank P.rHi M : ℝ))) - 1| ≤
              |driftGap * (stageLength (shrinkingHighSetup P M M) n : ℝ) -
                ((M : ℝ) - (rationalTargetRank P.rHi M : ℝ))| + 1 := by
            simpa using (abs_sub_le
              (driftGap * (stageLength (shrinkingHighSetup P M M) n : ℝ) -
                ((M : ℝ) - (rationalTargetRank P.rHi M : ℝ))) 0 (1 : ℝ))
          _ ≤ durationError (shrinkingHighTolerance P M M) M := by
            unfold durationError
            linarith
      linarith
  | @nextHi elapsed qPrev m hrun hSm hm0 hsourceShell hsourceGood hgap ih =>
      have hmEq := hrun.certified_endpoint_shell_eq
        (shrinkingHighTolerance_lt_a0 P M m) hsourceGood hsourceShell
      have hm1 : 1 ≤ m := P.pHi.M0_pos.trans hm0
      have hlen := stageLength_le_shell (shrinkingHighSetup P M m)
        hm0 hsourceShell hsourceGood
      have hpos := stageLength_pos (shrinkingHighSetup P M m)
        hm0 hsourceShell hsourceGood
      have hlocalfp : IsFirstPassage (2 ^ rationalTargetRank P.rHi m)
          (orbit elapsed n)
          (stageLength (shrinkingHighSetup P M m) (orbit elapsed n)) := by
        simpa [targetScale_rat] using
          stageLength_isFirstPassage (shrinkingHighSetup P M m)
            hm0 hsourceShell hsourceGood
      have herr := certified_firstPassage_duration_error
        (shrinkingHighTolerance_pos P M m).le
        (shrinkingHighTolerance_le_tau P M m |>.trans P.pHi.eta_le_one)
        hsourceShell hsourceGood hlen hpos hlocalfp
      have hq := realTargetRank_cast_le
        (by exact_mod_cast P.pHi.r_pos.le : (0 : ℝ) ≤ (P.rHi : ℝ)) m
      have hprevpos := hrun.currentRank_pos
      have hmPrevEq : qPrev = m + 1 := by omega
      have hstep := movingTimePotential_step P
        P.pHi.eta_pos.le P.pHi.eta_le_one
        (S := S) (qPrev := qPrev) (m := m)
        (q := rationalTargetRank P.rHi m) hM hm1 hmPrevEq (by
        simpa [hSm, realTargetRank, rationalTargetRank] using hq)
      rw [if_pos hSm] at hstep
      have hdecomp :
          driftGap * ((elapsed +
              stageLength (shrinkingHighSetup P M m) (orbit elapsed n) : ℕ) : ℝ) -
              (((M + 1 : ℕ) : ℝ) -
                (rationalTargetRank P.rHi m : ℝ)) =
            (driftGap * (elapsed : ℝ) -
              (((M + 1 : ℕ) : ℝ) - (qPrev : ℝ))) +
            (driftGap *
                (stageLength (shrinkingHighSetup P M m) (orbit elapsed n) : ℝ) -
              ((m : ℝ) - (rationalTargetRank P.rHi m : ℝ))) - 1 := by
        rw [hmPrevEq]
        push_cast
        ring
      rw [hdecomp]
      have habs := moving_abs_add_sub_one_le
        (driftGap * (elapsed : ℝ) -
          (((M + 1 : ℕ) : ℝ) - (qPrev : ℝ)))
        (driftGap *
            (stageLength (shrinkingHighSetup P M m) (orbit elapsed n) : ℝ) -
          ((m : ℝ) - (rationalTargetRank P.rHi m : ℝ)))
      have hlocal :
          |driftGap *
              (stageLength (shrinkingHighSetup P M m) (orbit elapsed n) : ℝ) -
            ((m : ℝ) - (rationalTargetRank P.rHi m : ℝ))| + 1 ≤
            durationError (shrinkingHighTolerance P M m) m := by
        unfold durationError
        linarith
      linarith
  | @nextLo elapsed qPrev m hrun hmS hm0 hsourceShell hsourceGood hgap ih =>
      have hmEq := hrun.certified_endpoint_shell_eq htLoA
        hsourceGood hsourceShell
      have hm1 : 1 ≤ m := pLo.M0_pos.trans hm0
      have hlen := stageLength_le_shell pLo hm0 hsourceShell hsourceGood
      have hpos := stageLength_pos pLo hm0 hsourceShell hsourceGood
      have hlocalfp : IsFirstPassage (2 ^ realTargetRank rLo m)
          (orbit elapsed n) (stageLength pLo (orbit elapsed n)) := by
        simpa [targetScale_eq_pow_realTargetRank] using
          stageLength_isFirstPassage pLo hm0 hsourceShell hsourceGood
      have herr := certified_firstPassage_duration_error pLo.eta_pos.le
        pLo.eta_le_one hsourceShell hsourceGood hlen hpos hlocalfp
      have hq := realTargetRank_lt_parent pLo.r_pos.le pLo.r_lt_one
        (lt_of_lt_of_le (by omega) hm1)
      have hprevpos := hrun.currentRank_pos
      have hmPrevEq : qPrev = m + 1 := by omega
      have hstep := movingTimePotential_step P pLo.eta_pos.le pLo.eta_le_one
        (S := S) (qPrev := qPrev) (m := m)
        (q := realTargetRank rLo m) hM hm1 hmPrevEq (by
        simpa [show ¬ S ≤ m by omega] using hq)
      rw [if_neg (show ¬ S ≤ m by omega)] at hstep
      have hdecomp :
          driftGap * ((elapsed + stageLength pLo (orbit elapsed n) : ℕ) : ℝ) -
              (((M + 1 : ℕ) : ℝ) - (realTargetRank rLo m : ℝ)) =
            (driftGap * (elapsed : ℝ) -
              (((M + 1 : ℕ) : ℝ) - (qPrev : ℝ))) +
            (driftGap * (stageLength pLo (orbit elapsed n) : ℝ) -
              ((m : ℝ) - (realTargetRank rLo m : ℝ))) - 1 := by
        rw [hmPrevEq]
        push_cast
        ring
      rw [hdecomp]
      have habs := moving_abs_add_sub_one_le
        (driftGap * (elapsed : ℝ) -
          (((M + 1 : ℕ) : ℝ) - (qPrev : ℝ)))
        (driftGap * (stageLength pLo (orbit elapsed n) : ℝ) -
          ((m : ℝ) - (realTargetRank rLo m : ℝ)))
      have hlocal :
          |driftGap * (stageLength pLo (orbit elapsed n) : ℝ) -
            ((m : ℝ) - (realTargetRank rLo m : ℝ))| + 1 ≤
            durationError tLo m := by
        unfold durationError
        linarith
      linarith

/-- A finite cutoff large enough to contain every realized moving time. -/
def movingFeasibleTimeCutoff
    (P : ShrinkingBarrierRunData) (M S : ℕ) : ℕ :=
  ⌈((((M + 1 : ℕ) : ℝ) + movingTimePotential P M S (M + 1)) /
      driftGap)⌉₊

/-- All cumulative times of moving runs ending at rank `q`. -/
noncomputable def movingFeasibleTimes
    (P : ShrinkingBarrierRunData) {rLo tLo : ℝ}
    (pLo : StageSetup rLo tLo) (M S q : ℕ) : Finset ℕ := by
  classical
  exact (Finset.range (movingFeasibleTimeCutoff P M S + 1)).filter fun h =>
    ∃ n : ℕ, n ∈ dyadicShell M ∧
      MovingRecertificationRun P pLo M S n h q

theorem MovingRecertificationRun.mem_movingFeasibleTimes
    {P : ShrinkingBarrierRunData} {rLo tLo : ℝ}
    {pLo : StageSetup rLo tLo} {M S n elapsed q : ℕ}
    (htLoA : tLo < a0) (hM : 1 ≤ M)
    (hnShell : n ∈ dyadicShell M)
    (hrun : MovingRecertificationRun P pLo M S n elapsed q) :
    elapsed ∈ movingFeasibleTimes P pLo M S q := by
  classical
  have hdev := hrun.deviation_add_potential_le htLoA hM
  have hpotq0 := movingTimePotential_nonneg P M S q
  have habs :
      |driftGap * (elapsed : ℝ) - (((M + 1 : ℕ) : ℝ) - (q : ℝ))| ≤
        movingTimePotential P M S (M + 1) := by
    linarith
  have hupper := (abs_le.mp habs).2
  have hq0 : (0 : ℝ) ≤ q := Nat.cast_nonneg q
  have hreal : (elapsed : ℝ) ≤
      (((M + 1 : ℕ) : ℝ) + movingTimePotential P M S (M + 1)) /
        driftGap := by
    rw [le_div_iff₀ driftGap_pos]
    linarith
  have hceilReal := Nat.le_ceil
    ((((M + 1 : ℕ) : ℝ) + movingTimePotential P M S (M + 1)) / driftGap)
  have hbound : elapsed ≤ movingFeasibleTimeCutoff P M S := by
    exact_mod_cast hreal.trans hceilReal
  simp only [movingFeasibleTimes, Finset.mem_filter, Finset.mem_range]
  exact ⟨by omega, n, hnShell, hrun⟩

/-- Exact support-cardinality bound before asymptotic simplification. -/
theorem movingFeasibleTimes_card_le_potential
    (P : ShrinkingBarrierRunData) {rLo tLo : ℝ}
    (pLo : StageSetup rLo tLo) (htLoA : tLo < a0)
    {M S q : ℕ} (hM : 1 ≤ M) :
    (movingFeasibleTimes P pLo M S q).card ≤
      ⌈(1 + 2 * movingTimePotential P M S (M + 1) / driftGap)⌉₊ := by
  classical
  let times := movingFeasibleTimes P pLo M S q
  by_cases hne : times.Nonempty
  · have hspan := finset_card_le_one_add_span times hne
    have hmaxMem := times.max'_mem hne
    have hminMem := times.min'_mem hne
    have hmaxMem' : times.max' hne ∈
        movingFeasibleTimes P pLo M S q := by
      simpa [times] using hmaxMem
    have hminMem' : times.min' hne ∈
        movingFeasibleTimes P pLo M S q := by
      simpa [times] using hminMem
    rw [movingFeasibleTimes, Finset.mem_filter] at hmaxMem' hminMem'
    have hmaxData : ∃ n : ℕ, n ∈ dyadicShell M ∧
        MovingRecertificationRun P pLo M S n (times.max' hne) q := by
      exact hmaxMem'.2
    have hminData : ∃ n : ℕ, n ∈ dyadicShell M ∧
        MovingRecertificationRun P pLo M S n (times.min' hne) q := by
      exact hminMem'.2
    rcases hmaxData with ⟨xmax, hxShell, hxrun⟩
    rcases hminData with ⟨xmin, hxminShell, hxminrun⟩
    have hxdev := hxrun.deviation_add_potential_le htLoA hM
    have hmindev := hxminrun.deviation_add_potential_le htLoA hM
    have hpotq0 := movingTimePotential_nonneg P M S q
    have hxabs :
        |driftGap * (times.max' hne : ℝ) -
          (((M + 1 : ℕ) : ℝ) - (q : ℝ))| ≤
            movingTimePotential P M S (M + 1) := by
      linarith
    have hminabs :
        |driftGap * (times.min' hne : ℝ) -
          (((M + 1 : ℕ) : ℝ) - (q : ℝ))| ≤
            movingTimePotential P M S (M + 1) := by
      linarith
    have hdiff :
        ((times.max' hne : ℕ) : ℝ) - (times.min' hne : ℝ) ≤
          2 * movingTimePotential P M S (M + 1) / driftGap := by
      rw [le_div_iff₀ driftGap_pos]
      have hmaxUpper := (abs_le.mp hxabs).2
      have hminLower := (abs_le.mp hminabs).1
      nlinarith
    have hcardR : ((times.card : ℕ) : ℝ) ≤
        1 + 2 * movingTimePotential P M S (M + 1) / driftGap := by
      have hspanR : ((times.card : ℕ) : ℝ) ≤
          1 + (times.max' hne : ℝ) - (times.min' hne : ℝ) := by
        exact_mod_cast hspan
      linarith
    have hceil := Nat.le_ceil
      (1 + 2 * movingTimePotential P M S (M + 1) / driftGap)
    exact_mod_cast hcardR.trans hceil
  · have hempty : times = ∅ := Finset.not_nonempty_iff_eq_empty.mp hne
    have hactual : movingFeasibleTimes P pLo M S q = ∅ := by
      simpa [times] using hempty
    rw [hactual]
    exact Nat.zero_le _

/-- Explicit constant in the eventual moving feasible-time support. -/
def movingTimeSupportConstant
    (P : ShrinkingBarrierRunData) (C : ℝ) : ℝ :=
  2 + 2 / driftGap *
    ((P.D + P.tau + 3) / (1 - Real.sqrt (P.rHi : ℝ)) +
      (C + 5) ^ 2)

private theorem eventually_log_sq_le_sqrt_mul :
    ∀ᶠ M : ℕ in atTop,
      (Real.log ((M : ℝ) + 2)) ^ 2 ≤
        Real.sqrt (((M : ℝ) + 2) * Real.log ((M : ℝ) + 2)) := by
  have hsmallReal :=
    (Real.isLittleO_pow_log_id_atTop (n := 3)).bound
      (by norm_num : (0 : ℝ) < 1)
  have hxT : Tendsto (fun M : ℕ => (M : ℝ) + 2) atTop atTop :=
    tendsto_atTop_add_const_right atTop (2 : ℝ)
      tendsto_natCast_atTop_atTop
  have hsmall := hxT.eventually hsmallReal
  filter_upwards [hsmall, eventually_ge_atTop (1 : ℕ)] with M hsmall hM
  let x : ℝ := (M : ℝ) + 2
  have hx1 : 1 ≤ x := by
    dsimp [x]
    have hMR : (1 : ℝ) ≤ M := by exact_mod_cast hM
    linarith
  have hx0 : 0 ≤ x := zero_le_one.trans hx1
  have hlog1 : 1 ≤ Real.log x := by
    apply (Real.le_log_iff_exp_le (by positivity)).2
    have he : Real.exp 1 < 3 := Real.exp_one_lt_d9.trans (by norm_num)
    dsimp [x]
    have hMR : (1 : ℝ) ≤ M := by exact_mod_cast hM
    linarith
  have hlog0 : 0 ≤ Real.log x := zero_le_one.trans hlog1
  have hlogCube0 : 0 ≤ (Real.log x) ^ 3 := by positivity
  have hsmall' : (Real.log x) ^ 3 ≤ x := by
    simpa [x, id_eq, Real.norm_eq_abs, abs_of_nonneg hlogCube0,
      abs_of_nonneg hlog0, abs_of_nonneg hx0] using hsmall
  have hfourth : (Real.log x) ^ 4 ≤ x * Real.log x := by
    nlinarith [mul_le_mul_of_nonneg_right hsmall' hlog0]
  have hroot0 := Real.sqrt_nonneg (x * Real.log x)
  have hrootSq := Real.sq_sqrt (mul_nonneg hx0 hlog0)
  dsimp [x] at *
  nlinarith [sq_nonneg ((Real.log ((M : ℝ) + 2)) ^ 2 -
    Real.sqrt (((M : ℝ) + 2) * Real.log ((M : ℝ) + 2)))]

/-- Eventually the complete moving potential has the same square-root support
scale as the fixed low-rank construction. -/
theorem eventually_movingTimePotential_source_le_sqrt
    (P : ShrinkingBarrierRunData) {C : ℝ} (hC : 0 ≤ C) :
    ∀ᶠ M : ℕ in atTop,
      1 + 2 * movingTimePotential P M (shrinkingSwitchRank C M) (M + 1) /
          driftGap ≤
        movingTimeSupportConstant P C *
          Real.sqrt (((M : ℝ) + 2) * Real.log ((M : ℝ) + 2)) := by
  filter_upwards [eventually_log_sq_le_sqrt_mul,
      eventually_shrinkingSwitchRank_lt_source hC,
      eventually_ge_atTop (1 : ℕ)] with M hlogSq hSwitch hM
  let x : ℝ := (M : ℝ) + 2
  have hx1 : 1 ≤ x := by
    dsimp [x]
    have hM0 : (0 : ℝ) ≤ M := Nat.cast_nonneg M
    linarith
  have hlog1 : 1 ≤ Real.log x := by
    apply (Real.le_log_iff_exp_le (by positivity)).2
    have he : Real.exp 1 < 3 := Real.exp_one_lt_d9.trans (by norm_num)
    have hMR : (1 : ℝ) ≤ M := by exact_mod_cast hM
    dsimp [x]
    linarith
  have hsqrt1 : 1 ≤ Real.sqrt (x * Real.log x) := by
    rw [← Real.sqrt_one]
    apply Real.sqrt_le_sqrt
    nlinarith [show 0 ≤ Real.log x from zero_le_one.trans hlog1]
  have hsqrtM :
      Real.sqrt (Real.log x) * Real.sqrt ((M + 1 : ℕ) : ℝ) ≤
        Real.sqrt (x * Real.log x) := by
    rw [← Real.sqrt_mul (Real.log_nonneg hx1)]
    apply Real.sqrt_le_sqrt
    have hlog0 : 0 ≤ Real.log x := Real.log_nonneg hx1
    dsimp [x]
    push_cast
    nlinarith
  have hS := shrinkingSwitchRank_lt_add_one hC M
  have hSlow : (shrinkingSwitchRank C M : ℝ) + 4 ≤
      (C + 5) * Real.log x := by
    apply le_of_lt
    calc
      (shrinkingSwitchRank C M : ℝ) + 4 <
          C * Real.log x + 5 := by linarith
      _ ≤ C * Real.log x + 5 * Real.log x := by nlinarith
      _ = (C + 5) * Real.log x := by ring
  have hSnonneg : 0 ≤ (shrinkingSwitchRank C M : ℝ) := Nat.cast_nonneg _
  have hlow :
      movingLowStepCost (shrinkingSwitchRank C M) *
          (shrinkingSwitchRank C M : ℝ) ≤
        (C + 5) ^ 2 * Real.sqrt (x * Real.log x) := by
    have hC5 : 0 ≤ C + 5 := by linarith
    have hlog0 : 0 ≤ Real.log x := Real.log_nonneg hx1
    have hleft :
        ((shrinkingSwitchRank C M : ℝ) + 4) *
            (shrinkingSwitchRank C M : ℝ) ≤
          ((C + 5) * Real.log x) ^ 2 := by
      have hSle : (shrinkingSwitchRank C M : ℝ) ≤
          (C + 5) * Real.log x := by linarith
      nlinarith [mul_le_mul hSlow hSle hSnonneg
        (mul_nonneg hC5 hlog0)]
    unfold movingLowStepCost
    calc
      ((shrinkingSwitchRank C M : ℝ) + 4) *
          (shrinkingSwitchRank C M : ℝ) ≤
        ((C + 5) * Real.log x) ^ 2 := hleft
      _ = (C + 5) ^ 2 * (Real.log x) ^ 2 := by ring
      _ ≤ (C + 5) ^ 2 * Real.sqrt (x * Real.log x) := by
        exact mul_le_mul_of_nonneg_left (by simpa [x] using hlogSq) (sq_nonneg _)
  have hdHi : 0 < 1 - Real.sqrt (P.rHi : ℝ) := sub_pos.mpr
    (moving_sqrt_rat_lt_one
      (by exact_mod_cast P.pHi.r_lt_one : P.rHi < 1))
  have hcoefHi : 0 ≤ P.D + P.tau + 3 := by
    nlinarith [P.D_pos, P.pHi.eta_pos]
  have hpot :
      movingTimePotential P M (shrinkingSwitchRank C M) (M + 1) ≤
        ((P.D + P.tau + 3) / (1 - Real.sqrt (P.rHi : ℝ)) +
          (C + 5) ^ 2) * Real.sqrt (x * Real.log x) := by
    rw [movingTimePotential, if_pos (by omega : shrinkingSwitchRank C M < M + 1)]
    calc
      ((P.D + P.tau + 3) * Real.sqrt (Real.log ((M : ℝ) + 2)) *
            Real.sqrt (((M + 1 : ℕ) : ℝ))) /
              (1 - Real.sqrt (P.rHi : ℝ)) +
          movingLowStepCost (shrinkingSwitchRank C M) *
            (shrinkingSwitchRank C M : ℝ) ≤
        ((P.D + P.tau + 3) * Real.sqrt (x * Real.log x)) /
              (1 - Real.sqrt (P.rHi : ℝ)) +
          (C + 5) ^ 2 * Real.sqrt (x * Real.log x) := by
        apply add_le_add
        · apply (div_le_div_iff_of_pos_right hdHi).2
          simpa [x, mul_assoc] using
            (mul_le_mul_of_nonneg_left hsqrtM hcoefHi)
        · exact hlow
      _ = ((P.D + P.tau + 3) / (1 - Real.sqrt (P.rHi : ℝ)) +
          (C + 5) ^ 2) * Real.sqrt (x * Real.log x) := by ring
  unfold movingTimeSupportConstant
  have hscale0 : 0 ≤ Real.sqrt (x * Real.log x) := Real.sqrt_nonneg _
  calc
    1 + 2 * movingTimePotential P M (shrinkingSwitchRank C M) (M + 1) /
        driftGap ≤
      1 + 2 * (((P.D + P.tau + 3) /
          (1 - Real.sqrt (P.rHi : ℝ)) + (C + 5) ^ 2) *
            Real.sqrt (x * Real.log x)) / driftGap := by
      have hmul := mul_le_mul_of_nonneg_left hpot (by norm_num : (0 : ℝ) ≤ 2)
      have hdiv := div_le_div_of_nonneg_right hmul driftGap_pos.le
      linarith
    _ ≤ (2 + 2 / driftGap *
        ((P.D + P.tau + 3) / (1 - Real.sqrt (P.rHi : ℝ)) +
          (C + 5) ^ 2)) * Real.sqrt (x * Real.log x) := by
      let B := (P.D + P.tau + 3) / (1 - Real.sqrt (P.rHi : ℝ)) +
        (C + 5) ^ 2
      have hid :
          (2 + 2 / driftGap * B) * Real.sqrt (x * Real.log x) -
            (1 + 2 * (B * Real.sqrt (x * Real.log x)) / driftGap) =
              2 * Real.sqrt (x * Real.log x) - 1 := by ring
      dsimp only [B] at hid
      linarith

/-- The moving low schedule retains square-root-logarithmic feasible-time
support, uniformly over every admissible real low-stage package. -/
theorem eventually_movingFeasibleTimes_card_lt_sqrt
    (P : ShrinkingBarrierRunData) {C : ℝ} (hC : 0 ≤ C) :
    ∀ᶠ M : ℕ in atTop,
      ∀ {rLo tLo : ℝ} (pLo : StageSetup rLo tLo), tLo < a0 → ∀ q : ℕ,
        ((movingFeasibleTimes P pLo M (shrinkingSwitchRank C M) q).card : ℝ) <
          (movingTimeSupportConstant P C + 1) *
            Real.sqrt (((M : ℝ) + 2) * Real.log ((M : ℝ) + 2)) := by
  filter_upwards [eventually_movingTimePotential_source_le_sqrt P hC,
      eventually_ge_atTop (1 : ℕ)] with M hpotential hM
  intro rLo tLo pLo htLoA q
  have hcard := movingFeasibleTimes_card_le_potential P pLo htLoA
    (S := shrinkingSwitchRank C M) (q := q) hM
  have hpot0 := movingTimePotential_nonneg P M (shrinkingSwitchRank C M) (M + 1)
  have hceil :
      (⌈(1 + 2 * movingTimePotential P M (shrinkingSwitchRank C M) (M + 1) /
        driftGap)⌉₊ : ℝ) <
      (1 + 2 * movingTimePotential P M (shrinkingSwitchRank C M) (M + 1) /
        driftGap) + 1 := by
    apply Nat.ceil_lt_add_one
    have hquot : 0 ≤
        2 * movingTimePotential P M (shrinkingSwitchRank C M) (M + 1) /
          driftGap := div_nonneg (mul_nonneg (by norm_num) hpot0) driftGap_pos.le
    linarith
  have hcardR :
      ((movingFeasibleTimes P pLo M (shrinkingSwitchRank C M) q).card : ℝ) ≤
        (⌈(1 + 2 * movingTimePotential P M (shrinkingSwitchRank C M) (M + 1) /
          driftGap)⌉₊ : ℝ) := by exact_mod_cast hcard
  have hsqrt1 : 1 ≤
      Real.sqrt (((M : ℝ) + 2) * Real.log ((M : ℝ) + 2)) := by
    rw [← Real.sqrt_one]
    apply Real.sqrt_le_sqrt
    have hlog1 : 1 ≤ Real.log ((M : ℝ) + 2) := by
      apply (Real.le_log_iff_exp_le (by positivity)).2
      have he : Real.exp 1 < 3 := Real.exp_one_lt_d9.trans (by norm_num)
      have hMR : (1 : ℝ) ≤ M := by exact_mod_cast hM
      linarith
    nlinarith
  calc
    ((movingFeasibleTimes P pLo M (shrinkingSwitchRank C M) q).card : ℝ) ≤
        (⌈(1 + 2 * movingTimePotential P M (shrinkingSwitchRank C M) (M + 1) /
          driftGap)⌉₊ : ℝ) := hcardR
    _ < (1 + 2 * movingTimePotential P M (shrinkingSwitchRank C M) (M + 1) /
          driftGap) + 1 := hceil
    _ ≤ movingTimeSupportConstant P C *
          Real.sqrt (((M : ℝ) + 2) * Real.log ((M : ℝ) + 2)) + 1 := by
      linarith
    _ ≤ (movingTimeSupportConstant P C + 1) *
          Real.sqrt (((M : ℝ) + 2) * Real.log ((M : ℝ) + 2)) := by
      nlinarith

/-- The literal moving low parameters eventually admit a stopped-map stage
package.  This is the producer needed to instantiate the uniform support
theorem at each outer shell.

**Formalization status.** This proves only `Nonempty (StageSetup ...)`; the
existential erases the constructed startup rank, so no caller may assume
`p.M0 ≤ L` for the resulting witness `p`.  This is not a bookkeeping gap
alone: `exists_stageSetup`'s own construction sets
`M0 = max 1 (max Mlin (max Mone Mhor))` with
`Mlin = ⌈(2 + η) / (r - a0 - η)⌉`, and `movingLow_passageMargin` shows the
low-stage gap `r_L - a0 - η_L` equals exactly `K₀ / (2L)`.  A direct
application therefore only yields `M0 = O(L)` with a constant that is
uncontrolled by this lemma (and `Mhor`, coming from the non-constructive
`eventually_horizon_small`, is not tracked at all), short of the exact
`p_L.M0 ≤ L` declaration the moving headline needs.  The reserved name for
the uniform closure is `eventually_movingLowStageSetup_M0_le`.  The
regression gate in `audits/audit_paper_lean_semantics.py` refuses any ledger
claim that uniform startup is formally complete until a declaration of that
name (or an explicitly updated gate) exists; see `proof-state.md` for the
tracked status. -/
theorem eventually_nonempty_movingLowStageSetup
    {K₀ : ℝ} (hK₀ : 0 < K₀) :
    ∀ᶠ L : ℕ in atTop,
      Nonempty (StageSetup (movingLowRatio K₀ L)
        (movingLowTolerance K₀ L)) := by
  have hadm := eventually_movingLow_admissible hK₀ (by norm_num : (0 : ℝ) < 1)
  filter_upwards [hadm, eventually_ge_atTop (1 : ℕ)] with L hadm hL
  rcases hadm with ⟨ht0, htGap, hr0, hr1, _hlam0, _hlam1, _hcorr⟩
  have hmargin := movingLow_passageMargin K₀ L
  have hmarginPos : 0 < K₀ / (2 * (L : ℝ)) := by positivity
  have ha0r : a0 < movingLowRatio K₀ L := by linarith
  have htPass : movingLowTolerance K₀ L < movingLowRatio K₀ L - a0 := by
    linarith
  exact exists_stageSetup ha0r hr1 ht0 htPass

end

end FirstPassageLinearTransport
