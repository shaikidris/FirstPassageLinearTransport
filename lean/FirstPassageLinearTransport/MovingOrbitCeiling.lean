/-
Copyright (c) 2026 Idris Ali Shaik. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Idris Ali Shaik
-/
import FirstPassageLinearTransport.MovingExecution
import FirstPassageLinearTransport.OrbitCeiling

/-!
# Intermediate-orbit ceiling for moving endpoint runs

The low contraction ratio may approach one, but its certification tolerance
is fixed during each outer-shell run.  The complete run therefore obeys the
same outer power ceiling once the logarithmic switch is absorbed by the
outer-shell margin.
-/

namespace FirstPassageLinearTransport

open Filter
open scoped Real Topology

noncomputable section

theorem MovingRecertificationRun.currentRank_lt_startShell
    {P : ShrinkingBarrierRunData} {rLo tLo : ℝ}
    {pLo : StageSetup rLo tLo} {M S n elapsed q : ℕ}
    (hrun : MovingRecertificationRun P pLo M S n elapsed q) : q < M := by
  induction hrun with
  | first hSM hM0 hnShell hnGood =>
      have hMpos : 0 < M := by
        have ht := P.pHi.target_one_lt M hM0
        by_contra hM
        have hMzero : M = 0 := Nat.eq_zero_of_not_pos hM
        rw [hMzero] at ht
        norm_num [targetScale] at ht
      exact rationalTargetRank_lt_parent
        (by exact_mod_cast P.pHi.r_pos.le)
        (by exact_mod_cast P.pHi.r_lt_one) hMpos
  | nextHi hrun hSm hm0 hsourceShell hsourceGood hgap ih =>
      exact hgap.trans ih
  | nextLo hrun hmS hm0 hsourceShell hsourceGood hgap ih =>
      exact hgap.trans ih

theorem MovingRecertificationRun.endpoint_lt_start
    {P : ShrinkingBarrierRunData} {rLo tLo : ℝ}
    {pLo : StageSetup rLo tLo} {M S n elapsed q : ℕ}
    (hrun : MovingRecertificationRun P pLo M S n elapsed q)
    (hnShell : n ∈ dyadicShell M) : orbit elapsed n < n := by
  have hqM := hrun.currentRank_lt_startShell
  exact hrun.directFirstPassage.1.trans_lt
    ((Nat.pow_lt_pow_right (by omega) hqM).trans_le
      (mem_dyadicShell.mp hnShell).1)

