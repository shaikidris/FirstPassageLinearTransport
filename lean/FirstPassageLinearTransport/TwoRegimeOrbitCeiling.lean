/-
Copyright (c) 2026 Idris Ali Shaik. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Idris Ali Shaik
-/
import FirstPassageLinearTransport.TwoRegimePolylogExecution
import FirstPassageLinearTransport.OrbitCeiling

/-!
# Intermediate-orbit ceiling for the two-regime run

High-rank blocks use the strict envelope margin `tHi < beta`.  Low-rank
blocks start below the quadratic-logarithmic switch; their complete local
envelope is therefore absorbed by `n^beta` at sufficiently large outer rank.
-/

namespace FirstPassageLinearTransport

open Filter
open scoped Real Topology

noncomputable section

/-- Every threshold rank occurring in a literal two-regime run is strictly
below the outer source-shell rank. -/
theorem TwoRegimeRecertificationRun.currentRank_lt_startShell
    {rHi rLo : ℚ} {etaHi etaLo : ℝ}
    {pHi : StageSetup (rHi : ℝ) etaHi}
    {pLo : StageSetup (rLo : ℝ) etaLo}
    {S M n elapsed q : ℕ}
    (hrun : TwoRegimeRecertificationRun pHi pLo S n elapsed q)
    (hnShell : n ∈ dyadicShell M) :
    q < M := by
  induction hrun with
  | @first M' hSM hM0 hnShell' hnGood =>
      have hMM' : M = M' := by
        have hlogM := log_two_eq_of_mem_dyadicShell hnShell
        have hlogM' := log_two_eq_of_mem_dyadicShell hnShell'
        omega
      subst M'
      have hMpos : 0 < M := by
        have ht := pHi.target_one_lt M hM0
        by_contra hM
        have hMzero : M = 0 := Nat.eq_zero_of_not_pos hM
        rw [hMzero] at ht
        norm_num [targetScale] at ht
      have hr0 : (0 : ℚ) ≤ rHi := by exact_mod_cast pHi.r_pos.le
      have hr1 : rHi < 1 := by exact_mod_cast pHi.r_lt_one
      exact rationalTargetRank_lt_parent hr0 hr1 hMpos
  | nextHi hrun hSm hm0 hsourceShell hsourceGood hgap ih =>
      exact hgap.trans ih
  | nextLo hrun hmS hm0 hsourceShell hsourceGood hgap ih =>
      exact hgap.trans ih

/-- Every completed proper prefix of a two-regime run lies below its outer
source. -/
theorem TwoRegimeRecertificationRun.endpoint_lt_start
    {rHi rLo : ℚ} {etaHi etaLo : ℝ}
    {pHi : StageSetup (rHi : ℝ) etaHi}
    {pLo : StageSetup (rLo : ℝ) etaLo}
    {S M n elapsed q : ℕ}
    (hrun : TwoRegimeRecertificationRun pHi pLo S n elapsed q)
    (hnShell : n ∈ dyadicShell M) :
    orbit elapsed n < n := by
  have hqM := hrun.currentRank_lt_startShell hnShell
  have hpow : 2 ^ q < 2 ^ M :=
    Nat.pow_lt_pow_right (by omega) hqM
  exact hrun.directFirstPassage.1.trans_lt
    (hpow.trans_le (mem_dyadicShell.mp hnShell).1)

