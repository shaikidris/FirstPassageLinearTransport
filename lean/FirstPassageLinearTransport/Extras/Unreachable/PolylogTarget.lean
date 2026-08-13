/-
Copyright (c) 2026 Idris Ali Shaik. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Idris Ali Shaik
-/
/- Generated source-preserving extraction: declarations in this module are outside the canonical referee-facing roots. -/
import FirstPassageLinearTransport.Basic

import FirstPassageLinearTransport.PolylogTarget
/-!
# Shell-to-logarithm target conversion

Shared scalar conversions from a dyadic-shell clock and terminal target to
the natural-logarithm normalization used by the public theorems.  These
lemmas are independent of any particular recertification execution.
-/

namespace FirstPassageLinearTransport

open Filter
open scoped Real Topology

noncomputable section


theorem fixedPolylogTargetConstant_pos (A : ℝ) :
    0 < fixedPolylogTargetConstant A := by
  unfold fixedPolylogTargetConstant
  have hbase : 0 < 1 / Real.log 2 + 2 := by
    positivity
  exact mul_pos (by norm_num) (Real.rpow_pos_of_pos hbase A)



end

end FirstPassageLinearTransport
