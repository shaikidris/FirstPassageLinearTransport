/-
Copyright (c) 2026 Idris Ali Shaik. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Idris Ali Shaik
-/
import FirstPassageLinearTransport.ShrinkingSchedules
import FirstPassageLinearTransport.TimeSupportTransport

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

/-- Certification tolerance selected by the parent shell `q-1` of a landing
at threshold rank `q`. -/
def shrinkingTargetTolerance
    (P : ShrinkingBarrierRunData) (M S q : ℕ) : ℝ :=
  if S ≤ q - 1 then shrinkingHighTolerance P M (q - 1) else P.etaLo

/-- Literal sources with a shrinking run ending in a bad target at one rank. -/
noncomputable def shrinkingFirstBadSourcesAtRank
    (P : ShrinkingBarrierRunData) (M S q : ℕ) : Finset ℕ := by
  classical
  exact (dyadicShell M).filter fun n =>
    ∃ h : ℕ, ShrinkingRecertificationRun P M S n h q ∧
      orbit h n ∈ landingBad q (shrinkingTargetTolerance P M S q)

@[simp] theorem mem_shrinkingFirstBadSourcesAtRank
    {P : ShrinkingBarrierRunData} {M S q n : ℕ} :
    n ∈ shrinkingFirstBadSourcesAtRank P M S q ↔
      n ∈ dyadicShell M ∧
        ∃ h : ℕ, ShrinkingRecertificationRun P M S n h q ∧
          orbit h n ∈ landingBad q (shrinkingTargetTolerance P M S q) := by
  classical
  simp [shrinkingFirstBadSourcesAtRank]

/-- Every literal failed endpoint lies in the exact support-sensitive direct
transport set. -/
theorem shrinkingFirstBadSourcesAtRank_subset_transport
    (P : ShrinkingBarrierRunData) {M S q : ℕ} :
    shrinkingFirstBadSourcesAtRank P M S q ⊆
      lossFilteredTransportedSourcesAtTimes M (2 ^ q)
        (shrinkingFeasibleTimes P M S q)
        (landingBad q (shrinkingTargetTolerance P M S q))
        (((q + 2 : ℕ) : ℚ) / P.rStar) := by
  classical
  intro n hn
  rcases mem_shrinkingFirstBadSourcesAtRank.mp hn with
    ⟨hnShell, h, hrun, hbad⟩
  apply mem_lossFilteredTransportedSourcesAtTimes.mpr
  refine ⟨hnShell, h, ?_, hrun.directFirstPassage, hbad, ?_⟩
  · apply mem_shrinkingFeasibleTimes.mpr
    exact ⟨hrun.elapsed_le_horizon, n, hnShell, hrun⟩
  · exact (hrun.toMixed.toCertifiedRankChain P.rStar_pos).scaledReverseLoss_le
      P.rStar_pos

/-- Exact rankwise counting bound with the compressed time support exposed. -/
theorem shrinkingFirstBadSourcesAtRank_card_le
    (P : ShrinkingBarrierRunData) {M S q : ℕ}
    (hqM : q < M)
    (hsmall : ((((q + 2 : ℕ) : ℚ) / P.rStar) /
      ((2 ^ q : ℕ) : ℚ)) ≤ 1 / 3) :
    ((shrinkingFirstBadSourcesAtRank P M S q).card : ℚ) ≤
      ((shrinkingFeasibleTimes P M S q).card : ℚ) *
        (1 + 3 * (((q + 2 : ℕ) : ℚ) / P.rStar)) *
          (2 : ℚ) ^ M / ((2 ^ q : ℕ) : ℚ) *
        ((landingBad q (shrinkingTargetTolerance P M S q)).card : ℚ) := by
  have hsubset := shrinkingFirstBadSourcesAtRank_subset_transport P
    (M := M) (S := S) (q := q)
  have hcardNat := Finset.card_le_card hsubset
  have hcardQ :
      ((shrinkingFirstBadSourcesAtRank P M S q).card : ℚ) ≤
        ((lossFilteredTransportedSourcesAtTimes M (2 ^ q)
          (shrinkingFeasibleTimes P M S q)
          (landingBad q (shrinkingTargetTolerance P M S q))
          (((q + 2 : ℕ) : ℚ) / P.rStar)).card : ℚ) := by
    exact_mod_cast hcardNat
  exact hcardQ.trans
    (lossFiltered_arbitraryTarget_transport_atTimes_uniform
      (shrinkingFeasibleTimes P M S q)
      (landingBad q (shrinkingTargetTolerance P M S q))
      (by positivity)
      (div_nonneg (by positivity) P.rStar_pos.le) hsmall
      (Nat.pow_lt_pow_right (by omega) hqM))

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
