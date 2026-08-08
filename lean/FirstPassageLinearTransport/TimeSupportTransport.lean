/-
Copyright (c) 2026 Idris Ali Shaik. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Idris Ali Shaik
-/
import FirstPassageLinearTransport.LossTransport

/-!
# First-passage transport on an explicit time support

The older transport interface sums over every positive time up to one global
horizon.  The shrinking-barrier argument knows a smaller finite set of
feasible cumulative times.  This module records the exact replacement: the
transport cost is the cardinality of that set, with no interval or density
assumption on it.
-/

namespace FirstPassageLinearTransport

noncomputable section

/-- Loss-filtered sources whose actual first-passage time belongs to the
declared finite support. -/
noncomputable def lossFilteredTransportedSourcesAtTimes
    (M Y : ℕ) (times B : Finset ℕ) (D : ℚ) : Finset ℕ := by
  classical
  exact times.biUnion fun h =>
    B.biUnion fun y => lossFilteredTaggedFiber M Y h y D

@[simp] theorem mem_lossFilteredTransportedSourcesAtTimes
    {M Y n : ℕ} {times B : Finset ℕ} {D : ℚ} :
    n ∈ lossFilteredTransportedSourcesAtTimes M Y times B D ↔
      n ∈ dyadicShell M ∧
        ∃ h : ℕ, h ∈ times ∧ IsFirstPassage Y n h ∧
          orbit h n ∈ B ∧ scaledReverseLoss Y n h ≤ D := by
  classical
  constructor
  · intro hn
    unfold lossFilteredTransportedSourcesAtTimes at hn
    rcases Finset.mem_biUnion.mp hn with ⟨h, hh, hn⟩
    rcases Finset.mem_biUnion.mp hn with ⟨y, hy, hn⟩
    have htag := mem_lossFilteredTaggedFiber.mp hn
    exact ⟨htag.1, h, hh, htag.2.1, by simpa [htag.2.2.1] using hy,
      htag.2.2.2⟩
  · rintro ⟨hShell, h, hh, hfp, hB, hloss⟩
    unfold lossFilteredTransportedSourcesAtTimes
    apply Finset.mem_biUnion.mpr
    refine ⟨h, hh, ?_⟩
    apply Finset.mem_biUnion.mpr
    refine ⟨orbit h n, hB, ?_⟩
    exact mem_lossFilteredTaggedFiber.mpr ⟨hShell, hfp, rfl, hloss⟩

/-- Arbitrary-target transport over a finite set of actual time tags. -/
theorem lossFiltered_arbitraryTarget_transport_atTimes
    {M Y : ℕ} (times B : Finset ℕ) {D : ℚ}
    (hY : 0 < Y) (hD : 0 ≤ D)
    (hsmall : D / (Y : ℚ) ≤ 1 / 3) :
    ((lossFilteredTransportedSourcesAtTimes M Y times B D).card : ℚ) ≤
      (times.card : ℚ) *
        (1 + 3 * D * (2 : ℚ) ^ M / (Y : ℚ)) * (B.card : ℚ) := by
  classical
  have houter := card_biUnion_le_sum times fun h =>
    B.biUnion fun y => lossFilteredTaggedFiber M Y h y D
  have hcardNat :
      (lossFilteredTransportedSourcesAtTimes M Y times B D).card ≤
        ∑ h in times, ∑ y in B,
          (lossFilteredTaggedFiber M Y h y D).card := by
    unfold lossFilteredTransportedSourcesAtTimes
    calc
      (times.biUnion fun h =>
          B.biUnion fun y => lossFilteredTaggedFiber M Y h y D).card ≤
          ∑ h in times,
            (B.biUnion fun y => lossFilteredTaggedFiber M Y h y D).card :=
        houter
      _ ≤ ∑ h in times, ∑ y in B,
          (lossFilteredTaggedFiber M Y h y D).card := by
        apply Finset.sum_le_sum
        intro h _hh
        exact card_biUnion_le_sum B fun y =>
          lossFilteredTaggedFiber M Y h y D
  have hcardQ :
      ((lossFilteredTransportedSourcesAtTimes M Y times B D).card : ℚ) ≤
        ∑ h in times, ∑ y in B,
          ((lossFilteredTaggedFiber M Y h y D).card : ℚ) := by
    exact_mod_cast hcardNat
  let K : ℚ := 1 + 3 * D * (2 : ℚ) ^ M / (Y : ℚ)
  calc
    ((lossFilteredTransportedSourcesAtTimes M Y times B D).card : ℚ) ≤
        ∑ h in times, ∑ y in B,
          ((lossFilteredTaggedFiber M Y h y D).card : ℚ) := hcardQ
    _ ≤ ∑ _h in times, ∑ _y in B, K := by
      apply Finset.sum_le_sum
      intro h _hh
      apply Finset.sum_le_sum
      intro y _hy
      exact lossFilteredTaggedFiber_bound hY hD hsmall
    _ = (times.card : ℚ) *
        (1 + 3 * D * (2 : ℚ) ^ M / (Y : ℚ)) * (B.card : ℚ) := by
      simp [K]
      ring

