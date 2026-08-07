/-
Copyright (c) 2026 Idris Ali Shaik. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Idris Ali Shaik
-/
import FirstPassageLinearTransport.TwoRegimePolylogProfile
import FirstPassageLinearTransport.Constants

/-!
# Endpoint parameters for fixed-polylogarithmic descent

This module isolates the scalar endpoint optimization behind the paper's
constant `A_FP`.  It contains no Collatz-set or checkpoint-congestion input.
The main result selects an admissible adjustable low-rank barrier and a
strictly positive exceptional-count exponent from every
`A > fixedPolylogCriticalExponent`.
-/

namespace FirstPassageLinearTransport

open Filter
open scoped Real Topology

noncomputable section

/-- The endpoint displacement obtained as the envelope tolerance approaches
the full drift gap and the adjustable barrier fraction approaches one. -/
def firstPassageEndpointDisplacement : ℝ := driftGap / logTwoThree

/-- The entropy rate available at the nonattained low-rank endpoint. -/
def firstPassageEndpointRate : ℝ :=
  binaryBarrierRate firstPassageEndpointDisplacement

/-- Exact critical fixed-polylogarithmic exponent. -/
def fixedPolylogCriticalExponent : ℝ :=
  Real.log 2 / firstPassageEndpointRate

/-- Base-three logarithm of two. -/
def logThreeTwo : ℝ := Real.log 2 / Real.log 3

/-- Binary entropy in base two, expressed through Mathlib's natural-log
binary entropy. -/
def binaryEntropyBaseTwo (p : ℝ) : ℝ :=
  Real.binEntropy p / Real.log 2

theorem driftGap_lt_a0 : driftGap < a0 := by
  have haHalf : (1 / 2 : ℝ) < a0 := by
    unfold a0
    linarith [logTwoThree_one_lt]
  unfold driftGap
  linarith

theorem firstPassageEndpointDisplacement_pos :
    0 < firstPassageEndpointDisplacement := by
  unfold firstPassageEndpointDisplacement
  exact div_pos driftGap_pos logTwoThree_pos

theorem firstPassageEndpointDisplacement_lt_half :
    firstPassageEndpointDisplacement < 1 / 2 := by
  unfold firstPassageEndpointDisplacement
  rw [div_lt_iff₀ logTwoThree_pos]
  have htwo : logTwoThree = 2 * a0 := by
    unfold a0
    ring
  rw [htwo]
  linarith [driftGap_lt_a0]

theorem endpoint_probability_eq_logThreeTwo :
    1 / 2 + firstPassageEndpointDisplacement = logThreeTwo := by
  unfold firstPassageEndpointDisplacement driftGap a0 logTwoThree logThreeTwo
  have hlog2 : Real.log 2 ≠ 0 := ne_of_gt (Real.log_pos (by norm_num))
  have hlog3 : Real.log 3 ≠ 0 := ne_of_gt (Real.log_pos (by norm_num))
  field_simp [hlog2, hlog3]
  ring

theorem firstPassageEndpointRate_pos : 0 < firstPassageEndpointRate := by
  unfold firstPassageEndpointRate binaryBarrierRate
  apply sub_pos.mpr
  rw [Real.binEntropy_lt_log_two]
  have hdisp := firstPassageEndpointDisplacement_pos
  intro hEq
  linarith

theorem firstPassageEndpointRate_lt_logTwo :
    firstPassageEndpointRate < Real.log 2 := by
  unfold firstPassageEndpointRate binaryBarrierRate
  have hp0 : 0 < 1 / 2 + firstPassageEndpointDisplacement := by
    linarith [firstPassageEndpointDisplacement_pos]
  have hp1 : 1 / 2 + firstPassageEndpointDisplacement < 1 := by
    linarith [firstPassageEndpointDisplacement_lt_half]
  linarith [Real.binEntropy_pos hp0 hp1]

