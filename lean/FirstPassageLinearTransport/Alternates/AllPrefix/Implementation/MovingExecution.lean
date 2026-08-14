/-
Copyright (c) 2026 Idris Ali Shaik. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Idris Ali Shaik
-/
import FirstPassageLinearTransport.MovingEndpointParameters
import FirstPassageLinearTransport.Alternates.AllPrefix.Implementation.MovingFirstBad

import FirstPassageLinearTransport.Extras.Unreachable
/-!
# Literal execution of the moving re-certification chain

The moving chain stops as soon as its threshold rank is at most `L`.  This is
the exact convention that makes `pLo.M0 ≤ L` sufficient: continuation from a
rank `q > L` starts in the certified landing shell `q - 1 ≥ L`.
-/

namespace FirstPassageLinearTransport

noncomputable section

/-- A literal moving run has reached the terminal threshold rank. -/
def HasMovingTerminalLanding
    (P : ShrinkingBarrierRunData) {rLo tLo : ℝ}
    (pLo : StageSetup rLo tLo) (M S n L : ℕ) : Prop :=
  ∃ elapsed q : ℕ,
    q ≤ L ∧ MovingRecertificationRun P pLo M S n elapsed q

theorem HasMovingTerminalLanding.orbit_le
    {P : ShrinkingBarrierRunData} {rLo tLo : ℝ}
    {pLo : StageSetup rLo tLo} {M S n L : ℕ}
    (hterm : HasMovingTerminalLanding P pLo M S n L) :
    ∃ elapsed : ℕ, orbit elapsed n ≤ 2 ^ L := by
  rcases hterm with ⟨elapsed, q, hqL, hrun⟩
  exact ⟨elapsed, hrun.directFirstPassage.1.trans
    (Nat.pow_le_pow_right (by omega) hqL)⟩

/-- Failure of the certification selected at a moving endpoint is literal
membership in the corresponding landing target. -/
theorem MovingRecertificationRun.endpoint_mem_movingLandingBad
    {P : ShrinkingBarrierRunData} {rLo tLo : ℝ}
    {pLo : StageSetup rLo tLo} {M S n elapsed q : ℕ}
    (hrun : MovingRecertificationRun P pLo M S n elapsed q)
    (hbad : orbit elapsed n ∉
      initialWindowGood (movingTargetTolerance P tLo M S q)) :
    orbit elapsed n ∈
      landingBad q (movingTargetTolerance P tLo M S q) := by
  have hband := firstPassage_band hrun.elapsed_pos hrun.directFirstPassage
  have hq := hrun.currentRank_pos
  apply mem_landingBad.mpr
  refine ⟨?_, hband.2, hbad⟩
  rw [show q = (q - 1) + 1 by omega, pow_succ] at hband
  omega

