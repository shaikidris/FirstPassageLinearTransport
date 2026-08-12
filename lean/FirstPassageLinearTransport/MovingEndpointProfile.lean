/-
Copyright (c) 2026 Idris Ali Shaik. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Idris Ali Shaik
-/
import FirstPassageLinearTransport.MovingEndpointParameters
import FirstPassageLinearTransport.MovingEndpointScalars
import FirstPassageLinearTransport.MovingSharpProfile
import FirstPassageLinearTransport.ShrinkingTailAsymptotics

/-!
# Literal sharp profile for the moving endpoint

This module joins the high-rank part of the separated first-bad envelope to
the sharp `q⁻¹ᐟ²` low-rank sum.  It deliberately stops before asymptotic
reassembly: the displayed output retains the actual moving entropy rate.
-/

namespace FirstPassageLinearTransport

open Filter
open scoped BigOperators Real

noncomputable section

/-- Full separated-envelope estimate retaining the exact sharp low-rate
profile.  The canonical positive constant is independent of `M`, `L`, `S`,
and the actual rate `b ≥ b₀`. -/
theorem movingSeparatedFailureEnvelope_density_sharp_le
    {P : ShrinkingBarrierRunData} {rLo tLo : ℝ}
    (pLo : StageSetup rLo tLo) {rStar : ℚ}
    (hrStar : 0 < rStar) (hStarHi : rStar ≤ P.rHi)
    (hStarLo : (rStar : ℝ) ≤ rLo)
    (htLoA : tLo < a0)
    {M L S : ℕ} {H dHi C b₀ b : ℝ}
    (hM : 1 ≤ M) (hLS : L ≤ S) (hSM : S < M) (hL : 2 ≤ L)
    (hH0 : 0 ≤ H) (hC : 0 ≤ C)
    (hsmall : ∀ q ∈ Finset.Icc L (M - 1),
      ((((q + 2 : ℕ) : ℚ) / rStar) /
        ((2 ^ q : ℕ) : ℚ)) ≤ 1 / 3)
    (hTimes : ∀ q ∈ Finset.Icc L (M - 1),
      ((movingFeasibleTimes P pLo M S q).card : ℝ) ≤ H)
    (hInitial :
      ((shellInitialWindowBad M (shrinkingHighTolerance P M M)).card : ℝ) /
        (2 : ℝ) ^ M ≤ dHi)
    (hHigh : ∀ q ∈ Finset.Icc (S + 1) (M - 1),
      ((landingBad q (shrinkingHighTolerance P M (q - 1))).card : ℝ) /
        (2 : ℝ) ^ q ≤ dHi)
    (hLow : ∀ q ∈ Finset.Icc L S,
      ((landingBad q tLo).card : ℝ) / (2 : ℝ) ^ q ≤
        1 / (2 : ℝ) ^ q +
          (C / Real.sqrt ((q - 1 : ℕ) : ℝ)) *
            Real.exp (-(b * ((q - 1 : ℕ) : ℝ))))
    (hb₀ : 0 < b₀) (hb₀b : b₀ ≤ b) :
    ((movingSeparatedFailureEnvelope P pLo M L S).card : ℝ) /
          (2 : ℝ) ^ M ≤
        dHi + H * (1 + 6 / (rStar : ℝ)) * ((M : ℝ) + 1) ^ 2 * dHi +
          H * (1 + 6 / (rStar : ℝ)) *
            exactSharpCriticalLowSeriesConstant b₀ C *
            (((L + 1 : ℕ) : ℝ) *
                Real.exp (-(Real.log 2 * (L : ℝ))) +
              Real.sqrt L *
                Real.exp (-(b * ((L - 1 : ℕ) : ℝ)))) := by
  have hLowSum :=
    moving_low_firstBad_sharp_exact_sum_canonical_le pLo hrStar hStarHi hStarLo
      htLoA hM hLS hSM hL hH0 hC
      (fun q hq => hsmall q (Finset.mem_Icc.mpr
        ⟨(Finset.mem_Icc.mp hq).1,
          (Finset.mem_Icc.mp hq).2.trans (Nat.le_pred_of_lt hSM)⟩))
      (fun q hq => hTimes q (Finset.mem_Icc.mpr
        ⟨(Finset.mem_Icc.mp hq).1,
          (Finset.mem_Icc.mp hq).2.trans (Nat.le_pred_of_lt hSM)⟩))
      hLow hb₀ hb₀b
  have hcardNat := movingSeparatedFailureEnvelope_card_le P pLo M L S
  have hcard :
      ((movingSeparatedFailureEnvelope P pLo M L S).card : ℝ) ≤
        ((shellInitialWindowBad M
          (shrinkingHighTolerance P M M)).card : ℝ) +
        ∑ q in Finset.Icc (S + 1) (M - 1),
          ((movingFirstBadSourcesAtRank P pLo M S q).card : ℝ) +
        ∑ q in Finset.Icc L S,
          ((movingFirstBadSourcesAtRank P pLo M S q).card : ℝ) := by
    exact_mod_cast hcardNat
  have hpowM : 0 < (2 : ℝ) ^ M := by positivity
  have hrR : (0 : ℝ) < (rStar : ℝ) := by exact_mod_cast hrStar
  have hHighEach : ∀ q ∈ Finset.Icc (S + 1) (M - 1),
      ((movingFirstBadSourcesAtRank P pLo M S q).card : ℝ) /
          (2 : ℝ) ^ M ≤
        H * (1 + 6 / (rStar : ℝ)) * ((q + 1 : ℕ) : ℝ) * dHi := by
    intro q hq
    have hqi := Finset.mem_Icc.mp hq
    have hSq : S ≤ q := Nat.le_of_succ_le hqi.1
    have hqAll : q ∈ Finset.Icc L (M - 1) :=
      Finset.mem_Icc.mpr ⟨hLS.trans hSq, hqi.2⟩
    have hqM : q < M := Nat.lt_of_le_pred (by omega) hqi.2
    apply movingFirstBadSourcesAtRank_density_le (S := S) pLo
      hrStar hStarHi hStarLo htLoA hM hqM (hsmall q hqAll)
      (hTimes q hqAll)
    rw [movingTargetTolerance_eq_high P tLo hqi.1]
    exact hHigh q hq
  have hdHi0 : 0 ≤ dHi := by
    have hnonneg : 0 ≤
        ((shellInitialWindowBad M
          (shrinkingHighTolerance P M M)).card : ℝ) / (2 : ℝ) ^ M := by
      positivity
    linarith
  have hHighSum :
      ∑ q in Finset.Icc (S + 1) (M - 1),
          ((movingFirstBadSourcesAtRank P pLo M S q).card : ℝ) /
            (2 : ℝ) ^ M ≤
        H * (1 + 6 / (rStar : ℝ)) * ((M : ℝ) + 1) ^ 2 * dHi := by
    calc
      _ ≤ ∑ _q in Finset.Icc (S + 1) (M - 1),
          H * (1 + 6 / (rStar : ℝ)) * ((M : ℝ) + 1) * dHi := by
        apply Finset.sum_le_sum
        intro q hq
        have hqi := Finset.mem_Icc.mp hq
        have hq1 : ((q + 1 : ℕ) : ℝ) ≤ (M : ℝ) + 1 := by
          exact_mod_cast (show q + 1 ≤ M + 1 by omega)
        exact (hHighEach q hq).trans (by
          have hcoef0 : 0 ≤ H * (1 + 6 / (rStar : ℝ)) := by positivity
          gcongr)
      _ ≤ H * (1 + 6 / (rStar : ℝ)) * ((M : ℝ) + 1) ^ 2 * dHi := by
        rw [Finset.sum_const, nsmul_eq_mul]
        have hcardI : ((Finset.Icc (S + 1) (M - 1)).card : ℝ) ≤
            (M : ℝ) + 1 := by
          rw [Nat.card_Icc]
          exact_mod_cast (show M - 1 + 1 - (S + 1) ≤ M + 1 by omega)
        have hcoef0 : 0 ≤ H * (1 + 6 / (rStar : ℝ)) *
            ((M : ℝ) + 1) * dHi := by positivity
        calc
          ((Finset.Icc (S + 1) (M - 1)).card : ℝ) *
              (H * (1 + 6 / (rStar : ℝ)) * ((M : ℝ) + 1) * dHi) ≤
            ((M : ℝ) + 1) *
              (H * (1 + 6 / (rStar : ℝ)) * ((M : ℝ) + 1) * dHi) :=
            mul_le_mul_of_nonneg_right hcardI hcoef0
          _ = _ := by ring
  have hdiv :
      ((movingSeparatedFailureEnvelope P pLo M L S).card : ℝ) /
          (2 : ℝ) ^ M ≤
        ((shellInitialWindowBad M
          (shrinkingHighTolerance P M M)).card : ℝ) / (2 : ℝ) ^ M +
        ∑ q in Finset.Icc (S + 1) (M - 1),
          ((movingFirstBadSourcesAtRank P pLo M S q).card : ℝ) /
            (2 : ℝ) ^ M +
        ∑ q in Finset.Icc L S,
          ((movingFirstBadSourcesAtRank P pLo M S q).card : ℝ) /
            (2 : ℝ) ^ M := by
    have h := div_le_div_of_nonneg_right hcard hpowM.le
    simpa [add_div, Finset.sum_div] using h
  calc
    _ ≤ ((shellInitialWindowBad M
          (shrinkingHighTolerance P M M)).card : ℝ) / (2 : ℝ) ^ M +
        ∑ q in Finset.Icc (S + 1) (M - 1),
          ((movingFirstBadSourcesAtRank P pLo M S q).card : ℝ) /
            (2 : ℝ) ^ M +
        ∑ q in Finset.Icc L S,
          ((movingFirstBadSourcesAtRank P pLo M S q).card : ℝ) /
            (2 : ℝ) ^ M := hdiv
    _ ≤ dHi +
        H * (1 + 6 / (rStar : ℝ)) * ((M : ℝ) + 1) ^ 2 * dHi +
        H * (1 + 6 / (rStar : ℝ)) *
          exactSharpCriticalLowSeriesConstant b₀ C *
          (((L + 1 : ℕ) : ℝ) *
              Real.exp (-(Real.log 2 * (L : ℝ))) +
            Real.sqrt L * Real.exp (-(b * ((L - 1 : ℕ) : ℝ)))) :=
      add_le_add (add_le_add hInitial hHighSum) hLowSum