/-- All prefixes of a literal moving run obey the outer power ceiling. -/
theorem MovingRecertificationRun.orbit_le_start_power
    {P : ShrinkingBarrierRunData} {rLo tLo beta : ℝ}
    {pLo : StageSetup rLo tLo}
    {M S n elapsed q : ℕ}
    (hbeta : 0 < beta) (htau : P.tau < beta)
    (hLowMargin : (S : ℝ) * (1 + tLo) ≤ beta * (M : ℝ))
    (hrun : MovingRecertificationRun P pLo M S n elapsed q)
    (hnShell : n ∈ dyadicShell M)
    {j : ℕ} (hj : j ≤ elapsed) :
    (orbit j n : ℝ) ≤ (n : ℝ) ^ (1 + beta) := by
  have hn : 0 < n := by
    have hp : 0 < 2 ^ M := by positivity
    exact hp.trans_le (mem_dyadicShell.mp hnShell).1
  have hnOne : (1 : ℝ) ≤ n := by exact_mod_cast hn
  induction hrun with
  | first hSM hM0 hnShell' hnGood =>
      let p := shrinkingHighSetup P M M
      have hnW : n ∈ extendedWindow p :=
        initialWindowGood_subset_extendedWindow p hnGood
      have hlocal := orbit_le_one_add_eta_of_le_stageLength p hn hnW hj
      have heta : shrinkingHighTolerance P M M < beta :=
        (shrinkingHighTolerance_le_tau P M M).trans_lt htau
      exact hlocal.trans
        (Real.rpow_le_rpow_of_exponent_le hnOne (by linarith))
  | @nextHi elapsed qPrev m hrun hSm hm0 hsourceShell hsourceGood hgap ih =>
      by_cases hjPrev : j ≤ elapsed
      · exact ih hjPrev
      · let v := j - elapsed
        have hjForm : j = elapsed + v := by dsimp [v]; omega
        have hv : v ≤ stageLength (shrinkingHighSetup P M m)
            (orbit elapsed n) := by dsimp [v]; omega
        have hx : 0 < orbit elapsed n := orbit_pos hn elapsed
        have hxW : orbit elapsed n ∈ extendedWindow (shrinkingHighSetup P M m) :=
          initialWindowGood_subset_extendedWindow _ hsourceGood
        have hlocal := orbit_le_one_add_eta_of_le_stageLength
          (shrinkingHighSetup P M m) hx hxW hv
        have hxle : (orbit elapsed n : ℝ) ≤ (n : ℝ) := by
          exact_mod_cast (hrun.endpoint_lt_start hnShell).le
        have heta : shrinkingHighTolerance P M m < beta :=
          (shrinkingHighTolerance_le_tau P M m).trans_lt htau
        have hbase : (orbit elapsed n : ℝ) ^
            (1 + shrinkingHighTolerance P M m) ≤
              (n : ℝ) ^ (1 + shrinkingHighTolerance P M m) :=
          Real.rpow_le_rpow (by positivity) hxle
            (by linarith [shrinkingHighTolerance_pos P M m])
        rw [hjForm, add_comm, orbit_add]
        exact hlocal.trans (hbase.trans
          (Real.rpow_le_rpow_of_exponent_le hnOne (by linarith)))
  | @nextLo elapsed qPrev m hrun hmS hm0 hsourceShell hsourceGood hgap ih =>
      by_cases hjPrev : j ≤ elapsed
      · exact ih hjPrev
      · let v := j - elapsed
        have hjForm : j = elapsed + v := by dsimp [v]; omega
        have hv : v ≤ stageLength pLo (orbit elapsed n) := by
          dsimp [v]
          omega
        have hx : 0 < orbit elapsed n := orbit_pos hn elapsed
        have hxW : orbit elapsed n ∈ extendedWindow pLo :=
          initialWindowGood_subset_extendedWindow pLo hsourceGood
        have hlocal := orbit_le_one_add_eta_of_le_stageLength pLo hx hxW hv
        have hmSle : m + 1 ≤ S := by omega
        have hxUpperNat : orbit elapsed n ≤ 2 ^ S :=
          (mem_dyadicShell.mp hsourceShell).2.le.trans
            (Nat.pow_le_pow_right (by omega) hmSle)
        have hxUpper : (orbit elapsed n : ℝ) ≤ (2 : ℝ) ^ S := by
          norm_num at hxUpperNat ⊢
          exact_mod_cast hxUpperNat
        have hlocalScale :
            (orbit elapsed n : ℝ) ^ (1 + tLo) ≤
              ((2 : ℝ) ^ S) ^ (1 + tLo) :=
          Real.rpow_le_rpow (by positivity) hxUpper
            (by linarith [pLo.eta_pos])
        have hExp : (S : ℝ) * (1 + tLo) ≤
            (M : ℝ) * (1 + beta) := by
          calc
            _ ≤ beta * (M : ℝ) := hLowMargin
            _ ≤ (M : ℝ) * (1 + beta) := by
              nlinarith [show (0 : ℝ) ≤ M from Nat.cast_nonneg M]
        have htwo : ((2 : ℝ) ^ S) ^ (1 + tLo) ≤
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

/-- The square-root logarithmic time corridor is little-oh of the source
rank, in a coefficient-sensitive form. -/
theorem eventually_sqrt_mul_log_le_linear
    {delta : ℝ} (hdelta : 0 < delta) :
    ∀ᶠ M : ℕ in atTop,
      Real.sqrt (((M : ℝ) + 2) * Real.log ((M : ℝ) + 2)) ≤
        delta * ((M : ℝ) + 2) := by
  have hsmallReal :=
    (isLittleO_log_rpow_rpow_atTop (s := (1 / 2 : ℝ))
      (1 / 2 : ℝ) (by norm_num)).bound hdelta
  have hxT : Tendsto (fun M : ℕ => (M : ℝ) + 2) atTop atTop :=
    tendsto_atTop_add_const_right atTop (2 : ℝ)
      tendsto_natCast_atTop_atTop
  have hsmall := hxT.eventually hsmallReal
  filter_upwards [hsmall] with M hsmall
  let x : ℝ := (M : ℝ) + 2
  have hx1 : 1 ≤ x := by
    dsimp [x]
    have hM0 : (0 : ℝ) ≤ M := Nat.cast_nonneg M
    linarith
  have hx0 : 0 < x := zero_lt_one.trans_le hx1
  have hlog0 : 0 ≤ Real.log x := Real.log_nonneg hx1
  have hxhalf0 : 0 ≤ x ^ (1 / 2 : ℝ) := Real.rpow_nonneg hx0.le _
  have hloghalf0 : 0 ≤ Real.log x ^ (1 / 2 : ℝ) :=
    Real.rpow_nonneg hlog0 _
  rw [Real.norm_eq_abs, abs_of_nonneg hloghalf0,
    Real.norm_eq_abs, abs_of_nonneg hxhalf0] at hsmall
  rw [Real.sqrt_mul hx0.le, Real.sqrt_eq_rpow, Real.sqrt_eq_rpow]
  calc
    x ^ (1 / 2 : ℝ) * Real.log x ^ (1 / 2 : ℝ) ≤
        x ^ (1 / 2 : ℝ) * (delta * x ^ (1 / 2 : ℝ)) :=
      mul_le_mul_of_nonneg_left hsmall hxhalf0
    _ = delta * (x ^ (1 / 2 : ℝ) * x ^ (1 / 2 : ℝ)) := by ring
    _ = delta * x := by
      rw [← Real.rpow_add hx0]
      norm_num

