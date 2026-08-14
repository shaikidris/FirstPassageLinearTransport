/-
Copyright (c) 2026 Idris Ali Shaik. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Idris Ali Shaik
-/
import FirstPassageLinearTransport.Legacy.TwoRegimeRecertificationRun

import FirstPassageLinearTransport.Extras.Unreachable
/-!
# Exact two-regime failure profile

The switch rank is treated as the union of the high- and low-certification
complements.  Positive aggregation occurs only after the five literal source
sets have been formed.
-/

namespace FirstPassageLinearTransport

noncomputable section

/-- The five source sets in the two-regime first-bad union: initial failure,
high-rank failure, the two switch targets, and low-rank failure. -/
noncomputable def twoRegimeFailureEnvelope
    (M L S U H : ℕ) (rStar : ℚ) (tHi tLo : ℝ) : Finset ℕ :=
  shellInitialWindowBad M tHi ∪
    generatedFirstBadSources M (S + 1) U H rStar tHi ∪
    generatedFirstBadSources M S S H rStar tHi ∪
    generatedFirstBadSources M S S H rStar tLo ∪
    generatedFirstBadSources M L (S - 1) H rStar tLo

/-- Literal failed sources: either the outer source is not high-certified or
a variable-regime run has a rank-appropriate first bad endpoint. -/
noncomputable def twoRegimeFailureSources
    (M L S U H : ℕ) (rStar : ℚ) (tHi tLo : ℝ) : Finset ℕ := by
  classical
  exact (dyadicShell M).filter fun n =>
    n ∉ initialWindowGood tHi ∨
      HasTwoRegimeFirstBadLanding rStar tHi tLo n L S U H

/-- Every literal variable-regime first failure lies in exactly one of the
five rank-aggregated transport targets. -/
theorem twoRegimeFailureSources_subset_envelope
    {M L S U H : ℕ} {rStar : ℚ} {tHi tLo : ℝ}
    (hr : 0 < rStar) :
    twoRegimeFailureSources M L S U H rStar tHi tLo ⊆
      twoRegimeFailureEnvelope M L S U H rStar tHi tLo := by
  classical
  intro n hn
  rw [twoRegimeFailureSources, Finset.mem_filter] at hn
  rcases hn with ⟨hnShell, hnInitial | hnRun⟩
  · have hnBad : n ∈ shellInitialWindowBad M tHi := by
      rw [← shellBad_initialWindowGood, shellBad, Finset.mem_filter]
      exact ⟨hnShell, hnInitial⟩
    simp [twoRegimeFailureEnvelope, hnBad]
  · rcases hnRun with ⟨elapsed, q, hLq, hqU, hhH, hrun, htarget⟩
    rcases htarget with hHigh | hSwitch | hLow
    · have hgen : HasGeneratedFirstBadLanding
          rStar tHi n (S + 1) U H :=
        hrun.toGeneratedFirstBadLanding hr (by omega) hqU hhH hHigh.2
      have hmem : n ∈ generatedFirstBadSources M (S + 1) U H rStar tHi :=
        mem_generatedFirstBadSources.mpr ⟨hnShell, hgen⟩
      simp [twoRegimeFailureEnvelope, hmem]
    · rcases hSwitch with ⟨hqS, hbadHi | hbadLo⟩
      · have hgen : HasGeneratedFirstBadLanding rStar tHi n S S H :=
          hrun.toGeneratedFirstBadLanding hr (by omega) (by omega) hhH hbadHi
        have hmem : n ∈ generatedFirstBadSources M S S H rStar tHi :=
          mem_generatedFirstBadSources.mpr ⟨hnShell, hgen⟩
        simp [twoRegimeFailureEnvelope, hmem]
      · have hgen : HasGeneratedFirstBadLanding rStar tLo n S S H :=
          hrun.toGeneratedFirstBadLanding hr (by omega) (by omega) hhH hbadLo
        have hmem : n ∈ generatedFirstBadSources M S S H rStar tLo :=
          mem_generatedFirstBadSources.mpr ⟨hnShell, hgen⟩
        simp [twoRegimeFailureEnvelope, hmem]
    · have hgen : HasGeneratedFirstBadLanding rStar tLo n L (S - 1) H :=
        hrun.toGeneratedFirstBadLanding hr hLq (by omega) hhH hLow.2
      have hmem : n ∈ generatedFirstBadSources M L (S - 1) H rStar tLo :=
        mem_generatedFirstBadSources.mpr ⟨hnShell, hgen⟩
      simp [twoRegimeFailureEnvelope, hmem]

