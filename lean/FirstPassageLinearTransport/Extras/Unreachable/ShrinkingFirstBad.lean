/-
Copyright (c) 2026 Idris Ali Shaik. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Idris Ali Shaik
-/
/- Generated source-preserving extraction: declarations in this module are outside the canonical referee-facing roots. -/
import FirstPassageLinearTransport.ShrinkingSchedules
import FirstPassageLinearTransport.TimeSupportTransport

import FirstPassageLinearTransport.ShrinkingFirstBad
/-!
# First-bad sources for the shrinking-barrier chain

This is the semantic-to-counting cut vertex.  A failed endpoint of a literal
shrinking run is a direct first passage of the original source, has the
rank-scaled reverse-loss budget, and uses a cumulative time from the compressed
support.  The result is an exact subset of the support-sensitive transport
set; no generated-distribution hypothesis is introduced.
-/

namespace FirstPassageLinearTransport

open scoped BigOperators

noncomputable section






/-- The shrinking first-bad envelope, with the positive union taken only
after every literal rank target has been formed. -/
noncomputable def shrinkingFailureEnvelope
    (P : ShrinkingBarrierRunData) (M L S : ℕ) : Finset ℕ := by
  classical
  exact shellInitialWindowBad M (shrinkingHighTolerance P M M) ∪
    (Finset.Icc L (M - 1)).biUnion fun q =>
      shrinkingFirstBadSourcesAtRank P M S q

/-- Exact finite union bound for the shrinking first-bad envelope. -/
theorem shrinkingFailureEnvelope_card_le
    (P : ShrinkingBarrierRunData) (M L S : ℕ) :
    (shrinkingFailureEnvelope P M L S).card ≤
      (shellInitialWindowBad M (shrinkingHighTolerance P M M)).card +
        ∑ q in Finset.Icc L (M - 1),
          (shrinkingFirstBadSourcesAtRank P M S q).card := by
  classical
  unfold shrinkingFailureEnvelope
  exact (Finset.card_union_le _ _).trans
    (Nat.add_le_add_left
      (card_biUnion_le_sum (Finset.Icc L (M - 1)) fun q =>
        shrinkingFirstBadSourcesAtRank P M S q) _)

/-- Real-valued aggregate bound obtained by summing the exact rankwise
support-sensitive estimates. -/
theorem shrinkingFailureEnvelope_card_real_le
    (P : ShrinkingBarrierRunData) {M L S : ℕ}
    (hL1 : 1 ≤ L)
    (hsmall : ∀ q ∈ Finset.Icc L (M - 1),
      ((((q + 2 : ℕ) : ℚ) / P.rStar) /
        ((2 ^ q : ℕ) : ℚ)) ≤ 1 / 3) :
    ((shrinkingFailureEnvelope P M L S).card : ℝ) ≤
      ((shellInitialWindowBad M (shrinkingHighTolerance P M M)).card : ℝ) +
        ∑ q in Finset.Icc L (M - 1),
          ((shrinkingFeasibleTimes P M S q).card : ℝ) *
            (1 + 3 * (((q + 2 : ℕ) : ℝ) / (P.rStar : ℝ))) *
              (2 : ℝ) ^ M / (2 : ℝ) ^ q *
            ((landingBad q (shrinkingTargetTolerance P M S q)).card : ℝ) := by
  have hcardNat := shrinkingFailureEnvelope_card_le P M L S
  have hcardReal :
      ((shrinkingFailureEnvelope P M L S).card : ℝ) ≤
        ((shellInitialWindowBad M (shrinkingHighTolerance P M M)).card : ℝ) +
          ∑ q in Finset.Icc L (M - 1),
            ((shrinkingFirstBadSourcesAtRank P M S q).card : ℝ) := by
    exact_mod_cast hcardNat
  apply hcardReal.trans
  apply add_le_add_left
  apply Finset.sum_le_sum
  intro q hq
  have hqBound := shrinkingFirstBadSourcesAtRank_card_le P
    (M := M) (S := S) (q := q)
    (by
      have hqi := Finset.mem_Icc.mp hq
      have hq1 := hL1.trans hqi.1
      omega)
    (hsmall q hq)
  exact_mod_cast hqBound

end

end FirstPassageLinearTransport
