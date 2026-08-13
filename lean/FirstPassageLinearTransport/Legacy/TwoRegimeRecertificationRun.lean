/-
Copyright (c) 2026 Idris Ali Shaik. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Idris Ali Shaik
-/
import FirstPassageLinearTransport.TwoRegimeClock
import FirstPassageLinearTransport.TwoRegimeRun

import FirstPassageLinearTransport.Extras.Unreachable
/-!
# Historical literal two-regime run

This module retains the literal high/low execution state and its first-bad
adapters for the legacy fixed-parameter route.  The canonical timeout proof
uses only the neutral scalar clock and common-budget rank-chain modules.
-/

namespace FirstPassageLinearTransport

noncomputable section

theorem MixedRecertificationRun.elapsed_pos
    {rStar : ℚ} {n elapsed q : ℕ}
    (hrun : MixedRecertificationRun rStar n elapsed q) : 0 < elapsed := by
  cases hrun with
  | first p hStar hm0 hnShell hnGood =>
      exact stageLength_pos p hm0 hnShell hnGood
  | next hrun p hStar hm0 hsourceShell hsourceGood hgap =>
      have hstage := stageLength_pos p hm0 hsourceShell hsourceGood
      omega

theorem MixedRecertificationRun.currentRank_pos
    {rStar : ℚ} {n elapsed q : ℕ}
    (hrun : MixedRecertificationRun rStar n elapsed q) : 0 < q := by
  cases hrun with
  | @first r eta p m hStar hm0 hnShell hnGood =>
      have ht := p.target_one_lt m hm0
      rw [targetScale_rat] at ht
      by_contra hq
      have : rationalTargetRank r m = 0 := Nat.eq_zero_of_not_pos hq
      simp [this] at ht
  | @next elapsed qprev hrun r eta p m hStar hm0 hsourceShell hsourceGood hgap =>
      have ht := p.target_one_lt m hm0
      rw [targetScale_rat] at ht
      by_contra hq
      have : rationalTargetRank r m = 0 := Nat.eq_zero_of_not_pos hq
      simp [this] at ht

/-- A failed endpoint of a variable-regime run lies in the literal bad
landing band for whichever certification tolerance is active at that rank. -/
theorem MixedRecertificationRun.endpoint_mem_landingBad
    {rStar : ℚ} (hrStar : 0 < rStar) {t : ℝ}
    {n elapsed q : ℕ}
    (hrun : MixedRecertificationRun rStar n elapsed q)
    (hbad : orbit elapsed n ∉ initialWindowGood t) :
    orbit elapsed n ∈ landingBad q t := by
  have hchain := hrun.toCertifiedRankChain hrStar
  have hfp := hchain.directFirstPassage
  have hband := firstPassage_band hrun.elapsed_pos hfp
  have hq := hrun.currentRank_pos
  apply mem_landingBad.mpr
  refine ⟨?_, hband.2, hbad⟩
  rw [show q = (q - 1) + 1 by omega, pow_succ] at hband
  omega

/-- A variable-regime failed endpoint supplies the same generated first-bad
witness consumed by the exact direct transport envelope. -/
theorem MixedRecertificationRun.toGeneratedFirstBadLanding
    {rStar : ℚ} (hrStar : 0 < rStar) {t : ℝ}
    {n elapsed q L U H : ℕ}
    (hrun : MixedRecertificationRun rStar n elapsed q)
    (hLq : L ≤ q) (hqU : q ≤ U) (hhH : elapsed ≤ H)
    (hbad : orbit elapsed n ∉ initialWindowGood t) :
    HasGeneratedFirstBadLanding rStar t n L U H :=
  hasGeneratedFirstBadLanding_of_chain hLq hqU hrun.elapsed_pos hhH
    (hrun.toCertifiedRankChain hrStar)
    (hrun.endpoint_mem_landingBad hrStar hbad)

