/-
Copyright (c) 2026 Idris Ali Shaik. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Idris Ali Shaik
-/
import FirstPassageLinearTransport.TerminalProfile

/-!
# Variable-regime certified runs

The optimized construction uses different stage parameters at high and low
shell ranks.  This module proves that every such literal stopped-map run is
still one `CertifiedRankChain` for a common lower contraction parameter
`rStar`.  Consequently the exact direct-first-passage and rank-scaled loss
theorems apply without inspecting how often the regime changes.
-/

namespace FirstPassageLinearTransport

noncomputable section

/-- A floor target formed with `r` satisfies the parent-rank budget for every
positive common parameter `rStar ≤ r`. -/
theorem parentRank_le_commonTargetBudget
    {rStar r : ℚ} (hrStar : 0 < rStar) (hStar : rStar ≤ r) (m : ℕ) :
    (m : ℚ) ≤ ((rationalTargetRank r m + 1 : ℕ) : ℚ) / rStar := by
  apply (le_div_iff₀ hrStar).2
  have hrStarR : (0 : ℝ) < (rStar : ℝ) := by exact_mod_cast hrStar
  have hStarR : (rStar : ℝ) ≤ (r : ℝ) := by exact_mod_cast hStar
  have hrR : (0 : ℝ) ≤ (r : ℝ) := hrStarR.le.trans hStarR
  have hnonneg : (0 : ℝ) ≤ (r : ℝ) * (m : ℝ) := by positivity
  have hfloor := Nat.lt_floor_add_one ((r : ℝ) * (m : ℝ))
  have hfloor' : (r : ℝ) * (m : ℝ) ≤
      (rationalTargetRank r m + 1 : ℕ) := by
    simpa [rationalTargetRank] using hfloor.le
  have hbound : (rStar : ℝ) * (m : ℝ) ≤
      (rationalTargetRank r m + 1 : ℕ) := by
    have hfirst : (rStar : ℝ) * (m : ℝ) ≤
        (r : ℝ) * (m : ℝ) :=
      mul_le_mul_of_nonneg_right hStarR (Nat.cast_nonneg m)
    exact hfirst.trans hfloor'
  have hboundQ : rStar * (m : ℚ) ≤
      ((rationalTargetRank r m + 1 : ℕ) : ℚ) := by
    exact_mod_cast hbound
  simpa [mul_comm] using hboundQ

/-- One literal stage initializes the common-budget rank chain. -/
theorem CertifiedRankChain.first_of_stage_common
    {rStar r : ℚ} {eta : ℝ} (p : StageSetup (r : ℝ) eta)
    (hrStar : 0 < rStar) (hStar : rStar ≤ r) {m n : ℕ}
    (hm0 : p.M0 ≤ m) (hnShell : n ∈ dyadicShell m)
    (hnGood : n ∈ initialWindowGood eta) :
    CertifiedRankChain rStar n (stageLength p n) (rationalTargetRank r m) := by
  apply CertifiedRankChain.first
  · simpa [targetScale_rat] using
      stageLength_isFirstPassage p hm0 hnShell hnGood
  · exact stageLength_le_shell p hm0 hnShell hnGood
  · exact parentRank_le_commonTargetBudget hrStar hStar m

/-- One further literal stage extends the same common-budget rank chain. -/
theorem CertifiedRankChain.next_of_stage_common
    {rStar r : ℚ} {eta : ℝ} (p : StageSetup (r : ℝ) eta)
    (hrStar : 0 < rStar) (hStar : rStar ≤ r)
    {n elapsed qprev m : ℕ}
    (hchain : CertifiedRankChain rStar n elapsed qprev)
    (hm0 : p.M0 ≤ m) (hsourceShell : orbit elapsed n ∈ dyadicShell m)
    (hsourceGood : orbit elapsed n ∈ initialWindowGood eta)
    (hgap : rationalTargetRank r m < qprev) :
    CertifiedRankChain rStar n
      (elapsed + stageLength p (orbit elapsed n))
      (rationalTargetRank r m) := by
  apply CertifiedRankChain.next hchain hgap
  · simpa [targetScale_rat] using
      stageLength_isFirstPassage p hm0 hsourceShell hsourceGood
  · exact stageLength_le_shell p hm0 hsourceShell hsourceGood
  · exact parentRank_le_commonTargetBudget hrStar hStar m

/-- A finite certified run whose successive blocks may use different stage
packages, all dominating the common contraction parameter `rStar`. -/
inductive MixedRecertificationRun (rStar : ℚ) (n : ℕ) : ℕ → ℕ → Prop
  | first {r : ℚ} {eta : ℝ} (p : StageSetup (r : ℝ) eta)
      {m : ℕ}
      (hStar : rStar ≤ r)
      (hm0 : p.M0 ≤ m)
      (hnShell : n ∈ dyadicShell m)
      (hnGood : n ∈ initialWindowGood eta) :
      MixedRecertificationRun rStar n
        (stageLength p n) (rationalTargetRank r m)
  | next {elapsed qprev : ℕ} (hrun : MixedRecertificationRun rStar n elapsed qprev)
      {r : ℚ} {eta : ℝ} (p : StageSetup (r : ℝ) eta)
      {m : ℕ}
      (hStar : rStar ≤ r)
      (hm0 : p.M0 ≤ m)
      (hsourceShell : orbit elapsed n ∈ dyadicShell m)
      (hsourceGood : orbit elapsed n ∈ initialWindowGood eta)
      (hgap : rationalTargetRank r m < qprev) :
      MixedRecertificationRun rStar n
        (elapsed + stageLength p (orbit elapsed n))
        (rationalTargetRank r m)

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

/-- Every variable-regime run is one exact rank chain for `rStar`. -/
theorem MixedRecertificationRun.toCertifiedRankChain
    {rStar : ℚ} (hrStar : 0 < rStar) {n elapsed q : ℕ}
    (hrun : MixedRecertificationRun rStar n elapsed q) :
    CertifiedRankChain rStar n elapsed q := by
  induction hrun with
  | first p hStar hm0 hnShell hnGood =>
      exact CertifiedRankChain.first_of_stage_common
        p hrStar hStar hm0 hnShell hnGood
  | next hrun p hStar hm0 hsourceShell hsourceGood hgap ih =>
      exact CertifiedRankChain.next_of_stage_common
        p hrStar hStar ih hm0 hsourceShell hsourceGood hgap

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

end

end FirstPassageLinearTransport
