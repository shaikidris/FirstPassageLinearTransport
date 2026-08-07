/-
Copyright (c) 2026 Idris Ali Shaik. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Idris Ali Shaik
-/
import FirstPassageLinearTransport.TwoRegimeProfile

/-!
# Two-regime geometric clock

The potential below pays the remaining high-rank geometric series and, once
needed, the complete low-rank geometric series.  Its one-step decrease gives
the exact clock bound from the manuscript without counting stages.
-/

namespace FirstPassageLinearTransport

noncomputable section

/-- Remaining clock potential at rank `q`. -/
def twoRegimeClockPotential (rHi rLo : ℝ) (S q : ℕ) : ℝ :=
  if S ≤ q then
    (q : ℝ) / (1 - rHi) + (S : ℝ) / (1 - rLo)
  else
    (q : ℝ) / (1 - rLo)

theorem twoRegimeClockPotential_nonneg
    {rHi rLo : ℝ} (hrHi : rHi < 1) (hrLo : rLo < 1)
    (S q : ℕ) :
    0 ≤ twoRegimeClockPotential rHi rLo S q := by
  have hdHi : 0 < 1 - rHi := sub_pos.mpr hrHi
  have hdLo : 0 < 1 - rLo := sub_pos.mpr hrLo
  unfold twoRegimeClockPotential
  split_ifs
  · exact add_nonneg
      (div_nonneg (Nat.cast_nonneg q) hdHi.le)
      (div_nonneg (Nat.cast_nonneg S) hdLo.le)
  · exact div_nonneg (Nat.cast_nonneg q) hdLo.le

