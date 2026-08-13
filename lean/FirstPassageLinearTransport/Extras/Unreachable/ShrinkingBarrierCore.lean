/-
Copyright (c) 2026 Idris Ali Shaik. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Idris Ali Shaik
-/
/- Generated source-preserving extraction: declarations in this module are outside the canonical referee-facing roots. -/
import FirstPassageLinearTransport.Parameters
import FirstPassageLinearTransport.TimeSupportTransport

import FirstPassageLinearTransport.ShrinkingBarrierCore
/-!
# Deterministic core of the shrinking-barrier schedule

This module contains the three exact facts on which feasible-time compression
rests: a fixed stage package may be restricted to a smaller tolerance, powers
of two are not certified, and a certified first-passage block has a narrow
duration corridor.
-/

namespace FirstPassageLinearTransport

open scoped Real

noncomputable section









/-- Width of the real duration corridor before division by the positive
central drift gap. -/
theorem duration_corridor_linear_width
    (t : ℝ) (m q : ℕ) :
    ((1 + t) * ((m : ℝ) + 1) - (q : ℝ) + 1) -
        ((1 - t) * (m : ℝ) - (q : ℝ)) =
      2 * t * (m : ℝ) + t + 2 := by
  ring

end

end FirstPassageLinearTransport