theorem fixedPolylogCriticalExponent_gt_one :
    1 < fixedPolylogCriticalExponent := by
  unfold fixedPolylogCriticalExponent
  rw [lt_div_iff₀ firstPassageEndpointRate_pos]
  simpa using firstPassageEndpointRate_lt_logTwo

/-- Exact identification with the paper's
`1 / (1 - H₂(log₃ 2))`. -/
theorem fixedPolylogCriticalExponent_eq_entropy :
    fixedPolylogCriticalExponent =
      1 / (1 - binaryEntropyBaseTwo logThreeTwo) := by
  rw [fixedPolylogCriticalExponent, firstPassageEndpointRate,
    binaryBarrierRate, endpoint_probability_eq_logThreeTwo]
  unfold binaryEntropyBaseTwo
  have hlog2 : Real.log 2 ≠ 0 := ne_of_gt (Real.log_pos (by norm_num))
  have hrate : Real.log 2 - Real.binEntropy logThreeTwo ≠ 0 := by
    have hpos := firstPassageEndpointRate_pos
    rw [firstPassageEndpointRate, binaryBarrierRate] at hpos
    change 0 < Real.log 2 - Real.binEntropy
      (1 / 2 + firstPassageEndpointDisplacement) at hpos
    rw [endpoint_probability_eq_logThreeTwo] at hpos
    exact ne_of_gt hpos
  field_simp [hlog2, hrate]

theorem continuous_binaryBarrierRate : Continuous binaryBarrierRate := by
  unfold binaryBarrierRate
  fun_prop

/-- A one-parameter admissible approach to the low-rank endpoint. -/
def endpointLambda (n : ℕ) : ℝ :=
  1 - 1 / ((n : ℝ) + 2)

/-- The matching envelope tolerance, strictly below the full drift gap. -/
def endpointTolerance (n : ℕ) : ℝ :=
  driftGap * endpointLambda n

theorem tendsto_endpointLambda :
    Tendsto endpointLambda atTop (nhds 1) := by
  have hden : Tendsto (fun n : ℕ => (n : ℝ) + 2) atTop atTop :=
    tendsto_atTop_add_const_right atTop (2 : ℝ)
      tendsto_natCast_atTop_atTop
  have hinv : Tendsto (fun n : ℕ => 1 / ((n : ℝ) + 2)) atTop (nhds 0) := by
    simpa [one_div] using tendsto_inv_atTop_zero.comp hden
  change Tendsto (fun n : ℕ => 1 - 1 / ((n : ℝ) + 2)) atTop (nhds 1)
  simpa using
    ((tendsto_const_nhds : Tendsto (fun _ : ℕ => (1 : ℝ)) atTop (nhds 1)).sub hinv)

theorem tendsto_endpointTolerance :
    Tendsto endpointTolerance atTop (nhds driftGap) := by
  simpa [endpointTolerance] using
    tendsto_const_nhds.mul tendsto_endpointLambda

theorem tendsto_endpointEntropyRate :
    Tendsto
      (fun n : ℕ =>
        adjustableEntropyRate (endpointLambda n) (endpointTolerance n))
      atTop (nhds firstPassageEndpointRate) := by
  have hdisp : Tendsto
      (fun n : ℕ => adjustableBarrierDisplacement
        (endpointLambda n) (endpointTolerance n))
      atTop (nhds firstPassageEndpointDisplacement) := by
    have hmul := tendsto_endpointLambda.mul tendsto_endpointTolerance
    simpa [adjustableBarrierDisplacement, firstPassageEndpointDisplacement]
      using hmul.div_const logTwoThree
  unfold adjustableEntropyRate firstPassageEndpointRate
  exact continuous_binaryBarrierRate.continuousAt.tendsto.comp hdisp