theorem twoRegimeFailureSources_card_le_envelope
    {M L S U H : ℕ} {rStar : ℚ} {tHi tLo : ℝ}
    (hr : 0 < rStar) :
    (twoRegimeFailureSources M L S U H rStar tHi tLo).card ≤
      (twoRegimeFailureEnvelope M L S U H rStar tHi tLo).card :=
  Finset.card_le_card (twoRegimeFailureSources_subset_envelope hr)

theorem twoRegimeFailureSources_density_le_envelope
    {M L S U H : ℕ} {rStar : ℚ} {tHi tLo B : ℝ}
    (hr : 0 < rStar)
    (hEnvelope :
      ((twoRegimeFailureEnvelope M L S U H rStar tHi tLo).card : ℝ) /
        (2 : ℝ) ^ M ≤ B) :
    ((twoRegimeFailureSources M L S U H rStar tHi tLo).card : ℝ) /
        (2 : ℝ) ^ M ≤ B := by
  have hcardNat := twoRegimeFailureSources_card_le_envelope
    (M := M) (L := L) (S := S) (U := U) (H := H)
    (rStar := rStar) (tHi := tHi) (tLo := tLo) hr
  have hcard :
      ((twoRegimeFailureSources M L S U H rStar tHi tLo).card : ℝ) ≤
        ((twoRegimeFailureEnvelope M L S U H rStar tHi tLo).card : ℝ) := by
    exact_mod_cast hcardNat
  exact (div_le_div_of_nonneg_right hcard (by positivity)).trans hEnvelope

/-- Exact union bound for the five two-regime failure components. -/
theorem twoRegimeFailureEnvelope_card_le
    (M L S U H : ℕ) (rStar : ℚ) (tHi tLo : ℝ) :
    (twoRegimeFailureEnvelope M L S U H rStar tHi tLo).card ≤
      (shellInitialWindowBad M tHi).card +
      (generatedFirstBadSources M (S + 1) U H rStar tHi).card +
      (generatedFirstBadSources M S S H rStar tHi).card +
      (generatedFirstBadSources M S S H rStar tLo).card +
      (generatedFirstBadSources M L (S - 1) H rStar tLo).card := by
  classical
  unfold twoRegimeFailureEnvelope
  calc
    (shellInitialWindowBad M tHi ∪
      generatedFirstBadSources M (S + 1) U H rStar tHi ∪
      generatedFirstBadSources M S S H rStar tHi ∪
      generatedFirstBadSources M S S H rStar tLo ∪
      generatedFirstBadSources M L (S - 1) H rStar tLo).card ≤
        (shellInitialWindowBad M tHi ∪
          generatedFirstBadSources M (S + 1) U H rStar tHi ∪
          generatedFirstBadSources M S S H rStar tHi ∪
          generatedFirstBadSources M S S H rStar tLo).card +
        (generatedFirstBadSources M L (S - 1) H rStar tLo).card :=
      Finset.card_union_le _ _
    _ ≤ ((shellInitialWindowBad M tHi ∪
          generatedFirstBadSources M (S + 1) U H rStar tHi ∪
          generatedFirstBadSources M S S H rStar tHi).card +
        (generatedFirstBadSources M S S H rStar tLo).card) +
        (generatedFirstBadSources M L (S - 1) H rStar tLo).card := by
      gcongr
      exact Finset.card_union_le _ _
    _ ≤ (((shellInitialWindowBad M tHi ∪
          generatedFirstBadSources M (S + 1) U H rStar tHi).card +
        (generatedFirstBadSources M S S H rStar tHi).card) +
        (generatedFirstBadSources M S S H rStar tLo).card) +
        (generatedFirstBadSources M L (S - 1) H rStar tLo).card := by
      gcongr
      exact Finset.card_union_le _ _
    _ ≤ ((((shellInitialWindowBad M tHi).card +
        (generatedFirstBadSources M (S + 1) U H rStar tHi).card) +
        (generatedFirstBadSources M S S H rStar tHi).card) +
        (generatedFirstBadSources M S S H rStar tLo).card) +
        (generatedFirstBadSources M L (S - 1) H rStar tLo).card := by
      gcongr
      exact Finset.card_union_le _ _
    _ = (shellInitialWindowBad M tHi).card +
      (generatedFirstBadSources M (S + 1) U H rStar tHi).card +
      (generatedFirstBadSources M S S H rStar tHi).card +
      (generatedFirstBadSources M S S H rStar tLo).card +
      (generatedFirstBadSources M L (S - 1) H rStar tLo).card := by omega

