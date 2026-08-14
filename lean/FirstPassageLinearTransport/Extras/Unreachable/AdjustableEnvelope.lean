/-
Copyright (c) 2026 Idris Ali Shaik. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Idris Ali Shaik
-/
/- Generated source-preserving extraction: declarations in this module are outside the canonical referee-facing roots. -/
import FirstPassageLinearTransport.EntropyBarrier
import FirstPassageLinearTransport.Envelope

import FirstPassageLinearTransport.AdjustableEnvelope
/-!
# Adjustable maximal-barrier envelope

This module separates the deterministic orbit-envelope payload from the
scalar startup inequalities used by the entropy-sharp barrier.  No density or
independence hypothesis is introduced.
-/

namespace FirstPassageLinearTransport

open scoped Real

noncomputable section


theorem adjustableBarrierHeight_nonneg
    {lambda t : ℝ} {M : ℕ} (hlambda : 0 ≤ lambda) (ht : 0 ≤ t) :
    0 ≤ adjustableBarrierHeight lambda t M := by
  unfold adjustableBarrierHeight
  exact div_nonneg
    (mul_nonneg (mul_nonneg hlambda ht) (Nat.cast_nonneg M))
    logTwoThree_pos.le








end

end FirstPassageLinearTransport
