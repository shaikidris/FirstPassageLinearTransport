/-
Copyright (c) 2026 Idris Ali Shaik. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Idris Ali Shaik
-/
/- Generated source-preserving extraction: declarations in this module are outside the canonical referee-facing roots. -/
import Mathlib.Analysis.SpecialFunctions.Stirling
import Mathlib.Data.Fintype.Powerset
import Mathlib.Data.Nat.Choose.Sum
import Mathlib.Order.Interval.Finset.Nat
import FirstPassageLinearTransport.EntropyBarrier

import FirstPassageLinearTransport.SharpEntropyBarrier
/-!
# Sharp-prefactor Boolean barrier

This module refines the entropy barrier by retaining the local
`M^{-1/2}` binomial prefactor.  The proof is deliberately split into three
independent pieces: a finite reflection/first-hit comparison, a binomial-tail
estimate, and a uniform Stirling estimate.  No probabilistic independence
assumption is used.
-/

namespace FirstPassageLinearTransport

open scoped BigOperators Real

noncomputable section

/-- Number of `r`-step continuations whose terminal position is at least the
integer level `a`.  This recursive presentation is convenient for the exact
first-hit comparison. -/
def endpointUpperCount (a : ℤ) : ℕ → ℤ → ℕ
  | 0, y => if a ≤ y then 1 else 0
  | r + 1, y => endpointUpperCount a r (y - 1) + endpointUpperCount a r (y + 1)

/-- Number of continuations which visit the upper half-line `[a,∞)` at
some inspected vertex, including the starting vertex. -/
def upperBarrierCount (a : ℤ) : ℕ → ℤ → ℕ
  | 0, y => if a ≤ y then 1 else 0
  | r + 1, y =>
      if a ≤ y then 2 ^ (r + 1)
      else upperBarrierCount a r (y - 1) + upperBarrierCount a r (y + 1)

/-- Integer two-sided barrier count. -/
def integerBarrierCount (a : ℕ) : ℕ → ℤ → ℕ
  | 0, y => if (a : ℤ) ≤ |y| then 1 else 0
  | r + 1, y =>
      if (a : ℤ) ≤ |y| then 2 ^ (r + 1)
      else integerBarrierCount a r (y - 1) + integerBarrierCount a r (y + 1)

theorem endpointUpperCount_mono_start (a : ℤ) (r : ℕ) :
    Monotone (endpointUpperCount a r) := by
  induction r with
  | zero =>
      intro y z hyz
      simp only [endpointUpperCount]
      split_ifs <;> omega
  | succ r ihr =>
      intro y z hyz
      simp only [endpointUpperCount]
      exact Nat.add_le_add (ihr (by omega)) (ihr (by omega))

/-- Complementing every remaining bit pairs the terminal thresholds `d` and
`1-d`. -/
theorem endpointUpperCount_complement (a y : ℤ) (r : ℕ) :
    endpointUpperCount a r y + endpointUpperCount a r (2 * a - 1 - y) =
      2 ^ r := by
  induction r generalizing y with
  | zero =>
      simp only [endpointUpperCount, pow_zero]
      split_ifs <;> omega
  | succ r ihr =>
      simp only [endpointUpperCount, pow_succ]
      have hminus := ihr (y := y - 1)
      have hplus := ihr (y := y + 1)
      calc
        endpointUpperCount a r (y - 1) + endpointUpperCount a r (y + 1) +
              (endpointUpperCount a r (2 * a - 1 - y - 1) +
                endpointUpperCount a r (2 * a - 1 - y + 1)) =
            (endpointUpperCount a r (y - 1) +
                endpointUpperCount a r (2 * a - 1 - (y - 1))) +
              (endpointUpperCount a r (y + 1) +
                endpointUpperCount a r (2 * a - 1 - (y + 1))) := by
                  have hleft : 2 * a - 1 - y - 1 = 2 * a - 1 - (y + 1) := by ring
                  have hright : 2 * a - 1 - y + 1 = 2 * a - 1 - (y - 1) := by ring
                  rw [hleft, hright]
                  ac_rfl
        _ = 2 ^ r + 2 ^ r := by rw [hminus, hplus]
        _ = 2 ^ r * 2 := by omega

