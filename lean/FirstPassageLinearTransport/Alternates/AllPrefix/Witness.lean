/-
Copyright (c) 2026 Idris Ali Shaik. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Idris Ali Shaik
-/
import FirstPassageLinearTransport.MovingEndpointAsymptotics
import FirstPassageLinearTransport.MovingOrbitCeiling
import FirstPassageLinearTransport.TwoRegimePolylogExecution

/-!
# Same-witness execution for the moving endpoint

The literal source outside the separated first-bad envelope reaches the
moving terminal rank.  The very same elapsed time supplies the logarithmic
clock, the moving polylogarithmic landing, and the complete pre-witness orbit
ceiling.
-/

namespace FirstPassageLinearTransport

open Filter
open scoped Real Topology

noncomputable section

/-- The fixed natural-log normalization constant is monotone in a
nonnegative exponent upper bound. -/
theorem fixedPolylogTargetConstant_mono
    {a b : ℝ} (hab : a ≤ b) :
    fixedPolylogTargetConstant a ≤ fixedPolylogTargetConstant b := by
  unfold fixedPolylogTargetConstant
  have hbase : 1 ≤ 1 / Real.log 2 + 2 := by
    have hlog2 : 0 < Real.log 2 := Real.log_pos (by norm_num)
    have hinv : 0 < 1 / Real.log 2 := by positivity
    linarith
  exact mul_le_mul_of_nonneg_left
    (Real.rpow_le_rpow_of_exponent_le hbase hab) (by norm_num)