/-- Rank-dependent certification failure used at the high/low switch.  The
single switch rank is deliberately the union of both complements. -/
def TwoRegimeTargetFailure
    (tHi tLo : ℝ) (S q y : ℕ) : Prop :=
  (S < q ∧ y ∉ initialWindowGood tHi) ∨
  (q = S ∧ (y ∉ initialWindowGood tHi ∨ y ∉ initialWindowGood tLo)) ∨
  (q < S ∧ y ∉ initialWindowGood tLo)

/-- A literal variable-regime run whose endpoint fails the certification
selected by its final threshold rank. -/
def HasTwoRegimeFirstBadLanding
    (rStar : ℚ) (tHi tLo : ℝ) (n L S U H : ℕ) : Prop :=
  ∃ elapsed q : ℕ,
    L ≤ q ∧ q ≤ U ∧ elapsed ≤ H ∧
    MixedRecertificationRun rStar n elapsed q ∧
    TwoRegimeTargetFailure tHi tLo S q (orbit elapsed n)

/-- Literal high/low stopped-map run.  High blocks are used exactly at parent
ranks at least `S`, and low blocks below `S`. -/
inductive TwoRegimeRecertificationRun
    {rHi rLo : ℚ} {etaHi etaLo : ℝ}
    (pHi : StageSetup (rHi : ℝ) etaHi)
    (pLo : StageSetup (rLo : ℝ) etaLo)
    (S : ℕ) (n : ℕ) : ℕ → ℕ → Prop
  | first {M : ℕ}
      (hSM : S ≤ M) (hM0 : pHi.M0 ≤ M)
      (hnShell : n ∈ dyadicShell M)
      (hnGood : n ∈ initialWindowGood etaHi) :
      TwoRegimeRecertificationRun pHi pLo S n
        (stageLength pHi n) (rationalTargetRank rHi M)
  | nextHi {elapsed qPrev m : ℕ}
      (hrun : TwoRegimeRecertificationRun pHi pLo S n elapsed qPrev)
      (hSm : S ≤ m) (hm0 : pHi.M0 ≤ m)
      (hsourceShell : orbit elapsed n ∈ dyadicShell m)
      (hsourceGood : orbit elapsed n ∈ initialWindowGood etaHi)
      (hgap : rationalTargetRank rHi m < qPrev) :
      TwoRegimeRecertificationRun pHi pLo S n
        (elapsed + stageLength pHi (orbit elapsed n))
        (rationalTargetRank rHi m)
  | nextLo {elapsed qPrev m : ℕ}
      (hrun : TwoRegimeRecertificationRun pHi pLo S n elapsed qPrev)
      (hmS : m < S) (hm0 : pLo.M0 ≤ m)
      (hsourceShell : orbit elapsed n ∈ dyadicShell m)
      (hsourceGood : orbit elapsed n ∈ initialWindowGood etaLo)
      (hgap : rationalTargetRank rLo m < qPrev) :
      TwoRegimeRecertificationRun pHi pLo S n
        (elapsed + stageLength pLo (orbit elapsed n))
        (rationalTargetRank rLo m)

theorem TwoRegimeRecertificationRun.elapsed_pos
    {rHi rLo : ℚ} {etaHi etaLo : ℝ}
    {pHi : StageSetup (rHi : ℝ) etaHi}
    {pLo : StageSetup (rLo : ℝ) etaLo}
    {S n elapsed q : ℕ}
    (hrun : TwoRegimeRecertificationRun pHi pLo S n elapsed q) :
    0 < elapsed := by
  cases hrun with
  | first hSM hM0 hnShell hnGood =>
      exact stageLength_pos pHi hM0 hnShell hnGood
  | nextHi hrun hSm hm0 hsourceShell hsourceGood hgap =>
      have hstage := stageLength_pos pHi hm0 hsourceShell hsourceGood
      omega
  | nextLo hrun hmS hm0 hsourceShell hsourceGood hgap =>
      have hstage := stageLength_pos pLo hm0 hsourceShell hsourceGood
      omega