/-- Shellwise good set for the moving endpoint.  Before the eventual moving
startup becomes available the definition is empty; this finite prefix is
irrelevant to natural density and keeps the public set total. -/
noncomputable def movingEndpointGood
    {Amax c beta : ℝ}
    (P : MovingEndpointParameterPackage Amax c beta)
    (A : ℕ → ℝ) (M : ℕ) : Set ℕ := by
  classical
  let L := movingTerminalRank A M
  let S := shrinkingSwitchRank P.Cswitch M
  exact if h : Nonempty (MovingLowStagePackage P L) then
      let Q := Classical.choice h
      {n | n ∉ movingSeparatedFailureEnvelope P.run Q.1 M L S}
    else
      ∅

/-- Once the quantitative low startup is present, the bad shell of the
canonical good set is literally the separated first-bad envelope. -/
theorem shellBad_movingEndpointGood_of_nonempty
    {Amax c beta : ℝ}
    (P : MovingEndpointParameterPackage Amax c beta)
    (A : ℕ → ℝ) (M : ℕ)
    (h : Nonempty (MovingLowStagePackage P (movingTerminalRank A M))) :
    shellBad (movingEndpointGood P A M) M =
      movingSeparatedFailureEnvelope P.run (Classical.choice h).1 M
        (movingTerminalRank A M) (shrinkingSwitchRank P.Cswitch M) := by
  classical
  let Q := Classical.choice h
  let L := movingTerminalRank A M
  let S := shrinkingSwitchRank P.Cswitch M
  have hEnvelopeShell : ∀ n,
      n ∈ movingSeparatedFailureEnvelope P.run Q.1 M L S →
        n ∈ dyadicShell M := by
    intro n hn
    unfold movingSeparatedFailureEnvelope at hn
    simp only [Finset.mem_union, Finset.mem_biUnion] at hn
    rcases hn with (hn | hn) | hn
    · exact (Finset.mem_filter.mp hn).1
    · rcases hn with ⟨q, _hq, hnq⟩
      exact (mem_movingFirstBadSourcesAtRank.mp hnq).1
    · rcases hn with ⟨q, _hq, hnq⟩
      exact (mem_movingFirstBadSourcesAtRank.mp hnq).1
  ext n
  constructor
  · intro hn
    rw [shellBad, Finset.mem_filter] at hn
    have hnot : ¬ n ∉ movingSeparatedFailureEnvelope P.run Q.1 M L S := by
      simpa [movingEndpointGood, h, Q, L, S] using hn.2
    simpa [Q, L, S] using not_not.mp hnot
  · intro hn
    have hnShell : n ∈ dyadicShell M := hEnvelopeShell n (by
      simpa [Q, L, S] using hn)
    rw [shellBad, Finset.mem_filter]
    refine ⟨hnShell, ?_⟩
    simpa [movingEndpointGood, h, Q, L, S] using
      (show ¬ n ∉ movingSeparatedFailureEnvelope P.run Q.1 M L S from
        not_not.mpr (by simpa [Q, L, S] using hn))