/-- Canonical moving shell-good sources have one witness satisfying landing,
clock, and ceiling simultaneously. -/
theorem eventually_movingEndpointGood_has_shellWitness
    {Amax c beta : ℝ}
    (P : MovingEndpointParameterPackage Amax c beta)
    {A : ℕ → ℝ}
    (hbuffer : Tendsto (movingRankBuffer A) atTop atTop)
    (hUpper : ∀ᶠ M : ℕ in atTop, A M ≤ Amax) :
    ∀ᶠ M : ℕ in atTop, ∀ n : ℕ,
      n ∈ dyadicShell M →
      n ∈ movingEndpointGood P A M →
      ∃ k : ℕ,
        (k : ℝ) < c * (M : ℝ) * Real.log 2 ∧
        (orbit k n : ℝ) <
          fixedPolylogTargetConstant Amax * (Real.log n) ^ (A M) ∧
        ∀ j : ℕ, j ≤ k →
          (orbit j n : ℝ) ≤ (n : ℝ) ^ (1 + beta) := by
  have hTerminalT := tendsto_movingTerminalRank_atTop hbuffer
  have hPackages := hTerminalT.eventually P.eventually_lowStagePackage
  have hL2 := (tendsto_atTop.1 hTerminalT) 2
  have hHiStartup := (tendsto_atTop.1 hTerminalT) P.run.pHi.M0
  have hSwitch := eventually_shrinkingSwitchRank_lt_source P.Cswitch_pos.le
  have hClock := eventually_movingRun_elapsed_lt_shellClock P
  have hMargin' := eventually_shrinkingSwitchRank_envelope_le_shellMargin
    P.Cswitch_pos.le (show (0 : ℝ) ≤ 1 by norm_num)
      (P.run.pHi.eta_pos.trans P.tau_lt_beta)
  have hA0 := eventually_movingExponent_pos hbuffer
  filter_upwards [hPackages, hL2, hHiStartup, hSwitch, hClock, hMargin',
      hA0, hUpper, eventually_ge_atTop P.run.pHi.M0,
      eventually_ge_atTop (3 : ℕ)]
    with M hPackage hL2 hHiStartup hSwitch hClock hMargin hA0 hUpper hM0 hM3
  intro n hnShell hnGood
  let L := movingTerminalRank A M
  let S := shrinkingSwitchRank P.Cswitch M
  let Q := Classical.choice hPackage
  let pLo := Q.1
  let tLo := movingLowTolerance P.K₀ L
  have hSM : S ≤ M := by dsimp [S]; exact hSwitch.le
  have hL2' : 2 ≤ L := by simpa [L] using hL2
  have hHiStartup' : P.run.pHi.M0 ≤ L := by simpa [L] using hHiStartup
  have hLoStartup : pLo.M0 ≤ L := by
    dsimp [pLo, Q]
    exact (Classical.choice hPackage).2
  have htLoA : tLo < a0 := by
    have hLR : 0 < (L : ℝ) := by positivity
    have hgap : tLo < driftGap := by
      dsimp [tLo, movingLowTolerance]
      have : 0 < P.K₀ / (L : ℝ) :=
        div_pos (by linarith [P.K₀_gt_six]) hLR
      linarith
    exact hgap.trans driftGap_lt_a0
  have hq0M : rationalTargetRank P.run.rHi M ≤ M - 1 := by
    have hlt := rationalTargetRank_lt_parent
      (by exact_mod_cast P.run.pHi.r_pos.le)
      (by exact_mod_cast P.run.pHi.r_lt_one) (by omega : 0 < M)
    omega
  have hnNotFailure : n ∉
      movingSeparatedFailureEnvelope P.run pLo M L S := by
    simpa [movingEndpointGood, hPackage, Q, pLo, L, S] using hnGood
  rcases movingSource_terminal_or_failure P.run pLo hSM hM0 hL2'
    htLoA hHiStartup' hLoStartup hq0M hnShell with hterm | hfail
  · rcases hterm with ⟨k, q, hqL, hrun⟩
    have hlandingNat : orbit k n ≤ 2 ^ L :=
      hrun.directFirstPassage.1.trans
        (Nat.pow_le_pow_right (by omega) hqL)
    have hlandingReal : (orbit k n : ℝ) ≤ ((2 ^ L : ℕ) : ℝ) := by
      exact_mod_cast hlandingNat
    have hterminal : ((2 ^ L : ℕ) : ℝ) <
        2 * (((M : ℝ) + 2) ^ (A M)) := by
      simpa [L] using two_pow_movingTerminalRank_lt hA0.le
    have hn8 : 8 ≤ n := by
      have hpow : 2 ^ 3 ≤ 2 ^ M := Nat.pow_le_pow_right (by omega) hM3
      exact hpow.trans (mem_dyadicShell.mp hnShell).1
    have hlog8 : 1 ≤ Real.log (8 : ℝ) := by
      rw [show (8 : ℝ) = 2 ^ (3 : ℕ) by norm_num, Real.log_pow]
      have hlog2Half : (1 / 2 : ℝ) < Real.log 2 :=
        (by norm_num : (1 / 2 : ℝ) < 0.6931471803).trans Real.log_two_gt_d9
      norm_num only [Nat.cast_ofNat]
      nlinarith
    have hn8Real : (8 : ℝ) ≤ (n : ℝ) := by exact_mod_cast hn8
    have hlogMono : Real.log (8 : ℝ) ≤ Real.log n :=
      Real.log_le_log (by norm_num) hn8Real
    have hlogn : 1 ≤ Real.log n := hlog8.trans hlogMono
    have htarget := shellPolylogTarget_le_natLog hA0.le hnShell hlogn
    have hconst := fixedPolylogTargetConstant_mono hUpper
    have hlogPow0 : 0 ≤ (Real.log n) ^ (A M) :=
      Real.rpow_nonneg (zero_le_one.trans hlogn) _
    refine ⟨k, hClock pLo n k q htLoA hrun,
      hlandingReal.trans_lt (hterminal.trans_le (htarget.trans
        (mul_le_mul_of_nonneg_right hconst hlogPow0))), ?_⟩
    intro j hj
    have hLowMargin : (S : ℝ) * (1 + tLo) ≤ beta * (M : ℝ) := by
      have htLoOne : tLo ≤ 1 := by
        dsimp [tLo, pLo, Q]
        exact (Classical.choice hPackage).1.eta_le_one
      have hS0 : (0 : ℝ) ≤ S := Nat.cast_nonneg S
      calc
        (S : ℝ) * (1 + tLo) ≤ (S : ℝ) * (1 + 1) := by gcongr
        _ ≤ beta * (M : ℝ) := by simpa [S] using hMargin
    exact hrun.orbit_le_start_power
      (P.run.pHi.eta_pos.trans P.tau_lt_beta) P.tau_lt_beta
      hLowMargin hnShell hj
  · exact False.elim (hnNotFailure hfail)

end

end FirstPassageLinearTransport