/-- Normalize the exact five-piece union.  This lemma intentionally knows
nothing about the estimates used on the individual components. -/
theorem twoRegimeFailureEnvelope_density_le_of_components
    {M L S U H : ℕ} {rStar : ℚ} {tHi tLo A B C D E : ℝ}
    (hA : ((shellInitialWindowBad M tHi).card : ℝ) / (2 : ℝ) ^ M ≤ A)
    (hB : ((generatedFirstBadSources M (S + 1) U H rStar tHi).card : ℝ) /
      (2 : ℝ) ^ M ≤ B)
    (hC : ((generatedFirstBadSources M S S H rStar tHi).card : ℝ) /
      (2 : ℝ) ^ M ≤ C)
    (hD : ((generatedFirstBadSources M S S H rStar tLo).card : ℝ) /
      (2 : ℝ) ^ M ≤ D)
    (hE : ((generatedFirstBadSources M L (S - 1) H rStar tLo).card : ℝ) /
      (2 : ℝ) ^ M ≤ E) :
    ((twoRegimeFailureEnvelope M L S U H rStar tHi tLo).card : ℝ) /
      (2 : ℝ) ^ M ≤ A + B + C + D + E := by
  have hcardNat := twoRegimeFailureEnvelope_card_le
    M L S U H rStar tHi tLo
  have hcard :
      ((twoRegimeFailureEnvelope M L S U H rStar tHi tLo).card : ℝ) ≤
        ((shellInitialWindowBad M tHi).card : ℝ) +
        ((generatedFirstBadSources M (S + 1) U H rStar tHi).card : ℝ) +
        ((generatedFirstBadSources M S S H rStar tHi).card : ℝ) +
        ((generatedFirstBadSources M S S H rStar tLo).card : ℝ) +
        ((generatedFirstBadSources M L (S - 1) H rStar tLo).card : ℝ) := by
    exact_mod_cast hcardNat
  have hpow : 0 < (2 : ℝ) ^ M := by positivity
  have hdiv := div_le_div_of_nonneg_right hcard hpow.le
  calc
    ((twoRegimeFailureEnvelope M L S U H rStar tHi tLo).card : ℝ) /
        (2 : ℝ) ^ M ≤
      (((shellInitialWindowBad M tHi).card : ℝ) +
        ((generatedFirstBadSources M (S + 1) U H rStar tHi).card : ℝ) +
        ((generatedFirstBadSources M S S H rStar tHi).card : ℝ) +
        ((generatedFirstBadSources M S S H rStar tLo).card : ℝ) +
        ((generatedFirstBadSources M L (S - 1) H rStar tLo).card : ℝ)) /
          (2 : ℝ) ^ M := hdiv
    _ = ((shellInitialWindowBad M tHi).card : ℝ) / (2 : ℝ) ^ M +
        ((generatedFirstBadSources M (S + 1) U H rStar tHi).card : ℝ) /
          (2 : ℝ) ^ M +
        ((generatedFirstBadSources M S S H rStar tHi).card : ℝ) /
          (2 : ℝ) ^ M +
        ((generatedFirstBadSources M S S H rStar tLo).card : ℝ) /
          (2 : ℝ) ^ M +
        ((generatedFirstBadSources M L (S - 1) H rStar tLo).card : ℝ) /
          (2 : ℝ) ^ M := by ring
    _ ≤ A + B + C + D + E := by linarith