/-- The drift-potential identity gives the declared logarithmic shell clock
uniformly for every literal moving run. -/
theorem eventually_movingRun_elapsed_lt_shellClock
    {Amax c beta : ℝ}
    (P : MovingEndpointParameterPackage Amax c beta) :
    ∀ᶠ M : ℕ in atTop, ∀ {rLo tLo : ℝ}
      (pLo : StageSetup rLo tLo) (n elapsed q : ℕ),
      tLo < a0 →
      MovingRecertificationRun P.run pLo M
        (shrinkingSwitchRank P.Cswitch M) n elapsed q →
      (elapsed : ℝ) < c * (M : ℝ) * Real.log 2 := by
  let T := movingTimeSupportConstant P.run P.Cswitch
  let margin := c * Real.log 2 - 1 / driftGap
  have hmargin : 0 < margin := by
    dsimp [margin]
    exact sub_pos.mpr P.clock_pressure
  have hT0 : 0 ≤ T := by
    have hrHi0 : 0 < (P.run.rHi : ℝ) := P.run.pHi.r_pos
    have hsqrtSq := Real.sq_sqrt hrHi0.le
    have hsqrt0 := Real.sqrt_nonneg (P.run.rHi : ℝ)
    have hsqrt1 : Real.sqrt (P.run.rHi : ℝ) < 1 := by
      nlinarith [P.run.pHi.r_lt_one]
    have hden : 0 < 1 - Real.sqrt (P.run.rHi : ℝ) := sub_pos.mpr hsqrt1
    have hnum : 0 ≤ P.run.D + P.run.tau + 3 := by
      linarith [P.run.D_pos, P.run.pHi.eta_pos]
    have hfrac : 0 ≤
        (P.run.D + P.run.tau + 3) /
          (1 - Real.sqrt (P.run.rHi : ℝ)) := div_nonneg hnum hden.le
    have hinner : 0 ≤
        (P.run.D + P.run.tau + 3) /
            (1 - Real.sqrt (P.run.rHi : ℝ)) +
          (P.Cswitch + 5) ^ 2 := by positivity
    have hratio : 0 ≤ 2 / driftGap :=
      div_nonneg (by norm_num) driftGap_pos.le
    dsimp [T, movingTimeSupportConstant]
    nlinarith [mul_nonneg hratio hinner]
  let delta := margin / (4 * (T + 1))
  have hdelta : 0 < delta := by
    dsimp [delta]
    positivity
  have hSqrt := eventually_sqrt_mul_log_le_linear hdelta
  have hPotential := eventually_movingTimePotential_source_le_sqrt
    P.run P.Cswitch_pos.le
  have hLarge := tendsto_natCast_atTop_atTop.eventually
    (eventually_gt_atTop (2 / (driftGap * margin)))
  filter_upwards [hSqrt, hPotential, hLarge, eventually_ge_atTop (2 : ℕ)]
    with M hSqrt hPotential hLarge hM2
  intro rLo tLo pLo n elapsed q htLoA hrun
  have hM1 : 1 ≤ M := by omega
  let root := Real.sqrt (((M : ℝ) + 2) * Real.log ((M : ℝ) + 2))
  have hM0 : (0 : ℝ) ≤ M := Nat.cast_nonneg M
  have hMpos : (0 : ℝ) < M := by exact_mod_cast (show 0 < M by omega)
  have hroot0 : 0 ≤ root := Real.sqrt_nonneg _
  have hpot0 := movingTimePotential_nonneg P.run M
    (shrinkingSwitchRank P.Cswitch M) (M + 1)
  have hdev := hrun.deviation_add_potential_le htLoA hM1
  have hpotq0 := movingTimePotential_nonneg P.run M
    (shrinkingSwitchRank P.Cswitch M) q
  have habs :
      |driftGap * (elapsed : ℝ) - (((M + 1 : ℕ) : ℝ) - (q : ℝ))| ≤
        movingTimePotential P.run M (shrinkingSwitchRank P.Cswitch M) (M + 1) := by
    linarith
  have hupper := (abs_le.mp habs).2
  have htime : (elapsed : ℝ) ≤
      (M : ℝ) / driftGap +
        (1 / driftGap + T * root) := by
    have hpotRatio :
        movingTimePotential P.run M (shrinkingSwitchRank P.Cswitch M) (M + 1) /
            driftGap ≤ T * root := by
      have hgap0 : 0 ≤ driftGap := driftGap_pos.le
      have hratio0 : 0 ≤
          movingTimePotential P.run M (shrinkingSwitchRank P.Cswitch M) (M + 1) /
            driftGap := div_nonneg hpot0 hgap0
      calc
        _ ≤ 1 + 2 *
            (movingTimePotential P.run M
              (shrinkingSwitchRank P.Cswitch M) (M + 1) / driftGap) := by
          linarith
        _ ≤ T * root := by
          simpa [T, root, div_eq_mul_inv, mul_assoc] using hPotential
    have hraw : driftGap * (elapsed : ℝ) ≤
        (M : ℝ) + 1 +
          movingTimePotential P.run M
            (shrinkingSwitchRank P.Cswitch M) (M + 1) := by
      push_cast at hupper
      have hq0 : (0 : ℝ) ≤ q := Nat.cast_nonneg q
      linarith
    have hdiv : (elapsed : ℝ) ≤
        ((M : ℝ) + 1 +
          movingTimePotential P.run M
            (shrinkingSwitchRank P.Cswitch M) (M + 1)) / driftGap := by
      rw [le_div_iff₀ driftGap_pos]
      simpa [mul_comm] using hraw
    calc
      (elapsed : ℝ) ≤
          ((M : ℝ) + 1 +
            movingTimePotential P.run M
              (shrinkingSwitchRank P.Cswitch M) (M + 1)) / driftGap := hdiv
      _ = (M : ℝ) / driftGap +
          (1 / driftGap +
            movingTimePotential P.run M
              (shrinkingSwitchRank P.Cswitch M) (M + 1) / driftGap) := by ring
      _ ≤ (M : ℝ) / driftGap + (1 / driftGap + T * root) := by
        gcongr
  have hTdelta : T * delta ≤ margin / 4 := by
    have hratioT : T / (T + 1) ≤ 1 := by
      exact (div_le_one (by positivity)).2 (by linarith)
    calc
      T * delta = (margin / 4) * (T / (T + 1)) := by
        dsimp [delta]
        field_simp
        ring
      _ ≤ (margin / 4) * 1 :=
        mul_le_mul_of_nonneg_left hratioT (by positivity)
      _ = margin / 4 := by ring
  have hrootBound : T * root ≤ margin / 2 * (M : ℝ) := by
    have hxM : (M : ℝ) + 2 ≤ 2 * (M : ℝ) := by
      have hMR : (2 : ℝ) ≤ M := by exact_mod_cast hM2
      linarith
    have hfirst : T * root ≤ T * (delta * ((M : ℝ) + 2)) := by
      exact mul_le_mul_of_nonneg_left (by simpa [root] using hSqrt) hT0
    calc
      T * root ≤ (T * delta) * ((M : ℝ) + 2) := by
        simpa [mul_assoc] using hfirst
      _ ≤ (margin / 4) * ((M : ℝ) + 2) :=
        mul_le_mul_of_nonneg_right hTdelta (by positivity)
      _ ≤ (margin / 4) * (2 * (M : ℝ)) :=
        mul_le_mul_of_nonneg_left hxM (by positivity)
      _ = margin / 2 * (M : ℝ) := by ring
  have hconst : 1 / driftGap < margin / 2 * (M : ℝ) := by
    have hprod : 2 / (driftGap * margin) < (M : ℝ) := by
      simpa using hLarge
    rw [div_lt_iff₀ (mul_pos driftGap_pos hmargin)] at hprod
    rw [div_lt_iff₀ driftGap_pos]
    ring_nf at hprod ⊢
    nlinarith
  have hsublinear : 1 / driftGap + T * root < margin * (M : ℝ) := by
    linarith
  calc
    (elapsed : ℝ) ≤ (M : ℝ) / driftGap +
        (1 / driftGap + T * root) := htime
    _ < (M : ℝ) / driftGap + margin * (M : ℝ) :=
      add_lt_add_left hsublinear _
    _ = (1 / driftGap + margin) * (M : ℝ) := by ring
    _ = c * (M : ℝ) * Real.log 2 := by
      dsimp [margin]
      ring

end

end FirstPassageLinearTransport
