/-
Copyright (c) 2026 Idris Ali Shaik. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Idris Ali Shaik
-/
import FirstPassageLinearTransport.TwoRegimeClock

/-!
# Termination of two-regime re-certification

Rank descent is used only to prove termination.  Failure is recorded before
the next block is invoked, so no bad landing is ever assumed certified.
-/

namespace FirstPassageLinearTransport

noncomputable section

/-- The shell rank of a positive first-passage landing differs from the
threshold rank by at most one. -/
theorem firstPassage_landing_shell_rank
    {n elapsed q m : ℕ} (helapsed : 0 < elapsed)
    (hfp : IsFirstPassage (2 ^ q) n elapsed)
    (hshell : orbit elapsed n ∈ dyadicShell m) :
    m ≤ q ∧ q ≤ m + 1 := by
  have hpowLe : 2 ^ m ≤ 2 ^ q :=
    (mem_dyadicShell.mp hshell).1.trans hfp.1
  have hmq : m ≤ q := by
    by_contra hnot
    have hstrict : 2 ^ q < 2 ^ m :=
      Nat.pow_lt_pow_right (by omega) (by omega)
    omega
  have hband := firstPassage_band helapsed hfp
  have hshellUpper := (mem_dyadicShell.mp hshell).2
  have hpowLt : 2 ^ q < 2 ^ (m + 2) := by
    calc
      2 ^ q < 2 * orbit elapsed n := hband.1
      _ < 2 * 2 ^ (m + 1) := Nat.mul_lt_mul_of_pos_left hshellUpper (by omega)
      _ = 2 ^ (m + 2) := by rw [pow_succ]; ring
  have hqm : q < m + 2 := by
    by_contra hnot
    have hpowBack : 2 ^ (m + 2) ≤ 2 ^ q :=
      Nat.pow_le_pow_right (by omega) (by omega)
    omega
  exact ⟨hmq, by omega⟩

/-- Successful terminal rank reached by a literal two-regime run. -/
def HasTwoRegimeTerminalLanding
    {rHi rLo : ℚ} {etaHi etaLo : ℝ}
    (pHi : StageSetup (rHi : ℝ) etaHi)
    (pLo : StageSetup (rLo : ℝ) etaLo)
    (S n L : ℕ) : Prop :=
  ∃ elapsed q : ℕ,
    q < L ∧ TwoRegimeRecertificationRun pHi pLo S n elapsed q

theorem HasTwoRegimeTerminalLanding.orbit_le
    {rHi rLo : ℚ} {etaHi etaLo : ℝ}
    {pHi : StageSetup (rHi : ℝ) etaHi}
    {pLo : StageSetup (rLo : ℝ) etaLo}
    {S n L : ℕ} (hterm : HasTwoRegimeTerminalLanding pHi pLo S n L) :
    ∃ elapsed : ℕ, orbit elapsed n < 2 ^ L := by
  rcases hterm with ⟨elapsed, q, hqL, hrun⟩
  have hfp := hrun.directFirstPassage
  refine ⟨elapsed, hfp.1.trans_lt ?_⟩
  exact Nat.pow_lt_pow_right (by omega) hqL

