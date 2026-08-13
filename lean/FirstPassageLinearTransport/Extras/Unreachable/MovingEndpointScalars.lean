/-
Copyright (c) 2026 Idris Ali Shaik. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Idris Ali Shaik
-/
/- Generated source-preserving extraction: declarations in this module are outside the canonical referee-facing roots. -/
import FirstPassageLinearTransport.ShrinkingParameters
import FirstPassageLinearTransport.VaryingDensity

import FirstPassageLinearTransport.MovingEndpointScalars
/-!
# Scalar schedules for the moving polylogarithmic endpoint

This module formalizes the integer terminal rank and the critical entropy
buffer used by a shell-dependent exponent profile.  It contains no Collatz
transport estimate: the moving low-barrier density theorem is a separate
analytic input that must be proved before the public headline is assembled.
-/

namespace FirstPassageLinearTransport

open Filter
open scoped Real Topology

noncomputable section



theorem timeSupportCriticalExponent_mul_entropyGap :
    timeSupportCriticalExponent * firstPassageEntropyGap = 1 / 2 := by
  rw [timeSupportCriticalExponent_eq_entropy]
  change 1 / (2 * firstPassageEntropyGap) * firstPassageEntropyGap = 1 / 2
  field_simp [ne_of_gt firstPassageEntropyGap_pos]
  ring



theorem movingTerminalRank_lower (A : ℕ → ℝ) (M : ℕ) :
    A M * Real.logb 2 ((M : ℝ) + 2) ≤
      (movingTerminalRank A M : ℝ) := by
  exact Nat.le_ceil _












end

end FirstPassageLinearTransport