/-- Forgetting the high/low labels gives the common-budget variable run. -/
theorem TwoRegimeRecertificationRun.toMixed
    {rStar rHi rLo : ℚ} {etaHi etaLo : ℝ}
    {pHi : StageSetup (rHi : ℝ) etaHi}
    {pLo : StageSetup (rLo : ℝ) etaLo}
    {S n elapsed q : ℕ}
    (hStarHi : rStar ≤ rHi) (hStarLo : rStar ≤ rLo)
    (hrun : TwoRegimeRecertificationRun pHi pLo S n elapsed q) :
    MixedRecertificationRun rStar n elapsed q := by
  induction hrun with
  | first hSM hM0 hnShell hnGood =>
      exact MixedRecertificationRun.first pHi hStarHi hM0 hnShell hnGood
  | nextHi hrun hSm hm0 hsourceShell hsourceGood hgap ih =>
      exact MixedRecertificationRun.next ih pHi hStarHi hm0
        hsourceShell hsourceGood hgap
  | nextLo hrun hmS hm0 hsourceShell hsourceGood hgap ih =>
      exact MixedRecertificationRun.next ih pLo hStarLo hm0
        hsourceShell hsourceGood hgap

/-- Nested first passage is independent of which regime supplied each
threshold. -/
theorem TwoRegimeRecertificationRun.directFirstPassage
    {rHi rLo : ℚ} {etaHi etaLo : ℝ}
    {pHi : StageSetup (rHi : ℝ) etaHi}
    {pLo : StageSetup (rLo : ℝ) etaLo}
    {S n elapsed q : ℕ}
    (hrun : TwoRegimeRecertificationRun pHi pLo S n elapsed q) :
    IsFirstPassage (2 ^ q) n elapsed := by
  induction hrun with
  | first hSM hM0 hnShell hnGood =>
      simpa [targetScale_rat] using
        stageLength_isFirstPassage pHi hM0 hnShell hnGood
  | nextHi hrun hSm hm0 hsourceShell hsourceGood hgap ih =>
      have hthreshold : 2 ^ rationalTargetRank rHi _ < 2 ^ _ :=
        Nat.pow_lt_pow_right (by omega) hgap
      exact ih.nested hthreshold (by
        simpa [targetScale_rat] using
          stageLength_isFirstPassage pHi hm0 hsourceShell hsourceGood)
  | nextLo hrun hmS hm0 hsourceShell hsourceGood hgap ih =>
      have hthreshold : 2 ^ rationalTargetRank rLo _ < 2 ^ _ :=
        Nat.pow_lt_pow_right (by omega) hgap
      exact ih.nested hthreshold (by
        simpa [targetScale_rat] using
          stageLength_isFirstPassage pLo hm0 hsourceShell hsourceGood)

private theorem rationalTargetRank_cast_le
    {r : ℚ} (hr : 0 ≤ r) (m : ℕ) :
    (rationalTargetRank r m : ℝ) ≤ (r : ℝ) * (m : ℝ) := by
  exact Nat.floor_le (mul_nonneg (by exact_mod_cast hr) (Nat.cast_nonneg m))

