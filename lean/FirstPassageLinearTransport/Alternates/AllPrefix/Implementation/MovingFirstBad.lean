/-
Copyright (c) 2026 Idris Ali Shaik. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Idris Ali Shaik
-/
import FirstPassageLinearTransport.Alternates.AllPrefix.Implementation.MovingTimeSupport
import FirstPassageLinearTransport.TimeSupportTransport
import FirstPassageLinearTransport.TwoRegimeRun

import FirstPassageLinearTransport.Extras.Unreachable
/-!
# First-bad sources for the moving low-rank barrier

Semantic-to-counting cut vertex for the moving endpoint.  A failed landing of
a literal moving run is a direct first passage of the original source, carries
the common rank-scaled reverse-loss budget for every positive rational
`rStar ≤ min(rHi, rLo)`, and uses a cumulative time from the compressed moving
support.  No generated-distribution hypothesis is introduced.

The low contraction may approach one: the loss budget uses only a fixed
positive `rStar` dominated by both regimes, never a factor `1/(1-rLo)`.
-/

namespace FirstPassageLinearTransport

open scoped BigOperators

noncomputable section

/-- Parent-rank budget for a real floor target under a rational common
contraction dominated by that real ratio. -/
theorem parentRank_le_realTargetBudget
    {rStar : ℚ} {r : ℝ} (hrStar : 0 < rStar) (hStar : (rStar : ℝ) ≤ r)
    (m : ℕ) :
    (m : ℚ) ≤ ((realTargetRank r m + 1 : ℕ) : ℚ) / rStar := by
  apply (le_div_iff₀ hrStar).2
  have hrStarR : (0 : ℝ) < (rStar : ℝ) := by exact_mod_cast hrStar
  have hr0 : (0 : ℝ) ≤ r := hrStarR.le.trans hStar
  have hnonneg : (0 : ℝ) ≤ r * (m : ℝ) := by positivity
  have hfloor := Nat.lt_floor_add_one (r * (m : ℝ))
  have hfloor' : r * (m : ℝ) ≤ (realTargetRank r m + 1 : ℕ) := by
    simpa [realTargetRank] using hfloor.le
  have hbound : (rStar : ℝ) * (m : ℝ) ≤
      (realTargetRank r m + 1 : ℕ) := by
    have hfirst : (rStar : ℝ) * (m : ℝ) ≤ r * (m : ℝ) :=
      mul_le_mul_of_nonneg_right hStar (Nat.cast_nonneg m)
    exact hfirst.trans hfloor'
  have hboundQ : rStar * (m : ℚ) ≤
      ((realTargetRank r m + 1 : ℕ) : ℚ) := by
    exact_mod_cast hbound
  simpa [mul_comm] using hboundQ

/-- Every moving mixed run is one certified rank chain for any positive
rational contraction dominated by both the high and low ratios. -/
theorem MovingRecertificationRun.toCertifiedRankChain
    {P : ShrinkingBarrierRunData} {rLo tLo : ℝ}
    {pLo : StageSetup rLo tLo} {rStar : ℚ}
    (hrStar : 0 < rStar) (hStarHi : rStar ≤ P.rHi)
    (hStarLo : (rStar : ℝ) ≤ rLo)
    {M S n elapsed q : ℕ}
    (hrun : MovingRecertificationRun P pLo M S n elapsed q) :
    CertifiedRankChain rStar n elapsed q := by
  induction hrun with
  | first hSM hM0 hnShell hnGood =>
      exact CertifiedRankChain.first_of_stage_common
        (shrinkingHighSetup P M M) hrStar hStarHi hM0 hnShell hnGood
  | nextHi hrun hSm hm0 hsourceShell hsourceGood hgap ih =>
      exact CertifiedRankChain.next_of_stage_common
        (shrinkingHighSetup P M _) hrStar hStarHi ih hm0
        hsourceShell hsourceGood hgap
  | @nextLo elapsed qPrev m hrun hmS hm0 hsourceShell hsourceGood hgap ih =>
      apply CertifiedRankChain.next ih hgap
      · simpa [targetScale_eq_pow_realTargetRank] using
          stageLength_isFirstPassage pLo hm0 hsourceShell hsourceGood
      · exact stageLength_le_shell pLo hm0 hsourceShell hsourceGood
      · exact parentRank_le_realTargetBudget hrStar hStarLo m

theorem MovingRecertificationRun.scaledReverseLoss_le
    {P : ShrinkingBarrierRunData} {rLo tLo : ℝ}
    {pLo : StageSetup rLo tLo} {rStar : ℚ}
    (hrStar : 0 < rStar) (hStarHi : rStar ≤ P.rHi)
    (hStarLo : (rStar : ℝ) ≤ rLo)
    {M S n elapsed q : ℕ}
    (hrun : MovingRecertificationRun P pLo M S n elapsed q) :
    scaledReverseLoss (2 ^ q) n elapsed ≤ ((q + 2 : ℕ) : ℚ) / rStar :=
  (hrun.toCertifiedRankChain hrStar hStarHi hStarLo).scaledReverseLoss_le hrStar

