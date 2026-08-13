/-
Copyright (c) 2026 Idris Ali Shaik. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Idris Ali Shaik
-/
import FirstPassageLinearTransport.MovingEndpointParameters
import FirstPassageLinearTransport.Alternates.AllPrefix.Implementation.MovingLowSetup

import FirstPassageLinearTransport.Extras.Unreachable
/-!
# All-prefix moving low-stage package

Compatibility adapter used only by the retained all-prefix realization.  It
is intentionally outside the canonical timeout theorem's import closure.
-/

namespace FirstPassageLinearTransport

open Filter

/-- The moving low-stage package together with the exact startup bound used
by the all-prefix continuation step. -/
def MovingLowStagePackage
    {Amax c beta : ℝ}
    (P : MovingEndpointParameterPackage Amax c beta) (L : ℕ) :=
  {p : StageSetup (movingLowRatio P.K₀ L) (movingLowTolerance P.K₀ L) //
    p.M0 ≤ L}

/-- The quantitative moving startup produces a usable all-prefix low-stage
package at every sufficiently large terminal rank. -/
theorem MovingEndpointParameterPackage.eventually_lowStagePackage
    {Amax c beta : ℝ} (P : MovingEndpointParameterPackage Amax c beta) :
    ∀ᶠ L : ℕ in atTop, Nonempty (MovingLowStagePackage P L) := by
  filter_upwards [eventually_movingLowStageSetup_M0_le P.K₀_gt_six]
    with L hL
  rcases hL with ⟨p, hp⟩
  exact ⟨⟨p, hp⟩⟩

end FirstPassageLinearTransport