/-- All shortcut prefixes of one literal two-regime run obey the requested
outer power ceiling, provided the low-rank switch envelope fits the outer
power margin. -/
theorem TwoRegimeRecertificationRun.orbit_le_start_power
    {rHi rLo : ℚ} {etaHi etaLo beta : ℝ}
    {pHi : StageSetup (rHi : ℝ) etaHi}
    {pLo : StageSetup (rLo : ℝ) etaLo}
    {S M n elapsed q : ℕ}
    (hbeta : 0 < beta) (hetaHi : etaHi < beta)
    (hLowMargin : (S : ℝ) * (1 + etaLo) ≤ beta * (M : ℝ))
    (hrun : TwoRegimeRecertificationRun pHi pLo S n elapsed q)
    (hnShell : n ∈ dyadicShell M)
    {j : ℕ} (hj : j ≤ elapsed) :
    (orbit j n : ℝ) ≤ (n : ℝ) ^ (1 + beta) := by
  have hn : 0 < n := by
    have hp : 0 < 2 ^ M := by positivity
    exact hp.trans_le (mem_dyadicShell.mp hnShell).1
  have hnOne : (1 : ℝ) ≤ n := by exact_mod_cast hn
  induction hrun with
  | @first M' hSM hM0 hnShell' hnGood =>
      have hnW : n ∈ extendedWindow pHi :=
        initialWindowGood_subset_extendedWindow pHi hnGood
      have hlocal := orbit_le_one_add_eta_of_le_stageLength
        pHi hn hnW hj
      exact hlocal.trans
        (Real.rpow_le_rpow_of_exponent_le hnOne (by linarith))
  | @nextHi elapsed qPrev m hrun hSm hm0 hsourceShell hsourceGood hgap ih =>
      by_cases hjPrev : j ≤ elapsed
      · exact ih hjPrev
      · let v := j - elapsed
        have hjForm : j = elapsed + v := by
          dsimp [v]
          omega
        have hv : v ≤ stageLength pHi (orbit elapsed n) := by
          dsimp [v]
          omega
        have hx : 0 < orbit elapsed n := orbit_pos hn elapsed
        have hxW : orbit elapsed n ∈ extendedWindow pHi :=
          initialWindowGood_subset_extendedWindow pHi hsourceGood
        have hlocal := orbit_le_one_add_eta_of_le_stageLength
          pHi hx hxW hv
        have hxle : (orbit elapsed n : ℝ) ≤ (n : ℝ) := by
          exact_mod_cast (hrun.endpoint_lt_start hnShell).le
        have hbase :
            (orbit elapsed n : ℝ) ^ (1 + etaHi) ≤
              (n : ℝ) ^ (1 + etaHi) :=
          Real.rpow_le_rpow (by positivity) hxle (by linarith [pHi.eta_pos])
        rw [hjForm, add_comm, orbit_add]
        exact hlocal.trans (hbase.trans
          (Real.rpow_le_rpow_of_exponent_le hnOne (by linarith)))
  | @nextLo elapsed qPrev m hrun hmS hm0 hsourceShell hsourceGood hgap ih =>
      by_cases hjPrev : j ≤ elapsed
      · exact ih hjPrev
      · let v := j - elapsed
        have hjForm : j = elapsed + v := by
          dsimp [v]
          omega
        have hv : v ≤ stageLength pLo (orbit elapsed n) := by
          dsimp [v]
          omega
        have hx : 0 < orbit elapsed n := orbit_pos hn elapsed
        have hxW : orbit elapsed n ∈ extendedWindow pLo :=
          initialWindowGood_subset_extendedWindow pLo hsourceGood
        have hlocal := orbit_le_one_add_eta_of_le_stageLength
          pLo hx hxW hv
        have hmSle : m + 1 ≤ S := by omega
        have hxUpperNat : orbit elapsed n ≤ 2 ^ S := by
          exact (mem_dyadicShell.mp hsourceShell).2.le.trans
            (Nat.pow_le_pow_right (by omega) hmSle)
        have hxUpper : (orbit elapsed n : ℝ) ≤ (2 : ℝ) ^ S := by
          norm_num at hxUpperNat ⊢
          exact_mod_cast hxUpperNat
        have hlocalScale :
            (orbit elapsed n : ℝ) ^ (1 + etaLo) ≤
              ((2 : ℝ) ^ S) ^ (1 + etaLo) :=
          Real.rpow_le_rpow (by positivity) hxUpper
            (by linarith [pLo.eta_pos])
        have hExp :
            (S : ℝ) * (1 + etaLo) ≤
              (M : ℝ) * (1 + beta) := by
          calc
            (S : ℝ) * (1 + etaLo) ≤ beta * (M : ℝ) := hLowMargin
            _ ≤ (M : ℝ) * (1 + beta) := by
              nlinarith [show (0 : ℝ) ≤ M from Nat.cast_nonneg M]
        have htwo :
            ((2 : ℝ) ^ S) ^ (1 + etaLo) ≤
              ((2 : ℝ) ^ M) ^ (1 + beta) := by
          rw [← Real.rpow_natCast, ← Real.rpow_mul (by norm_num),
            ← Real.rpow_natCast, ← Real.rpow_mul (by norm_num)]
          exact Real.rpow_le_rpow_of_exponent_le (by norm_num) hExp
        have hnLower : (2 : ℝ) ^ M ≤ (n : ℝ) := by
          exact_mod_cast (mem_dyadicShell.mp hnShell).1
        have houter : ((2 : ℝ) ^ M) ^ (1 + beta) ≤
            (n : ℝ) ^ (1 + beta) :=
          Real.rpow_le_rpow (by positivity) hnLower (by linarith)
        rw [hjForm, add_comm, orbit_add]
        exact hlocal.trans (hlocalScale.trans (htwo.trans houter))

/-- On the canonical quadratic-logarithmic switch, every sufficiently large
literal run satisfies the intermediate-orbit ceiling. -/
theorem eventually_twoRegimeRun_orbitCeiling
    {A c beta : ℝ} (hbeta : 0 < beta)
    (P : FixedPolylogParameterPackage A c beta) :
    ∀ᶠ M : ℕ in atTop, ∀ n elapsed q : ℕ,
      n ∈ dyadicShell M →
      TwoRegimeRecertificationRun P.pHi P.pLo
        (polylogSwitchRank M) n elapsed q →
      ∀ j : ℕ, j ≤ elapsed →
        (orbit j n : ℝ) ≤ (n : ℝ) ^ (1 + beta) := by
  have hMargin := eventually_polylogSwitchRank_envelope_le_shellMargin
    P.tLo_pos.le hbeta
  filter_upwards [hMargin] with M hMargin
  intro n elapsed q hnShell hrun j hj
  exact hrun.orbit_le_start_power hbeta P.tHi_lt_beta hMargin hnShell hj

