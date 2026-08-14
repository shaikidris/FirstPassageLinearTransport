/-
Copyright (c) 2026 Idris Ali Shaik. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Idris Ali Shaik
-/
/- Generated source-preserving extraction: declarations in this module are outside the canonical referee-facing roots. -/
import FirstPassageLinearTransport.ShrinkingTimeSupport
import FirstPassageLinearTransport.PolylogTerminalSchedule
import FirstPassageLinearTransport.TwoRegimeClock

import FirstPassageLinearTransport.ShrinkingSchedules
/-!
# Scalar schedules for shrinking-barrier transport

The switch is linear in `log (M+2)`, while the terminal rank is linear in
`logb 2 (M+2)`.  This file proves the exact finite inequalities behind the
paper's `O(sqrt (M log M))` feasible-time support.  No density estimate is
used here.
-/

namespace FirstPassageLinearTransport

open Filter
open scoped Real Topology

noncomputable section





theorem tendsto_shrinkingSwitchRank_atTop
    {C : ℝ} (hC : 0 < C) :
    Tendsto (shrinkingSwitchRank C) atTop atTop := by
  have hxT : Tendsto (fun M : ℕ => (M : ℝ) + 2) atTop atTop :=
    tendsto_atTop_add_const_right atTop (2 : ℝ)
      tendsto_natCast_atTop_atTop
  have hlogT : Tendsto (fun M : ℕ => Real.log ((M : ℝ) + 2))
      atTop atTop := Real.tendsto_log_atTop.comp hxT
  have hreal : Tendsto
      (fun M : ℕ => C * Real.log ((M : ℝ) + 2)) atTop atTop :=
    hlogT.const_mul_atTop hC
  rw [tendsto_atTop]
  intro N
  have hN := (tendsto_atTop.1 hreal) (N : ℝ)
  filter_upwards [hN] with M hN
  exact_mod_cast hN.trans (shrinkingSwitchRank_lower C M)





private theorem log_le_sqrt_mul
    {x : ℝ} (hx : 1 ≤ x) :
    Real.log x ≤ Real.sqrt (x * Real.log x) := by
  have hlog0 : 0 ≤ Real.log x := Real.log_nonneg hx
  have hlogx : Real.log x ≤ x := (Real.log_le_sub_one_of_pos (lt_of_lt_of_le zero_lt_one hx)).trans (by linarith)
  have hsqrt0 := Real.sqrt_nonneg (x * Real.log x)
  have hsqrtSq := Real.sq_sqrt (mul_nonneg (zero_le_one.trans hx) hlog0)
  have hsq : Real.log x * Real.log x ≤ x * Real.log x :=
    mul_le_mul_of_nonneg_right hlogx hlog0
  nlinarith





end

end FirstPassageLinearTransport