/-- At least half of all symmetric continuations finish above their starting
level. -/
theorem pow_le_two_mul_endpointUpperCount_of_le
    {a y : ℤ} {r : ℕ} (hay : a ≤ y) :
    2 ^ r ≤ 2 * endpointUpperCount a r y := by
  have hcenter := endpointUpperCount_complement a a r
  have hcenter' :
      endpointUpperCount a r a + endpointUpperCount a r (a - 1) = 2 ^ r := by
    convert hcenter using 1 <;> ring
  have hmono1 : endpointUpperCount a r (a - 1) ≤ endpointUpperCount a r a :=
    endpointUpperCount_mono_start a r (by omega)
  have hmono2 : endpointUpperCount a r a ≤ endpointUpperCount a r y :=
    endpointUpperCount_mono_start a r hay
  calc
    2 ^ r = endpointUpperCount a r a + endpointUpperCount a r (a - 1) :=
      hcenter'.symm
    _ ≤ endpointUpperCount a r a + endpointUpperCount a r a :=
      Nat.add_le_add_left hmono1 _
    _ = 2 * endpointUpperCount a r a := by omega
    _ ≤ 2 * endpointUpperCount a r y := Nat.mul_le_mul_left 2 hmono2

/-- A one-sided first-hit count is at most twice the corresponding terminal
tail.  This is the reflection-principle input in a recursion-friendly form. -/
theorem upperBarrierCount_le_two_endpointUpperCount
    (a y : ℤ) (r : ℕ) :
    upperBarrierCount a r y ≤ 2 * endpointUpperCount a r y := by
  induction r generalizing y with
  | zero =>
      simp only [upperBarrierCount, endpointUpperCount]
      split_ifs <;> omega
  | succ r ihr =>
      by_cases hay : a ≤ y
      · rw [upperBarrierCount]
        simp only [if_pos hay]
        exact pow_le_two_mul_endpointUpperCount_of_le hay
      · rw [upperBarrierCount]
        simp only [if_neg hay, endpointUpperCount]
        have hminus := ihr (y := y - 1)
        have hplus := ihr (y := y + 1)
        omega

/-- The two-sided barrier is dominated by the sum of its two one-sided
versions. -/
theorem integerBarrierCount_le_upper_add_reflected
    (a : ℕ) (r : ℕ) (y : ℤ) :
    integerBarrierCount a r y ≤
      upperBarrierCount (a : ℤ) r y + upperBarrierCount (a : ℤ) r (-y) := by
  induction r generalizing y with
  | zero =>
      simp only [integerBarrierCount, upperBarrierCount]
      by_cases hy : (a : ℤ) ≤ |y|
      · simp only [if_pos hy]
        rcases le_total 0 y with hy0 | hy0
        · have hay : (a : ℤ) ≤ y := by simpa [abs_of_nonneg hy0] using hy
          simp [hay]
        · have hay : (a : ℤ) ≤ -y := by simpa [abs_of_nonpos hy0] using hy
          simp [hay]
      · simp [hy]
  | succ r ihr =>
      by_cases hy : (a : ℤ) ≤ |y|
      · rw [integerBarrierCount]
        simp only [if_pos hy]
        rcases le_total 0 y with hy0 | hy0
        · have hay : (a : ℤ) ≤ y := by simpa [abs_of_nonneg hy0] using hy
          have hfull : upperBarrierCount (a : ℤ) (r + 1) y = 2 ^ (r + 1) := by
            simp [upperBarrierCount, hay]
          rw [hfull]
          omega
        · have hay : (a : ℤ) ≤ -y := by simpa [abs_of_nonpos hy0] using hy
          have hfull : upperBarrierCount (a : ℤ) (r + 1) (-y) = 2 ^ (r + 1) := by
            simp [upperBarrierCount, hay]
          rw [hfull]
          omega
      · have hsafe : ¬(a : ℤ) ≤ y ∧ ¬(a : ℤ) ≤ -y := by
          constructor <;> intro h <;> apply hy
          · exact h.trans (le_abs_self y)
          · simpa [abs_neg] using h.trans (le_abs_self (-y))
        rw [integerBarrierCount]
        simp only [if_neg hy]
        rw [upperBarrierCount, upperBarrierCount]
        simp only [if_neg hsafe.1, if_neg hsafe.2]
        have hminus := ihr (y := y - 1)
        have hplus := ihr (y := y + 1)
        calc
          integerBarrierCount a r (y - 1) + integerBarrierCount a r (y + 1) ≤
              (upperBarrierCount (a : ℤ) r (y - 1) +
                  upperBarrierCount (a : ℤ) r (-(y - 1))) +
                (upperBarrierCount (a : ℤ) r (y + 1) +
                  upperBarrierCount (a : ℤ) r (-(y + 1))) :=
            Nat.add_le_add hminus hplus
          _ = upperBarrierCount (a : ℤ) r (y - 1) +
                upperBarrierCount (a : ℤ) r (y + 1) +
                  (upperBarrierCount (a : ℤ) r (-y - 1) +
                    upperBarrierCount (a : ℤ) r (-y + 1)) := by
              have hminus' : -(y - 1) = -y + 1 := by ring
              have hplus' : -(y + 1) = -y - 1 := by ring
              rw [hminus', hplus']
              ac_rfl