theorem endpointLambda_pos (n : ℕ) : 0 < endpointLambda n := by
  unfold endpointLambda
  have hn0 : (0 : ℝ) ≤ n := by positivity
  have hden : (1 : ℝ) < (n : ℝ) + 2 := by linarith
  have hinv : 1 / ((n : ℝ) + 2) < 1 := (div_lt_one (by positivity)).2 hden
  linarith

theorem endpointLambda_lt_one (n : ℕ) : endpointLambda n < 1 := by
  unfold endpointLambda
  have hinv : 0 < 1 / ((n : ℝ) + 2) := by positivity
  linarith

theorem endpointTolerance_pos (n : ℕ) : 0 < endpointTolerance n := by
  unfold endpointTolerance
  exact mul_pos driftGap_pos (endpointLambda_pos n)

theorem endpointTolerance_lt_driftGap (n : ℕ) :
    endpointTolerance n < driftGap := by
  unfold endpointTolerance
  nlinarith [driftGap_pos, endpointLambda_pos n, endpointLambda_lt_one n]

/-- Scalar endpoint selection.  Every exponent above the critical value
admits a fixed low-rank adjustable barrier whose entropy rate exceeds the
required `log 2 / A` threshold. -/
theorem exists_lowBarrier_of_critical_lt
    {A : ℝ} (hA : fixedPolylogCriticalExponent < A) :
    ∃ lambda t : ℝ,
      0 ≤ lambda ∧ lambda < 1 ∧
      0 < t ∧ t < driftGap ∧ t < a0 ∧
      Real.log 2 / A < adjustableEntropyRate lambda t := by
  have hA1 : 1 < A := fixedPolylogCriticalExponent_gt_one.trans hA
  have hA0 : 0 < A := lt_trans zero_lt_one hA1
  have hthreshold : Real.log 2 / A < firstPassageEndpointRate := by
    rw [div_lt_iff₀ hA0]
    have hcross : Real.log 2 < A * firstPassageEndpointRate := by
      have := (div_lt_iff₀ firstPassageEndpointRate_pos).1 hA
      simpa [fixedPolylogCriticalExponent, mul_comm] using this
    simpa [mul_comm] using hcross
  have hEventually : ∀ᶠ n : ℕ in atTop,
      Real.log 2 / A <
        adjustableEntropyRate (endpointLambda n) (endpointTolerance n) :=
    tendsto_endpointEntropyRate.eventually
      (Ioi_mem_nhds hthreshold)
  obtain ⟨n, hn⟩ := hEventually.exists
  refine ⟨endpointLambda n, endpointTolerance n,
    (endpointLambda_pos n).le, endpointLambda_lt_one n,
    endpointTolerance_pos n, endpointTolerance_lt_driftGap n,
    (endpointTolerance_lt_driftGap n).trans driftGap_lt_a0, hn⟩