/-- Normalize the entropy-sharp initial-shell count. -/
theorem shellInitialWindowBad_density_le
    {M : ℕ} {t b : ℝ}
    (hcard : ((shellInitialWindowBad M t).card : ℝ) ≤
      (2 : ℝ) ^ (M + 1) * Real.exp (-((M : ℝ) * b))) :
    ((shellInitialWindowBad M t).card : ℝ) / (2 : ℝ) ^ M ≤
      2 * Real.exp (-((M : ℝ) * b)) := by
  have hpow : 0 < (2 : ℝ) ^ M := by positivity
  have hdiv := div_le_div_of_nonneg_right hcard hpow.le
  calc
    ((shellInitialWindowBad M t).card : ℝ) / (2 : ℝ) ^ M ≤
        ((2 : ℝ) ^ (M + 1) * Real.exp (-((M : ℝ) * b))) /
          (2 : ℝ) ^ M := hdiv
    _ = 2 * Real.exp (-((M : ℝ) * b)) := by
      rw [pow_succ]
      field_simp [hpow.ne']
      ring

/-- Explicit two-regime terminal profile.  The switch rank is charged once
to each certification complement; all rank factors are absorbed using strict
rate margins. -/
theorem twoRegimeFailureEnvelope_density_terminalProfile
    {M L S U H : ℕ} {rStar : ℚ}
    {tHi tLo bHi bHi' bLo bLo' c' : ℝ}
    (hr : 0 < rStar) (hUM : U < M)
    (hL1 : 1 ≤ L) (hLS : L ≤ S) (hSU : S ≤ U)
    (hsmall : ∀ q ∈ Finset.Icc L U,
      ((((q + 2 : ℕ) : ℚ) / rStar) / ((2 ^ q : ℕ) : ℚ)) ≤ 1 / 3)
    (hInitial : ((shellInitialWindowBad M tHi).card : ℝ) ≤
      (2 : ℝ) ^ (M + 1) * Real.exp (-((M : ℝ) * bHi)))
    (hHi : ∀ q ∈ Finset.Icc S U,
      ((landingBad q tHi).card : ℝ) ≤
        1 + (2 : ℝ) ^ q * Real.exp (-(((q - 1 : ℕ) : ℝ) * bHi)))
    (hLo : ∀ q ∈ Finset.Icc L S,
      ((landingBad q tLo).card : ℝ) ≤
        1 + (2 : ℝ) ^ q * Real.exp (-(((q - 1 : ℕ) : ℝ) * bLo)))
    (hbHi' : 0 < bHi') (hHiRate : bHi' < bHi)
    (hbLo' : 0 < bLo') (hLoRate : bLo' < bLo)
    (hc' : 0 < c') (hc2 : c' < Real.log 2) :
    ((twoRegimeFailureEnvelope M L S U H rStar tHi tLo).card : ℝ) /
        (2 : ℝ) ^ M ≤
      2 * Real.exp (-((M : ℝ) * bHi)) +
      (H : ℝ) * (1 + 6 / (rStar : ℝ)) *
        terminalTailBound bHi bHi' c' (S + 1) +
      (H : ℝ) * (1 + 6 / (rStar : ℝ)) *
        terminalTailBound bHi bHi' c' S +
      (H : ℝ) * (1 + 6 / (rStar : ℝ)) *
        terminalTailBound bLo bLo' c' S +
      (H : ℝ) * (1 + 6 / (rStar : ℝ)) *
        terminalTailBound bLo bLo' c' L := by
  have hS1 : 1 ≤ S := hL1.trans hLS
  have hHighSmall : ∀ q ∈ Finset.Icc (S + 1) U,
      ((((q + 2 : ℕ) : ℚ) / rStar) / ((2 ^ q : ℕ) : ℚ)) ≤ 1 / 3 := by
    intro q hq
    have hqI := Finset.mem_Icc.mp hq
    apply hsmall q
    exact Finset.mem_Icc.mpr
      ⟨hLS.trans (by omega : S ≤ q), hqI.2⟩
  have hSwitchSmall : ∀ q ∈ Finset.Icc S S,
      ((((q + 2 : ℕ) : ℚ) / rStar) / ((2 ^ q : ℕ) : ℚ)) ≤ 1 / 3 := by
    intro q hq
    have hqI := Finset.mem_Icc.mp hq
    have hqS : q = S := by omega
    subst q
    exact hsmall S (Finset.mem_Icc.mpr ⟨hLS, hSU⟩)
  have hLowSmall : ∀ q ∈ Finset.Icc L (S - 1),
      ((((q + 2 : ℕ) : ℚ) / rStar) / ((2 ^ q : ℕ) : ℚ)) ≤ 1 / 3 := by
    intro q hq
    apply hsmall q
    exact Finset.mem_Icc.mpr
      ⟨(Finset.mem_Icc.mp hq).1, (Finset.mem_Icc.mp hq).2.trans
        (Nat.sub_le S 1) |>.trans hSU⟩
  have hHighLanding : ∀ q ∈ Finset.Icc (S + 1) U,
      ((landingBad q tHi).card : ℝ) ≤
        1 + (2 : ℝ) ^ q * Real.exp (-(((q - 1 : ℕ) : ℝ) * bHi)) := by
    intro q hq
    have hqI := Finset.mem_Icc.mp hq
    exact hHi q (Finset.mem_Icc.mpr
      ⟨by omega, hqI.2⟩)
  have hSwitchHi : ∀ q ∈ Finset.Icc S S,
      ((landingBad q tHi).card : ℝ) ≤
        1 + (2 : ℝ) ^ q * Real.exp (-(((q - 1 : ℕ) : ℝ) * bHi)) := by
    intro q hq
    have hqI := Finset.mem_Icc.mp hq
    have hqS : q = S := by omega
    subst q
    exact hHi S (Finset.mem_Icc.mpr ⟨le_rfl, hSU⟩)
  have hSwitchLo : ∀ q ∈ Finset.Icc S S,
      ((landingBad q tLo).card : ℝ) ≤
        1 + (2 : ℝ) ^ q * Real.exp (-(((q - 1 : ℕ) : ℝ) * bLo)) := by
    intro q hq
    have hqI := Finset.mem_Icc.mp hq
    have hqS : q = S := by omega
    subst q
    exact hLo S (Finset.mem_Icc.mpr ⟨hLS, le_rfl⟩)
  have hLowLanding : ∀ q ∈ Finset.Icc L (S - 1),
      ((landingBad q tLo).card : ℝ) ≤
        1 + (2 : ℝ) ^ q * Real.exp (-(((q - 1 : ℕ) : ℝ) * bLo)) := by
    intro q hq
    exact hLo q (Finset.mem_Icc.mpr
      ⟨(Finset.mem_Icc.mp hq).1,
        (Finset.mem_Icc.mp hq).2.trans (Nat.sub_le S 1)⟩)
  have hA := shellInitialWindowBad_density_le hInitial
  have hB := generatedFirstBadSources_density_terminalProfile
    (M := M) (L := S + 1) (U := U) (H := H)
    (r := rStar) (t := tHi) hr hUM (by omega)
    hHighSmall hHighLanding hbHi' hHiRate hc' hc2
  have hC := generatedFirstBadSources_density_terminalProfile
    (M := M) (L := S) (U := S) (H := H)
    (r := rStar) (t := tHi) hr (hSU.trans_lt hUM) hS1
    hSwitchSmall hSwitchHi hbHi' hHiRate hc' hc2
  have hD := generatedFirstBadSources_density_terminalProfile
    (M := M) (L := S) (U := S) (H := H)
    (r := rStar) (t := tLo) hr (hSU.trans_lt hUM) hS1
    hSwitchSmall hSwitchLo hbLo' hLoRate hc' hc2
  have hE := generatedFirstBadSources_density_terminalProfile
    (M := M) (L := L) (U := S - 1) (H := H)
    (r := rStar) (t := tLo) hr ((Nat.sub_le S 1).trans_lt (hSU.trans_lt hUM)) hL1
    hLowSmall hLowLanding hbLo' hLoRate hc' hc2
  exact twoRegimeFailureEnvelope_density_le_of_components hA hB hC hD hE

end

end FirstPassageLinearTransport
