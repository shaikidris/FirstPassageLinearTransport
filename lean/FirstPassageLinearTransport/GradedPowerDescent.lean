/-
Copyright (c) 2026 Idris Ali Shaik. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Idris Ali Shaik
-/
import FirstPassageLinearTransport.GradedClock
import FirstPassageLinearTransport.Constants

/-!
# Smooth graded power descent

Scalar parameter selection for the fixed-depth clock.  The output is the
full tradeoff `2 (1-alpha) / log (4/3) + epsilon`.
-/

namespace FirstPassageLinearTransport

open Filter
open scoped Real Topology

noncomputable section

/-- For every fixed power target and every positive clock slack, there are
strict stopped-stage parameters with the required fixed-depth landing and
clock inequalities. -/
theorem exists_gradedClockParameters
    {alpha epsilon : ℝ}
    (halpha0 : 0 < alpha) (halpha1 : alpha < 1)
    (hepsilon : 0 < epsilon) :
    ∃ (r eta : ℝ) (R : ℕ) (_p : StageSetup r eta),
      eta < r - a0 ∧ r ^ R < alpha ∧
        heightClockSlope r eta * clockGeom r R / Real.log 2 <
          2 * (1 - alpha) / Real.log (4 / 3) + epsilon := by
  let dlog := driftGap * Real.log 2
  have hdlog : 0 < dlog := by
    dsimp [dlog]
    exact mul_pos driftGap_pos (Real.log_pos (by norm_num))
  let t := min (alpha / 2) (epsilon * dlog / 8)
  let alpha' := alpha - t
  have ht0 : 0 < t := by
    dsimp [t]
    exact lt_min (by linarith) (by positivity)
  have htAlpha : t ≤ alpha / 2 := by
    dsimp [t]
    exact min_le_left _ _
  have htEps : t ≤ epsilon * dlog / 8 := by
    dsimp [t]
    exact min_le_right _ _
  have halpha'0 : 0 < alpha' := by dsimp [alpha']; linarith
  have halpha'Alpha : alpha' < alpha := by dsimp [alpha']; linarith
  have halpha'1 : alpha' < 1 := halpha'Alpha.trans halpha1
  have hrootT : Tendsto
      (fun N : ℕ => alpha' ^ (1 / ((N : ℝ) + 1)))
      atTop (nhds 1) := by
    have hc := (Real.continuousAt_const_rpow halpha'0.ne').tendsto.comp
      tendsto_one_div_add_atTop_nhds_zero_nat
    simpa using hc
  have hrootAbove : ∀ᶠ N : ℕ in atTop,
      a0 < alpha' ^ (1 / ((N : ℝ) + 1)) :=
    (tendsto_order.1 hrootT).1 a0 a0_lt_one
  obtain ⟨N, hN⟩ := hrootAbove.exists
  let R := N + 1
  let r := alpha' ^ (1 / (R : ℝ))
  have hR0 : 0 < R := by dsimp [R]; omega
  have hRR : (0 : ℝ) < R := by exact_mod_cast hR0
  have ha0r : a0 < r := by
    dsimp [r, R]
    simpa only [Nat.cast_add, Nat.cast_one] using hN
  have hr0 : 0 < r := by
    dsimp [r]
    exact Real.rpow_pos_of_pos halpha'0 _
  have hr1 : r < 1 := by
    dsimp [r]
    exact Real.rpow_lt_one halpha'0.le halpha'1 (by positivity)
  have hrR : r ^ R = alpha' := by
    dsimp [r]
    rw [← Real.rpow_natCast, ← Real.rpow_mul halpha'0.le]
    have hRne : (R : ℝ) ≠ 0 := hRR.ne'
    field_simp [hRne]
  have hgeom0 : 0 ≤ clockGeom r R :=
    clockGeom_nonneg hr0.le R
  have hgeomPlus : 0 < clockGeom r R + 1 := by linarith
  let eta := min ((r - a0) / 2)
    (epsilon * dlog / (8 * (clockGeom r R + 1)))
  have heta0 : 0 < eta := by
    dsimp [eta]
    exact lt_min (by linarith) (by positivity)
  have hetaGap : eta < r - a0 := by
    have hle : eta ≤ (r - a0) / 2 := by
      dsimp [eta]
      exact min_le_left _ _
    linarith
  have hetaBudget :
      eta ≤ epsilon * dlog / (8 * (clockGeom r R + 1)) := by
    dsimp [eta]
    exact min_le_right _ _
  let p : StageSetup r eta :=
    Classical.choice (exists_stageSetup ha0r hr1 heta0 hetaGap)
  have hextra :
      eta * clockGeom r R / dlog ≤ epsilon / 8 := by
    have hden : 0 < 8 * (clockGeom r R + 1) := by positivity
    have hcross : eta * (8 * (clockGeom r R + 1)) ≤
        epsilon * dlog :=
      (le_div_iff₀ hden).1 hetaBudget
    have hmono : eta * clockGeom r R ≤
        eta * (clockGeom r R + 1) :=
      mul_le_mul_of_nonneg_left (by linarith) heta0.le
    apply (div_le_iff₀ hdlog).2
    nlinarith [mul_nonneg heta0.le hgeom0]
  have htOver : t / dlog ≤ epsilon / 8 := by
    apply (div_le_iff₀ hdlog).2
    nlinarith
  have hcoeff := heightClockCoefficient_eq (eta := eta) hr1 R
  have hmainRewrite :
      (1 - alpha) / dlog =
        2 * (1 - alpha) / Real.log (4 / 3) := by
    have hid := inv_drift_clock_eq
    unfold driftGap at hid
    dsimp [dlog]
    calc
      (1 - alpha) / ((1 - a0) * Real.log 2) =
          (1 - alpha) * (1 / ((1 - a0) * Real.log 2)) := by ring
      _ = (1 - alpha) * (2 / Real.log (4 / 3)) := by rw [hid]
      _ = 2 * (1 - alpha) / Real.log (4 / 3) := by ring
  refine ⟨r, eta, R, p, hetaGap, ?_, ?_⟩
  · rw [hrR]
    exact halpha'Alpha
  · rw [hcoeff, hrR]
    have hdecomp :
        (1 - alpha') / dlog = (1 - alpha) / dlog + t / dlog := by
      dsimp [alpha']
      ring
    have hbase :
        (1 - alpha') / dlog ≤ (1 - alpha) / dlog + epsilon / 8 := by
      rw [hdecomp]
      linarith
    have hsum :
        (1 - alpha') / dlog +
            eta * clockGeom r R / dlog ≤
          (1 - alpha) / dlog + epsilon / 4 := by
      linarith
    change (1 - alpha') / dlog + eta * clockGeom r R / dlog <
      2 * (1 - alpha) / Real.log (4 / 3) + epsilon
    rw [hmainRewrite] at hsum
    exact hsum.trans_lt (by linarith)

/-- **Smooth graded first-passage clock.** Reaching `n^alpha` costs only the
corresponding fraction `1-alpha` of the full descent clock, up to arbitrary
positive slack. -/
theorem firstPassageLinearTransportGradedPower
    {alpha epsilon : ℝ}
    (halpha0 : 0 < alpha) (halpha1 : alpha < 1)
    (hepsilon : 0 < epsilon) :
    ∃ S : Set ℕ,
      NaturalDensityOne S ∧
        ∀ᶠ n : ℕ in atTop,
          n ∈ S →
            ∃ k : ℕ,
              (k : ℝ) <
                  (2 * (1 - alpha) / Real.log (4 / 3) + epsilon) *
                    Real.log n ∧
                (orbit k n : ℝ) ≤ (n : ℝ) ^ alpha := by
  obtain ⟨r, eta, R, p, hetaGap, hpower, hclock⟩ :=
    exists_gradedClockParameters halpha0 halpha1 hepsilon
  exact fixedDepthGradedPowerDescent p hetaGap hpower hclock

end

end FirstPassageLinearTransport