/-- A running certified path either terminates below rank `L` or supplies a
rank-appropriate first bad landing.  The proof is strong induction on the
strictly decreasing threshold rank. -/
theorem twoRegimeRun_terminal_or_firstBad
    {rHi rLo : ℚ} {etaHi etaLo : ℝ}
    {pHi : StageSetup (rHi : ℝ) etaHi}
    {pLo : StageSetup (rLo : ℝ) etaLo}
    {S n L U H : ℕ}
    (hn : 0 < n)
    (hHiStartup : pHi.M0 + 1 ≤ L)
    (hLoStartup : pLo.M0 + 1 ≤ L)
    (hclock : ∀ elapsed q,
      TwoRegimeRecertificationRun pHi pLo S n elapsed q → elapsed ≤ H)
    {elapsed q : ℕ} (hqU : q ≤ U)
    (hrun : TwoRegimeRecertificationRun pHi pLo S n elapsed q) :
    HasTwoRegimeTerminalLanding pHi pLo S n L ∨
      HasTwoRegimeFirstBadLanding
        (min rHi rLo) etaHi etaLo n L S U H := by
  induction q using Nat.strong_induction_on generalizing elapsed with
  | h q ih =>
      by_cases hqL : q < L
      · exact Or.inl ⟨elapsed, q, hqL, hrun⟩
      · have hLq : L ≤ q := by omega
        let x := orbit elapsed n
        let m := Nat.log 2 x
        have hx : 0 < x := orbit_pos hn elapsed
        have hxshell : x ∈ dyadicShell m := by
          rw [mem_dyadicShell]
          exact ⟨Nat.pow_log_le_self 2 hx.ne',
            Nat.lt_pow_succ_log_self (by norm_num) x⟩
        have hranks := firstPassage_landing_shell_rank hrun.elapsed_pos
          hrun.directFirstPassage hxshell
        have hmHiStartup : pHi.M0 ≤ m := by omega
        have hmLoStartup : pLo.M0 ≤ m := by omega
        have htime : elapsed ≤ H := hclock elapsed q hrun
        by_cases hmHigh : S ≤ m
        · by_cases hxGood : x ∈ initialWindowGood etaHi
          · have hrHi0 : (0 : ℚ) ≤ rHi := by exact_mod_cast pHi.r_pos.le
            have hrHi1 : rHi < 1 := by exact_mod_cast pHi.r_lt_one
            have hmpos : 0 < m := by
              by_contra hm0
              have hmzero : m = 0 := Nat.eq_zero_of_not_pos hm0
              have ht := pHi.target_one_lt m hmHiStartup
              rw [hmzero] at ht
              norm_num [targetScale] at ht
            have hgap : rationalTargetRank rHi m < q :=
              (rationalTargetRank_lt_parent hrHi0 hrHi1 hmpos).trans_le hranks.1
            let nextRun : TwoRegimeRecertificationRun pHi pLo S n
                (elapsed + stageLength pHi x) (rationalTargetRank rHi m) :=
              TwoRegimeRecertificationRun.nextHi hrun hmHigh hmHiStartup
                hxshell hxGood hgap
            exact ih (rationalTargetRank rHi m) hgap
              (hgap.le.trans hqU) nextRun
          · have htarget :
                TwoRegimeTargetFailure etaHi etaLo S q x := by
              by_cases hqS : q = S
              · exact Or.inr (Or.inl ⟨hqS, Or.inl hxGood⟩)
              · exact Or.inl ⟨by omega, hxGood⟩
            exact Or.inr ⟨elapsed, q, hLq, hqU, htime,
              hrun.toMixed (min_le_left _ _) (min_le_right _ _), htarget⟩
        · have hmLow : m < S := Nat.lt_of_not_ge hmHigh
          by_cases hxGood : x ∈ initialWindowGood etaLo
          · have hrLo0 : (0 : ℚ) ≤ rLo := by exact_mod_cast pLo.r_pos.le
            have hrLo1 : rLo < 1 := by exact_mod_cast pLo.r_lt_one
            have hmpos : 0 < m := by
              by_contra hm0
              have hmzero : m = 0 := Nat.eq_zero_of_not_pos hm0
              have ht := pLo.target_one_lt m hmLoStartup
              rw [hmzero] at ht
              norm_num [targetScale] at ht
            have hgap : rationalTargetRank rLo m < q :=
              (rationalTargetRank_lt_parent hrLo0 hrLo1 hmpos).trans_le hranks.1
            let nextRun : TwoRegimeRecertificationRun pHi pLo S n
                (elapsed + stageLength pLo x) (rationalTargetRank rLo m) :=
              TwoRegimeRecertificationRun.nextLo hrun hmLow hmLoStartup
                hxshell hxGood hgap
            exact ih (rationalTargetRank rLo m) hgap
              (hgap.le.trans hqU) nextRun
          · have hqSle : q ≤ S := by omega
            have htarget : TwoRegimeTargetFailure etaHi etaLo S q x := by
              by_cases hqS : q = S
              · exact Or.inr (Or.inl ⟨hqS, Or.inr hxGood⟩)
              · exact Or.inr (Or.inr ⟨by omega, hxGood⟩)
            exact Or.inr ⟨elapsed, q, hLq, hqU, htime,
              hrun.toMixed (min_le_left _ _) (min_le_right _ _), htarget⟩

/-- Every outer-shell source either reaches terminal rank or belongs to the
literal two-regime failure set. -/
theorem twoRegimeSource_terminal_or_failure
    {rHi rLo : ℚ} {etaHi etaLo : ℝ}
    {pHi : StageSetup (rHi : ℝ) etaHi}
    {pLo : StageSetup (rLo : ℝ) etaLo}
    {S M n L U H : ℕ}
    (hSM : S ≤ M) (hM0 : pHi.M0 ≤ M)
    (hHiStartup : pHi.M0 + 1 ≤ L)
    (hLoStartup : pLo.M0 + 1 ≤ L)
    (hq0U : rationalTargetRank rHi M ≤ U)
    (hclock : ∀ elapsed q,
      TwoRegimeRecertificationRun pHi pLo S n elapsed q → elapsed ≤ H)
    (hnShell : n ∈ dyadicShell M) :
    HasTwoRegimeTerminalLanding pHi pLo S n L ∨
      n ∈ twoRegimeFailureSources M L S U H (min rHi rLo) etaHi etaLo := by
  classical
  have hn : 0 < n := by
    have hp : 0 < 2 ^ M := by positivity
    exact hp.trans_le (mem_dyadicShell.mp hnShell).1
  by_cases hnGood : n ∈ initialWindowGood etaHi
  · let firstRun : TwoRegimeRecertificationRun pHi pLo S n
        (stageLength pHi n) (rationalTargetRank rHi M) :=
      TwoRegimeRecertificationRun.first hSM hM0 hnShell hnGood
    rcases twoRegimeRun_terminal_or_firstBad hn hHiStartup hLoStartup
      hclock hq0U firstRun with hterm | hfail
    · exact Or.inl hterm
    · exact Or.inr (by
        rw [twoRegimeFailureSources, Finset.mem_filter]
        exact ⟨hnShell, Or.inr hfail⟩)
  · exact Or.inr (by
      rw [twoRegimeFailureSources, Finset.mem_filter]
      exact ⟨hnShell, Or.inl hnGood⟩)

