/-
Copyright (c) 2026 Idris Ali Shaik. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Idris Ali Shaik
-/
import FirstPassageLinearTransport.Pullback

/-!
# Height-sensitive first-passage clock

The maximal all-prefix envelope certifies the existing stopped map before a
horizon proportional to the logarithmic height removed.  This is the new
structural input for the smooth graded-clock corollary.
-/

namespace FirstPassageLinearTransport

open scoped Real

noncomputable section

/-- The shortened shell horizon from Lemma 5.2 of the manuscript. -/
noncomputable def heightSensitiveHorizon (r eta : ℝ) (M : ℕ) : ℕ :=
  ⌈(((1 + eta - r) * M + 2 + eta) / driftGap)⌉₊

/-- The defining real expression lies below its natural ceiling. -/
theorem heightSensitiveHorizon_lower (r eta : ℝ) (M : ℕ) :
    ((1 + eta - r) * M + 2 + eta) / driftGap ≤
      (heightSensitiveHorizon r eta M : ℝ) := by
  exact Nat.le_ceil _

/-- The ceiling costs less than one once the horizon expression is
nonnegative. -/
theorem heightSensitiveHorizon_lt_add_one
    {r eta : ℝ} {M : ℕ}
    (hnum : 0 ≤ ((1 + eta - r) * M + 2 + eta) / driftGap) :
    (heightSensitiveHorizon r eta M : ℝ) <
      ((1 + eta - r) * M + 2 + eta) / driftGap + 1 := by
  exact Nat.ceil_lt_add_one hnum

/-- At any shell where the shortened horizon remains inside the envelope,
the retained orbit has already entered the usual stage target. -/
theorem heightSensitive_terminal_witness
    {r eta : ℝ} (p : StageSetup r eta) {M n : ℕ}
    (hHle : heightSensitiveHorizon r eta M ≤ M)
    (hnShell : n ∈ dyadicShell M)
    (hnGood : n ∈ initialWindowGood eta) :
    orbit (heightSensitiveHorizon r eta M) n ≤ targetScale r M := by
  let H := heightSensitiveHorizon r eta M
  have hgap : 0 < driftGap := driftGap_pos
  have hceil := heightSensitiveHorizon_lower r eta M
  have hscaled :
      (1 + eta - r) * (M : ℝ) + 2 + eta ≤ driftGap * H := by
    have := (div_le_iff₀ hgap).mp hceil
    dsimp [H]
    nlinarith
  have hexponent :
      -driftGap * (H : ℝ) + ((M : ℝ) + 1) * (1 + eta) ≤
        r * M - 1 := by
    nlinarith
  have hlog := log_two_eq_of_mem_dyadicShell hnShell
  have henv := hnGood H (by simpa [H, hlog] using hHle)
  have hnUpperNat : n < 2 ^ (M + 1) := (mem_dyadicShell.mp hnShell).2
  have hnUpper : (n : ℝ) ≤ (2 : ℝ) ^ (M + 1) := by
    exact_mod_cast hnUpperNat.le
  have heta : 0 ≤ 1 + eta := by linarith [p.eta_pos]
  have hpow :
      (n : ℝ) ^ (1 + eta) ≤ ((2 : ℝ) ^ (M + 1)) ^ (1 + eta) :=
    Real.rpow_le_rpow (by positivity) hnUpper heta
  have hscale0 : 0 ≤ centralOrbitScale H := (centralOrbitScale_pos H).le
  have hmain :
      centralOrbitScale H * (n : ℝ) ^ (1 + eta) ≤
        (2 : ℝ) ^ (r * M - 1) := by
    calc
      centralOrbitScale H * (n : ℝ) ^ (1 + eta) ≤
          centralOrbitScale H * ((2 : ℝ) ^ (M + 1)) ^ (1 + eta) :=
        mul_le_mul_of_nonneg_left hpow hscale0
      _ = (2 : ℝ) ^
          (-driftGap * (H : ℝ) + ((M : ℝ) + 1) * (1 + eta)) := by
        rw [centralOrbitScale_eq_two_rpow_neg_gap,
          ← Real.rpow_natCast, ← Real.rpow_mul (by norm_num),
          ← Real.rpow_add (by norm_num)]
        congr 1
        push_cast
        ring
      _ ≤ (2 : ℝ) ^ (r * M - 1) :=
        Real.rpow_le_rpow_of_exponent_le (by norm_num) hexponent
  have hfloor : r * (M : ℝ) - 1 < (⌊r * (M : ℝ)⌋₊ : ℝ) :=
    Nat.sub_one_lt_floor _
  have htarget :
      (2 : ℝ) ^ (r * M - 1) ≤ (targetScale r M : ℝ) := by
    unfold targetScale
    rw [Nat.cast_pow, ← Real.rpow_natCast]
    exact Real.rpow_le_rpow_of_exponent_le (by norm_num) hfloor.le
  have horbit : (orbit H n : ℝ) ≤ targetScale r M :=
    henv.2.trans (hmain.trans htarget)
  exact_mod_cast horbit

/-- The shortened horizon is inside the original length-`M` envelope once
the shell is beyond the explicit scalar threshold. -/
theorem heightSensitiveHorizon_le_shell
    {r eta : ℝ}
    (hetaGap : eta < r - a0) {M : ℕ}
    (hM : (2 + eta) / (r - a0 - eta) ≤ M) :
    heightSensitiveHorizon r eta M ≤ M := by
  have hgap : 0 < driftGap := driftGap_pos
  have hmargin : 0 < r - a0 - eta := by linarith
  unfold heightSensitiveHorizon
  rw [Nat.ceil_le]
  apply (div_le_iff₀ hgap).2
  have hpay : 2 + eta ≤ (r - a0 - eta) * (M : ℝ) := by
    have hpay' := (div_le_iff₀ hmargin).1 (by simpa using hM)
    nlinarith
  unfold driftGap
  nlinarith

/-- The existing totalized stopped time is no larger than the new
height-sensitive witness.  The stopped map itself is unchanged. -/
theorem stageLength_le_heightSensitiveHorizon
    {r eta : ℝ} (p : StageSetup r eta) {M n : ℕ}
    (hM : p.M0 ≤ M)
    (hHle : heightSensitiveHorizon r eta M ≤ M)
    (hnShell : n ∈ dyadicShell M)
    (hnGood : n ∈ initialWindowGood eta) :
    stageLength p n ≤ heightSensitiveHorizon r eta M := by
  have hfull := bounded_passage_exists p hM hnShell hnGood
  rw [stageLength_eq_bounded p hM hnShell,
    boundedFirstPassage_eq_find hfull]
  exact Nat.find_min' hfull ⟨hHle,
    heightSensitive_terminal_witness p hHle hnShell hnGood⟩

/-- Real upper bound for the shortened natural ceiling. -/
theorem heightSensitiveHorizon_real_lt
    {r eta : ℝ} {M : ℕ}
    (hnum : 0 ≤ (1 + eta - r) * (M : ℝ) + 2 + eta) :
    (heightSensitiveHorizon r eta M : ℝ) <
      ((1 + eta - r) / driftGap) * M +
        (2 + eta) / driftGap + 1 := by
  have hgap : 0 < driftGap := driftGap_pos
  have hraw := heightSensitiveHorizon_lt_add_one
    (r := r) (eta := eta) (M := M)
    ((div_nonneg hnum hgap.le))
  convert hraw using 1
  field_simp [hgap.ne']
  ring

end

end FirstPassageLinearTransport