/-- Every literal two-regime run carries the scalar rank trace used by the
clock potential. -/
theorem TwoRegimeRecertificationRun.toRankTrace
    {rHi rLo : ℚ} {etaHi etaLo : ℝ}
    {pHi : StageSetup (rHi : ℝ) etaHi}
    {pLo : StageSetup (rLo : ℝ) etaLo}
    {S M n elapsed q : ℕ}
    (hrun : TwoRegimeRecertificationRun pHi pLo S n elapsed q)
    (hstartShell : n ∈ dyadicShell M) :
    TwoRegimeRankTrace (rHi : ℝ) (rLo : ℝ) S M elapsed q := by
  have hrHi0 : (0 : ℚ) ≤ rHi := by exact_mod_cast pHi.r_pos.le
  have hrLo0 : (0 : ℚ) ≤ rLo := by exact_mod_cast pLo.r_pos.le
  induction hrun with
  | @first M' hSM hM0 hnShell hnGood =>
      have hMM' : M = M' := by
        have hlogM := log_two_eq_of_mem_dyadicShell hstartShell
        have hlogM' := log_two_eq_of_mem_dyadicShell hnShell
        omega
      subst M'
      exact TwoRegimeRankTrace.first
        (stageLength_le_shell pHi hM0 hnShell hnGood)
        (rationalTargetRank_cast_le hrHi0 M)
  | @nextHi elapsed qPrev m hrun hSm hm0 hsourceShell hsourceGood hgap ih =>
      have hfp := hrun.directFirstPassage
      have hpow : 2 ^ m ≤ 2 ^ qPrev :=
        (mem_dyadicShell.mp hsourceShell).1.trans hfp.1
      have hmPrev : m ≤ qPrev := by
        by_contra hnot
        have hstrict : 2 ^ qPrev < 2 ^ m :=
          Nat.pow_lt_pow_right (by omega) (by omega)
        omega
      apply TwoRegimeRankTrace.next ih hmPrev
        (stageLength_le_shell pHi hm0 hsourceShell hsourceGood)
      simpa [hSm] using rationalTargetRank_cast_le hrHi0 m
  | @nextLo elapsed qPrev m hrun hmS hm0 hsourceShell hsourceGood hgap ih =>
      have hfp := hrun.directFirstPassage
      have hpow : 2 ^ m ≤ 2 ^ qPrev :=
        (mem_dyadicShell.mp hsourceShell).1.trans hfp.1
      have hmPrev : m ≤ qPrev := by
        by_contra hnot
        have hstrict : 2 ^ qPrev < 2 ^ m :=
          Nat.pow_lt_pow_right (by omega) (by omega)
        omega
      apply TwoRegimeRankTrace.next ih hmPrev
        (stageLength_le_shell pLo hm0 hsourceShell hsourceGood)
      simpa [show ¬ S ≤ m by omega] using
        rationalTargetRank_cast_le hrLo0 m

/-- Literal two-regime runs satisfy the advertised geometric shortcut-clock
bound. -/
theorem TwoRegimeRecertificationRun.elapsed_le
    {rHi rLo : ℚ} {etaHi etaLo : ℝ}
    {pHi : StageSetup (rHi : ℝ) etaHi}
    {pLo : StageSetup (rLo : ℝ) etaLo}
    {S M n elapsed q : ℕ}
    (hrun : TwoRegimeRecertificationRun pHi pLo S n elapsed q)
    (hstartShell : n ∈ dyadicShell M) :
    (elapsed : ℝ) ≤
      (M : ℝ) / (1 - (rHi : ℝ)) +
        (S : ℝ) / (1 - (rLo : ℝ)) := by
  exact (hrun.toRankTrace hstartShell).elapsed_le
    pHi.r_pos.le pHi.r_lt_one pLo.r_lt_one

/-- Literal two-regime runs satisfy the canonical integer clock used by the
failure and execution profiles. -/
theorem TwoRegimeRecertificationRun.elapsed_le_horizon
    {rHi rLo : ℚ} {etaHi etaLo : ℝ}
    {pHi : StageSetup (rHi : ℝ) etaHi}
    {pLo : StageSetup (rLo : ℝ) etaLo}
    {S M n elapsed q : ℕ}
    (hrun : TwoRegimeRecertificationRun pHi pLo S n elapsed q)
    (hstartShell : n ∈ dyadicShell M) :
    elapsed ≤ twoRegimeHorizon rHi rLo S M := by
  have hreal : (elapsed : ℝ) ≤
      (twoRegimeHorizon rHi rLo S M : ℝ) :=
    (hrun.elapsed_le hstartShell).trans
      (twoRegimeHorizon_lower rHi rLo S M)
  exact_mod_cast hreal

end

end FirstPassageLinearTransport