/-- The literal moving shell profile before its last scalar simplification.
It combines quantitative startup, the endpoint-rate landing producer, the
square-root feasible-time support, and both high-rank density bounds. -/
theorem exists_eventually_movingEndpointGood_rawProfile
    {Amax c beta : ℝ}
    (P : MovingEndpointParameterPackage Amax c beta)
    {A : ℕ → ℝ}
    (hbuffer : Tendsto (movingRankBuffer A) atTop atTop)
    (hUpper : ∀ᶠ M : ℕ in atTop, A M ≤ Amax) :
    ∃ C D : ℝ, 0 < C ∧ 0 < D ∧
      ∀ᶠ M : ℕ in atTop,
        shellExceptionalRatio (movingEndpointGood P A M) M ≤
          let L := movingTerminalRank A M
          let H := (movingTimeSupportConstant P.run P.Cswitch + 1) *
            Real.sqrt (((M : ℝ) + 2) * Real.log ((M : ℝ) + 2))
          let dHi := shrinkingHighDensityProfile P.run P.Cswitch M
          let b := firstPassageEndpointRate - D / (L : ℝ)
          dHi + H * (1 + 6 / (P.run.rStar : ℝ)) *
              ((M : ℝ) + 1) ^ 2 * dHi +
            H * (1 + 6 / (P.run.rStar : ℝ)) *
              exactSharpCriticalLowSeriesConstant
                (firstPassageEndpointRate / 2) (C / 2) *
              (((L + 1 : ℕ) : ℝ) *
                  Real.exp (-(Real.log 2 * (L : ℝ))) +
                Real.sqrt L *
                  Real.exp (-(b * ((L - 1 : ℕ) : ℝ)))) := by
  obtain ⟨C, D, hC, hD, hLowBase⟩ :=
    exists_eventually_card_landingBad_movingLow_endpointRate_le
      (show 0 < P.K₀ by linarith [P.K₀_gt_six]) P.K₁_pos P.K₁_reserve
  refine ⟨C, D, hC, hD, ?_⟩
  have hTerminalT := tendsto_movingTerminalRank_atTop hbuffer
  have hPackages := hTerminalT.eventually P.eventually_lowStagePackage
  have hLowTargets := hTerminalT.eventually hLowBase
  have hSmallBase := eventually_interval_rankTransport_small P.run.rStar_pos
  have hSmall := hTerminalT.eventually hSmallBase
  have hLS := eventually_movingTerminalRank_lt_shrinkingSwitchRank
    P.Amax_pos.le P.terminal_below_switch hUpper
  have hSM := eventually_shrinkingSwitchRank_lt_source P.Cswitch_pos.le
  have hTimes := eventually_movingFeasibleTimes_card_lt_sqrt
    P.run P.Cswitch_pos.le
  have hStarHi : P.run.rStar ≤ P.run.rHi := by
    rw [P.run.rStar_eq]
    exact min_le_left _ _
  have hStarLoBase : ∀ᶠ L : ℕ in atTop,
      (P.run.rStar : ℝ) ≤ movingLowRatio P.K₀ L := by
    have hrStarOne : (P.run.rStar : ℝ) < 1 := by
      have hStarHiR : (P.run.rStar : ℝ) ≤ (P.run.rHi : ℝ) := by
        exact_mod_cast hStarHi
      exact hStarHiR.trans_lt P.run.pHi.r_lt_one
    exact (tendsto_movingLowRatio P.K₀).eventually
      (Ici_mem_nhds hrStarOne)
  have hStarLo := hTerminalT.eventually hStarLoBase
  have hRateBase : ∀ᶠ L : ℕ in atTop,
      firstPassageEndpointRate / 2 ≤
        firstPassageEndpointRate - D / (L : ℝ) := by
    have hcast : Tendsto (fun L : ℕ => (L : ℝ)) atTop atTop :=
      tendsto_natCast_atTop_atTop
    have hinv : Tendsto (fun L : ℕ => ((L : ℝ))⁻¹) atTop (nhds 0) :=
      tendsto_inv_atTop_zero.comp hcast
    have hdiv : Tendsto (fun L : ℕ => D / (L : ℝ)) atTop (nhds 0) := by
      simpa [div_eq_mul_inv] using
        (tendsto_const_nhds.mul hinv :
          Tendsto (fun L : ℕ => D * ((L : ℝ))⁻¹) atTop (nhds (D * 0)))
    have hrate : Tendsto
        (fun L : ℕ => firstPassageEndpointRate - D / (L : ℝ))
        atTop (nhds firstPassageEndpointRate) := by
      simpa using (tendsto_const_nhds.sub hdiv)
    exact hrate.eventually (Ici_mem_nhds (by
      linarith [firstPassageEndpointRate_pos]))
  have hRate := hTerminalT.eventually hRateBase
  have hRank2 := (tendsto_atTop.1 hTerminalT) 2
  filter_upwards [hPackages, hLowTargets, hSmall, hLS, hSM, hTimes,
      hStarLo, hRate, hRank2,
      eventually_ge_atTop (max 2 P.run.pHi.M0)]
    with M hPackage hLowTargets hSmall hLS hSM hTimes hStarLo hRate hRank2 hM
  let L := movingTerminalRank A M
  let S := shrinkingSwitchRank P.Cswitch M
  let Q := Classical.choice hPackage
  let pLo := Q.1
  let H := (movingTimeSupportConstant P.run P.Cswitch + 1) *
    Real.sqrt (((M : ℝ) + 2) * Real.log ((M : ℝ) + 2))
  let dHi := shrinkingHighDensityProfile P.run P.Cswitch M
  let b := firstPassageEndpointRate - D / (L : ℝ)
  have hM1 : 1 ≤ M := by omega
  have hL2 : 2 ≤ L := by
    dsimp [L]
    exact hRank2
  have hLS' : L ≤ S := by dsimp [L, S]; exact hLS.le
  have hSM' : S < M := by simpa [S] using hSM
  have hH0 : 0 ≤ H := by
    dsimp [H]
    have hrHi0 : 0 < (P.run.rHi : ℝ) := P.run.pHi.r_pos
    have hsqrtSq := Real.sq_sqrt hrHi0.le
    have hsqrt0 := Real.sqrt_nonneg (P.run.rHi : ℝ)
    have hsqrt1 : Real.sqrt (P.run.rHi : ℝ) < 1 := by
      nlinarith [P.run.pHi.r_lt_one]
    have hden : 0 < 1 - Real.sqrt (P.run.rHi : ℝ) := sub_pos.mpr hsqrt1
    have hnum : 0 ≤ P.run.D + P.run.tau + 3 := by
      linarith [P.run.D_pos, P.run.pHi.eta_pos]
    have hfrac : 0 ≤
        (P.run.D + P.run.tau + 3) /
          (1 - Real.sqrt (P.run.rHi : ℝ)) :=
      div_nonneg hnum hden.le
    have hinner : 0 ≤
        (P.run.D + P.run.tau + 3) /
            (1 - Real.sqrt (P.run.rHi : ℝ)) +
          (P.Cswitch + 5) ^ 2 := by positivity
    have hcoef : 0 ≤
        2 + 2 / driftGap *
          ((P.run.D + P.run.tau + 3) /
              (1 - Real.sqrt (P.run.rHi : ℝ)) +
            (P.Cswitch + 5) ^ 2) + 1 := by
      have hratio : 0 ≤ 2 / driftGap :=
        div_nonneg (by norm_num) driftGap_pos.le
      nlinarith [mul_nonneg hratio hinner]
    dsimp [movingTimeSupportConstant]
    exact mul_nonneg hcoef (Real.sqrt_nonneg _)
  have hC2 : 0 ≤ C / 2 := by positivity
  have hb₀ : 0 < firstPassageEndpointRate / 2 := by
    exact div_pos firstPassageEndpointRate_pos (by norm_num)
  have htLoA : movingLowTolerance P.K₀ L < a0 := by
    have hLR : 0 < (L : ℝ) := by positivity
    have hgap : movingLowTolerance P.K₀ L < driftGap := by
      unfold movingLowTolerance
      have : 0 < P.K₀ / (L : ℝ) :=
        div_pos (by linarith [P.K₀_gt_six]) hLR
      linarith
    exact hgap.trans driftGap_lt_a0
  have hTimes' : ∀ q ∈ Finset.Icc L (M - 1),
      ((movingFeasibleTimes P.run pLo M S q).card : ℝ) ≤ H := by
    intro q hq
    exact (hTimes pLo htLoA q).le
  have hInitial :
      ((shellInitialWindowBad M
        (shrinkingHighTolerance P.run M M)).card : ℝ) /
          (2 : ℝ) ^ M ≤ dHi := by
    have hbase := card_shellInitialWindowBad_shrinking_le P.run
      P.Cswitch_pos P.high_cap hM1 hSM.le
    dsimp [dHi, shrinkingHighDensityProfile]
    have hboundary : 0 ≤
        Real.exp (-(Real.log 2 * (shrinkingSwitchRank P.Cswitch M : ℝ))) :=
      Real.exp_pos _ |>.le
    linarith
  have hHighTargets : ∀ q ∈ Finset.Icc (S + 1) (M - 1),
      ((landingBad q
        (shrinkingHighTolerance P.run M (q - 1))).card : ℝ) /
          (2 : ℝ) ^ q ≤ dHi := by
    intro q hq
    have hqLower := (Finset.mem_Icc.mp hq).1
    have hq1 : 1 ≤ q := by omega
    have hSParent : shrinkingSwitchRank P.Cswitch M ≤ q - 1 := by
      simpa [S] using (show S ≤ q - 1 by omega)
    have hbase := card_landingBad_shrinking_high_density_le P.run
      P.Cswitch_pos P.high_cap hq1 hSParent
    have hqS : (S : ℝ) ≤ (q : ℝ) := by exact_mod_cast (show S ≤ q by omega)
    have hlog2 : 0 < Real.log 2 := Real.log_pos (by norm_num)
    have hexp : Real.exp (-(Real.log 2 * (q : ℝ))) ≤
        Real.exp (-(Real.log 2 * (S : ℝ))) := by
      apply Real.exp_le_exp.mpr
      nlinarith
    dsimp [dHi, shrinkingHighDensityProfile]
    exact hbase.trans (by
      calc
        _ ≤ Real.exp (-(Real.log 2 * (S : ℝ))) +
            quadraticWindowShellConstant / 2 *
              Real.exp (-(maximalBarrierC0 * P.run.D ^ 2 *
                Real.log ((M : ℝ) + 2))) := add_le_add hexp le_rfl
        _ ≤ Real.exp (-(Real.log 2 * (S : ℝ))) +
            quadraticWindowShellConstant *
              Real.exp (-(maximalBarrierC0 * P.run.D ^ 2 *
                Real.log ((M : ℝ) + 2))) := by
          gcongr
          linarith [quadraticWindowShellConstant_pos]
        _ = _ := rfl)
  have hLow : ∀ q ∈ Finset.Icc L S,
      ((landingBad q (movingLowTolerance P.K₀ L)).card : ℝ) /
          (2 : ℝ) ^ q ≤
        1 / (2 : ℝ) ^ q +
          ((C / 2) / Real.sqrt ((q - 1 : ℕ) : ℝ)) *
            Real.exp (-(b * ((q - 1 : ℕ) : ℝ))) := by
    intro q hq
    have hqL := (Finset.mem_Icc.mp hq).1
    have hbase := hLowTargets q hqL
    simpa [b, div_div, mul_comm, mul_left_comm, mul_assoc] using hbase
  have hProfile := movingSeparatedFailureEnvelope_density_sharp_le pLo
    P.run.rStar_pos hStarHi hStarLo htLoA
    hM1 hLS' hSM' hL2 hH0 hC2
    (fun q hq => hSmall (M - 1) q hq) hTimes' hInitial hHighTargets
    hLow hb₀ hRate
  rw [shellExceptionalRatio,
    shellBad_movingEndpointGood_of_nonempty P A M hPackage]
  simpa [L, S, Q, pLo, H, dHi, b] using hProfile

end

end FirstPassageLinearTransport