/-- The literal shell-good witness simultaneously satisfies the canonical
clock, the polylogarithmic landing, and the complete intermediate-orbit
ceiling. -/
theorem eventually_twoRegimePolylogGood_has_shellLanding_with_orbitCeiling
    {A c beta : ℝ} (hA : 0 < A) (hbeta : 0 < beta)
    (P : FixedPolylogParameterPackage A c beta) :
    ∀ᶠ M : ℕ in atTop, ∀ n : ℕ,
      n ∈ dyadicShell M →
      n ∈ twoRegimePolylogGood
        A P.rHi P.rLo P.rStar P.tHi P.tLo M →
      ∃ k : ℕ,
        (k : ℝ) < c * (M : ℝ) * Real.log 2 ∧
        (orbit k n : ℝ) < 2 * (((M : ℝ) + 2) ^ A) ∧
        ∀ j : ℕ, j ≤ k →
          (orbit j n : ℝ) ≤ (n : ℝ) ^ (1 + beta) := by
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
  have hCeiling := eventually_twoRegimeRun_orbitCeiling hbeta P
  filter_upwards [hSwitch, hHiStartup, hLoStartup, hClock, hCeiling,
      eventually_ge_atTop P.pHi.M0, eventually_ge_atTop (1 : ℕ)]
    with M hSwitch hHiStartup hLoStartup hClock hCeiling hM0 hM1
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
  obtain ⟨k, q, hqL, hrun⟩ :=
    twoRegimeSource_has_terminalLanding_horizon
      (pHi := P.pHi) (pLo := P.pLo)
      hSM hM0 hHiStartup hLoStartup hq0U hnShell hnNotFailure
  have hkH := hrun.elapsed_le_horizon hnShell
  have hkReal : (k : ℝ) ≤
      twoRegimeHorizon P.rHi P.rLo (polylogSwitchRank M) M := by
    exact_mod_cast hkH
  have hlanding : orbit k n < 2 ^ polylogTerminalRank A M :=
    hrun.directFirstPassage.1.trans_lt
      (Nat.pow_lt_pow_right (by omega) hqL)
  have hlandingReal : (orbit k n : ℝ) <
      ((2 ^ polylogTerminalRank A M : ℕ) : ℝ) := by
    exact_mod_cast hlanding
  refine ⟨k, hkReal.trans_lt hClock,
    hlandingReal.trans (two_pow_polylogTerminalRank_lt hA.le M), ?_⟩
  intro j hj
  exact hCeiling n k q hnShell hrun j hj

/-- Natural-logarithm form of the simultaneous landing/clock/ceiling
consumer. -/
theorem eventually_assembleDyadic_twoRegimePolylogGood_has_landing_with_orbitCeiling
    {A c beta : ℝ} (hA : 0 < A) (hc : 0 < c) (hbeta : 0 < beta)
    (P : FixedPolylogParameterPackage A c beta) :
    ∀ᶠ n : ℕ in atTop,
      n ∈ assembleDyadic
        (twoRegimePolylogGood A P.rHi P.rLo P.rStar P.tHi P.tLo) →
      ∃ k : ℕ,
        (k : ℝ) < c * Real.log n ∧
        (orbit k n : ℝ) <
          fixedPolylogTargetConstant A * (Real.log n) ^ A ∧
        ∀ j : ℕ, j ≤ k →
          (orbit j n : ℝ) ≤ (n : ℝ) ^ (1 + beta) := by
  have hShell :=
    eventually_twoRegimePolylogGood_has_shellLanding_with_orbitCeiling
      hA hbeta P
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
  obtain ⟨k, hk, hlanding, hceiling⟩ := hAtLog n hnShell hnGood
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
  refine ⟨k, hk.trans_le (shellClock_le_natLog hc.le hnShell),
    hlanding.trans_le
      (shellPolylogTarget_le_natLog hA.le hnShell hlogn), hceiling⟩

/-- Fully assembled headline theorem: density one, quantitative exceptional
count, fixed-polylogarithmic landing, asymptotically optimal strict clock,
and the complete pre-witness orbit ceiling. -/
theorem fixedPolylogNaturalDensityDescent
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
            fixedPolylogTargetConstant A * (Real.log n) ^ A ∧
          ∀ j : ℕ, j ≤ k →
            (orbit j n : ℝ) ≤ (n : ℝ) ^ (1 + beta)) := by
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
  · exact
      eventually_assembleDyadic_twoRegimePolylogGood_has_landing_with_orbitCeiling
        hA0 hc0 hbeta P

end

end FirstPassageLinearTransport