/-- One rank step decreases the clock potential by at least the local time.
The active contraction is selected by the parent rank `m`. -/
theorem twoRegimeClockPotential_step
    {rHi rLo : ℝ} {S qPrev m h q : ℕ}
    (hrHi0 : 0 ≤ rHi) (hrHi1 : rHi < 1)
    (hrLo1 : rLo < 1)
    (hmPrev : m ≤ qPrev) (hhm : h ≤ m)
    (hcontract :
      if S ≤ m then (q : ℝ) ≤ rHi * (m : ℝ)
      else (q : ℝ) ≤ rLo * (m : ℝ)) :
    (h : ℝ) + twoRegimeClockPotential rHi rLo S q ≤
      twoRegimeClockPotential rHi rLo S qPrev := by
  have hdHi : 0 < 1 - rHi := sub_pos.mpr hrHi1
  have hdLo : 0 < 1 - rLo := sub_pos.mpr hrLo1
  have hhmR : (h : ℝ) ≤ (m : ℝ) := by exact_mod_cast hhm
  have hmPrevR : (m : ℝ) ≤ (qPrev : ℝ) := by exact_mod_cast hmPrev
  by_cases hqHigh : S ≤ q
  · have hmHigh : S ≤ m := by
      by_contra hmHigh
      have hactive : (q : ℝ) ≤ rLo * (m : ℝ) := by
        simpa [hmHigh] using hcontract
      have hrmul : rLo * (m : ℝ) ≤ (m : ℝ) := by
        nlinarith [show (0 : ℝ) ≤ (m : ℝ) from Nat.cast_nonneg m]
      have hqm : q ≤ m := by exact_mod_cast hactive.trans hrmul
      omega
    have hactive : (q : ℝ) ≤ rHi * (m : ℝ) := by
      simpa [hmHigh] using hcontract
    have hrmul : rHi * (m : ℝ) ≤ (m : ℝ) := by
      nlinarith [show (0 : ℝ) ≤ (m : ℝ) from Nat.cast_nonneg m]
    have hqm : q ≤ m := by exact_mod_cast hactive.trans hrmul
    have hprevHigh : S ≤ qPrev := hqHigh.trans (hqm.trans hmPrev)
    unfold twoRegimeClockPotential
    rw [if_pos hqHigh, if_pos hprevHigh]
    have hlocal : (h : ℝ) + (q : ℝ) / (1 - rHi) ≤
        (m : ℝ) / (1 - rHi) := by
      calc
        (h : ℝ) + (q : ℝ) / (1 - rHi) ≤
            (m : ℝ) + (rHi * (m : ℝ)) / (1 - rHi) :=
          add_le_add hhmR ((div_le_div_iff_of_pos_right hdHi).2 hactive)
        _ = (m : ℝ) / (1 - rHi) := by
          field_simp [hdHi.ne']
          ring
    have hmono : (m : ℝ) / (1 - rHi) ≤
        (qPrev : ℝ) / (1 - rHi) :=
      (div_le_div_iff_of_pos_right hdHi).2 hmPrevR
    linarith
  · have hqLow : q < S := Nat.lt_of_not_ge hqHigh
    by_cases hprevHigh : S ≤ qPrev
    · unfold twoRegimeClockPotential
      rw [if_neg hqHigh, if_pos hprevHigh]
      have htime : (h : ℝ) ≤ (qPrev : ℝ) / (1 - rHi) := by
        have hmq : (m : ℝ) ≤ (qPrev : ℝ) := hmPrevR
        have hqdiv : (qPrev : ℝ) ≤ (qPrev : ℝ) / (1 - rHi) := by
          apply (le_div_iff₀ hdHi).2
          nlinarith [show (0 : ℝ) ≤ (qPrev : ℝ) from Nat.cast_nonneg qPrev]
        exact hhmR.trans (hmq.trans hqdiv)
      have hqS : (q : ℝ) / (1 - rLo) ≤
          (S : ℝ) / (1 - rLo) :=
        (div_le_div_iff_of_pos_right hdLo).2 (by exact_mod_cast hqLow.le)
      linarith
    · have hprevLow : qPrev < S := Nat.lt_of_not_ge hprevHigh
      have hmLow : ¬ S ≤ m := by omega
      have hactive : (q : ℝ) ≤ rLo * (m : ℝ) := by
        simpa [hmLow] using hcontract
      unfold twoRegimeClockPotential
      rw [if_neg hqHigh, if_neg hprevHigh]
      have hlocal : (h : ℝ) + (q : ℝ) / (1 - rLo) ≤
          (m : ℝ) / (1 - rLo) := by
        calc
          (h : ℝ) + (q : ℝ) / (1 - rLo) ≤
              (m : ℝ) + (rLo * (m : ℝ)) / (1 - rLo) :=
            add_le_add hhmR ((div_le_div_iff_of_pos_right hdLo).2 hactive)
          _ = (m : ℝ) / (1 - rLo) := by
            field_simp [hdLo.ne']
            ring
      have hmono : (m : ℝ) / (1 - rLo) ≤
          (qPrev : ℝ) / (1 - rLo) :=
        (div_le_div_iff_of_pos_right hdLo).2 hmPrevR
      exact hlocal.trans hmono

/-- Rank/time data of a two-regime stopped path. -/
inductive TwoRegimeRankTrace
    (rHi rLo : ℝ) (S M : ℕ) : ℕ → ℕ → Prop
  | first {h q : ℕ}
      (hhM : h ≤ M)
      (hq : (q : ℝ) ≤ rHi * (M : ℝ)) :
      TwoRegimeRankTrace rHi rLo S M h q
  | next {elapsed qPrev m h q : ℕ}
      (htrace : TwoRegimeRankTrace rHi rLo S M elapsed qPrev)
      (hmPrev : m ≤ qPrev) (hhm : h ≤ m)
      (hq : if S ≤ m then (q : ℝ) ≤ rHi * (m : ℝ)
        else (q : ℝ) ≤ rLo * (m : ℝ)) :
      TwoRegimeRankTrace rHi rLo S M (elapsed + h) q

/-- Potential invariant for the complete two-regime trace. -/
theorem TwoRegimeRankTrace.elapsed_add_potential_le
    {rHi rLo : ℝ} {S M elapsed q : ℕ}
    (hrHi0 : 0 ≤ rHi) (hrHi1 : rHi < 1)
    (hrLo1 : rLo < 1)
    (htrace : TwoRegimeRankTrace rHi rLo S M elapsed q) :
    (elapsed : ℝ) + twoRegimeClockPotential rHi rLo S q ≤
      (M : ℝ) / (1 - rHi) + (S : ℝ) / (1 - rLo) := by
  induction htrace with
  | @first h q hhM hq =>
      have hdHi : 0 < 1 - rHi := sub_pos.mpr hrHi1
      have hdLo : 0 < 1 - rLo := sub_pos.mpr hrLo1
      have hhMR : (h : ℝ) ≤ (M : ℝ) := by exact_mod_cast hhM
      by_cases hqHigh : S ≤ q
      · unfold twoRegimeClockPotential
        rw [if_pos hqHigh]
        have hlocal : (h : ℝ) + (q : ℝ) / (1 - rHi) ≤
            (M : ℝ) / (1 - rHi) := by
          calc
            (h : ℝ) + (q : ℝ) / (1 - rHi) ≤
                (M : ℝ) + (rHi * (M : ℝ)) / (1 - rHi) :=
              add_le_add hhMR ((div_le_div_iff_of_pos_right hdHi).2 hq)
            _ = (M : ℝ) / (1 - rHi) := by
              field_simp [hdHi.ne']
              ring
        linarith
      · unfold twoRegimeClockPotential
        rw [if_neg hqHigh]
        have htime : (h : ℝ) ≤ (M : ℝ) / (1 - rHi) := by
          have hMdiv : (M : ℝ) ≤ (M : ℝ) / (1 - rHi) := by
            apply (le_div_iff₀ hdHi).2
            nlinarith [show (0 : ℝ) ≤ (M : ℝ) from Nat.cast_nonneg M]
          exact hhMR.trans hMdiv
        have hqS : (q : ℝ) / (1 - rLo) ≤
            (S : ℝ) / (1 - rLo) :=
          (div_le_div_iff_of_pos_right hdLo).2 (by
            exact_mod_cast (Nat.lt_of_not_ge hqHigh).le)
        linarith
  | @next elapsed qPrev m h q htrace hmPrev hhm hq ih =>
      have hstep := twoRegimeClockPotential_step
        hrHi0 hrHi1 hrLo1 hmPrev hhm hq
      push_cast
      linarith

/-- The complete two-regime shortcut time is bounded by the two geometric
rank budgets. -/
theorem TwoRegimeRankTrace.elapsed_le
    {rHi rLo : ℝ} {S M elapsed q : ℕ}
    (hrHi0 : 0 ≤ rHi) (hrHi1 : rHi < 1)
    (hrLo1 : rLo < 1)
    (htrace : TwoRegimeRankTrace rHi rLo S M elapsed q) :
    (elapsed : ℝ) ≤
      (M : ℝ) / (1 - rHi) + (S : ℝ) / (1 - rLo) := by
  have hmain := htrace.elapsed_add_potential_le
    hrHi0 hrHi1 hrLo1
  have hpot := twoRegimeClockPotential_nonneg hrHi1 hrLo1 S q
  linarith

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

/-- Canonical natural-number clock for the complete two-regime run.  The
ceiling is taken only after the high- and low-rank geometric budgets have
been added. -/
noncomputable def twoRegimeHorizon
    (rHi rLo : ℚ) (S M : ℕ) : ℕ :=
  ⌈((M : ℝ) / (1 - (rHi : ℝ)) +
      (S : ℝ) / (1 - (rLo : ℝ)))⌉₊

/-- The real geometric budget lies below its canonical natural ceiling. -/
theorem twoRegimeHorizon_lower
    (rHi rLo : ℚ) (S M : ℕ) :
    (M : ℝ) / (1 - (rHi : ℝ)) +
        (S : ℝ) / (1 - (rLo : ℝ)) ≤
      (twoRegimeHorizon rHi rLo S M : ℝ) := by
  exact Nat.le_ceil _

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