/-- The endpoint selector also leaves room for a strict retained entropy
rate and a positive global exceptional-count power. -/
theorem exists_lowBarrier_rate_margin_of_critical_lt
    {A : ℝ} (hA : fixedPolylogCriticalExponent < A) :
    ∃ lambda t b kappa : ℝ,
      0 ≤ lambda ∧ lambda < 1 ∧
      0 < t ∧ t < driftGap ∧ t < a0 ∧
      0 < b ∧ b < adjustableEntropyRate lambda t ∧
      b < Real.log 2 ∧
      0 < kappa ∧ kappa < A * b / Real.log 2 - 1 := by
  obtain ⟨lambda, t, hlambda0, hlambda1, ht0, htGap, htA, hrate⟩ :=
    exists_lowBarrier_of_critical_lt hA
  have hA1 : 1 < A := fixedPolylogCriticalExponent_gt_one.trans hA
  have hA0 : 0 < A := lt_trans zero_lt_one hA1
  let threshold := Real.log 2 / A
  let upper := min (adjustableEntropyRate lambda t) (Real.log 2)
  have hthreshold0 : 0 < threshold := by
    dsimp [threshold]
    exact div_pos (Real.log_pos (by norm_num)) hA0
  have hthresholdUpper : threshold < upper := by
    rw [lt_min_iff]
    refine ⟨by simpa [threshold] using hrate, ?_⟩
    dsimp [threshold]
    exact div_lt_self (Real.log_pos (by norm_num)) hA1
  let b := (threshold + upper) / 2
  have hbLower : threshold < b := by
    dsimp [b]
    linarith
  have hbUpper : b < upper := by
    dsimp [b]
    linarith
  have hb0 : 0 < b := hthreshold0.trans hbLower
  have hbRate : b < adjustableEntropyRate lambda t :=
    hbUpper.trans_le (min_le_left _ _)
  have hbLog : b < Real.log 2 :=
    hbUpper.trans_le (min_le_right _ _)
  have hmargin : 0 < A * b / Real.log 2 - 1 := by
    have hlog2 : 0 < Real.log 2 := Real.log_pos (by norm_num)
    have hAb : Real.log 2 < A * b := by
      have := mul_lt_mul_of_pos_left hbLower hA0
      dsimp [threshold] at this
      field_simp [ne_of_gt hA0] at this
      simpa [mul_comm] using this
    rw [sub_pos, one_lt_div hlog2]
    exact hAb
  let kappa := (A * b / Real.log 2 - 1) / 2
  have hkappa0 : 0 < kappa := by
    dsimp [kappa]
    linarith
  have hkappa : kappa < A * b / Real.log 2 - 1 := by
    dsimp [kappa]
    linarith
  exact ⟨lambda, t, b, kappa,
    hlambda0, hlambda1, ht0, htGap, htA, hb0, hbRate, hbLog,
    hkappa0, hkappa⟩

/-- Critical shortcut-clock coefficient in the natural-logarithm
normalization. -/
def fixedPolylogClockCritical : ℝ :=
  1 / (driftGap * Real.log 2)

theorem fixedPolylogClockCritical_eq_paper :
    fixedPolylogClockCritical = 2 / Real.log (4 / 3) := by
  exact inv_drift_clock_eq

theorem fixedPolylogClockCritical_pos : 0 < fixedPolylogClockCritical := by
  unfold fixedPolylogClockCritical
  exact one_div_pos.mpr
    (mul_pos driftGap_pos (Real.log_pos (by norm_num)))

theorem adjustableEntropyRate_pos
    {lambda t : ℝ} (hlambda0 : 0 < lambda) (ht0 : 0 < t) :
    0 < adjustableEntropyRate lambda t := by
  unfold adjustableEntropyRate binaryBarrierRate
  apply sub_pos.mpr
  rw [Real.binEntropy_lt_log_two]
  have hdisp0 : 0 < adjustableBarrierDisplacement lambda t := by
    unfold adjustableBarrierDisplacement
    exact div_pos (mul_pos hlambda0 ht0) logTwoThree_pos
  intro hEq
  linarith