/-- A certified moving path either reaches rank at most `L` or its original
source lies in one exact rankwise first-bad set. -/
theorem movingRun_terminal_or_firstBad
    (P : ShrinkingBarrierRunData) {rLo tLo : ℝ}
    (pLo : StageSetup rLo tLo)
    {M S n L elapsed q : ℕ}
    (hn : 0 < n)
    (hnShell : n ∈ dyadicShell M)
    (htLoA : tLo < a0)
    (hL2 : 2 ≤ L)
    (hHiStartup : P.pHi.M0 ≤ L)
    (hLoStartup : pLo.M0 ≤ L)
    (hqM : q ≤ M - 1)
    (hrun : MovingRecertificationRun P pLo M S n elapsed q) :
    HasMovingTerminalLanding P pLo M S n L ∨
      ∃ q' : ℕ, L < q' ∧ q' ≤ q ∧
        n ∈ movingFirstBadSourcesAtRank P pLo M S q' := by
  induction q using Nat.strong_induction_on generalizing elapsed with
  | h q ih =>
      by_cases hqL : q ≤ L
      · exact Or.inl ⟨elapsed, q, hqL, hrun⟩
      · have hLq : L < q := by omega
        let x := orbit elapsed n
        let m := Nat.log 2 x
        have hx : 0 < x := orbit_pos hn elapsed
        have hxshell : x ∈ dyadicShell m := by
          rw [mem_dyadicShell]
          exact ⟨Nat.pow_log_le_self 2 hx.ne',
            Nat.lt_pow_succ_log_self (by norm_num) x⟩
        let t := movingTargetTolerance P tLo M S q
        by_cases hxGood : x ∈ initialWindowGood t
        · have htA : t < a0 := by
            by_cases hqHigh : S + 1 ≤ q
            · rw [show t = shrinkingHighTolerance P M (q - 1) by
                exact movingTargetTolerance_eq_high P tLo hqHigh]
              exact shrinkingHighTolerance_lt_a0 P M (q - 1)
            · have hqLow : q ≤ S := by omega
              rw [show t = tLo by
                exact movingTargetTolerance_eq_low P tLo
                  hrun.currentRank_pos hqLow]
              exact htLoA
          have hband := firstPassage_band hrun.elapsed_pos
            hrun.directFirstPassage
          have hlower : 2 ^ (q - 1) < x := by
            have hmul : 2 ^ (q - 1) * 2 < x * 2 := by
              calc
                2 ^ (q - 1) * 2 = 2 ^ ((q - 1) + 1) := by rw [pow_succ]
                _ = 2 ^ q := by rw [Nat.sub_add_cancel hrun.currentRank_pos]
                _ < 2 * x := hband.1
                _ = x * 2 := by omega
            exact lt_of_mul_lt_mul_right hmul (by norm_num)
          have hcert : x ∈ dyadicShell (q - 1) :=
            certified_landing_mem_lower_shell hrun.currentRank_pos htA
              ⟨hlower, hband.2⟩ hxGood
          have hmEq : m = q - 1 := by
            dsimp [m]
            exact log_two_eq_of_mem_dyadicShell hcert
          have hmStartup : L ≤ m := by omega
          have hmHiStartup : P.pHi.M0 ≤ m := hHiStartup.trans hmStartup
          have hmLoStartup : pLo.M0 ≤ m := hLoStartup.trans hmStartup
          by_cases hmHigh : S ≤ m
          · have htEq : t = shrinkingHighTolerance P M m := by
              dsimp [t]
              rw [movingTargetTolerance_eq_high P tLo (by omega), hmEq]
            have hxGoodHi : x ∈ initialWindowGood
                (shrinkingHighTolerance P M m) := by
              simpa [htEq] using hxGood
            have hrHi0 : (0 : ℚ) ≤ P.rHi := by
              exact_mod_cast P.pHi.r_pos.le
            have hrHi1 : P.rHi < 1 := by exact_mod_cast P.pHi.r_lt_one
            have hgap : rationalTargetRank P.rHi m < q := by
              exact (rationalTargetRank_lt_parent hrHi0 hrHi1 (by omega)).trans
                (by omega)
            let nextRun : MovingRecertificationRun P pLo M S n
                (elapsed + stageLength (shrinkingHighSetup P M m) x)
                (rationalTargetRank P.rHi m) :=
              MovingRecertificationRun.nextHi hrun hmHigh hmHiStartup
                hxshell hxGoodHi hgap
            rcases ih (rationalTargetRank P.rHi m) hgap
              (hgap.le.trans hqM) nextRun with hterm | hfail
            · exact Or.inl hterm
            · rcases hfail with ⟨q', hq'L, hq'next, hq'bad⟩
              exact Or.inr ⟨q', hq'L, hq'next.trans hgap.le, hq'bad⟩
          · have hmLow : m < S := Nat.lt_of_not_ge hmHigh
            have htEq : t = tLo := by
              dsimp [t]
              exact movingTargetTolerance_eq_low P tLo hrun.currentRank_pos
                (by omega)
            have hxGoodLo : x ∈ initialWindowGood tLo := by
              simpa [htEq] using hxGood
            have hgap : realTargetRank rLo m < q := by
              exact (realTargetRank_lt_parent pLo.r_pos.le pLo.r_lt_one
                (by omega)).trans (by omega)
            let nextRun : MovingRecertificationRun P pLo M S n
                (elapsed + stageLength pLo x) (realTargetRank rLo m) :=
              MovingRecertificationRun.nextLo hrun hmLow hmLoStartup
                hxshell hxGoodLo hgap
            rcases ih (realTargetRank rLo m) hgap
              (hgap.le.trans hqM) nextRun with hterm | hfail
            · exact Or.inl hterm
            · rcases hfail with ⟨q', hq'L, hq'next, hq'bad⟩
              exact Or.inr ⟨q', hq'L, hq'next.trans hgap.le, hq'bad⟩
        · exact Or.inr ⟨q, hLq, le_rfl,
            mem_movingFirstBadSourcesAtRank.mpr
              ⟨hnShell, elapsed, hrun,
                hrun.endpoint_mem_movingLandingBad hxGood⟩⟩

