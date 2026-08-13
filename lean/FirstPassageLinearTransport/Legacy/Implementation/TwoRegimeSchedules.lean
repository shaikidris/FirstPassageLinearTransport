/-
Copyright (c) 2026 Idris Ali Shaik. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Idris Ali Shaik
-/
import Mathlib.Analysis.SpecialFunctions.Pow.Asymptotics
import FirstPassageLinearTransport.PolylogTerminalSchedule
import FirstPassageLinearTransport.RankTransportAsymptotics
import FirstPassageLinearTransport.TwoRegimeClock

import FirstPassageLinearTransport.Extras.Unreachable
/-!
# Polylogarithmic two-regime schedules

This module fixes the terminal and switch ranks used by the optimized
first-passage theorem and discharges the eventual rank-transport startup.
It contains only scalar schedule facts; density and orbit assembly remain in
separate modules.
-/

namespace FirstPassageLinearTransport

open Filter
open scoped Real Topology

noncomputable section

/-- High/low switch schedule. -/
def polylogSwitchRank (M : ℕ) : ℕ :=
  ⌈(Real.log ((M : ℝ) + 2)) ^ 2⌉₊

theorem polylogSwitchRank_lower (M : ℕ) :
    (Real.log ((M : ℝ) + 2)) ^ 2 ≤
      (polylogSwitchRank M : ℝ) := by
  exact Nat.le_ceil _

theorem polylogSwitchRank_lt_add_one (M : ℕ) :
    (polylogSwitchRank M : ℝ) <
      (Real.log ((M : ℝ) + 2)) ^ 2 + 1 := by
  exact Nat.ceil_lt_add_one (sq_nonneg _)

/-- The quadratic-logarithmic regime switch diverges with the source shell
rank. -/
theorem tendsto_polylogSwitchRank_atTop :
    Tendsto polylogSwitchRank atTop atTop := by
  have hxT : Tendsto (fun M : ℕ => (M : ℝ) + 2) atTop atTop :=
    tendsto_atTop_add_const_right atTop (2 : ℝ)
      tendsto_natCast_atTop_atTop
  have hlogT : Tendsto (fun M : ℕ => Real.log ((M : ℝ) + 2))
      atTop atTop := Real.tendsto_log_atTop.comp hxT
  have hsq : Tendsto (fun M : ℕ => (Real.log ((M : ℝ) + 2)) ^ 2)
      atTop atTop :=
    (tendsto_pow_atTop (by norm_num : (2 : ℕ) ≠ 0)).comp hlogT
  rw [tendsto_atTop]
  intro N
  have hN := (tendsto_atTop.1 hsq) (N : ℝ)
  filter_upwards [hN] with M hN
  have hceil := polylogSwitchRank_lower M
  have hcast : (N : ℝ) ≤ (polylogSwitchRank M : ℝ) :=
    hN.trans hceil
  exact_mod_cast hcast

/-- The quadratic-logarithmic switch eventually lies strictly below the
source shell rank. -/
theorem eventually_polylogSwitchRank_lt_source :
    ∀ᶠ M : ℕ in atTop, polylogSwitchRank M < M := by
  have hxT : Tendsto (fun M : ℕ => (M : ℝ) + 2) atTop atTop :=
    tendsto_atTop_add_const_right atTop (2 : ℝ)
      tendsto_natCast_atTop_atTop
  have hsmallReal :=
    (Real.isLittleO_pow_log_id_atTop (n := 2)).bound
      (show (0 : ℝ) < 1 / 4 by norm_num)
  have hsmall := hxT.eventually hsmallReal
  filter_upwards [hsmall, eventually_ge_atTop (3 : ℕ)] with M hsmall hM
  have hx0 : 0 ≤ (M : ℝ) + 2 := by positivity
  have hlogSq0 : 0 ≤ (Real.log ((M : ℝ) + 2)) ^ 2 := sq_nonneg _
  rw [Real.norm_eq_abs, abs_of_nonneg hlogSq0] at hsmall
  simp only [id_eq, Real.norm_eq_abs, abs_of_nonneg hx0] at hsmall
  have hreal :
      (polylogSwitchRank M : ℝ) < (M : ℝ) := by
    calc
      (polylogSwitchRank M : ℝ) <
          (Real.log ((M : ℝ) + 2)) ^ 2 + 1 :=
        polylogSwitchRank_lt_add_one M
      _ ≤ (1 / 4 : ℝ) * ((M : ℝ) + 2) + 1 := by linarith
      _ < (M : ℝ) := by
        have hM3 : (3 : ℝ) ≤ (M : ℝ) := by exact_mod_cast hM
        linarith
  exact_mod_cast hreal

