/-
Copyright (c) 2026 Idris Ali Shaik. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Idris Ali Shaik
-/
import FirstPassageLinearTransport.FixedPolylogParameters
import FirstPassageLinearTransport.PolylogTarget

/-!
# Canonical two-regime polylogarithmic execution

This module consumes the literal first-bad good set.  It converts the finite
two-regime execution theorem into an explicit shortcut iterate below the
paper's fixed-polylogarithmic target and inside the requested shell clock.
No checkpoint-congestion or LC.28 hypothesis occurs here.
-/

namespace FirstPassageLinearTransport

open Filter
open scoped Real Topology

noncomputable section

/-- Every sufficiently large shell-good source has one literal shortcut
iterate below `2 * (M + 2)^A`, before the shell clock `c M log 2`. -/
theorem eventually_twoRegimePolylogGood_has_shellLanding
    {A c beta : ℝ} (hA : 0 < A)
    (P : FixedPolylogParameterPackage A c beta) :
    ∀ᶠ M : ℕ in atTop, ∀ n : ℕ,
      n ∈ dyadicShell M →
      n ∈ twoRegimePolylogGood
        A P.rHi P.rLo P.rStar P.tHi P.tLo M →
      ∃ k : ℕ,
        (k : ℝ) < c * (M : ℝ) * Real.log 2 ∧
        (orbit k n : ℝ) < 2 * (((M : ℝ) + 2) ^ A) := by
  have hSwitch := eventually_polylogSwitchRank_lt_source
  have hTerminalT := tendsto_polylogTerminalRank_atTop hA
  have hHiStartup : ∀ᶠ M : ℕ in atTop,
      P.pHi.M0 + 1 ≤ polylogTerminalRank A M :=
    hTerminalT.eventually (eventually_ge_atTop (P.pHi.M0 + 1))
  have hLoStartup : ∀ᶠ M : ℕ in atTop,
      P.pLo.M0 + 1 ≤ polylogTerminalRank A M :=
    hTerminalT.eventually (eventually_ge_atTop (P.pLo.M0 + 1))
  have hClock := eventually_twoRegimeHorizon_lt_shellClock
    P.rHi_nonneg P.rHi_lt_one P.rLo_nonneg P.rLo_lt_one P.clock_pressure
  filter_upwards [hSwitch, hHiStartup, hLoStartup, hClock,
      eventually_ge_atTop P.pHi.M0, eventually_ge_atTop (1 : ℕ)]
    with M hSwitch hHiStartup hLoStartup hClock hM0 hM1
  intro n hnShell hnGood
  have hSM : polylogSwitchRank M ≤ M := hSwitch.le
  have hq0U : rationalTargetRank P.rHi M ≤ M - 1 := by
    have hlt := rationalTargetRank_lt_parent
      P.rHi_nonneg P.rHi_lt_one (by omega : 0 < M)
    omega
  have hnNotFailure : n ∉ twoRegimeFailureSources M
      (polylogTerminalRank A M) (polylogSwitchRank M) (M - 1)
      (twoRegimeHorizon P.rHi P.rLo (polylogSwitchRank M) M)
      (min P.rHi P.rLo) P.tHi P.tLo := by
    rw [twoRegimePolylogGood, Set.mem_setOf_eq] at hnGood
    simpa [P.rStar_eq] using hnGood
  obtain ⟨k, hk, hlanding⟩ := twoRegimeSource_lands_below_horizon
    (pHi := P.pHi) (pLo := P.pLo)
    hSM hM0 hHiStartup hLoStartup hq0U hnShell hnNotFailure
  refine ⟨k, ?_, ?_⟩
  · have hkReal : (k : ℝ) ≤
        twoRegimeHorizon P.rHi P.rLo (polylogSwitchRank M) M := by
      exact_mod_cast hk
    exact hkReal.trans_lt hClock
  · have hlandingReal : (orbit k n : ℝ) <
        ((2 ^ polylogTerminalRank A M : ℕ) : ℝ) := by
      exact_mod_cast hlanding
    exact hlandingReal.trans
      (two_pow_polylogTerminalRank_lt hA.le M)

