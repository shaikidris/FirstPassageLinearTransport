/-
Copyright (c) 2026 Idris Ali Shaik. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Idris Ali Shaik
-/
import Mathlib.Analysis.SpecialFunctions.Stirling
import Mathlib.Data.Fintype.Powerset
import Mathlib.Data.Nat.Choose.Sum
import Mathlib.Order.Interval.Finset.Nat
import FirstPassageLinearTransport.EntropyBarrier

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

/-- Positions carrying a true bit. -/
def boolSupport {r : ℕ} (v : Fin r → Bool) : Finset (Fin r) :=
  Finset.univ.filter fun i => v i = true

/-- Boolean words are exactly finite subsets of their coordinate set. -/
noncomputable def boolWordFinsetEquiv (r : ℕ) :
    (Fin r → Bool) ≃ Finset (Fin r) where
  toFun := boolSupport
  invFun := fun s i => decide (i ∈ s)
  left_inv := by
    intro v
    funext i
    cases h : v i <;> simp [boolSupport, h]
  right_inv := by
    intro s
    ext i
    simp [boolSupport]

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

/-- Upper binomial tail. -/
def binomialUpperTail (r k : ℕ) : ℕ :=
  ∑ j ∈ Finset.Icc k r, r.choose j

theorem card_finsets_card_ge (r k : ℕ) (hk : k ≤ r) :
    Fintype.card {s : Finset (Fin r) // k ≤ s.card} = binomialUpperTail r k := by
  classical
  rw [Fintype.card_subtype]
  let s : Finset (Finset (Fin r)) := Finset.univ.filter fun u => k ≤ u.card
  have hs :
      s.card = ∑ j ∈ Finset.Icc k r, (s.filter fun u => u.card = j).card := by
    apply Finset.card_eq_sum_card_fiberwise
    intro u hu
    have hku : k ≤ u.card := by simpa [s] using hu
    exact Finset.mem_Icc.mpr ⟨hku, card_finset_fin_le u⟩
  rw [show (Finset.univ.filter fun u : Finset (Fin r) => k ≤ u.card).card = s.card by rfl,
    hs]
  unfold binomialUpperTail
  apply Finset.sum_congr rfl
  intro j hj
  have hj' := Finset.mem_Icc.mp hj
  calc
    (s.filter fun u => u.card = j).card =
        Fintype.card {u : Finset (Fin r) // u.card = j} := by
      rw [Fintype.card_subtype]
      congr 1
      ext u
      simp only [s, Finset.mem_filter, Finset.mem_univ, true_and]
      constructor
      · exact fun h => h.2
      · intro h
        exact ⟨by omega, h⟩
    _ = r.choose j := by
      simpa using Fintype.card_finset_len (Fin r) j

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

/-- Removing the first binomial layer from a nonempty upper tail. -/
theorem binomialUpperTail_eq_choose_add
    {r k : ℕ} (hkr : k ≤ r) :
    binomialUpperTail r k = r.choose k + binomialUpperTail r (k + 1) := by
  unfold binomialUpperTail
  rw [← Nat.Icc_insert_succ_left hkr]
  simp

/-- A binomial upper tail above the midpoint is controlled by its first
coefficient.  The proof is an exact telescoping argument: the factor
`2 * k - r` is the distance from the midpoint. -/
theorem binomialUpperTail_weighted_le
    {r k : ℕ} (hkr : k ≤ r) (hhalf : r < 2 * k) :
    (((2 * k : ℕ) : ℝ) - (r : ℝ)) * (binomialUpperTail r k : ℝ) ≤
      (k : ℝ) * (r.choose k : ℝ) := by
  by_cases heq : k = r
  · subst k
    simp [binomialUpperTail]
    linarith
  · have hkr' : k < r := lt_of_le_of_ne hkr heq
    have hk1r : k + 1 ≤ r := by omega
    have hhalf' : r < 2 * (k + 1) := by omega
    have hrec := binomialUpperTail_weighted_le hk1r hhalf'
    have htail :
        (binomialUpperTail r k : ℝ) =
          (r.choose k : ℝ) + (binomialUpperTail r (k + 1) : ℝ) := by
      exact_mod_cast binomialUpperTail_eq_choose_add hkr
    have hchoose := congr_arg ((↑) : ℕ → ℝ)
      (Nat.choose_succ_right_eq r k)
    have htail_nonneg : 0 ≤ (binomialUpperTail r (k + 1) : ℝ) := by
      positivity
    have hcoeff :
        ((2 * k : ℕ) : ℝ) - (r : ℝ) ≤
          ((2 * (k + 1) : ℕ) : ℝ) - (r : ℝ) := by
      push_cast
      linarith
    have hstep :
        (((2 * k : ℕ) : ℝ) - (r : ℝ)) *
            (binomialUpperTail r (k + 1) : ℝ) ≤
          (((2 * (k + 1) : ℕ) : ℝ) - (r : ℝ)) *
            (binomialUpperTail r (k + 1) : ℝ) :=
      mul_le_mul_of_nonneg_right hcoeff htail_nonneg
    rw [htail]
    push_cast at hrec hchoose ⊢
    rw [Nat.cast_sub hkr] at hchoose
    nlinarith
termination_by r - k
decreasing_by omega

/-- On a fixed positive displacement window, the entire binomial upper tail
is bounded by a uniform multiple of its first coefficient. -/
theorem binomialUpperTail_le_first_of_fractional_gap
    {t₀ : ℝ} (ht₀ : 0 < t₀) {r k : ℕ}
    (hr : 0 < r) (hkr : k ≤ r)
    (hgap : (r : ℝ) * (1 / 2 + t₀) ≤ (k : ℝ)) :
    (binomialUpperTail r k : ℝ) ≤
      (1 / (2 * t₀)) * (r.choose k : ℝ) := by
  have hhalf : r < 2 * k := by
    exact_mod_cast (show (r : ℝ) < 2 * (k : ℝ) by
      have hrR : 0 < (r : ℝ) := by positivity
      nlinarith)
  have hweighted := binomialUpperTail_weighted_le hkr hhalf
  have htail0 : 0 ≤ (binomialUpperTail r k : ℝ) := by positivity
  have hchoose0 : 0 ≤ (r.choose k : ℝ) := by positivity
  have hcoeff :
      2 * t₀ * (r : ℝ) ≤ ((2 * k : ℕ) : ℝ) - (r : ℝ) := by
    push_cast
    nlinarith
  have hleft := mul_le_mul_of_nonneg_right hcoeff htail0
  have hright :
      (k : ℝ) * (r.choose k : ℝ) ≤
        (r : ℝ) * (r.choose k : ℝ) := by
    exact mul_le_mul_of_nonneg_right (by exact_mod_cast hkr) hchoose0
  have hcombined :
      (r : ℝ) * (2 * t₀ * (binomialUpperTail r k : ℝ)) ≤
        (r : ℝ) * (r.choose k : ℝ) := by
    calc
      (r : ℝ) * (2 * t₀ * (binomialUpperTail r k : ℝ)) =
          (2 * t₀ * (r : ℝ)) * (binomialUpperTail r k : ℝ) := by ring
      _ ≤ (((2 * k : ℕ) : ℝ) - (r : ℝ)) *
          (binomialUpperTail r k : ℝ) := hleft
      _ ≤ (k : ℝ) * (r.choose k : ℝ) := hweighted
      _ ≤ (r : ℝ) * (r.choose k : ℝ) := hright
  have hcancel :
      2 * t₀ * (binomialUpperTail r k : ℝ) ≤ (r.choose k : ℝ) :=
    (mul_le_mul_left (show 0 < (r : ℝ) by positivity)).mp hcombined
  calc
    (binomialUpperTail r k : ℝ) ≤
        (r.choose k : ℝ) / (2 * t₀) :=
      (le_div_iff₀ (mul_pos (by norm_num) ht₀)).2 (by
        simpa [mul_comm, mul_left_comm, mul_assoc] using hcancel)
    _ = (1 / (2 * t₀)) * (r.choose k : ℝ) := by ring

/-- Stirling's main factorial scale, with the harmless limiting constant kept
outside the definition. -/
def stirlingCore (n : ℕ) : ℝ :=
  Real.sqrt (2 * n) * ((n : ℝ) / Real.exp 1) ^ n

/-- Logarithmic weight carried by the binomial coefficient before normalizing
by `2^r`. -/
def binomialLogWeight (r k : ℕ) : ℝ :=
  (r : ℝ) * Real.log r -
    (k : ℝ) * Real.log k -
      ((r - k : ℕ) : ℝ) * Real.log (r - k)

theorem stirlingCore_eq_sqrt_mul_exp
    {n : ℕ} (hn : 0 < n) :
    stirlingCore n =
      Real.sqrt (2 * n) *
        Real.exp ((n : ℝ) * (Real.log n - 1)) := by
  unfold stirlingCore
  congr 1
  have hnR : 0 < (n : ℝ) := by positivity
  calc
    ((n : ℝ) / Real.exp 1) ^ n =
        (Real.exp (Real.log n - 1)) ^ n := by
      congr 1
      rw [Real.exp_sub, Real.exp_log hnR]
    _ = Real.exp ((n : ℝ) * (Real.log n - 1)) := by
      rw [← Real.exp_nat_mul]

theorem stirlingCore_ratio_eq_sqrt_exp
    {r k : ℕ} (hk : 0 < k) (hkr : k < r) :
    stirlingCore r / (stirlingCore k * stirlingCore (r - k)) =
      Real.sqrt (2 * r) /
          (Real.sqrt (2 * k) * Real.sqrt (2 * (r - k))) *
        Real.exp (binomialLogWeight r k) := by
  have hr : 0 < r := hk.trans hkr
  have hrk : 0 < r - k := Nat.sub_pos_of_lt hkr
  rw [stirlingCore_eq_sqrt_mul_exp hr,
    stirlingCore_eq_sqrt_mul_exp hk,
    stirlingCore_eq_sqrt_mul_exp hrk]
  have hexp :
      Real.exp ((r : ℝ) * (Real.log r - 1)) /
          (Real.exp ((k : ℝ) * (Real.log k - 1)) *
            Real.exp (((r - k : ℕ) : ℝ) * (Real.log (r - k) - 1))) =
        Real.exp (binomialLogWeight r k) := by
    rw [← Real.exp_add, ← Real.exp_sub]
    congr 1
    unfold binomialLogWeight
    rw [Nat.cast_sub hkr.le]
    ring
  have factor_div (A B C E F G : ℝ) :
      A * E / ((B * F) * (C * G)) =
        A / (B * C) * (E / (F * G)) := by ring
  rw [Nat.cast_sub hkr.le] at hexp ⊢
  rw [factor_div, hexp]

/-- On the central quarter-window, the square-root factor in Stirling's
binomial ratio is uniformly `O(r⁻¹ᐟ²)`.  The deliberately loose constant `4`
keeps the statement independent of any endpoint tuning. -/
theorem stirlingSqrtPrefactor_le_of_quarter
    {r k : ℕ} (hr : 0 < r) (hk : 0 < k) (hkr : k < r)
    (hkLower : (r : ℝ) / 4 ≤ (k : ℝ))
    (hrkLower : (r : ℝ) / 4 ≤ ((r - k : ℕ) : ℝ)) :
    Real.sqrt (2 * r) /
        (Real.sqrt (2 * k) * Real.sqrt (2 * (r - k))) ≤
      4 / Real.sqrt r := by
  have hrR : 0 < (r : ℝ) := by positivity
  have hrk : 0 < r - k := Nat.sub_pos_of_lt hkr
  rw [Nat.cast_sub hkr.le] at hrkLower
  have hsqrtR : 0 < Real.sqrt (r : ℝ) := Real.sqrt_pos.2 hrR
  have hkR : 0 < (k : ℝ) := by positivity
  have hrkR : 0 < (r : ℝ) - (k : ℝ) :=
    sub_pos.mpr (by exact_mod_cast hkr)
  have hden :
      0 < Real.sqrt (2 * k) * Real.sqrt (2 * ((r : ℝ) - k)) := by
    exact mul_pos (Real.sqrt_pos.2 (mul_pos (by norm_num) hkR))
      (Real.sqrt_pos.2 (mul_pos (by norm_num) hrkR))
  have hkSqrt :
      Real.sqrt ((r : ℝ) / 2) ≤ Real.sqrt (2 * k) := by
    apply Real.sqrt_le_sqrt
    calc
      (r : ℝ) / 2 = 2 * ((r : ℝ) / 4) := by ring
      _ ≤ 2 * (k : ℝ) := mul_le_mul_of_nonneg_left hkLower (by norm_num)
  have hrkSqrt :
      Real.sqrt ((r : ℝ) / 2) ≤
        Real.sqrt (2 * ((r : ℝ) - k)) := by
    apply Real.sqrt_le_sqrt
    calc
      (r : ℝ) / 2 = 2 * ((r : ℝ) / 4) := by ring
      _ ≤ 2 * ((r : ℝ) - k) :=
        mul_le_mul_of_nonneg_left hrkLower (by norm_num)
  have hdenLower :
      (r : ℝ) / 2 ≤
        Real.sqrt (2 * k) * Real.sqrt (2 * ((r : ℝ) - k)) := by
    calc
      (r : ℝ) / 2 =
          Real.sqrt ((r : ℝ) / 2) * Real.sqrt ((r : ℝ) / 2) := by
        rw [Real.mul_self_sqrt]
        positivity
      _ ≤ Real.sqrt (2 * k) * Real.sqrt (2 * ((r : ℝ) - k)) :=
        mul_le_mul hkSqrt hrkSqrt (Real.sqrt_nonneg _) (Real.sqrt_nonneg _)
  have hnumUpper :
      Real.sqrt (2 * r) ≤ 2 * Real.sqrt r := by
    calc
      Real.sqrt (2 * r) ≤ Real.sqrt (4 * r) := by
        apply Real.sqrt_le_sqrt
        push_cast
        linarith
      _ = Real.sqrt (4 : ℝ) * Real.sqrt r := by
        rw [Real.sqrt_mul (by norm_num : (0 : ℝ) ≤ 4)]
      _ = 2 * Real.sqrt r := by
        have hsqrtFour : Real.sqrt (4 : ℝ) = 2 := by
          have hsquare := Real.sq_sqrt (show (0 : ℝ) ≤ 4 by norm_num)
          have hnonneg := Real.sqrt_nonneg (4 : ℝ)
          nlinarith
        rw [hsqrtFour]
  apply (div_le_div_iff₀ hden hsqrtR).2
  have hleft :
      Real.sqrt (2 * r) * Real.sqrt r ≤ 2 * (r : ℝ) := by
    calc
      Real.sqrt (2 * r) * Real.sqrt r ≤
          (2 * Real.sqrt r) * Real.sqrt r :=
        mul_le_mul_of_nonneg_right hnumUpper (Real.sqrt_nonneg _)
      _ = 2 * (r : ℝ) := by
        rw [mul_assoc, Real.mul_self_sqrt hrR.le]
  have hright :
      2 * (r : ℝ) ≤
        4 * (Real.sqrt (2 * k) * Real.sqrt (2 * ((r : ℝ) - k))) := by
    linarith
  exact hleft.trans hright

/-- The logarithmic Stirling weight is exactly `r` times binary entropy at the
empirical success proportion `k / r`. -/
theorem binomialLogWeight_eq_mul_binEntropy
    {r k : ℕ} (hk : 0 < k) (hkr : k < r) :
    binomialLogWeight r k =
      (r : ℝ) * Real.binEntropy ((k : ℝ) / (r : ℝ)) := by
  have hr : 0 < r := hk.trans hkr
  have hrk : 0 < r - k := Nat.sub_pos_of_lt hkr
  have hrR : (r : ℝ) ≠ 0 := by positivity
  have hkR : (k : ℝ) ≠ 0 := by positivity
  have hrkR : ((r - k : ℕ) : ℝ) ≠ 0 := by positivity
  have hcomplement :
      1 - (k : ℝ) / (r : ℝ) =
        ((r - k : ℕ) : ℝ) / (r : ℝ) := by
    rw [Nat.cast_sub hkr.le]
    field_simp [hrR]
  unfold binomialLogWeight Real.binEntropy
  rw [hcomplement, Real.log_inv, Real.log_inv,
    Real.log_div hkR hrR, Real.log_div hrkR hrR,
    Nat.cast_sub hkr.le]
  field_simp [hrR]
  ring

/-- After dividing by the `2^r` Boolean mass, the Stirling exponential is
exactly the repository's binary barrier rate. -/
theorem normalized_binomialLogWeight_eq_binaryBarrierRate
    {r k : ℕ} (hk : 0 < k) (hkr : k < r) :
    binomialLogWeight r k - (r : ℝ) * Real.log 2 =
      -((r : ℝ) *
        binaryBarrierRate ((k : ℝ) / (r : ℝ) - 1 / 2)) := by
  rw [binomialLogWeight_eq_mul_binEntropy hk hkr]
  unfold binaryBarrierRate
  congr 1
  congr 1
  ring

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

theorem stirlingSeq_eq_factorial_div_core (n : ℕ) :
    Stirling.stirlingSeq n = (Nat.factorial n : ℝ) / stirlingCore n := by
  rfl

/-- Uniform two-sided factorial bounds obtained from monotonicity and the
positive lower bound of Mathlib's Stirling sequence. -/
theorem exists_factorial_stirlingCore_bounds :
    ∃ a b : ℝ, 0 < a ∧ 0 < b ∧
      ∀ n : ℕ, 0 < n →
        a * stirlingCore n ≤ (Nat.factorial n : ℝ) ∧
          (Nat.factorial n : ℝ) ≤ b * stirlingCore n := by
  obtain ⟨a, ha, hlow⟩ := Stirling.stirlingSeq'_bounded_by_pos_constant
  refine ⟨a, Stirling.stirlingSeq 1, ha, Stirling.stirlingSeq'_pos 0, ?_⟩
  intro n hn
  obtain ⟨m, rfl⟩ := Nat.exists_eq_succ_of_ne_zero (Nat.ne_of_gt hn)
  have hcore : 0 < stirlingCore (m + 1) := by
    unfold stirlingCore
    positivity
  have hlo : a ≤ (Nat.factorial (m + 1) : ℝ) / stirlingCore (m + 1) := by
    simpa [stirlingSeq_eq_factorial_div_core] using hlow m
  have hup : (Nat.factorial (m + 1) : ℝ) / stirlingCore (m + 1) ≤ Stirling.stirlingSeq 1 := by
    simpa [stirlingSeq_eq_factorial_div_core] using
      Stirling.stirlingSeq'_antitone (Nat.zero_le m)
  constructor
  · exact (le_div_iff₀ hcore).mp hlo
  · exact (div_le_iff₀ hcore).mp hup

/-- A uniform Stirling bound for every nontrivial binomial coefficient.  The
remaining ratio of `stirlingCore`s is converted to entropy in the next layer. -/
theorem exists_choose_le_stirlingCore_ratio :
    ∃ C : ℝ, 0 < C ∧
      ∀ r k : ℕ, 0 < k → k < r →
        (r.choose k : ℝ) ≤
          C * stirlingCore r /
            (stirlingCore k * stirlingCore (r - k)) := by
  obtain ⟨a, b, ha, hb, hfac⟩ := exists_factorial_stirlingCore_bounds
  refine ⟨b / (a * a), div_pos hb (mul_pos ha ha), ?_⟩
  intro r k hk hkr
  have hr : 0 < r := hk.trans hkr
  have hrk : 0 < r - k := Nat.sub_pos_of_lt hkr
  rcases hfac r hr with ⟨-, hrUpper⟩
  rcases hfac k hk with ⟨hkLower, -⟩
  rcases hfac (r - k) hrk with ⟨hrkLower, -⟩
  have hcorek : 0 < stirlingCore k := by unfold stirlingCore; positivity
  have hcorerk : 0 < stirlingCore (r - k) := by unfold stirlingCore; positivity
  have hden : 0 < (a * stirlingCore k) * (a * stirlingCore (r - k)) := by
    positivity
  have hchoose : 0 ≤ (r.choose k : ℝ) := by positivity
  have hkfac : 0 ≤ (Nat.factorial k : ℝ) := by positivity
  have hmul :
      (r.choose k : ℝ) * (a * stirlingCore k) *
          (a * stirlingCore (r - k)) ≤ b * stirlingCore r := by
    calc
      (r.choose k : ℝ) * (a * stirlingCore k) *
          (a * stirlingCore (r - k)) ≤
          (r.choose k : ℝ) * (Nat.factorial k : ℝ) *
            (Nat.factorial (r - k) : ℝ) := by
        apply mul_le_mul
        · exact mul_le_mul_of_nonneg_left hkLower hchoose
        · exact hrkLower
        · exact le_of_lt (mul_pos ha hcorerk)
        · exact mul_nonneg hchoose hkfac
      _ = (Nat.factorial r : ℝ) := by
        exact_mod_cast
          (Nat.choose_mul_factorial_mul_factorial (Nat.le_of_lt hkr))
      _ ≤ b * stirlingCore r := hrUpper
  have hdiv :
      (r.choose k : ℝ) ≤
        b * stirlingCore r /
          ((a * stirlingCore k) * (a * stirlingCore (r - k))) :=
    (le_div_iff₀ hden).2 (by simpa [mul_assoc] using hmul)
  calc
    (r.choose k : ℝ) ≤
        b * stirlingCore r /
          ((a * stirlingCore k) * (a * stirlingCore (r - k))) := hdiv
    _ = (b / (a * a)) * stirlingCore r /
          (stirlingCore k * stirlingCore (r - k)) := by
      apply (div_eq_div_iff hden.ne'
        (mul_pos hcorek hcorerk).ne').2
      field_simp [ha.ne']
      ring

/-- Sharp-prefactor upper-tail socket before rewriting the Stirling-core ratio
as an entropy exponential.  The constant is uniform in `r` and `k` once the
positive displacement margin `t₀` is fixed. -/
theorem exists_binomialUpperTail_le_stirlingCore_ratio
    {t₀ : ℝ} (ht₀ : 0 < t₀) :
    ∃ C : ℝ, 0 < C ∧
      ∀ r k : ℕ, 0 < r → 0 < k → k < r →
        (r : ℝ) * (1 / 2 + t₀) ≤ (k : ℝ) →
        (binomialUpperTail r k : ℝ) ≤
          C * stirlingCore r /
            (stirlingCore k * stirlingCore (r - k)) := by
  obtain ⟨C₀, hC₀, hchoose⟩ := exists_choose_le_stirlingCore_ratio
  refine ⟨(1 / (2 * t₀)) * C₀,
    mul_pos (one_div_pos.mpr (mul_pos (by norm_num) ht₀)) hC₀, ?_⟩
  intro r k hr hk hkr hgap
  have htail := binomialUpperTail_le_first_of_fractional_gap
    ht₀ hr hkr.le hgap
  have hfirst := hchoose r k hk hkr
  have hfactor0 : 0 ≤ 1 / (2 * t₀) :=
    (one_div_pos.mpr (mul_pos (by norm_num) ht₀)).le
  calc
    (binomialUpperTail r k : ℝ) ≤
        (1 / (2 * t₀)) * (r.choose k : ℝ) := htail
    _ ≤ (1 / (2 * t₀)) *
        (C₀ * stirlingCore r /
          (stirlingCore k * stirlingCore (r - k))) :=
      mul_le_mul_of_nonneg_left hfirst hfactor0
    _ = ((1 / (2 * t₀)) * C₀) * stirlingCore r /
          (stirlingCore k * stirlingCore (r - k)) := by ring

/-- Sharp upper-binomial-tail estimate on the central quarter-window.  This is
the analytic socket needed by the moving endpoint: the exponential term is
exact, while all dependence on the walk length outside the exponent is the
single factor `r⁻¹ᐟ²`. -/
theorem exists_binomialUpperTail_le_sqrt_exp
    {t₀ : ℝ} (ht₀ : 0 < t₀) :
    ∃ C : ℝ, 0 < C ∧
      ∀ r k : ℕ, 0 < r → 0 < k → k < r →
        (r : ℝ) * (1 / 2 + t₀) ≤ (k : ℝ) →
        (r : ℝ) / 4 ≤ (k : ℝ) →
        (r : ℝ) / 4 ≤ ((r - k : ℕ) : ℝ) →
        (binomialUpperTail r k : ℝ) ≤
          (C / Real.sqrt r) * Real.exp (binomialLogWeight r k) := by
  obtain ⟨C₀, hC₀, htail⟩ :=
    exists_binomialUpperTail_le_stirlingCore_ratio ht₀
  refine ⟨4 * C₀, mul_pos (by norm_num) hC₀, ?_⟩
  intro r k hr hk hkr hgap hkLower hrkLower
  have h := htail r k hr hk hkr hgap
  have h' :
      (binomialUpperTail r k : ℝ) ≤
        C₀ * (stirlingCore r /
          (stirlingCore k * stirlingCore (r - k))) := by
    calc
      (binomialUpperTail r k : ℝ) ≤
          C₀ * stirlingCore r /
            (stirlingCore k * stirlingCore (r - k)) := h
      _ = C₀ * (stirlingCore r /
          (stirlingCore k * stirlingCore (r - k))) := by ring
  rw [stirlingCore_ratio_eq_sqrt_exp hk hkr] at h'
  have hpref := stirlingSqrtPrefactor_le_of_quarter
    hr hk hkr hkLower hrkLower
  have hCnonneg : 0 ≤ C₀ := hC₀.le
  have hexpNonneg : 0 ≤ Real.exp (binomialLogWeight r k) :=
    (Real.exp_pos _).le
  calc
    (binomialUpperTail r k : ℝ) ≤
        C₀ * (Real.sqrt (2 * r) /
          (Real.sqrt (2 * k) * Real.sqrt (2 * (r - k))) *
            Real.exp (binomialLogWeight r k)) := h'
    _ ≤ C₀ * ((4 / Real.sqrt r) *
          Real.exp (binomialLogWeight r k)) := by
      exact mul_le_mul_of_nonneg_left
        (mul_le_mul_of_nonneg_right hpref hexpNonneg) hCnonneg
    _ = ((4 * C₀) / Real.sqrt r) *
          Real.exp (binomialLogWeight r k) := by ring

/-- Probability-scale version of the sharp binomial-tail socket.  Dividing
by the Boolean mass `2^r` converts the entropy exponential exactly into the
canonical binary barrier rate. -/
theorem exists_normalized_binomialUpperTail_le_binaryBarrierRate
    {t₀ : ℝ} (ht₀ : 0 < t₀) :
    ∃ C : ℝ, 0 < C ∧
      ∀ r k : ℕ, 0 < r → 0 < k → k < r →
        (r : ℝ) * (1 / 2 + t₀) ≤ (k : ℝ) →
        (r : ℝ) / 4 ≤ (k : ℝ) →
        (r : ℝ) / 4 ≤ ((r - k : ℕ) : ℝ) →
        (binomialUpperTail r k : ℝ) / (2 : ℝ) ^ r ≤
          (C / Real.sqrt r) *
            Real.exp (-((r : ℝ) *
              binaryBarrierRate ((k : ℝ) / (r : ℝ) - 1 / 2))) := by
  obtain ⟨C, hC, htail⟩ := exists_binomialUpperTail_le_sqrt_exp ht₀
  refine ⟨C, hC, ?_⟩
  intro r k hr hk hkr hgap hkLower hrkLower
  have h := htail r k hr hk hkr hgap hkLower hrkLower
  have hpowPos : 0 < (2 : ℝ) ^ r := by positivity
  have hpow :
      (2 : ℝ) ^ r = Real.exp ((r : ℝ) * Real.log 2) := by
    calc
      (2 : ℝ) ^ r = (Real.exp (Real.log 2)) ^ r := by
        rw [Real.exp_log (by norm_num : (0 : ℝ) < 2)]
      _ = Real.exp ((r : ℝ) * Real.log 2) := by
        rw [← Real.exp_nat_mul]
  have hnormalized :
      Real.exp (binomialLogWeight r k) / (2 : ℝ) ^ r =
        Real.exp (-((r : ℝ) *
          binaryBarrierRate ((k : ℝ) / (r : ℝ) - 1 / 2))) := by
    rw [hpow, ← Real.exp_sub,
      normalized_binomialLogWeight_eq_binaryBarrierRate hk hkr]
  calc
    (binomialUpperTail r k : ℝ) / (2 : ℝ) ^ r ≤
        ((C / Real.sqrt r) * Real.exp (binomialLogWeight r k)) /
          (2 : ℝ) ^ r := (div_le_div_iff_of_pos_right hpowPos).2 h
    _ = (C / Real.sqrt r) *
          (Real.exp (binomialLogWeight r k) / (2 : ℝ) ^ r) := by ring
    _ = (C / Real.sqrt r) *
          Real.exp (-((r : ℝ) *
            binaryBarrierRate ((k : ℝ) / (r : ℝ) - 1 / 2))) := by
      rw [hnormalized]

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
