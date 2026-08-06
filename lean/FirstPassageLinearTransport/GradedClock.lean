/-
Copyright (c) 2026 Idris Ali Shaik. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Idris Ali Shaik
-/
import FirstPassageLinearTransport.HeightSensitiveClock
import FirstPassageLinearTransport.Bootstrap

/-!
# Fixed-depth graded first-passage clock

This module turns the shortened one-block witness into a fixed-depth clock
estimate.  It keeps the stopped map and all density pullbacks unchanged.
-/

namespace FirstPassageLinearTransport

open Filter
open scoped Real Topology

noncomputable section

/-- Leading fraction of one binary shell spent by the shortened block. -/
def heightClockSlope (r eta : ℝ) : ℝ :=
  (1 + eta - r) / driftGap

/-- A startup threshold beyond which the shortened witness fits inside the
already-proved length-`M` maximal envelope. -/
noncomputable def heightClockStartup {r eta : ℝ}
    (p : StageSetup r eta) : ℕ :=
  max p.M0 ⌈((2 + eta) / (r - a0 - eta))⌉₊

/-- Fixed additive payment in the global one-block clock estimate. -/
noncomputable def heightClockError {r eta : ℝ}
    (p : StageSetup r eta) : ℝ :=
  heightClockStartup p + (2 + eta) / driftGap + 1

theorem heightClockSlope_pos {r eta : ℝ} (p : StageSetup r eta) :
    0 < heightClockSlope r eta := by
  unfold heightClockSlope
  exact div_pos (by linarith [p.r_lt_one, p.eta_pos]) driftGap_pos

theorem heightClockError_pos {r eta : ℝ} (p : StageSetup r eta) :
    0 < heightClockError p := by
  unfold heightClockError
  have hgap : 0 < driftGap := driftGap_pos
  have heta : 0 < 2 + eta := by linarith [p.eta_pos]
  positivity

/-- Uniform one-stage version of the height-sensitive clock.  Small shells
are absorbed into a fixed startup constant. -/
theorem stageLength_le_heightClock
    {r eta : ℝ} (p : StageSetup r eta)
    (hetaGap : eta < r - a0) {n : ℕ}
    (hn : 0 < n) (hnW : n ∈ extendedWindow p) :
    (stageLength p n : ℝ) ≤
      heightClockSlope r eta * Real.logb 2 n + heightClockError p := by
  let M := Nat.log 2 n
  let Mstar := heightClockStartup p
  have hshell : n ∈ dyadicShell M := mem_dyadicShell_log hn
  have hlogb : (M : ℝ) ≤ Real.logb 2 n :=
    Real.natLog_le_logb n 2
  have hslope0 : 0 ≤ heightClockSlope r eta :=
    (heightClockSlope_pos p).le
  by_cases hlarge : Mstar ≤ M
  · have hM0 : p.M0 ≤ M :=
      (le_max_left _ _).trans hlarge
    have hceilNat :
        ⌈((2 + eta) / (r - a0 - eta))⌉₊ ≤ M :=
      (le_max_right _ _).trans hlarge
    have hmargin : 0 < r - a0 - eta := by linarith
    have hratio0 : 0 ≤ (2 + eta) / (r - a0 - eta) := by
      exact div_nonneg (by linarith [p.eta_pos]) hmargin.le
    have hratio : (2 + eta) / (r - a0 - eta) ≤ (M : ℝ) :=
      (Nat.le_ceil _).trans (by exact_mod_cast hceilNat)
    have hHle := heightSensitiveHorizon_le_shell hetaGap hratio
    have hgood := mem_initialWindowGood_of_mem_extended_of_large
      p hnW hM0
    have hlenNat := stageLength_le_heightSensitiveHorizon
      p hM0 hHle hshell hgood
    have hlen : (stageLength p n : ℝ) ≤
        (heightSensitiveHorizon r eta M : ℝ) := by
      exact_mod_cast hlenNat
    have hnum : 0 ≤ (1 + eta - r) * (M : ℝ) + 2 + eta := by
      have hcoef : 0 < 1 + eta - r := by linarith [p.r_lt_one, p.eta_pos]
      have hMnonneg : (0 : ℝ) ≤ M := Nat.cast_nonneg _
      have hmul : 0 ≤ (1 + eta - r) * (M : ℝ) :=
        mul_nonneg hcoef.le hMnonneg
      have heta2 : 0 ≤ 2 + eta := by linarith [p.eta_pos]
      nlinarith
    have hHreal := heightSensitiveHorizon_real_lt
      (r := r) (eta := eta) (M := M) hnum
    calc
      (stageLength p n : ℝ) ≤
          (heightSensitiveHorizon r eta M : ℝ) := hlen
      _ ≤ heightClockSlope r eta * M +
          (2 + eta) / driftGap + 1 := by
        exact (by simpa [heightClockSlope] using hHreal.le)
      _ ≤ heightClockSlope r eta * Real.logb 2 n +
          heightClockError p := by
        unfold heightClockError
        have hmul := mul_le_mul_of_nonneg_left hlogb hslope0
        have hstartup0 : (0 : ℝ) ≤ Mstar := Nat.cast_nonneg _
        linarith
  · have hlenNat := stageLength_le_log p hn hnW
    have hMlt : M < Mstar := by omega
    have hlen : (stageLength p n : ℝ) ≤ M := by
      exact_mod_cast hlenNat
    have hMstar : (M : ℝ) ≤ Mstar := by exact_mod_cast hMlt.le
    have hlogb0 : 0 ≤ Real.logb 2 n :=
      Real.logb_nonneg (by norm_num) (by exact_mod_cast hn)
    unfold heightClockError
    have hintercept : 0 ≤ (2 + eta) / driftGap + 1 := by
      have hgap : 0 < driftGap := driftGap_pos
      have heta : 0 < 2 + eta := by linarith [p.eta_pos]
      positivity
    nlinarith [mul_nonneg hslope0 hlogb0]