/-- The shellwise execution theorem assembled into the literal
natural-logarithm statement used by the public API. -/
theorem eventually_assembleDyadic_twoRegimePolylogGood_has_landing
    {A c beta : ℝ} (hA : 0 < A) (hc : 0 < c)
    (P : FixedPolylogParameterPackage A c beta) :
    ∀ᶠ n : ℕ in atTop,
      n ∈ assembleDyadic
        (twoRegimePolylogGood A P.rHi P.rLo P.rStar P.tHi P.tLo) →
      ∃ k : ℕ,
        (k : ℝ) < c * Real.log n ∧
        (orbit k n : ℝ) <
          fixedPolylogTargetConstant A * (Real.log n) ^ A := by
  have hShell := eventually_twoRegimePolylogGood_has_shellLanding hA P
  have hAtLog := tendsto_natLogTwo_atTop.eventually hShell
  filter_upwards [hAtLog, eventually_ge_atTop (8 : ℕ)]
    with n hAtLog hn8
  intro hnSet
  have hn : 0 < n := by omega
  let M := Nat.log 2 n
  have hnShell : n ∈ dyadicShell M := mem_dyadicShell_log hn
  have hnGood : n ∈ twoRegimePolylogGood
      A P.rHi P.rLo P.rStar P.tHi P.tLo M := by
    simpa [assembleDyadic, M] using hnSet
  obtain ⟨k, hk, hlanding⟩ := hAtLog n hnShell hnGood
  have hlog8 : 1 ≤ Real.log (8 : ℝ) := by
    rw [show (8 : ℝ) = 2 ^ (3 : ℕ) by norm_num, Real.log_pow]
    have hlog2Half : (1 / 2 : ℝ) < Real.log 2 :=
      (by norm_num : (1 / 2 : ℝ) < 0.6931471803).trans
        Real.log_two_gt_d9
    norm_num only [Nat.cast_ofNat]
    nlinarith
  have hn8Real : (8 : ℝ) ≤ (n : ℝ) := by exact_mod_cast hn8
  have hlogMono : Real.log (8 : ℝ) ≤ Real.log n :=
    Real.log_le_log (by norm_num) hn8Real
  have hlogn : 1 ≤ Real.log n := hlog8.trans hlogMono
  refine ⟨k, hk.trans_le (shellClock_le_natLog hc.le hnShell), ?_⟩
  exact hlanding.trans_le
    (shellPolylogTarget_le_natLog hA.le hnShell hlogn)

/-- The canonical good set selected by a complete endpoint parameter package
has natural density one. -/
theorem FixedPolylogParameterPackage.naturalDensityOne_good
    {A c beta : ℝ} (hA : 0 < A)
    (P : FixedPolylogParameterPackage A c beta) :
    NaturalDensityOne
      (assembleDyadic
        (twoRegimePolylogGood
          A P.rHi P.rLo P.rStar P.tHi P.tLo)) := by
  exact naturalDensityOne_twoRegimePolylogGood
    hA P.lambdaHi_nonneg P.lambdaHi_lt_one P.tHi_pos P.tHi_lt_a0
    P.lambdaLo_nonneg P.lambdaLo_lt_one P.tLo_pos P.tLo_lt_a0
    P.bHi_pos P.bHi_lt_rate P.bLo_pos P.bLo_lt_rate
    P.cDyadic_pos P.cDyadic_lt_logTwo
    P.rHi_nonneg P.rHi_lt_one P.rLo_nonneg P.rLo_lt_one
    P.rStar_pos P.clock_pressure P.kappa_pos P.kappa_lt