/-- Certification tolerance at the parent shell of a landing of rank `q`.
High ranks use the outer-shell shrinking high tolerance; low ranks use the
moving low tolerance. -/
def movingTargetTolerance
    (P : ShrinkingBarrierRunData) (tLo : ℝ) (M S q : ℕ) : ℝ :=
  if S ≤ q - 1 then shrinkingHighTolerance P M (q - 1) else tLo

theorem movingTargetTolerance_eq_high
    (P : ShrinkingBarrierRunData) (tLo : ℝ) {M S q : ℕ} (hSq : S < q) :
    movingTargetTolerance P tLo M S q =
      shrinkingHighTolerance P M (q - 1) := by
  unfold movingTargetTolerance
  rw [if_pos (by omega)]

theorem movingTargetTolerance_eq_low
    (P : ShrinkingBarrierRunData) (tLo : ℝ) {M S q : ℕ}
    (hq1 : 1 ≤ q) (hqS : q ≤ S) :
    movingTargetTolerance P tLo M S q = tLo := by
  unfold movingTargetTolerance
  rw [if_neg (by omega)]

/-- Literal sources with a moving run ending in a bad target at one rank. -/
noncomputable def movingFirstBadSourcesAtRank
    (P : ShrinkingBarrierRunData) {rLo tLo : ℝ}
    (pLo : StageSetup rLo tLo) (M S q : ℕ) : Finset ℕ := by
  classical
  exact (dyadicShell M).filter fun n =>
    ∃ h : ℕ, MovingRecertificationRun P pLo M S n h q ∧
      orbit h n ∈ landingBad q (movingTargetTolerance P tLo M S q)

@[simp] theorem mem_movingFirstBadSourcesAtRank
    {P : ShrinkingBarrierRunData} {rLo tLo : ℝ}
    {pLo : StageSetup rLo tLo} {M S q n : ℕ} :
    n ∈ movingFirstBadSourcesAtRank P pLo M S q ↔
      n ∈ dyadicShell M ∧
        ∃ h : ℕ, MovingRecertificationRun P pLo M S n h q ∧
          orbit h n ∈ landingBad q (movingTargetTolerance P tLo M S q) := by
  classical
  simp [movingFirstBadSourcesAtRank]

/-- Every literal failed endpoint lies in the support-sensitive direct
transport set for the common reverse-loss budget. -/
theorem movingFirstBadSourcesAtRank_subset_transport
    {P : ShrinkingBarrierRunData} {rLo tLo : ℝ}
    (pLo : StageSetup rLo tLo) {rStar : ℚ}
    (hrStar : 0 < rStar) (hStarHi : rStar ≤ P.rHi)
    (hStarLo : (rStar : ℝ) ≤ rLo)
    (htLoA : tLo < a0) {M S q : ℕ} (hM : 1 ≤ M) :
    movingFirstBadSourcesAtRank P pLo M S q ⊆
      lossFilteredTransportedSourcesAtTimes M (2 ^ q)
        (movingFeasibleTimes P pLo M S q)
        (landingBad q (movingTargetTolerance P tLo M S q))
        (((q + 2 : ℕ) : ℚ) / rStar) := by
  classical
  intro n hn
  rcases mem_movingFirstBadSourcesAtRank.mp hn with
    ⟨hnShell, h, hrun, hbad⟩
  apply mem_lossFilteredTransportedSourcesAtTimes.mpr
  refine ⟨hnShell, h, ?_, hrun.directFirstPassage, hbad, ?_⟩
  · exact hrun.mem_movingFeasibleTimes htLoA hM hnShell
  · exact hrun.scaledReverseLoss_le hrStar hStarHi hStarLo