/-- Every fixed positive polylogarithmic terminal schedule eventually lies
strictly below the quadratic-logarithmic regime switch. -/
theorem eventually_polylogTerminalRank_lt_switchRank
    {A : ℝ} (hA : 0 < A) :
    ∀ᶠ M : ℕ in atTop,
      polylogTerminalRank A M < polylogSwitchRank M := by
  have hxT : Tendsto (fun M : ℕ => (M : ℝ) + 2) atTop atTop :=
    tendsto_atTop_add_const_right atTop (2 : ℝ)
      tendsto_natCast_atTop_atTop
  have hlogT : Tendsto (fun M : ℕ => Real.log ((M : ℝ) + 2))
      atTop atTop := Real.tendsto_log_atTop.comp hxT
  let C := A / Real.log 2
  have hC0 : 0 < C := by
    dsimp [C]
    exact div_pos hA (Real.log_pos (by norm_num))
  have hlarge : ∀ᶠ M : ℕ in atTop,
      C + 2 < Real.log ((M : ℝ) + 2) := by
    filter_upwards [(tendsto_atTop.1 hlogT) (C + 3)] with M hM
    linarith
  filter_upwards [hlarge] with M hlarge
  let y := Real.log ((M : ℝ) + 2)
  have hy : C + 2 < y := by simpa [y] using hlarge
  have hterminal :
      (polylogTerminalRank A M : ℝ) < C * y + 1 := by
    calc
      (polylogTerminalRank A M : ℝ) <
          A * Real.logb 2 ((M : ℝ) + 2) + 1 :=
        polylogTerminalRank_lt_add_one hA.le M
      _ = C * y + 1 := by
        simp only [Real.logb, C, y]
        field_simp [ne_of_gt (Real.log_pos (by norm_num : (1 : ℝ) < 2))]
  have hquad : C * y + 1 < y ^ 2 := by
    nlinarith
  have hswitch : y ^ 2 ≤ (polylogSwitchRank M : ℝ) := by
    simpa [y] using polylogSwitchRank_lower M
  have hreal :
      (polylogTerminalRank A M : ℝ) <
        (polylogSwitchRank M : ℝ) :=
    hterminal.trans (hquad.trans_le hswitch)
  exact_mod_cast hreal

