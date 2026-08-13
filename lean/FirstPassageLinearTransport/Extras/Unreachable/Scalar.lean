/-
Copyright (c) 2026 Idris Ali Shaik. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Idris Ali Shaik
-/
/- Generated source-preserving extraction: declarations in this module are outside the canonical referee-facing roots. -/
import FirstPassageLinearTransport.Bootstrap

import FirstPassageLinearTransport.Scalar
/-!
# Scalar asymptotics for the logarithmic stage schedule
-/

namespace FirstPassageLinearTransport

open scoped Real Topology BigOperators
open Filter Asymptotics

noncomputable section





theorem stageCount_tendsto_atTop {omega : ℝ} (homega : 0 < omega) :
    Tendsto (stageCount omega) atTop atTop := by
  unfold stageCount
  have hcast : Tendsto (fun M : ℕ => (M : ℝ)) atTop atTop :=
    tendsto_natCast_atTop_atTop
  have hadd : Tendsto (fun M : ℕ => (M : ℝ) + 4) atTop atTop :=
    tendsto_atTop_add_const_right atTop (4 : ℝ) hcast
  have hlog : Tendsto (fun M : ℕ => Real.log ((M : ℝ) + 4))
      atTop atTop := Real.tendsto_log_atTop.comp hadd
  exact tendsto_nat_floor_atTop.comp (hlog.const_mul_atTop homega)

end

end FirstPassageLinearTransport