/-- Outside the counted failure set there is one literal shortcut iterate
below `2^L`, within the declared clock. -/
theorem twoRegimeSource_lands_below
    {rHi rLo : ℚ} {etaHi etaLo : ℝ}
    {pHi : StageSetup (rHi : ℝ) etaHi}
    {pLo : StageSetup (rLo : ℝ) etaLo}
    {S M n L U H : ℕ}
    (hSM : S ≤ M) (hM0 : pHi.M0 ≤ M)
    (hHiStartup : pHi.M0 + 1 ≤ L)
    (hLoStartup : pLo.M0 + 1 ≤ L)
    (hq0U : rationalTargetRank rHi M ≤ U)
    (hclock : ∀ elapsed q,
      TwoRegimeRecertificationRun pHi pLo S n elapsed q → elapsed ≤ H)
    (hnShell : n ∈ dyadicShell M)
    (hnGood : n ∉
      twoRegimeFailureSources M L S U H (min rHi rLo) etaHi etaLo) :
    ∃ elapsed : ℕ, elapsed ≤ H ∧ orbit elapsed n < 2 ^ L := by
  classical
  have hout := twoRegimeSource_terminal_or_failure hSM hM0
    hHiStartup hLoStartup hq0U hclock hnShell
  rcases hout with hterm | hfail
  · rcases hterm with ⟨elapsed, q, hqL, hrun⟩
    refine ⟨elapsed, hclock elapsed q hrun, ?_⟩
    exact hrun.directFirstPassage.1.trans_lt
      (Nat.pow_lt_pow_right (by omega) hqL)
  · exact False.elim (hnGood hfail)

/-- Canonical-clock execution theorem.  The clock hypothesis in
`twoRegimeSource_lands_below` is discharged by the geometric two-regime
potential, so the only excluded sources are the literal counted failures. -/
theorem twoRegimeSource_lands_below_horizon
    {rHi rLo : ℚ} {etaHi etaLo : ℝ}
    {pHi : StageSetup (rHi : ℝ) etaHi}
    {pLo : StageSetup (rLo : ℝ) etaLo}
    {S M n L U : ℕ}
    (hSM : S ≤ M) (hM0 : pHi.M0 ≤ M)
    (hHiStartup : pHi.M0 + 1 ≤ L)
    (hLoStartup : pLo.M0 + 1 ≤ L)
    (hq0U : rationalTargetRank rHi M ≤ U)
    (hnShell : n ∈ dyadicShell M)
    (hnGood : n ∉ twoRegimeFailureSources M L S U
      (twoRegimeHorizon rHi rLo S M) (min rHi rLo) etaHi etaLo) :
    ∃ elapsed : ℕ,
      elapsed ≤ twoRegimeHorizon rHi rLo S M ∧
        orbit elapsed n < 2 ^ L := by
  apply twoRegimeSource_lands_below hSM hM0 hHiStartup hLoStartup
    hq0U ?_ hnShell hnGood
  intro elapsed q hrun
  exact hrun.elapsed_le_horizon hnShell

/-- Outside the canonical counted failure set, retain the literal terminal
run itself.  This stronger socket is used by consumers that must control all
intermediate iterates, not only the terminal landing. -/
theorem twoRegimeSource_has_terminalLanding_horizon
    {rHi rLo : ℚ} {etaHi etaLo : ℝ}
    {pHi : StageSetup (rHi : ℝ) etaHi}
    {pLo : StageSetup (rLo : ℝ) etaLo}
    {S M n L U : ℕ}
    (hSM : S ≤ M) (hM0 : pHi.M0 ≤ M)
    (hHiStartup : pHi.M0 + 1 ≤ L)
    (hLoStartup : pLo.M0 + 1 ≤ L)
    (hq0U : rationalTargetRank rHi M ≤ U)
    (hnShell : n ∈ dyadicShell M)
    (hnGood : n ∉ twoRegimeFailureSources M L S U
      (twoRegimeHorizon rHi rLo S M) (min rHi rLo) etaHi etaLo) :
    HasTwoRegimeTerminalLanding pHi pLo S n L := by
  have hout := twoRegimeSource_terminal_or_failure hSM hM0
    hHiStartup hLoStartup hq0U
    (fun elapsed q hrun => hrun.elapsed_le_horizon hnShell) hnShell
  rcases hout with hterm | hfail
  · exact hterm
  · exact False.elim (hnGood hfail)

end

end FirstPassageLinearTransport