/-- A fixed local envelope exponent at the quadratic-logarithmic switch is
eventually absorbed by every positive power margin of the outer shell. -/
theorem eventually_polylogSwitchRank_envelope_le_shellMargin
    {t beta : ℝ} (ht : 0 ≤ t) (hbeta : 0 < beta) :
    ∀ᶠ M : ℕ in atTop,
      (polylogSwitchRank M : ℝ) * (1 + t) ≤ beta * (M : ℝ) := by
  let u : ℝ := 1 + t
  have hu : 0 < u := by dsimp [u]; linarith
  let q : ℝ := beta / (4 * u)
  have hq : 0 < q := by dsimp [q]; positivity
  have hxT : Tendsto (fun M : ℕ => (M : ℝ) + 2) atTop atTop :=
    tendsto_atTop_add_const_right atTop (2 : ℝ)
      tendsto_natCast_atTop_atTop
  have hsmallReal :=
    (Real.isLittleO_pow_log_id_atTop (n := 2)).bound hq
  have hsmall := hxT.eventually hsmallReal
  have hlinT : Tendsto (fun M : ℕ => (3 * beta / 4) * (M : ℝ))
      atTop atTop :=
    tendsto_natCast_atTop_atTop.const_mul_atTop (by positivity)
  have hlarge : ∀ᶠ M : ℕ in atTop,
      beta / 2 + u < (3 * beta / 4) * (M : ℝ) := by
    filter_upwards [(tendsto_atTop.1 hlinT) (beta / 2 + u + 1)]
      with M hM
    linarith
  filter_upwards [hsmall, hlarge] with M hsmall hlarge
  have hx0 : 0 ≤ (M : ℝ) + 2 := by positivity
  have hlogSq0 : 0 ≤ (Real.log ((M : ℝ) + 2)) ^ 2 := sq_nonneg _
  rw [Real.norm_eq_abs, abs_of_nonneg hlogSq0] at hsmall
  simp only [id_eq, Real.norm_eq_abs, abs_of_nonneg hx0] at hsmall
  have hswitch := polylogSwitchRank_lt_add_one M
  have hqId : q * u = beta / 4 := by
    dsimp [q]
    field_simp [ne_of_gt hu]
    ring
  apply le_of_lt
  calc
    (polylogSwitchRank M : ℝ) * (1 + t) =
        (polylogSwitchRank M : ℝ) * u := by rfl
    _ < ((Real.log ((M : ℝ) + 2)) ^ 2 + 1) * u :=
      mul_lt_mul_of_pos_right hswitch hu
    _ ≤ (q * ((M : ℝ) + 2) + 1) * u := by
      exact mul_le_mul_of_nonneg_right (by linarith) hu.le
    _ = (q * u) * ((M : ℝ) + 2) + u := by ring
    _ = beta / 4 * ((M : ℝ) + 2) + u := by rw [hqId]
    _ < beta * (M : ℝ) := by
      nlinarith