/-- Explicit coefficient in the global exceptional-count estimate attached
to a selected endpoint parameter package. -/
def FixedPolylogParameterPackage.exceptionalConstant
    {A c beta : ℝ} (P : FixedPolylogParameterPackage A c beta) : ℝ :=
  let C := twoRegimePolylogProfileConstant
    (adjustableEntropyRate P.lambdaHi P.tHi) P.bHi
    (adjustableEntropyRate P.lambdaLo P.tLo) P.bLo
    P.cDyadic c P.rStar
  (1 + 2 * max C 0) * (2 * Real.log 2) ^ P.kappa

theorem FixedPolylogParameterPackage.exceptionalConstant_pos
    {A c beta : ℝ} (P : FixedPolylogParameterPackage A c beta) :
    0 < P.exceptionalConstant := by
  unfold FixedPolylogParameterPackage.exceptionalConstant
  have hbase : 0 < 2 * Real.log 2 := by positivity
  positivity

/-- The canonical good set has the paper's quantitative polylogarithmic
exceptional count. -/
theorem FixedPolylogParameterPackage.eventually_badCount_good_le
    {A c beta : ℝ} (hA : 0 < A)
    (P : FixedPolylogParameterPackage A c beta) :
    ∀ᶠ X : ℕ in atTop,
      (badCount
        (assembleDyadic
          (twoRegimePolylogGood
            A P.rHi P.rLo P.rStar P.tHi P.tLo)) X : ℝ) ≤
        P.exceptionalConstant * X * (Real.log X) ^ (-P.kappa) := by
  simpa [FixedPolylogParameterPackage.exceptionalConstant] using
    eventually_badCount_twoRegimePolylogGood_le_natLog
      hA P.lambdaHi_nonneg P.lambdaHi_lt_one P.tHi_pos P.tHi_lt_a0
      P.lambdaLo_nonneg P.lambdaLo_lt_one P.tLo_pos P.tLo_lt_a0
      P.bHi_pos P.bHi_lt_rate P.bLo_pos P.bLo_lt_rate
      P.cDyadic_pos P.cDyadic_lt_logTwo
      P.rHi_nonneg P.rHi_lt_one P.rLo_nonneg P.rLo_lt_one
      P.rStar_pos P.clock_pressure P.kappa_pos.le P.kappa_lt

/-- Fully assembled fixed-polylogarithmic landing theorem, before adding the
separate intermediate-orbit ceiling.  The strict endpoint ranges are exactly
those in the manuscript. -/
theorem fixedPolylogNaturalDensityLanding
    {A c beta : ℝ}
    (hA : fixedPolylogCriticalExponent < A)
    (hc : fixedPolylogClockCritical < c)
    (hbeta : 0 < beta) :
    ∃ S : Set ℕ, ∃ C kappa : ℝ,
      0 < C ∧ 0 < kappa ∧ NaturalDensityOne S ∧
      (∀ᶠ X : ℕ in atTop,
        (badCount S X : ℝ) ≤
          C * X * (Real.log X) ^ (-kappa)) ∧
      (∀ᶠ n : ℕ in atTop, n ∈ S →
        ∃ k : ℕ,
          (k : ℝ) < c * Real.log n ∧
          (orbit k n : ℝ) <
            fixedPolylogTargetConstant A * (Real.log n) ^ A) := by
  let P : FixedPolylogParameterPackage A c beta :=
    Classical.choice (exists_fixedPolylogParameterPackage hA hc hbeta)
  let S : Set ℕ := assembleDyadic
    (twoRegimePolylogGood A P.rHi P.rLo P.rStar P.tHi P.tLo)
  let C := P.exceptionalConstant
  have hA0 : 0 < A :=
    lt_trans zero_lt_one (fixedPolylogCriticalExponent_gt_one.trans hA)
  have hc0 : 0 < c := fixedPolylogClockCritical_pos.trans hc
  refine ⟨S, C, P.kappa, ?_, P.kappa_pos, ?_, ?_, ?_⟩
  · exact P.exceptionalConstant_pos
  · exact P.naturalDensityOne_good hA0
  · exact P.eventually_badCount_good_le hA0
  · exact eventually_assembleDyadic_twoRegimePolylogGood_has_landing
      hA0 hc0 P

end

end FirstPassageLinearTransport