/-- Exact rankwise counting bound with the compressed moving time support. -/
theorem movingFirstBadSourcesAtRank_card_le
    {P : ShrinkingBarrierRunData} {rLo tLo : ℝ}
    (pLo : StageSetup rLo tLo) {rStar : ℚ}
    (hrStar : 0 < rStar) (hStarHi : rStar ≤ P.rHi)
    (hStarLo : (rStar : ℝ) ≤ rLo)
    (htLoA : tLo < a0) {M S q : ℕ} (hM : 1 ≤ M)
    (hqM : q < M)
    (hsmall : ((((q + 2 : ℕ) : ℚ) / rStar) /
      ((2 ^ q : ℕ) : ℚ)) ≤ 1 / 3) :
    ((movingFirstBadSourcesAtRank P pLo M S q).card : ℚ) ≤
      ((movingFeasibleTimes P pLo M S q).card : ℚ) *
        (1 + 3 * (((q + 2 : ℕ) : ℚ) / rStar)) *
          (2 : ℚ) ^ M / ((2 ^ q : ℕ) : ℚ) *
        ((landingBad q (movingTargetTolerance P tLo M S q)).card : ℚ) := by
  have hsubset := movingFirstBadSourcesAtRank_subset_transport pLo
    hrStar hStarHi hStarLo htLoA hM (S := S) (q := q)
  have hcardNat := Finset.card_le_card hsubset
  have hcardQ :
      ((movingFirstBadSourcesAtRank P pLo M S q).card : ℚ) ≤
        ((lossFilteredTransportedSourcesAtTimes M (2 ^ q)
          (movingFeasibleTimes P pLo M S q)
          (landingBad q (movingTargetTolerance P tLo M S q))
          (((q + 2 : ℕ) : ℚ) / rStar)).card : ℚ) := by
    exact_mod_cast hcardNat
  exact hcardQ.trans
    (lossFiltered_arbitraryTarget_transport_atTimes_uniform
      (movingFeasibleTimes P pLo M S q)
      (landingBad q (movingTargetTolerance P tLo M S q))
      (by positivity)
      (div_nonneg (by positivity) hrStar.le) hsmall
      (Nat.pow_lt_pow_right (by omega) hqM))

/-- Three-piece moving failure envelope: initial high failure, high-rank
first failure, and low-rank first failure. -/
noncomputable def movingSeparatedFailureEnvelope
    (P : ShrinkingBarrierRunData) {rLo tLo : ℝ}
    (pLo : StageSetup rLo tLo) (M L S : ℕ) : Finset ℕ := by
  classical
  exact shellInitialWindowBad M (shrinkingHighTolerance P M M) ∪
    ((Finset.Icc (S + 1) (M - 1)).biUnion fun q =>
      movingFirstBadSourcesAtRank P pLo M S q) ∪
    ((Finset.Icc L S).biUnion fun q =>
      movingFirstBadSourcesAtRank P pLo M S q)

theorem movingSeparatedFailureEnvelope_card_le
    (P : ShrinkingBarrierRunData) {rLo tLo : ℝ}
    (pLo : StageSetup rLo tLo) (M L S : ℕ) :
    (movingSeparatedFailureEnvelope P pLo M L S).card ≤
      (shellInitialWindowBad M (shrinkingHighTolerance P M M)).card +
      ∑ q in Finset.Icc (S + 1) (M - 1),
        (movingFirstBadSourcesAtRank P pLo M S q).card +
      ∑ q in Finset.Icc L S,
        (movingFirstBadSourcesAtRank P pLo M S q).card := by
  classical
  unfold movingSeparatedFailureEnvelope
  calc
    _ ≤ (shellInitialWindowBad M (shrinkingHighTolerance P M M) ∪
        ((Finset.Icc (S + 1) (M - 1)).biUnion fun q =>
          movingFirstBadSourcesAtRank P pLo M S q)).card +
        ((Finset.Icc L S).biUnion fun q =>
          movingFirstBadSourcesAtRank P pLo M S q).card :=
      Finset.card_union_le _ _
    _ ≤ ((shellInitialWindowBad M (shrinkingHighTolerance P M M)).card +
        ((Finset.Icc (S + 1) (M - 1)).biUnion fun q =>
          movingFirstBadSourcesAtRank P pLo M S q).card) +
        ((Finset.Icc L S).biUnion fun q =>
          movingFirstBadSourcesAtRank P pLo M S q).card := by
      gcongr
      exact Finset.card_union_le _ _
    _ ≤ (shellInitialWindowBad M (shrinkingHighTolerance P M M)).card +
        ∑ q in Finset.Icc (S + 1) (M - 1),
          (movingFirstBadSourcesAtRank P pLo M S q).card +
        ∑ q in Finset.Icc L S,
          (movingFirstBadSourcesAtRank P pLo M S q).card := by
      apply Nat.add_le_add
      · exact Nat.add_le_add_left
          (card_biUnion_le_sum (Finset.Icc (S + 1) (M - 1)) fun q =>
            movingFirstBadSourcesAtRank P pLo M S q) _
      · exact card_biUnion_le_sum (Finset.Icc L S) fun q =>
          movingFirstBadSourcesAtRank P pLo M S q