/-- Uniform support-sensitive transport below the source shell. -/
theorem lossFiltered_arbitraryTarget_transport_atTimes_uniform
    {M Y : ℕ} (times B : Finset ℕ) {D : ℚ}
    (hY : 0 < Y) (hD : 0 ≤ D)
    (hsmall : D / (Y : ℚ) ≤ 1 / 3) (hYM : Y < 2 ^ M) :
    ((lossFilteredTransportedSourcesAtTimes M Y times B D).card : ℚ) ≤
      (times.card : ℚ) * (1 + 3 * D) *
        (2 : ℚ) ^ M / (Y : ℚ) * (B.card : ℚ) := by
  have hYQ : (0 : ℚ) < (Y : ℚ) := by exact_mod_cast hY
  have hYMq : (Y : ℚ) < (2 : ℚ) ^ M := by exact_mod_cast hYM
  have hratio : (1 : ℚ) ≤ (2 : ℚ) ^ M / (Y : ℚ) := by
    apply (le_div_iff₀ hYQ).2
    simpa using hYMq.le
  have hK :
      1 + 3 * D * (2 : ℚ) ^ M / (Y : ℚ) ≤
        (1 + 3 * D) * (2 : ℚ) ^ M / (Y : ℚ) := by
    calc
      1 + 3 * D * (2 : ℚ) ^ M / (Y : ℚ) ≤
          (2 : ℚ) ^ M / (Y : ℚ) +
            3 * D * (2 : ℚ) ^ M / (Y : ℚ) :=
        add_le_add_right hratio _
      _ = (1 + 3 * D) * (2 : ℚ) ^ M / (Y : ℚ) := by ring
  have hbase := lossFiltered_arbitraryTarget_transport_atTimes
    (M := M) (Y := Y) (D := D) times B hY hD hsmall
  have hcoef : 0 ≤ (times.card : ℚ) * (B.card : ℚ) := by positivity
  calc
    ((lossFilteredTransportedSourcesAtTimes M Y times B D).card : ℚ) ≤
        (times.card : ℚ) *
          (1 + 3 * D * (2 : ℚ) ^ M / (Y : ℚ)) * (B.card : ℚ) := hbase
    _ = ((times.card : ℚ) * (B.card : ℚ)) *
          (1 + 3 * D * (2 : ℚ) ^ M / (Y : ℚ)) := by ring
    _ ≤ ((times.card : ℚ) * (B.card : ℚ)) *
          ((1 + 3 * D) * (2 : ℚ) ^ M / (Y : ℚ)) :=
      mul_le_mul_of_nonneg_left hK hcoef
    _ = (times.card : ℚ) * (1 + 3 * D) *
        (2 : ℚ) ^ M / (Y : ℚ) * (B.card : ℚ) := by ring

/-- An arbitrary source restriction cannot increase the support-sensitive
transport count. -/
theorem lossFiltered_arbitraryTarget_transport_atTimes_restricted
    {M Y : ℕ} (times B A : Finset ℕ) {D : ℚ}
    (hY : 0 < Y) (hD : 0 ≤ D)
    (hsmall : D / (Y : ℚ) ≤ 1 / 3) (hYM : Y < 2 ^ M) :
    (((lossFilteredTransportedSourcesAtTimes M Y times B D) ∩ A).card : ℚ) ≤
      (times.card : ℚ) * (1 + 3 * D) *
        (2 : ℚ) ^ M / (Y : ℚ) * (B.card : ℚ) := by
  have hcard :
      (((lossFilteredTransportedSourcesAtTimes M Y times B D) ∩ A).card : ℚ) ≤
        ((lossFilteredTransportedSourcesAtTimes M Y times B D).card : ℚ) := by
    exact_mod_cast Finset.card_le_card Finset.inter_subset_left
  exact hcard.trans
    (lossFiltered_arbitraryTarget_transport_atTimes_uniform
      times B hY hD hsmall hYM)

end

end FirstPassageLinearTransport
