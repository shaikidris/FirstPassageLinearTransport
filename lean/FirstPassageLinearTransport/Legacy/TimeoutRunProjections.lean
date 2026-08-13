/-
Copyright (c) 2026 Idris Ali Shaik. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Idris Ali Shaik
-/
import FirstPassageLinearTransport.TimeoutRun

import FirstPassageLinearTransport.Extras.Unreachable
/-!
# Legacy timeout-run projection API

Convenience projections retained for compatibility with exploratory clients.
They are not dependencies of the canonical timeout theorem.
-/

namespace FirstPassageLinearTransport

noncomputable section

@[simp] theorem ShrinkingBarrierRunData.toTimeoutHigh_rHi
    (P : ShrinkingBarrierRunData) : P.toTimeoutHigh.rHi = P.rHi := rfl

@[simp] theorem ShrinkingBarrierRunData.toTimeoutHigh_tau
    (P : ShrinkingBarrierRunData) : P.toTimeoutHigh.tau = P.tau := rfl

@[simp] theorem ShrinkingBarrierRunData.toTimeoutHigh_D
    (P : ShrinkingBarrierRunData) : P.toTimeoutHigh.D = P.D := rfl

@[simp] theorem ShrinkingBarrierRunData.toTimeoutHigh_pHi
    (P : ShrinkingBarrierRunData) : P.toTimeoutHigh.pHi = P.pHi := rfl

@[simp] theorem ShrinkingBarrierRunData.toTimeoutHigh_tolerance
    (P : ShrinkingBarrierRunData) (M m : ℕ) :
    timeoutHighTolerance P.toTimeoutHigh M m =
      shrinkingHighTolerance P M m := rfl

@[simp] theorem timeoutHighSetup_M0
    (P : TimeoutHighRunData) (M m : ℕ) :
    (timeoutHighSetup P M m).M0 = P.pHi.M0 := rfl

end

end FirstPassageLinearTransport