theorem integerBarrierCount_le_four_endpointUpperCount (a r : ℕ) :
    integerBarrierCount a r 0 ≤ 4 * endpointUpperCount (a : ℤ) r 0 := by
  calc
    integerBarrierCount a r 0 ≤
        upperBarrierCount (a : ℤ) r 0 + upperBarrierCount (a : ℤ) r 0 := by
      simpa using integerBarrierCount_le_upper_add_reflected a r 0
    _ ≤ 4 * endpointUpperCount (a : ℤ) r 0 := by
      have h := upperBarrierCount_le_two_endpointUpperCount (a : ℤ) 0 r
      omega

private theorem half_lt_abs_cast_iff {a : ℕ} {y : ℤ} :
    (a : ℝ) - 1 / 2 < |(y : ℝ)| ↔ (a : ℤ) ≤ |y| := by
  have habs : |(y : ℝ)| = ((|y| : ℤ) : ℝ) := by exact_mod_cast rfl
  rw [habs]
  constructor
  · intro h
    by_contra hnot
    have hy : |y| < (a : ℤ) := lt_of_not_ge hnot
    have hyInt : |y| ≤ (a : ℤ) - 1 := by omega
    have hy' : ((|y| : ℤ) : ℝ) ≤ ((a : ℤ) : ℝ) - 1 := by
      exact_mod_cast hyInt
    norm_num at h hy' ⊢
    linarith
  · intro h
    have h' : ((a : ℤ) : ℝ) ≤ ((|y| : ℤ) : ℝ) := by exact_mod_cast h
    norm_num at h' ⊢
    linarith