/-- Every outer-shell source either reaches the moving terminal rank or lies
in the literal separated failure envelope. -/
theorem movingSource_terminal_or_failure
    (P : ShrinkingBarrierRunData) {rLo tLo : ℝ}
    (pLo : StageSetup rLo tLo)
    {M S n L : ℕ}
    (hSM : S ≤ M) (hM0 : P.pHi.M0 ≤ M)
    (hL2 : 2 ≤ L)
    (htLoA : tLo < a0)
    (hHiStartup : P.pHi.M0 ≤ L)
    (hLoStartup : pLo.M0 ≤ L)
    (hq0M : rationalTargetRank P.rHi M ≤ M - 1)
    (hnShell : n ∈ dyadicShell M) :
    HasMovingTerminalLanding P pLo M S n L ∨
      n ∈ movingSeparatedFailureEnvelope P pLo M L S := by
  classical
  have hn : 0 < n := by
    have hp : 0 < 2 ^ M := by positivity
    exact hp.trans_le (mem_dyadicShell.mp hnShell).1
  by_cases hnGood : n ∈ initialWindowGood (shrinkingHighTolerance P M M)
  · let firstRun : MovingRecertificationRun P pLo M S n
        (stageLength (shrinkingHighSetup P M M) n)
        (rationalTargetRank P.rHi M) :=
      MovingRecertificationRun.first hSM hM0 hnShell hnGood
    rcases movingRun_terminal_or_firstBad P pLo hn hnShell htLoA hL2
      hHiStartup hLoStartup hq0M firstRun with hterm | hfail
    · exact Or.inl hterm
    · rcases hfail with ⟨q, hqL, hqInitial, hfail⟩
      have hqUpper : q ≤ M - 1 := hqInitial.trans hq0M
      have hqS : q ≤ S ∨ S + 1 ≤ q := by omega
      exact Or.inr (by
        unfold movingSeparatedFailureEnvelope
        rcases hqS with hlow | hhigh
        · apply Finset.mem_union_right
          apply Finset.mem_biUnion.mpr
          exact ⟨q, Finset.mem_Icc.mpr ⟨by omega, hlow⟩, hfail⟩
        · apply Finset.mem_union_left
          apply Finset.mem_union_right
          apply Finset.mem_biUnion.mpr
          exact ⟨q, Finset.mem_Icc.mpr ⟨hhigh, hqUpper⟩, hfail⟩)
  · exact Or.inr (by
      unfold movingSeparatedFailureEnvelope
      apply Finset.mem_union_left
      apply Finset.mem_union_left
      rw [← shellBad_initialWindowGood]
      exact Finset.mem_filter.mpr ⟨hnShell, hnGood⟩)

end

end FirstPassageLinearTransport
