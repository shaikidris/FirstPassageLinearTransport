/-
Copyright (c) 2026 Idris Ali Shaik. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Idris Ali Shaik
-/
/- Generated source-preserving extraction: declarations in this module are outside the canonical referee-facing roots. -/
import FirstPassageLinearTransport.RawClockBudget
import FirstPassageLinearTransport.NaturalDensityDescent

import FirstPassageLinearTransport.RawNaturalDensityDescent
/-!
# Raw-clock natural-density descent

Parameter selection and global assembly for the literal raw Collatz clock
`261/25 = 10.44`.
-/

namespace FirstPassageLinearTransport

open Filter
open scoped Real Topology

noncomputable section

/-- The central raw-clock constant is strictly below `10.44`. -/
theorem centralRawClock_lt_261_div_25 :
    3 / Real.log (4 / 3) < (261 / 25 : ℝ) := by
  have hlog := log_four_thirds_gt_296_div_1029
  have hlogPos : 0 < Real.log (4 / 3) := Real.log_pos (by norm_num)
  apply (div_lt_iff₀ hlogPos).2
  have hrat : (3 : ℝ) < (261 / 25 : ℝ) * (296 / 1029) := by
    norm_num
  exact hrat.trans (mul_lt_mul_of_pos_left hlog (by norm_num))



end

end FirstPassageLinearTransport
