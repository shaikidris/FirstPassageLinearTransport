/-
Copyright (c) 2026 Idris Ali Shaik. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Idris Ali Shaik
-/
/- Generated source-preserving extraction: declarations in this module are outside the canonical referee-facing roots. -/
import FirstPassageLinearTransport.AdjustableBarrierDensity
import FirstPassageLinearTransport.RankScaledLoss

import FirstPassageLinearTransport.FirstBadEnvelope
/-!
# Exact first-bad landing envelope

This module performs the finite union used by the optimized terminal profile.
It keeps the bad-target cardinality at each landing rank explicit.  The
separate semantic step that puts every recursively generated first failure in
this envelope is not assumed here.
-/

namespace FirstPassageLinearTransport

open scoped BigOperators

noncomputable section










/-- Initial certification failures together with every possible transported
first-bad landing. -/
noncomputable def firstBadFailureEnvelope
    (M L U H : ℕ) (r : ℚ) (t : ℝ) : Finset ℕ :=
  shellInitialWindowBad M t ∪ firstBadLandingEnvelope M L U H r t

theorem firstBadFailureEnvelope_card_le
    {M L U H : ℕ} {r : ℚ} (t : ℝ)
    (hr : 0 < r) (hUM : U < M)
    (hsmall : ∀ q ∈ Finset.Icc L U,
      ((((q + 2 : ℕ) : ℚ) / r) / ((2 ^ q : ℕ) : ℚ)) ≤ 1 / 3) :
    ((firstBadFailureEnvelope M L U H r t).card : ℚ) ≤
      ((shellInitialWindowBad M t).card : ℚ) +
        ∑ q in Finset.Icc L U,
          (H : ℚ) * (1 + 3 * (((q + 2 : ℕ) : ℚ) / r)) *
            (2 : ℚ) ^ M / (2 : ℚ) ^ q *
              ((landingBad q t).card : ℚ) := by
  have hunion := Finset.card_union_le
    (shellInitialWindowBad M t) (firstBadLandingEnvelope M L U H r t)
  have hunionQ :
      ((firstBadFailureEnvelope M L U H r t).card : ℚ) ≤
        ((shellInitialWindowBad M t).card : ℚ) +
          ((firstBadLandingEnvelope M L U H r t).card : ℚ) := by
    unfold firstBadFailureEnvelope
    exact_mod_cast hunion
  exact hunionQ.trans (add_le_add_left
    (firstBadLandingEnvelope_card_le t hr hUM hsmall) _)






end

end FirstPassageLinearTransport