/-- If the high-rank geometric slope is strictly below the requested shell
clock, then the canonical two-regime horizon eventually fits that clock.  The
low-rank phase contributes only the quadratic-logarithmic switch cost. -/
theorem eventually_twoRegimeHorizon_lt_shellClock
    {rHi rLo : ℚ} {c : ℝ}
    (hrHi0 : 0 ≤ rHi) (hrHi1 : rHi < 1)
    (hrLo0 : 0 ≤ rLo) (hrLo1 : rLo < 1)
    (hlead : 1 / (1 - (rHi : ℝ)) < c * Real.log 2) :
    ∀ᶠ M : ℕ in atTop,
      (twoRegimeHorizon rHi rLo (polylogSwitchRank M) M : ℝ) <
        c * (M : ℝ) * Real.log 2 := by
  let dHi : ℝ := 1 - (rHi : ℝ)
  let dLo : ℝ := 1 - (rLo : ℝ)
  have hdHi : 0 < dHi := by
    dsimp [dHi]
    have h : (rHi : ℝ) < 1 := by exact_mod_cast hrHi1
    linarith
  have hdLo : 0 < dLo := by
    dsimp [dLo]
    have h : (rLo : ℝ) < 1 := by exact_mod_cast hrLo1
    linarith
  let g : ℝ := c * Real.log 2 - 1 / dHi
  have hg : 0 < g := by
    dsimp [g, dHi]
    linarith
  let q : ℝ := g * dLo / 4
  have hq : 0 < q := by
    dsimp [q]
    positivity
  have hxT : Tendsto (fun M : ℕ => (M : ℝ) + 2) atTop atTop :=
    tendsto_atTop_add_const_right atTop (2 : ℝ)
      tendsto_natCast_atTop_atTop
  have hsmallReal :=
    (Real.isLittleO_pow_log_id_atTop (n := 2)).bound hq
  have hsmall := hxT.eventually hsmallReal
  have hlinT : Tendsto (fun M : ℕ => (3 * g / 4) * (M : ℝ))
      atTop atTop :=
    tendsto_natCast_atTop_atTop.const_mul_atTop (by positivity)
  have hlarge : ∀ᶠ M : ℕ in atTop,
      g / 2 + 1 / dLo + 1 < (3 * g / 4) * (M : ℝ) := by
    filter_upwards [(tendsto_atTop.1 hlinT) (g / 2 + 1 / dLo + 2)]
      with M hM
    linarith
  filter_upwards [hsmall, hlarge] with M hsmall hlarge
  have hx0 : 0 ≤ (M : ℝ) + 2 := by positivity
  have hlogSq0 : 0 ≤ (Real.log ((M : ℝ) + 2)) ^ 2 := sq_nonneg _
  rw [Real.norm_eq_abs, abs_of_nonneg hlogSq0] at hsmall
  simp only [id_eq, Real.norm_eq_abs, abs_of_nonneg hx0] at hsmall
  have hSdiv :
      (polylogSwitchRank M : ℝ) / dLo <
        g / 4 * ((M : ℝ) + 2) + 1 / dLo := by
    have hS := polylogSwitchRank_lt_add_one M
    have hSd :
        (polylogSwitchRank M : ℝ) / dLo <
          ((Real.log ((M : ℝ) + 2)) ^ 2 + 1) / dLo :=
      (div_lt_div_iff_of_pos_right hdLo).2 hS
    have hqd : q / dLo = g / 4 := by
      dsimp [q]
      field_simp [ne_of_gt hdLo]
      ring
    calc
      (polylogSwitchRank M : ℝ) / dLo <
          ((Real.log ((M : ℝ) + 2)) ^ 2 + 1) / dLo := hSd
      _ ≤ (q * ((M : ℝ) + 2) + 1) / dLo := by
        exact (div_le_div_iff_of_pos_right hdLo).2 (by linarith)
      _ = g / 4 * ((M : ℝ) + 2) + 1 / dLo := by
        rw [add_div]
        calc
          q * ((M : ℝ) + 2) / dLo + 1 / dLo =
              (q / dLo) * ((M : ℝ) + 2) + 1 / dLo := by ring
          _ = g / 4 * ((M : ℝ) + 2) + 1 / dLo := by rw [hqd]
  have hHi0 : 0 ≤ (rHi : ℝ) := by exact_mod_cast hrHi0
  have hLo0 : 0 ≤ (rLo : ℝ) := by exact_mod_cast hrLo0
  have hbudget0 :
      0 ≤ (M : ℝ) / (1 - (rHi : ℝ)) +
        (polylogSwitchRank M : ℝ) / (1 - (rLo : ℝ)) := by
    positivity
  have hceil :
      (twoRegimeHorizon rHi rLo (polylogSwitchRank M) M : ℝ) <
        (M : ℝ) / dHi + (polylogSwitchRank M : ℝ) / dLo + 1 := by
    simpa [twoRegimeHorizon, dHi, dLo] using
      Nat.ceil_lt_add_one hbudget0
  have hid : 1 / dHi + g = c * Real.log 2 := by
    dsimp [g]
    ring
  calc
    (twoRegimeHorizon rHi rLo (polylogSwitchRank M) M : ℝ) <
        (M : ℝ) / dHi + (polylogSwitchRank M : ℝ) / dLo + 1 := hceil
    _ < (M : ℝ) / dHi +
        (g / 4 * ((M : ℝ) + 2) + 1 / dLo) + 1 := by
      linarith
    _ < (M : ℝ) / dHi + g * (M : ℝ) := by
      nlinarith
    _ = (1 / dHi + g) * (M : ℝ) := by ring
    _ = c * (M : ℝ) * Real.log 2 := by
      rw [hid]
      ring

end

end FirstPassageLinearTransport