/-- Complete scalar and rational parameter package consumed by the canonical
two-regime profile. -/
structure FixedPolylogParameterPackage (A c beta : ℝ) where
  rHi : ℚ
  rLo : ℚ
  rStar : ℚ
  tHi : ℝ
  tLo : ℝ
  lambdaHi : ℝ
  lambdaLo : ℝ
  bHi : ℝ
  bLo : ℝ
  cDyadic : ℝ
  kappa : ℝ
  pHi : StageSetup (rHi : ℝ) tHi
  pLo : StageSetup (rLo : ℝ) tLo
  lambdaHi_nonneg : 0 ≤ lambdaHi
  lambdaHi_lt_one : lambdaHi < 1
  lambdaLo_nonneg : 0 ≤ lambdaLo
  lambdaLo_lt_one : lambdaLo < 1
  tHi_pos : 0 < tHi
  tHi_lt_a0 : tHi < a0
  tHi_lt_beta : tHi < beta
  tLo_pos : 0 < tLo
  tLo_lt_a0 : tLo < a0
  bHi_pos : 0 < bHi
  bHi_lt_rate : bHi < adjustableEntropyRate lambdaHi tHi
  bLo_pos : 0 < bLo
  bLo_lt_rate : bLo < adjustableEntropyRate lambdaLo tLo
  cDyadic_pos : 0 < cDyadic
  cDyadic_lt_logTwo : cDyadic < Real.log 2
  rHi_nonneg : 0 ≤ rHi
  rHi_lt_one : rHi < 1
  rLo_nonneg : 0 ≤ rLo
  rLo_lt_one : rLo < 1
  rStar_eq : rStar = min rHi rLo
  rStar_pos : 0 < rStar
  rStar_le_hi : rStar ≤ rHi
  rStar_le_lo : rStar ≤ rLo
  clock_pressure : 1 / (1 - (rHi : ℝ)) < c * Real.log 2
  kappa_pos : 0 < kappa
  kappa_lt : kappa < A * min bLo cDyadic / Real.log 2 - 1