/-- The existing real-threshold barrier count agrees with the integer count
when the real threshold is placed halfway between adjacent lattice levels. -/
theorem barrierHitCount_half_eq_integerBarrierCount (a r : ℕ) (y : ℤ) :
    barrierHitCount ((a : ℝ) - 1 / 2) r y = integerBarrierCount a r y := by
  classical
  induction r generalizing y with
  | zero =>
      by_cases hy : (a : ℤ) ≤ |y|
      · have hy' := half_lt_abs_cast_iff.mpr hy
        rw [barrierHitCount_of_bad hy']
        simp [integerBarrierCount, hy]
      · have hy' := half_lt_abs_cast_iff.not.mpr hy
        rw [barrierHitCount]
        have hempty :
            Finset.univ.filter
                (hitsBarrierFrom ((a : ℝ) - 1 / 2) 0 y) = ∅ := by
          apply Finset.filter_eq_empty_iff.mpr
          intro v hv
          simpa [hitsBarrierFrom] using hy'
        rw [hempty]
        simp [integerBarrierCount, hy]
  | succ r ihr =>
      by_cases hy : (a : ℤ) ≤ |y|
      · have hy' : (a : ℝ) - 1 / 2 < |(y : ℝ)| := half_lt_abs_cast_iff.mpr hy
        rw [barrierHitCount_of_bad hy']
        simp [integerBarrierCount, hy]
      · have hy' : ¬((a : ℝ) - 1 / 2 < |(y : ℝ)|) := by
          exact half_lt_abs_cast_iff.not.mpr hy
        rw [barrierHitCount_succ_of_safe hy']
        simp only [integerBarrierCount, if_neg hy]
        rw [ihr (y := y - 1), ihr (y := y + 1)]

/-- Raising the open barrier can only remove hitting words. -/
theorem hitsBarrierFrom_mono_threshold
    {a b : ℝ} (hab : a ≤ b) {r : ℕ} {y : ℤ} {v : Fin r → Bool}
    (h : hitsBarrierFrom b r y v) :
    hitsBarrierFrom a r y v := by
  induction r generalizing y with
  | zero =>
      simpa only [hitsBarrierFrom] using lt_of_le_of_lt hab h
  | succ r ihr =>
      rw [hitsBarrierFrom] at h ⊢
      rcases h with hnow | hlater
      · exact Or.inl (lt_of_le_of_lt hab hnow)
      · exact Or.inr (ihr hlater)

/-- The exact hitting count is antitone in the barrier height. -/
theorem barrierHitCount_antitone_threshold
    {a b : ℝ} (hab : a ≤ b) (r : ℕ) (y : ℤ) :
    barrierHitCount b r y ≤ barrierHitCount a r y := by
  classical
  unfold barrierHitCount
  apply Finset.card_le_card
  intro v hv
  simp only [Finset.mem_filter, Finset.mem_univ, true_and] at hv ⊢
  exact hitsBarrierFrom_mono_threshold hab hv

/-- Exact combinatorial reduction of a two-sided maximal event to one terminal
upper tail. -/
theorem barrierHitCount_half_le_four_endpointUpperCount (a r : ℕ) :
    barrierHitCount ((a : ℝ) - 1 / 2) r 0 ≤
      4 * endpointUpperCount (a : ℤ) r 0 := by
  rw [barrierHitCount_half_eq_integerBarrierCount]
  exact integerBarrierCount_le_four_endpointUpperCount a r

/-- Terminal upper-tail predicate on Boolean words. -/
def endpointUpperFrom (a : ℤ) (r : ℕ) (y : ℤ) (v : Fin r → Bool) : Prop :=
  a ≤ y + ∑ i, boolWalkStep (v i)

/-- Exact word count for the terminal upper tail. -/
noncomputable def endpointUpperWordCount (a : ℤ) (r : ℕ) (y : ℤ) : ℕ := by
  classical
  exact (Finset.univ.filter (endpointUpperFrom a r y)).card

noncomputable def endpointUpperSuccEquiv (a : ℤ) (r : ℕ) (y : ℤ) :
    {v : Fin (r + 1) → Bool // endpointUpperFrom a (r + 1) y v} ≃
      Σ b : Bool,
        {w : Fin r → Bool // endpointUpperFrom a r (y + boolWalkStep b) w} :=
  ((Fin.consEquiv (fun _ : Fin (r + 1) => Bool)).symm.subtypeEquiv (fun v => by
      change
        a ≤ y + ∑ i, boolWalkStep (v i) ↔
          a ≤ y + boolWalkStep (v 0) + ∑ i : Fin r, boolWalkStep (v i.succ)
      rw [Fin.sum_univ_succ]
      constructor <;> intro h <;> linarith)).trans
    (Equiv.subtypeProdEquivSigmaSubtype
      (fun b w => endpointUpperFrom a r (y + boolWalkStep b) w))

theorem endpointUpperWordCount_succ (a : ℤ) (r : ℕ) (y : ℤ) :
    endpointUpperWordCount a (r + 1) y =
      endpointUpperWordCount a r (y - 1) + endpointUpperWordCount a r (y + 1) := by
  classical
  have hc :
      Fintype.card {v : Fin (r + 1) → Bool // endpointUpperFrom a (r + 1) y v} =
        Fintype.card
          (Σ b : Bool,
            {w : Fin r → Bool // endpointUpperFrom a r (y + boolWalkStep b) w}) :=
    Fintype.card_congr (endpointUpperSuccEquiv a r y)
  simpa [endpointUpperWordCount, Fintype.card_subtype, Fintype.card_sigma,
    Fintype.sum_bool, sub_eq_add_neg, add_comm] using hc

theorem endpointUpperWordCount_eq_endpointUpperCount (a : ℤ) (r : ℕ) (y : ℤ) :
    endpointUpperWordCount a r y = endpointUpperCount a r y := by
  classical
  induction r generalizing y with
  | zero =>
      rw [endpointUpperWordCount]
      simp only [endpointUpperCount]
      have hp : endpointUpperFrom a 0 y = fun _ : Fin 0 → Bool => a ≤ y := by
        funext v
        simp [endpointUpperFrom]
      rw [hp]
      by_cases hay : a ≤ y <;> simp [hay]
  | succ r ihr =>
      rw [endpointUpperWordCount_succ, endpointUpperCount, ihr, ihr]



theorem boolWalkSum_eq_support (r : ℕ) (v : Fin r → Bool) :
    ∑ i, boolWalkStep (v i) = 2 * (boolSupport v).card - (r : ℤ) := by
  have hpoint (i : Fin r) :
      boolWalkStep (v i) = 2 * (if v i = true then (1 : ℤ) else 0) - 1 := by
    cases h : v i <;> simp [boolWalkStep, h]
  have hcard :
      ((boolSupport v).card : ℤ) =
        ∑ i, (if v i = true then (1 : ℤ) else 0) := by
    rw [boolSupport, Finset.card_eq_sum_ones]
    push_cast
    simp [Finset.sum_filter]
  calc
    ∑ i, boolWalkStep (v i) =
        ∑ i, (2 * (if v i = true then (1 : ℤ) else 0) - 1) := by
      exact Finset.sum_congr rfl fun i _ => hpoint i
    _ = 2 * (∑ i, (if v i = true then (1 : ℤ) else 0)) - (r : ℤ) := by
      rw [Finset.sum_sub_distrib, ← Finset.mul_sum]
      simp
    _ = 2 * (boolSupport v).card - (r : ℤ) := by rw [← hcard]

/-- The first true-count that can reach integer displacement `a`. -/
def endpointThreshold (r a : ℕ) : ℕ :=
  (r + a + 1) / 2

/-- Exact rounding window for the first reachable endpoint layer. -/
theorem endpointThreshold_double_bounds (r a : ℕ) :
    r + a ≤ 2 * endpointThreshold r a ∧
      2 * endpointThreshold r a < r + a + 2 := by
  unfold endpointThreshold
  omega

theorem endpointThreshold_pos {r a : ℕ} (hr : 0 < r) :
    0 < endpointThreshold r a := by
  unfold endpointThreshold
  omega

theorem endpointThreshold_lt_of_add_one_lt
    {r a : ℕ} (ha : a + 1 < r) :
    endpointThreshold r a < r := by
  rcases endpointThreshold_double_bounds r a with ⟨-, hupp⟩
  omega

/-- The upper endpoint layer is automatically above the lower quarter of the
binomial window. -/
theorem endpointThreshold_quarter_lower {r a : ℕ} :
    (r : ℝ) / 4 ≤ (endpointThreshold r a : ℝ) := by
  have hlower := (endpointThreshold_double_bounds r a).1
  have hlowerR : (r : ℝ) + (a : ℝ) ≤
      2 * (endpointThreshold r a : ℝ) := by exact_mod_cast hlower
  have haR : 0 ≤ (a : ℝ) := by positivity
  linarith

/-- If the displacement stays below the central quarter-window, so does the
rounded endpoint threshold. -/
theorem endpointThreshold_complement_quarter_lower
    {r a : ℕ} (ha : 2 * a + 4 ≤ r) :
    (r : ℝ) / 4 ≤ ((r - endpointThreshold r a : ℕ) : ℝ) := by
  have hupp := (endpointThreshold_double_bounds r a).2
  have hklt : endpointThreshold r a < r := by omega
  have hnat : r ≤ 4 * (r - endpointThreshold r a) := by omega
  have hnatR : (r : ℝ) ≤
      4 * ((r - endpointThreshold r a : ℕ) : ℝ) := by
    exact_mod_cast hnat
  linarith

theorem endpointUpperFrom_iff_support_card
    {r a : ℕ} {v : Fin r → Bool} (ha : a ≤ r) :
    endpointUpperFrom (a : ℤ) r 0 v ↔
      endpointThreshold r a ≤ (boolSupport v).card := by
  rw [endpointUpperFrom, zero_add, boolWalkSum_eq_support]
  unfold endpointThreshold
  have hcard : (boolSupport v).card ≤ r := card_finset_fin_le _
  omega



theorem endpointUpperCount_eq_binomialUpperTail
    {r a : ℕ} (ha : a ≤ r) :
    endpointUpperCount (a : ℤ) r 0 =
      binomialUpperTail r (endpointThreshold r a) := by
  classical
  rw [← endpointUpperWordCount_eq_endpointUpperCount]
  let e :
      {v : Fin r → Bool // endpointUpperFrom (a : ℤ) r 0 v} ≃
        {s : Finset (Fin r) // endpointThreshold r a ≤ s.card} :=
    (boolWordFinsetEquiv r).subtypeEquiv fun v => by
      change endpointUpperFrom (a : ℤ) r 0 v ↔
        endpointThreshold r a ≤ (boolSupport v).card
      exact endpointUpperFrom_iff_support_card ha
  have hc := Fintype.card_congr e
  have hk : endpointThreshold r a ≤ r := by
    unfold endpointThreshold
    omega
  rw [card_finsets_card_ge r (endpointThreshold r a) hk] at hc
  simpa [endpointUpperWordCount, Fintype.card_subtype] using hc











/-- The binary barrier rate increases with the displacement from one half on
the relevant half-interval. -/
theorem binaryBarrierRate_monotoneOn :
    MonotoneOn binaryBarrierRate (Set.Icc (0 : ℝ) (1 / 2)) := by
  intro x hx y hy hxy
  have hx' : 1 / 2 + x ∈ Set.Icc (2 : ℝ)⁻¹ 1 := by
    constructor <;> norm_num at hx ⊢ <;> linarith [hx.1, hx.2]
  have hy' : 1 / 2 + y ∈ Set.Icc (2 : ℝ)⁻¹ 1 := by
    constructor <;> norm_num at hy ⊢ <;> linarith [hy.1, hy.2]
  have hentropy := Real.binEntropy_strictAntiOn.antitoneOn hx' hy' (by linarith)
  unfold binaryBarrierRate
  linarith







/-- Sharp two-sided maximal-walk estimate at an integer barrier.  The
side-conditions state exactly that the corresponding terminal binomial layer
lies in a fixed positive-displacement, central quarter-window. -/
theorem exists_barrierHitCount_half_normalized_le_binaryBarrierRate
    {t₀ : ℝ} (ht₀ : 0 < t₀) :
    ∃ C : ℝ, 0 < C ∧
      ∀ r a : ℕ, 0 < r → a ≤ r →
        let k := endpointThreshold r a
        0 < k → k < r →
        (r : ℝ) * (1 / 2 + t₀) ≤ (k : ℝ) →
        (r : ℝ) / 4 ≤ (k : ℝ) →
        (r : ℝ) / 4 ≤ ((r - k : ℕ) : ℝ) →
        (barrierHitCount ((a : ℝ) - 1 / 2) r 0 : ℝ) /
            (2 : ℝ) ^ r ≤
          (C / Real.sqrt r) *
            Real.exp (-((r : ℝ) *
              binaryBarrierRate ((k : ℝ) / (r : ℝ) - 1 / 2))) := by
  obtain ⟨C₀, hC₀, htail⟩ :=
    exists_normalized_binomialUpperTail_le_binaryBarrierRate ht₀
  refine ⟨4 * C₀, mul_pos (by norm_num) hC₀, ?_⟩
  intro r a hr ha
  dsimp only
  intro hk hklt hgap hkLower hrkLower
  let k := endpointThreshold r a
  have hbarrier := barrierHitCount_half_le_four_endpointUpperCount a r
  have hendpoint := endpointUpperCount_eq_binomialUpperTail ha
  have hbarrierR :
      (barrierHitCount ((a : ℝ) - 1 / 2) r 0 : ℝ) ≤
        4 * (binomialUpperTail r k : ℝ) := by
    rw [hendpoint] at hbarrier
    exact_mod_cast hbarrier
  have hpowPos : 0 < (2 : ℝ) ^ r := by positivity
  have htail' := htail r k hr hk hklt hgap hkLower hrkLower
  calc
    (barrierHitCount ((a : ℝ) - 1 / 2) r 0 : ℝ) /
        (2 : ℝ) ^ r ≤
      (4 * (binomialUpperTail r k : ℝ)) / (2 : ℝ) ^ r :=
        (div_le_div_iff_of_pos_right hpowPos).2 hbarrierR
    _ = 4 * ((binomialUpperTail r k : ℝ) / (2 : ℝ) ^ r) := by ring
    _ ≤ 4 * ((C₀ / Real.sqrt r) *
          Real.exp (-((r : ℝ) *
            binaryBarrierRate ((k : ℝ) / (r : ℝ) - 1 / 2)))) :=
      mul_le_mul_of_nonneg_left htail' (by norm_num)
    _ = ((4 * C₀) / Real.sqrt r) *
          Real.exp (-((r : ℝ) *
            binaryBarrierRate ((k : ℝ) / (r : ℝ) - 1 / 2))) := by ring

/-- Sharp maximal-walk estimate for a real barrier, after replacing it by any
smaller half-integer lattice barrier.  This is the exact rounding socket used
by the moving Collatz envelope; the consumer retains the rounded entropy
argument instead of silently identifying it with the real displacement. -/
theorem exists_barrierHitCount_real_normalized_le_binaryBarrierRate
    {t₀ : ℝ} (ht₀ : 0 < t₀) :
    ∃ C : ℝ, 0 < C ∧
      ∀ r a : ℕ, ∀ h : ℝ,
        (a : ℝ) - 1 / 2 ≤ h →
        0 < r → a ≤ r →
        let k := endpointThreshold r a
        0 < k → k < r →
        (r : ℝ) * (1 / 2 + t₀) ≤ (k : ℝ) →
        (r : ℝ) / 4 ≤ (k : ℝ) →
        (r : ℝ) / 4 ≤ ((r - k : ℕ) : ℝ) →
        (barrierHitCount h r 0 : ℝ) / (2 : ℝ) ^ r ≤
          (C / Real.sqrt r) *
            Real.exp (-((r : ℝ) *
              binaryBarrierRate ((k : ℝ) / (r : ℝ) - 1 / 2))) := by
  obtain ⟨C, hC, hhalf⟩ :=
    exists_barrierHitCount_half_normalized_le_binaryBarrierRate ht₀
  refine ⟨C, hC, ?_⟩
  intro r a h hah hr har
  dsimp only
  intro hk hklt hgap hkLower hrkLower
  have hmono := barrierHitCount_antitone_threshold hah r 0
  have hmonoR :
      (barrierHitCount h r 0 : ℝ) ≤
        (barrierHitCount ((a : ℝ) - 1 / 2) r 0 : ℝ) := by
    exact_mod_cast hmono
  have hpowPos : 0 < (2 : ℝ) ^ r := by positivity
  calc
    (barrierHitCount h r 0 : ℝ) / (2 : ℝ) ^ r ≤
        (barrierHitCount ((a : ℝ) - 1 / 2) r 0 : ℝ) /
          (2 : ℝ) ^ r := (div_le_div_iff_of_pos_right hpowPos).2 hmonoR
    _ ≤ (C / Real.sqrt r) *
          Real.exp (-((r : ℝ) *
            binaryBarrierRate ((endpointThreshold r a : ℝ) /
              (r : ℝ) - 1 / 2))) :=
      hhalf r a hr har hk hklt hgap hkLower hrkLower

end

end FirstPassageLinearTransport