/-- Real-valued aggregate bound obtained by summing the exact rankwise
support-sensitive estimates. -/
theorem movingSeparatedFailureEnvelope_card_real_le
    {P : ShrinkingBarrierRunData} {rLo tLo : ℝ}
    (pLo : StageSetup rLo tLo) {rStar : ℚ}
    (hrStar : 0 < rStar) (hStarHi : rStar ≤ P.rHi)
    (hStarLo : (rStar : ℝ) ≤ rLo)
    (htLoA : tLo < a0) {M L S : ℕ}
    (hM : 1 ≤ M) (hLS : L ≤ S) (hSM : S < M)
    (hsmall : ∀ q ∈ Finset.Icc L (M - 1),
      ((((q + 2 : ℕ) : ℚ) / rStar) /
        ((2 ^ q : ℕ) : ℚ)) ≤ 1 / 3) :
    ((movingSeparatedFailureEnvelope P pLo M L S).card : ℝ) ≤
      ((shellInitialWindowBad M (shrinkingHighTolerance P M M)).card : ℝ) +
        ∑ q in Finset.Icc (S + 1) (M - 1),
          ((movingFeasibleTimes P pLo M S q).card : ℝ) *
            (1 + 3 * (((q + 2 : ℕ) : ℝ) / (rStar : ℝ))) *
              (2 : ℝ) ^ M / (2 : ℝ) ^ q *
            ((landingBad q (movingTargetTolerance P tLo M S q)).card : ℝ) +
        ∑ q in Finset.Icc L S,
          ((movingFeasibleTimes P pLo M S q).card : ℝ) *
            (1 + 3 * (((q + 2 : ℕ) : ℝ) / (rStar : ℝ))) *
              (2 : ℝ) ^ M / (2 : ℝ) ^ q *
            ((landingBad q (movingTargetTolerance P tLo M S q)).card : ℝ) := by
  have hcardNat := movingSeparatedFailureEnvelope_card_le P pLo M L S
  have hcardReal :
      ((movingSeparatedFailureEnvelope P pLo M L S).card : ℝ) ≤
        ((shellInitialWindowBad M (shrinkingHighTolerance P M M)).card : ℝ) +
          ∑ q in Finset.Icc (S + 1) (M - 1),
            ((movingFirstBadSourcesAtRank P pLo M S q).card : ℝ) +
          ∑ q in Finset.Icc L S,
            ((movingFirstBadSourcesAtRank P pLo M S q).card : ℝ) := by
    exact_mod_cast hcardNat
  apply hcardReal.trans
  have hHigh : ∑ q in Finset.Icc (S + 1) (M - 1),
      ((movingFirstBadSourcesAtRank P pLo M S q).card : ℝ) ≤
        ∑ q in Finset.Icc (S + 1) (M - 1),
          ((movingFeasibleTimes P pLo M S q).card : ℝ) *
            (1 + 3 * (((q + 2 : ℕ) : ℝ) / (rStar : ℝ))) *
              (2 : ℝ) ^ M / (2 : ℝ) ^ q *
            ((landingBad q (movingTargetTolerance P tLo M S q)).card : ℝ) := by
    apply Finset.sum_le_sum
    intro q hq
    have hqi := Finset.mem_Icc.mp hq
    have hSq : S ≤ q := Nat.le_of_succ_le hqi.1
    have hqAll : q ∈ Finset.Icc L (M - 1) :=
      Finset.mem_Icc.mpr ⟨hLS.trans hSq, hqi.2⟩
    have hqM : q < M := Nat.lt_of_le_pred (by omega) hqi.2
    have hqBound := movingFirstBadSourcesAtRank_card_le (S := S) pLo
      hrStar hStarHi hStarLo htLoA hM hqM (hsmall q hqAll)
    exact_mod_cast hqBound
  have hLow : ∑ q in Finset.Icc L S,
      ((movingFirstBadSourcesAtRank P pLo M S q).card : ℝ) ≤
        ∑ q in Finset.Icc L S,
          ((movingFeasibleTimes P pLo M S q).card : ℝ) *
            (1 + 3 * (((q + 2 : ℕ) : ℝ) / (rStar : ℝ))) *
              (2 : ℝ) ^ M / (2 : ℝ) ^ q *
            ((landingBad q (movingTargetTolerance P tLo M S q)).card : ℝ) := by
    apply Finset.sum_le_sum
    intro q hq
    have hqi := Finset.mem_Icc.mp hq
    have hqM : q < M := hqi.2.trans_lt hSM
    have hqAll : q ∈ Finset.Icc L (M - 1) :=
      Finset.mem_Icc.mpr ⟨hqi.1, Nat.le_pred_of_lt hqM⟩
    have hqBound := movingFirstBadSourcesAtRank_card_le (S := S) pLo
      hrStar hStarHi hStarLo htLoA hM hqM (hsmall q hqAll)
    exact_mod_cast hqBound
  linarith

end

end FirstPassageLinearTransport
