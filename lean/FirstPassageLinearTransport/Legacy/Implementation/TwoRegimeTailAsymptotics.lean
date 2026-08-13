/-
Copyright (c) 2026 Idris Ali Shaik. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Idris Ali Shaik
-/
import FirstPassageLinearTransport.Legacy.Implementation.TwoRegimeSchedules
import FirstPassageLinearTransport.TerminalTailAsymptotics

import FirstPassageLinearTransport.Extras.Unreachable
/-!
# Asymptotics of the two-regime terminal tails

This module converts the exact exponential terminal profile into the powers
of the outer shell rank used by the fixed-polylogarithmic theorem.  It keeps
the entropy and dyadic rate margins explicit and contains no Collatz-set
counting argument.
-/

namespace FirstPassageLinearTransport

open Filter
open scoped Real Topology

noncomputable section

/-- After multiplication by the canonical two-regime horizon, the terminal
tail loses exactly one power of the outer shell rank. -/
theorem eventually_horizon_mul_terminalTail_polylog_le
    {A b b' c' c : ℝ} {rHi rLo : ℚ}
    (hA : 0 < A)
    (hb' : 0 < b') (hbb' : b' < b)
    (hc' : 0 < c') (hc2 : c' < Real.log 2)
    (hrHi0 : 0 ≤ rHi) (hrHi1 : rHi < 1)
    (hrLo0 : 0 ≤ rLo) (hrLo1 : rLo < 1)
    (hlead : 1 / (1 - (rHi : ℝ)) < c * Real.log 2) :
    ∀ᶠ M : ℕ in atTop,
      (twoRegimeHorizon rHi rLo (polylogSwitchRank M) M : ℝ) *
          terminalTailBound b b' c' (polylogTerminalRank A M) ≤
        c * Real.log 2 * terminalTailPrefactor b b' c' *
          (((M : ℝ) + 2) ^
            (-(A * min b' c' / Real.log 2 - 1))) := by
  have hlog2 : 0 < Real.log 2 := Real.log_pos (by norm_num)
  have hdHi : 0 < 1 - (rHi : ℝ) := by
    have h : (rHi : ℝ) < 1 := by exact_mod_cast hrHi1
    linarith
  have hcLog : 0 < c * Real.log 2 :=
    (div_pos zero_lt_one hdHi).trans hlead
  have hc : 0 < c := by
    rcases mul_pos_iff.mp hcLog with h | h
    · exact h.1
    · exact False.elim ((not_lt_of_ge hlog2.le) h.2)
  have hH := eventually_twoRegimeHorizon_lt_shellClock
    hrHi0 hrHi1 hrLo0 hrLo1 hlead
  filter_upwards [hH] with M hH
  let x : ℝ := (M : ℝ) + 2
  let p : ℝ := A * min b' c' / Real.log 2
  have hx : 0 < x := by dsimp [x]; positivity
  have hMle : (M : ℝ) ≤ x := by dsimp [x]; linarith
  have hHle :
      (twoRegimeHorizon rHi rLo (polylogSwitchRank M) M : ℝ) ≤
        c * Real.log 2 * x := by
    have hMclock : c * (M : ℝ) * Real.log 2 ≤ c * Real.log 2 * x := by
      nlinarith
    exact hH.le.trans hMclock
  have htail := terminalTailBound_polylog_le
    hA hb' hbb' hc' hc2 M
  have htail0 :
      0 ≤ terminalTailBound b b' c' (polylogTerminalRank A M) := by
    unfold terminalTailBound
    have hdy := (weightedTailConstant_pos hc' hc2).le
    have hent := (weightedTailConstant_pos hb' hbb').le
    positivity
  have hxp : x * x ^ (-p) = x ^ (-(p - 1)) := by
    calc
      x * x ^ (-p) = x ^ (1 : ℝ) * x ^ (-p) := by rw [Real.rpow_one]
      _ = x ^ ((1 : ℝ) + (-p)) := (Real.rpow_add hx _ _).symm
      _ = x ^ (-(p - 1)) := by
        congr 1
        ring
  calc
    (twoRegimeHorizon rHi rLo (polylogSwitchRank M) M : ℝ) *
        terminalTailBound b b' c' (polylogTerminalRank A M) ≤
      (c * Real.log 2 * x) *
        (terminalTailPrefactor b b' c' * x ^ (-p)) :=
      mul_le_mul hHle (by simpa [x, p] using htail) htail0
        (mul_nonneg (mul_nonneg hc.le hlog2.le) hx.le)
    _ = c * Real.log 2 * terminalTailPrefactor b b' c' *
        (x * x ^ (-p)) := by ring
    _ = c * Real.log 2 * terminalTailPrefactor b b' c' *
        x ^ (-(p - 1)) := by rw [hxp]
    _ = c * Real.log 2 * terminalTailPrefactor b b' c' *
        (((M : ℝ) + 2) ^
          (-(A * min b' c' / Real.log 2 - 1))) := by
      rfl

/-- Every strict power below the terminal rate after its single horizon loss
is available with the same explicit coefficient. -/
theorem eventually_horizon_mul_terminalTail_polylog_le_power
    {A b b' c' c kappa : ℝ} {rHi rLo : ℚ}
    (hA : 0 < A)
    (hb' : 0 < b') (hbb' : b' < b)
    (hc' : 0 < c') (hc2 : c' < Real.log 2)
    (hrHi0 : 0 ≤ rHi) (hrHi1 : rHi < 1)
    (hrLo0 : 0 ≤ rLo) (hrLo1 : rLo < 1)
    (hlead : 1 / (1 - (rHi : ℝ)) < c * Real.log 2)
    (hkappa : kappa < A * min b' c' / Real.log 2 - 1) :
    ∀ᶠ M : ℕ in atTop,
      (twoRegimeHorizon rHi rLo (polylogSwitchRank M) M : ℝ) *
          terminalTailBound b b' c' (polylogTerminalRank A M) ≤
        c * Real.log 2 * terminalTailPrefactor b b' c' *
          (((M : ℝ) + 2) ^ (-kappa)) := by
  have hbase := eventually_horizon_mul_terminalTail_polylog_le
    hA hb' hbb' hc' hc2 hrHi0 hrHi1 hrLo0 hrLo1 hlead
  have hlog2 : 0 < Real.log 2 := Real.log_pos (by norm_num)
  have hdHi : 0 < 1 - (rHi : ℝ) := by
    have h : (rHi : ℝ) < 1 := by exact_mod_cast hrHi1
    linarith
  have hcLog : 0 < c * Real.log 2 :=
    (div_pos zero_lt_one hdHi).trans hlead
  have hpref0 : 0 ≤ terminalTailPrefactor b b' c' :=
    (terminalTailPrefactor_pos hb' hbb' hc' hc2).le
  filter_upwards [hbase] with M hbase
  have hx1 : 1 ≤ (M : ℝ) + 2 := by
    have hM0 : (0 : ℝ) ≤ (M : ℝ) := Nat.cast_nonneg M
    linarith
  have hpow :
      ((M : ℝ) + 2) ^
          (-(A * min b' c' / Real.log 2 - 1)) ≤
        ((M : ℝ) + 2) ^ (-kappa) :=
    Real.rpow_le_rpow_of_exponent_le hx1 (by linarith)
  exact hbase.trans (mul_le_mul_of_nonneg_left hpow
    (mul_nonneg hcLog.le hpref0))

/-- The quadratic-logarithmic switch terms are superpolynomial after the
same linear horizon loss.  The optional nonnegative offset covers both `S`
and `S + 1` in the five-piece failure profile. -/
theorem eventually_horizon_mul_terminalTail_switch_le_power
    {b b' c' c kappa : ℝ} {rHi rLo : ℚ} (offset : ℕ)
    (hb' : 0 < b') (hbb' : b' < b)
    (hc' : 0 < c') (hc2 : c' < Real.log 2)
    (hrHi0 : 0 ≤ rHi) (hrHi1 : rHi < 1)
    (hrLo0 : 0 ≤ rLo) (hrLo1 : rLo < 1)
    (hlead : 1 / (1 - (rHi : ℝ)) < c * Real.log 2) :
    ∀ᶠ M : ℕ in atTop,
      (twoRegimeHorizon rHi rLo (polylogSwitchRank M) M : ℝ) *
          terminalTailBound b b' c' (polylogSwitchRank M + offset) ≤
        c * Real.log 2 * terminalTailPrefactor b b' c' *
          (((M : ℝ) + 2) ^ (-kappa)) := by
  let d := min b' c'
  have hd : 0 < d := lt_min hb' hc'
  have hlog2 : 0 < Real.log 2 := Real.log_pos (by norm_num)
  have hdHi : 0 < 1 - (rHi : ℝ) := by
    have h : (rHi : ℝ) < 1 := by exact_mod_cast hrHi1
    linarith
  have hcLog : 0 < c * Real.log 2 :=
    (div_pos zero_lt_one hdHi).trans hlead
  have hc : 0 < c := by
    rcases mul_pos_iff.mp hcLog with h | h
    · exact h.1
    · exact False.elim ((not_lt_of_ge hlog2.le) h.2)
  have hpref0 : 0 ≤ terminalTailPrefactor b b' c' :=
    (terminalTailPrefactor_pos hb' hbb' hc' hc2).le
  have hH := eventually_twoRegimeHorizon_lt_shellClock
    hrHi0 hrHi1 hrLo0 hrLo1 hlead
  have hxT : Tendsto (fun M : ℕ => (M : ℝ) + 2) atTop atTop :=
    tendsto_atTop_add_const_right atTop (2 : ℝ)
      tendsto_natCast_atTop_atTop
  have hlogT : Tendsto (fun M : ℕ => Real.log ((M : ℝ) + 2))
      atTop atTop := Real.tendsto_log_atTop.comp hxT
  have hlarge : ∀ᶠ M : ℕ in atTop,
      (kappa + 1) / d ≤ Real.log ((M : ℝ) + 2) :=
    (tendsto_atTop.1 hlogT) ((kappa + 1) / d)
  filter_upwards [hH, hlarge] with M hH hlarge
  let x : ℝ := (M : ℝ) + 2
  let S := polylogSwitchRank M
  have hx : 0 < x := by dsimp [x]; positivity
  have hx1 : 1 ≤ x := by
    dsimp [x]
    have hM0 : (0 : ℝ) ≤ (M : ℝ) := Nat.cast_nonneg M
    linarith
  have hlog0 : 0 ≤ Real.log x := Real.log_nonneg hx1
  have hS : (Real.log x) ^ 2 ≤ (S : ℝ) := by
    simpa [x, S] using polylogSwitchRank_lower M
  have hSoff : (Real.log x) ^ 2 ≤ ((S + offset : ℕ) : ℝ) := by
    have hcast : (S : ℝ) ≤ ((S + offset : ℕ) : ℝ) := by
      exact_mod_cast Nat.le_add_right S offset
    exact hS.trans hcast
  have hExp :
      Real.exp (-(d * ((S + offset : ℕ) : ℝ))) ≤
        Real.exp (-(d * (Real.log x) ^ 2)) := by
    apply Real.exp_le_exp.mpr
    nlinarith
  have hdlog : kappa + 1 ≤ d * Real.log x := by
    have hmul := (div_le_iff₀ hd).mp (by simpa [x] using hlarge)
    nlinarith
  have hdecay :
      x * Real.exp (-(d * (Real.log x) ^ 2)) ≤ x ^ (-kappa) := by
    have hmul := mul_le_mul_of_nonneg_right hdlog hlog0
    calc
      x * Real.exp (-(d * (Real.log x) ^ 2)) =
          Real.exp (Real.log x) *
            Real.exp (-(d * (Real.log x) ^ 2)) := by
        congr 1
        exact (Real.exp_log hx).symm
      _ = Real.exp (Real.log x + -(d * (Real.log x) ^ 2)) := by
        rw [Real.exp_add]
      _ ≤ Real.exp (Real.log x * (-kappa)) := by
        apply Real.exp_le_exp.mpr
        nlinarith [hmul]
      _ = x ^ (-kappa) := (Real.rpow_def_of_pos hx _).symm
  have hHle :
      (twoRegimeHorizon rHi rLo (polylogSwitchRank M) M : ℝ) ≤
        c * Real.log 2 * x := by
    have hMle : (M : ℝ) ≤ x := by dsimp [x]; linarith
    have hMclock : c * (M : ℝ) * Real.log 2 ≤ c * Real.log 2 * x := by
      nlinarith
    exact hH.le.trans hMclock
  have htail := terminalTailBound_le_minRate
    hb' hbb' hc' hc2 (S + offset)
  have htail0 : 0 ≤ terminalTailBound b b' c' (S + offset) := by
    unfold terminalTailBound
    have hdy := (weightedTailConstant_pos hc' hc2).le
    have hent := (weightedTailConstant_pos hb' hbb').le
    positivity
  calc
    (twoRegimeHorizon rHi rLo (polylogSwitchRank M) M : ℝ) *
        terminalTailBound b b' c' (S + offset) ≤
      (c * Real.log 2 * x) *
        (terminalTailPrefactor b b' c' *
          Real.exp (-(d * ((S + offset : ℕ) : ℝ)))) :=
      mul_le_mul hHle (by simpa [d] using htail) htail0
        (mul_nonneg hcLog.le hx.le)
    _ ≤ (c * Real.log 2 * x) *
        (terminalTailPrefactor b b' c' *
          Real.exp (-(d * (Real.log x) ^ 2))) := by
      gcongr
    _ = c * Real.log 2 * terminalTailPrefactor b b' c' *
        (x * Real.exp (-(d * (Real.log x) ^ 2))) := by ring
    _ ≤ c * Real.log 2 * terminalTailPrefactor b b' c' *
        x ^ (-kappa) :=
      mul_le_mul_of_nonneg_left hdecay (mul_nonneg hcLog.le hpref0)
    _ = c * Real.log 2 * terminalTailPrefactor b b' c' *
        (((M : ℝ) + 2) ^ (-kappa)) := by rfl

/-- The entropy-sharp initial-shell term is smaller than every prescribed
power of the outer shell rank.  This is the only term in the five-piece
profile that does not carry the two-regime horizon. -/
theorem eventually_initialEntropyTail_le_power
    {b kappa : ℝ} (hb : 0 < b) (hkappa : 0 ≤ kappa) :
    ∀ᶠ M : ℕ in atTop,
      2 * Real.exp (-((M : ℝ) * b)) ≤
        2 * (((M : ℝ) + 2) ^ (-kappa)) := by
  have hxT : Tendsto (fun M : ℕ => (M : ℝ) + 2) atTop atTop :=
    tendsto_atTop_add_const_right atTop (2 : ℝ)
      tendsto_natCast_atTop_atTop
  let q : ℝ := b / (2 * (kappa + 1))
  have hq : 0 < q := by
    dsimp [q]
    positivity
  have hbound := hxT.eventually (Real.isLittleO_log_id_atTop.bound hq)
  filter_upwards [hbound, eventually_ge_atTop (2 : ℕ)] with M hbound hM
  let x : ℝ := (M : ℝ) + 2
  have hx : 0 < x := by dsimp [x]; positivity
  have hx1 : 1 ≤ x := by
    dsimp [x]
    nlinarith [show (0 : ℝ) ≤ (M : ℝ) from Nat.cast_nonneg M]
  have hlog0 : 0 ≤ Real.log x := Real.log_nonneg hx1
  rw [Real.norm_eq_abs, abs_of_nonneg hlog0] at hbound
  simp only [id_eq, Real.norm_eq_abs, abs_of_nonneg hx.le] at hbound
  have hkq : kappa * q ≤ b / 2 := by
    have hkfrac : kappa / (kappa + 1) ≤ 1 := by
      apply (div_le_one (by linarith)).2
      linarith
    calc
      kappa * q = (b / 2) * (kappa / (kappa + 1)) := by
        dsimp [q]
        field_simp [ne_of_gt (by linarith : 0 < kappa + 1)]
        ring
      _ ≤ (b / 2) * 1 :=
        mul_le_mul_of_nonneg_left hkfrac (by positivity)
      _ = b / 2 := by ring
  have hM2 : (2 : ℝ) ≤ (M : ℝ) := by exact_mod_cast hM
  have hlogM : kappa * Real.log x ≤ b * (M : ℝ) := by
    calc
      kappa * Real.log x ≤ kappa * (q * x) :=
        mul_le_mul_of_nonneg_left hbound hkappa
      _ ≤ (b / 2) * x := by
        simpa [mul_assoc] using mul_le_mul_of_nonneg_right hkq hx.le
      _ ≤ b * (M : ℝ) := by
        dsimp [x]
        nlinarith
  have hdirect : Real.exp (-((M : ℝ) * b)) ≤ x ^ (-kappa) := by
    rw [Real.rpow_def_of_pos hx]
    apply Real.exp_le_exp.mpr
    nlinarith
  exact mul_le_mul_of_nonneg_left hdirect (by norm_num)

/-- The exact scalar right-hand side of the canonical five-piece two-regime
failure profile. -/
def canonicalTwoRegimeTailProfile
    (A bHi bHi' bLo bLo' c' : ℝ)
    (rHi rLo rStar : ℚ) (M : ℕ) : ℝ :=
  let H := twoRegimeHorizon rHi rLo (polylogSwitchRank M) M
  let S := polylogSwitchRank M
  let L := polylogTerminalRank A M
  2 * Real.exp (-((M : ℝ) * bHi)) +
    (H : ℝ) * (1 + 6 / (rStar : ℝ)) *
      terminalTailBound bHi bHi' c' (S + 1) +
    (H : ℝ) * (1 + 6 / (rStar : ℝ)) *
      terminalTailBound bHi bHi' c' S +
    (H : ℝ) * (1 + 6 / (rStar : ℝ)) *
      terminalTailBound bLo bLo' c' S +
    (H : ℝ) * (1 + 6 / (rStar : ℝ)) *
      terminalTailBound bLo bLo' c' L

/-- Explicit coefficient in the canonical fixed-power shell profile. -/
def twoRegimePolylogProfileConstant
    (bHi bHi' bLo bLo' c' c : ℝ) (rStar : ℚ) : ℝ :=
  2 + (1 + 6 / (rStar : ℝ)) * c * Real.log 2 *
    (2 * terminalTailPrefactor bHi bHi' c' +
      2 * terminalTailPrefactor bLo bLo' c')

/-- The complete scalar two-regime terminal profile has every strict power
below the low-rank terminal rate.  The three switch terms are
superpolynomial; the terminal term alone determines the displayed exponent.
-/
theorem eventually_canonicalTwoRegimeTailProfile_le_power
    {A bHi bHi' bLo bLo' c' c kappa : ℝ}
    {rHi rLo rStar : ℚ}
    (hA : 0 < A)
    (hbHi' : 0 < bHi') (hHiRate : bHi' < bHi)
    (hbLo' : 0 < bLo') (hLoRate : bLo' < bLo)
    (hc' : 0 < c') (hc2 : c' < Real.log 2)
    (hrHi0 : 0 ≤ rHi) (hrHi1 : rHi < 1)
    (hrLo0 : 0 ≤ rLo) (hrLo1 : rLo < 1)
    (hrStar : 0 < rStar)
    (hlead : 1 / (1 - (rHi : ℝ)) < c * Real.log 2)
    (hkappa0 : 0 ≤ kappa)
    (hkappa : kappa < A * min bLo' c' / Real.log 2 - 1) :
    ∀ᶠ M : ℕ in atTop,
      canonicalTwoRegimeTailProfile A bHi bHi' bLo bLo' c'
          rHi rLo rStar M ≤
        twoRegimePolylogProfileConstant bHi bHi' bLo bLo' c' c rStar *
          (((M : ℝ) + 2) ^ (-kappa)) := by
  have hInitial := eventually_initialEntropyTail_le_power
    (hbHi'.trans hHiRate) hkappa0
  have hHi1 := eventually_horizon_mul_terminalTail_switch_le_power
    (b := bHi) (b' := bHi') (c' := c') (c := c)
    (kappa := kappa) (rHi := rHi) (rLo := rLo) 1
    hbHi' hHiRate hc' hc2 hrHi0 hrHi1 hrLo0 hrLo1 hlead
  have hHi0 := eventually_horizon_mul_terminalTail_switch_le_power
    (b := bHi) (b' := bHi') (c' := c') (c := c)
    (kappa := kappa) (rHi := rHi) (rLo := rLo) 0
    hbHi' hHiRate hc' hc2 hrHi0 hrHi1 hrLo0 hrLo1 hlead
  have hLo0 := eventually_horizon_mul_terminalTail_switch_le_power
    (b := bLo) (b' := bLo') (c' := c') (c := c)
    (kappa := kappa) (rHi := rHi) (rLo := rLo) 0
    hbLo' hLoRate hc' hc2 hrHi0 hrHi1 hrLo0 hrLo1 hlead
  have hTerminal := eventually_horizon_mul_terminalTail_polylog_le_power
    hA hbLo' hLoRate hc' hc2 hrHi0 hrHi1 hrLo0 hrLo1 hlead hkappa
  filter_upwards [hInitial, hHi1, hHi0, hLo0, hTerminal]
    with M hInitial hHi1 hHi0 hLo0 hTerminal
  let H := twoRegimeHorizon rHi rLo (polylogSwitchRank M) M
  let S := polylogSwitchRank M
  let L := polylogTerminalRank A M
  let x : ℝ := (M : ℝ) + 2
  let qStar : ℝ := 1 + 6 / (rStar : ℝ)
  let pHi : ℝ := c * Real.log 2 * terminalTailPrefactor bHi bHi' c'
  let pLo : ℝ := c * Real.log 2 * terminalTailPrefactor bLo bLo' c'
  have hrStarR : 0 < (rStar : ℝ) := by exact_mod_cast hrStar
  have hqStar : 0 ≤ qStar := by
    dsimp [qStar]
    positivity
  have hHi1' :
      (H : ℝ) * qStar * terminalTailBound bHi bHi' c' (S + 1) ≤
        qStar * pHi * x ^ (-kappa) := by
    calc
      (H : ℝ) * qStar * terminalTailBound bHi bHi' c' (S + 1) =
          qStar * ((H : ℝ) * terminalTailBound bHi bHi' c' (S + 1)) := by ring
      _ ≤ qStar * (pHi * x ^ (-kappa)) := by
        apply mul_le_mul_of_nonneg_left _ hqStar
        simpa [H, S, x, pHi] using hHi1
      _ = qStar * pHi * x ^ (-kappa) := by ring
  have hHi0' :
      (H : ℝ) * qStar * terminalTailBound bHi bHi' c' S ≤
        qStar * pHi * x ^ (-kappa) := by
    calc
      (H : ℝ) * qStar * terminalTailBound bHi bHi' c' S =
          qStar * ((H : ℝ) * terminalTailBound bHi bHi' c' S) := by ring
      _ ≤ qStar * (pHi * x ^ (-kappa)) := by
        apply mul_le_mul_of_nonneg_left _ hqStar
        simpa [H, S, x, pHi] using hHi0
      _ = qStar * pHi * x ^ (-kappa) := by ring
  have hLo0' :
      (H : ℝ) * qStar * terminalTailBound bLo bLo' c' S ≤
        qStar * pLo * x ^ (-kappa) := by
    calc
      (H : ℝ) * qStar * terminalTailBound bLo bLo' c' S =
          qStar * ((H : ℝ) * terminalTailBound bLo bLo' c' S) := by ring
      _ ≤ qStar * (pLo * x ^ (-kappa)) := by
        apply mul_le_mul_of_nonneg_left _ hqStar
        simpa [H, S, x, pLo] using hLo0
      _ = qStar * pLo * x ^ (-kappa) := by ring
  have hTerminal' :
      (H : ℝ) * qStar * terminalTailBound bLo bLo' c' L ≤
        qStar * pLo * x ^ (-kappa) := by
    calc
      (H : ℝ) * qStar * terminalTailBound bLo bLo' c' L =
          qStar * ((H : ℝ) * terminalTailBound bLo bLo' c' L) := by ring
      _ ≤ qStar * (pLo * x ^ (-kappa)) := by
        apply mul_le_mul_of_nonneg_left _ hqStar
        simpa [H, L, x, pLo] using hTerminal
      _ = qStar * pLo * x ^ (-kappa) := by ring
  calc
    canonicalTwoRegimeTailProfile A bHi bHi' bLo bLo' c'
        rHi rLo rStar M =
      2 * Real.exp (-((M : ℝ) * bHi)) +
        (H : ℝ) * qStar * terminalTailBound bHi bHi' c' (S + 1) +
        (H : ℝ) * qStar * terminalTailBound bHi bHi' c' S +
        (H : ℝ) * qStar * terminalTailBound bLo bLo' c' S +
        (H : ℝ) * qStar * terminalTailBound bLo bLo' c' L := by
      rfl
    _ ≤ 2 * x ^ (-kappa) +
        qStar * pHi * x ^ (-kappa) +
        qStar * pHi * x ^ (-kappa) +
        qStar * pLo * x ^ (-kappa) +
        qStar * pLo * x ^ (-kappa) := by
      exact add_le_add (add_le_add (add_le_add (add_le_add
        (by simpa [x] using hInitial) hHi1') hHi0') hLo0') hTerminal'
    _ = twoRegimePolylogProfileConstant bHi bHi' bLo bLo' c' c rStar *
        (((M : ℝ) + 2) ^ (-kappa)) := by
      simp only [twoRegimePolylogProfileConstant, qStar, pHi, pLo, x]
      ring

end

end FirstPassageLinearTransport