/-- The fixed-depth accumulated shortcut clock has the exact finite
geometric leading term. -/
theorem stageClock_le_heightClock
    {r eta : ℝ} (p : StageSetup r eta)
    (hetaGap : eta < r - a0) {R n : ℕ}
    (hn : 0 < n) (hnSet : n ∈ bootstrapSet p R) :
    (stageClock p R n : ℝ) ≤
      heightClockSlope r eta * clockGeom r R * Real.logb 2 n +
        (R : ℝ) * heightClockError p +
        heightClockSlope r eta * (R : ℝ) ^ 2 *
          Real.logb 2 (stageK p) := by
  have hslope0 : 0 ≤ heightClockSlope r eta :=
    (heightClockSlope_pos p).le
  have herror0 : 0 ≤ heightClockError p :=
    (heightClockError_pos p).le
  have hlogK0 : 0 ≤ Real.logb 2 (stageK p) :=
    Real.logb_nonneg (by norm_num) (stageK_one_le p)
  induction R generalizing n with
  | zero => simp [clockGeom]
  | succ R ih =>
      rw [bootstrapSet_succ] at hnSet
      have hnW := hnSet.1
      have hmapSet := hnSet.2
      have hmapPos : 0 < stageMap p n := by
        rw [stageMap_is_actual]
        exact orbit_pos hn _
      have hlen := stageLength_le_heightClock p hetaGap hn hnW
      have hIH := ih hmapPos hmapSet
      have hstage := stageMap_le_power p hn hnW
      have hlogMap : Real.logb 2 (stageMap p n) ≤
          Real.logb 2 (stageK p) + r * Real.logb 2 n := by
        have hmono := (Real.logb_le_logb (b := (2 : ℝ)) (by norm_num)
          (by exact_mod_cast hmapPos) (mul_pos (stageK_pos p)
            (Real.rpow_pos_of_pos (by exact_mod_cast hn) r))).2 hstage
        calc
          Real.logb 2 (stageMap p n) ≤
              Real.logb 2 (stageK p * (n : ℝ) ^ r) := hmono
          _ = Real.logb 2 (stageK p) + Real.logb 2 ((n : ℝ) ^ r) := by
            rw [Real.logb_mul (stageK_pos p).ne'
              (Real.rpow_pos_of_pos (by exact_mod_cast hn) r).ne']
          _ = Real.logb 2 (stageK p) + r * Real.logb 2 n := by
            rw [Real.logb_rpow_eq_mul_logb_of_pos (by exact_mod_cast hn)]
      have hgeom0 := clockGeom_nonneg p.r_pos.le R
      have hgeomR := clockGeom_le_nat p.r_pos.le p.r_lt_one.le R
      have hlead := mul_le_mul_of_nonneg_left hlogMap
        (mul_nonneg hslope0 hgeom0)
      rw [stageClock_succ, Nat.cast_add]
      calc
        (stageLength p n : ℝ) + (stageClock p R (stageMap p n) : ℝ)
            ≤ (heightClockSlope r eta * Real.logb 2 n +
                heightClockError p) +
              (heightClockSlope r eta * clockGeom r R *
                  Real.logb 2 (stageMap p n) +
                (R : ℝ) * heightClockError p +
                heightClockSlope r eta * (R : ℝ) ^ 2 *
                  Real.logb 2 (stageK p)) := add_le_add hlen hIH
        _ ≤ (heightClockSlope r eta * Real.logb 2 n +
                heightClockError p) +
              (heightClockSlope r eta * clockGeom r R *
                  (Real.logb 2 (stageK p) + r * Real.logb 2 n) +
                (R : ℝ) * heightClockError p +
                heightClockSlope r eta * (R : ℝ) ^ 2 *
                  Real.logb 2 (stageK p)) := by gcongr
        _ ≤ heightClockSlope r eta * clockGeom r (R + 1) *
                Real.logb 2 n +
              ((R : ℝ) + 1) * heightClockError p +
              heightClockSlope r eta * ((R : ℝ) + 1) ^ 2 *
                Real.logb 2 (stageK p) := by
          rw [clockGeom]
          have hcharge :
              heightClockSlope r eta * clockGeom r R *
                  Real.logb 2 (stageK p) ≤
                heightClockSlope r eta * (R : ℝ) *
                  Real.logb 2 (stageK p) := by gcongr
          nlinarith [mul_nonneg hslope0 hlogK0,
            mul_nonneg herror0 (Nat.cast_nonneg R)]
        _ = heightClockSlope r eta * clockGeom r (R + 1) *
                Real.logb 2 n +
              ((R + 1 : ℕ) : ℝ) * heightClockError p +
              heightClockSlope r eta * ((R + 1 : ℕ) : ℝ) ^ 2 *
                Real.logb 2 (stageK p) := by push_cast; ring

/-- Closed form for the finite geometric clock coefficient. -/
theorem one_sub_mul_clockGeom {r : ℝ} :
    ∀ R : ℕ, (1 - r) * clockGeom r R = 1 - r ^ R := by
  intro R
  induction R with
  | zero => simp [clockGeom]
  | succ R ih =>
      calc
        (1 - r) * clockGeom r (R + 1) =
            1 - r + r * ((1 - r) * clockGeom r R) := by
          rw [clockGeom]
          ring
        _ = 1 - r + r * (1 - r ^ R) := by rw [ih]
        _ = 1 - r ^ (R + 1) := by rw [pow_succ]; ring

/-- Exact split of the graded coefficient into its zero-tilt main term and
the positive `eta` payment. -/
theorem heightClockCoefficient_eq
    {r eta : ℝ} (hr1 : r < 1) (R : ℕ) :
    heightClockSlope r eta * clockGeom r R / Real.log 2 =
      (1 - r ^ R) / (driftGap * Real.log 2) +
        eta * clockGeom r R / (driftGap * Real.log 2) := by
  have hgap : driftGap ≠ 0 := driftGap_pos.ne'
  have hlog2 : Real.log 2 ≠ 0 := (Real.log_pos (by norm_num)).ne'
  have hrne : 1 - r ≠ 0 := ne_of_gt (sub_pos.mpr hr1)
  have hgeom := one_sub_mul_clockGeom (r := r) R
  unfold heightClockSlope
  field_simp [hgap, hlog2]
  nlinarith

/-- Every fixed number of stopped pullbacks retains a positive power-saving,
hence defines a natural-density-one set. -/
theorem fixedBootstrap_naturalDensityOne
    {r eta : ℝ} (p : StageSetup r eta) (R : ℕ) :
    NaturalDensityOne (bootstrapSet p R) := by
  let chi := r / 2
  let Dc := quadraticWindowDensityRate eta
  have hchi0 : 0 < chi := by dsimp [chi]; linarith [p.r_pos]
  have hchir : chi < r := by dsimp [chi]; linarith [p.r_pos]
  have hchi1 : chi ≤ 1 := by dsimp [chi]; linarith [p.r_lt_one]
  have hDc0 : 0 < Dc := by
    dsimp [Dc]
    exact (extendedWindow_powerDense p).D_pos
  have hDc1 : Dc ≤ 1 := by
    dsimp [Dc]
    exact (extendedWindow_powerDense p).D_le_one
  have hchiDc : chi * Dc < 1 := by
    have hprod : chi * Dc ≤ chi * 1 :=
      mul_le_mul_of_nonneg_left hDc1 hchi0.le
    nlinarith [hchir.trans p.r_lt_one]
  exact (bootstrapSet_powerDense p hchi0 hchir hchi1 hDc0 le_rfl
    hchiDc R).naturalDensityOne

/-- Conditional fixed-depth theorem.  This is the exact formal interface
consumed by the scalar parameter-selection lemma for the smooth graded
clock. -/
theorem fixedDepthGradedPowerDescent
    {alpha clock r eta : ℝ} (p : StageSetup r eta)
    (hetaGap : eta < r - a0) {R : ℕ}
    (hpower : r ^ R < alpha)
    (hclock :
      heightClockSlope r eta * clockGeom r R / Real.log 2 < clock) :
    ∃ S : Set ℕ,
      NaturalDensityOne S ∧
        ∀ᶠ n : ℕ in atTop,
          n ∈ S →
            ∃ k : ℕ,
              (k : ℝ) < clock * Real.log n ∧
                (orbit k n : ℝ) ≤ (n : ℝ) ^ alpha := by
  let lead := heightClockSlope r eta * clockGeom r R / Real.log 2
  let gap := alpha - r ^ R
  let clockGap := clock - lead
  let E := (R : ℝ) * heightClockError p +
    heightClockSlope r eta * (R : ℝ) ^ 2 * Real.logb 2 (stageK p)
  have hgap : 0 < gap := by dsimp [gap]; linarith
  have hclockGap : 0 < clockGap := by dsimp [clockGap, lead]; linarith
  have hlog2 : 0 < Real.log 2 := Real.log_pos (by norm_num)
  have htPower : Tendsto (fun n : ℕ => (n : ℝ) ^ gap) atTop atTop :=
    (tendsto_rpow_atTop hgap).comp tendsto_natCast_atTop_atTop
  have hKevent : ∀ᶠ n : ℕ in atTop,
      stageK p ^ R ≤ (n : ℝ) ^ gap :=
    (tendsto_atTop.1 htPower) (stageK p ^ R)
  have htLog : Tendsto (fun n : ℕ => Real.log n) atTop atTop :=
    Real.tendsto_log_atTop.comp tendsto_natCast_atTop_atTop
  have hEevent : ∀ᶠ n : ℕ in atTop,
      E < clockGap * Real.log n := by
    have htScaled := htLog.const_mul_atTop hclockGap
    have hev := (tendsto_atTop.1 htScaled) (E + 1)
    filter_upwards [hev] with n hnlarge
    linarith
  refine ⟨bootstrapSet p R, fixedBootstrap_naturalDensityOne p R, ?_⟩
  filter_upwards [hKevent, hEevent, eventually_gt_atTop (0 : ℕ)] with n
    hK hE hn hnSet
  have hnReal : (0 : ℝ) < n := by exact_mod_cast hn
  have horbit := stageOrbit_le_power p hn hnSet
  have hlanding : (stageOrbit p R n : ℝ) ≤ (n : ℝ) ^ alpha := by
    calc
      (stageOrbit p R n : ℝ) ≤
          stageK p ^ R * (n : ℝ) ^ (r ^ R) := horbit
      _ ≤ (n : ℝ) ^ gap * (n : ℝ) ^ (r ^ R) :=
        mul_le_mul_of_nonneg_right hK (Real.rpow_nonneg hnReal.le _)
      _ = (n : ℝ) ^ alpha := by
        rw [← Real.rpow_add hnReal]
        dsimp [gap]
        congr 2
        ring
  have htimeBound := stageClock_le_heightClock p hetaGap hn hnSet
  have hleadIdentity :
      heightClockSlope r eta * clockGeom r R * Real.logb 2 n =
        lead * Real.log n := by
    dsimp [lead]
    rw [Real.logb]
    field_simp [hlog2.ne']
  have htime : (stageClock p R n : ℝ) < clock * Real.log n := by
    calc
      (stageClock p R n : ℝ) ≤
          heightClockSlope r eta * clockGeom r R * Real.logb 2 n + E := by
        simpa [E, add_assoc] using htimeBound
      _ = lead * Real.log n + E := by rw [hleadIdentity]
      _ < lead * Real.log n + clockGap * Real.log n := add_lt_add_left hE _
      _ = clock * Real.log n := by
        dsimp [clockGap]
        ring
  refine ⟨stageClock p R n, htime, ?_⟩
  rw [← stageOrbit_eq_orbit_stageClock]
  exact hlanding

end

end FirstPassageLinearTransport