/-- Every paper-admissible triple `(A,c,beta)` admits one complete fixed
two-regime parameter package. -/
theorem exists_fixedPolylogParameterPackage
    {A c beta : ℝ}
    (hA : fixedPolylogCriticalExponent < A)
    (hc : fixedPolylogClockCritical < c)
    (hbeta : 0 < beta) :
    Nonempty (FixedPolylogParameterPackage A c beta) := by
  have hlog2 : 0 < Real.log 2 := Real.log_pos (by norm_num)
  have hc0 : 0 < c := fixedPolylogClockCritical_pos.trans hc
  have hcLog : 0 < c * Real.log 2 := mul_pos hc0 hlog2
  have hgapLog : 0 < driftGap * Real.log 2 :=
    mul_pos driftGap_pos hlog2
  have hclockCross : 1 < c * (driftGap * Real.log 2) := by
    have := (div_lt_iff₀ hgapLog).1 hc
    simpa [fixedPolylogClockCritical] using this
  have hInvGap : 1 / (c * Real.log 2) < driftGap := by
    rw [div_lt_iff₀ hcLog]
    nlinarith [hclockCross]
  have hHiInterval : a0 < 1 - 1 / (c * Real.log 2) := by
    unfold driftGap at hInvGap
    linarith
  obtain ⟨rHi, hrHiLower, hrHiUpper⟩ := exists_rat_btwn hHiInterval
  have hrHiOne : (rHi : ℝ) < 1 := by
    have hinv0 : 0 < 1 / (c * Real.log 2) := by positivity
    linarith
  have hrHiPos : (0 : ℝ) < rHi := a0_pos.trans hrHiLower
  have hclock : 1 / (1 - (rHi : ℝ)) < c * Real.log 2 := by
    have hgap : 1 / (c * Real.log 2) < 1 - (rHi : ℝ) := by
      linarith
    have hden : 0 < 1 - (rHi : ℝ) := sub_pos.mpr hrHiOne
    rw [div_lt_iff₀ hden]
    have hmul := (div_lt_iff₀ hcLog).1 hgap
    nlinarith
  let dHi : ℝ := min ((rHi : ℝ) - a0) (min beta a0)
  have hdHi : 0 < dHi := by
    rw [lt_min_iff, lt_min_iff]
    exact ⟨sub_pos.mpr hrHiLower, hbeta, a0_pos⟩
  let tHi := dHi / 2
  have htHi0 : 0 < tHi := by dsimp [tHi]; positivity
  have htHiD : tHi < dHi := by dsimp [tHi]; linarith
  have htHiGap : tHi < (rHi : ℝ) - a0 :=
    htHiD.trans_le (min_le_left _ _)
  have htHiBeta : tHi < beta :=
    htHiD.trans_le ((min_le_right _ _).trans (min_le_left _ _))
  have htHiA : tHi < a0 :=
    htHiD.trans_le ((min_le_right _ _).trans (min_le_right _ _))
  let lambdaHi : ℝ := 1 / 2
  have hlambdaHi0 : 0 ≤ lambdaHi := by dsimp [lambdaHi]; norm_num
  have hlambdaHi1 : lambdaHi < 1 := by dsimp [lambdaHi]; norm_num
  have hHiRate0 : 0 < adjustableEntropyRate lambdaHi tHi :=
    adjustableEntropyRate_pos (by dsimp [lambdaHi]; norm_num)
      htHi0
  let bHi := adjustableEntropyRate lambdaHi tHi / 2
  have hbHi0 : 0 < bHi := by dsimp [bHi]; positivity
  have hbHiRate : bHi < adjustableEntropyRate lambdaHi tHi := by
    dsimp [bHi]
    linarith
  let pHi := Classical.choice
    (exists_stageSetup hrHiLower hrHiOne htHi0 htHiGap)
  obtain ⟨lambdaLo, tLo, bLo, kappa,
      hlambdaLo0, hlambdaLo1, htLo0, htLoGap, htLoA,
      hbLo0, hbLoRate, hbLoLog, hkappa0, hkappa⟩ :=
    exists_lowBarrier_rate_margin_of_critical_lt hA
  have hLoInterval : a0 + tLo < 1 := by
    unfold driftGap at htLoGap
    linarith
  obtain ⟨rLo, hrLoLower, hrLoUpper⟩ := exists_rat_btwn hLoInterval
  have hrLoA : a0 < (rLo : ℝ) := by linarith [htLo0]
  have htLoRankGap : tLo < (rLo : ℝ) - a0 := by linarith
  have hrLoPos : (0 : ℝ) < rLo := a0_pos.trans hrLoA
  let pLo := Classical.choice
    (exists_stageSetup hrLoA hrLoUpper htLo0 htLoRankGap)
  let rStar : ℚ := min rHi rLo
  have hrStar0 : (0 : ℚ) < rStar := by
    dsimp [rStar]
    rw [lt_min_iff]
    exact ⟨by exact_mod_cast hrHiPos, by exact_mod_cast hrLoPos⟩
  refine ⟨{
    rHi := rHi
    rLo := rLo
    rStar := rStar
    tHi := tHi
    tLo := tLo
    lambdaHi := lambdaHi
    lambdaLo := lambdaLo
    bHi := bHi
    bLo := bLo
    cDyadic := bLo
    kappa := kappa
    pHi := pHi
    pLo := pLo
    lambdaHi_nonneg := hlambdaHi0
    lambdaHi_lt_one := hlambdaHi1
    lambdaLo_nonneg := hlambdaLo0
    lambdaLo_lt_one := hlambdaLo1
    tHi_pos := htHi0
    tHi_lt_a0 := htHiA
    tHi_lt_beta := htHiBeta
    tLo_pos := htLo0
    tLo_lt_a0 := htLoA
    bHi_pos := hbHi0
    bHi_lt_rate := hbHiRate
    bLo_pos := hbLo0
    bLo_lt_rate := hbLoRate
    cDyadic_pos := hbLo0
    cDyadic_lt_logTwo := hbLoLog
    rHi_nonneg := by exact_mod_cast hrHiPos.le
    rHi_lt_one := by exact_mod_cast hrHiOne
    rLo_nonneg := by exact_mod_cast hrLoPos.le
    rLo_lt_one := by exact_mod_cast hrLoUpper
    rStar_eq := rfl
    rStar_pos := hrStar0
    rStar_le_hi := min_le_left _ _
    rStar_le_lo := min_le_right _ _
    clock_pressure := hclock
    kappa_pos := hkappa0
    kappa_lt := by simpa using hkappa
  }⟩

end

end FirstPassageLinearTransport
