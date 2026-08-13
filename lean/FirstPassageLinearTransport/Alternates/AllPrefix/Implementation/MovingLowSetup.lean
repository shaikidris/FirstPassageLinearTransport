/-
Copyright (c) 2026 Idris Ali Shaik. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Idris Ali Shaik
-/
import FirstPassageLinearTransport.Alternates.AllPrefix.MovingLowParameters
import FirstPassageLinearTransport.Parameters

import FirstPassageLinearTransport.Extras.Unreachable
/-!
# Quantitative startup for the moving low stage

The generic stage constructor only returns an unspecified finite startup.
For the moving endpoint the passage gap is of order `1 / L`, so the literal
consumer needs a package whose startup is at most the terminal rank `L`.

For `K₀ > 6`, the exact reserve `K₀ / 2` at every parent rank `m ≥ L`
dominates the floor and upper-shell cost `2 + η_L ≤ 3`.  The horizon condition
is uniform because eventually `1 / 2 < r_L`, allowing comparison with the
fixed `r = 1 / 2` horizon.  This constructs the required package with
`M0 = L` exactly.
-/

namespace FirstPassageLinearTransport

open Filter
open scoped Real Topology

noncomputable section

/-- For sufficiently large terminal rank `L`, the moving low parameters admit
a literal stage package whose startup is exactly `L`. -/
theorem eventually_movingLowStageSetup_M0_le
    {K₀ : ℝ} (hK₀ : 6 < K₀) :
    ∀ᶠ L : ℕ in atTop,
      ∃ p : StageSetup (movingLowRatio K₀ L)
          (movingLowTolerance K₀ L),
        p.M0 ≤ L := by
  have hK₀pos : 0 < K₀ := by linarith
  have hAdmissible := eventually_movingLow_admissible hK₀pos
    (by norm_num : (0 : ℝ) < 1)
  have hRatioHalf : ∀ᶠ L : ℕ in atTop,
      (1 / 2 : ℝ) < movingLowRatio K₀ L :=
    (tendsto_movingLowRatio K₀).eventually
      (Ioi_mem_nhds (by norm_num : (1 / 2 : ℝ) < 1))
  obtain ⟨Mhor, hMhor⟩ :=
    eventually_atTop.1
      (eventually_horizon_small (r := (1 / 2 : ℝ)) (by norm_num))
  filter_upwards [hAdmissible, hRatioHalf,
      eventually_ge_atTop (max 5 Mhor)] with L hAdm hRatioHalf hL
  rcases hAdm with
    ⟨ht0, htGap, hr0, hr1, _hlambda0, _hlambda1, _hcorr⟩
  have hL5 : 5 ≤ L := (le_max_left 5 Mhor).trans hL
  have hMhorL : Mhor ≤ L := (le_max_right 5 Mhor).trans hL
  have hLpos : 0 < L := by omega
  have ht1 : movingLowTolerance K₀ L ≤ 1 := by
    have hgapOne : driftGap < 1 := by
      unfold driftGap
      linarith [a0_pos]
    exact (htGap.trans hgapOne).le
  let p : StageSetup (movingLowRatio K₀ L)
      (movingLowTolerance K₀ L) := {
    M0 := L
    r_pos := hr0
    r_lt_one := hr1
    eta_pos := ht0
    eta_le_one := ht1
    target_one_lt := by
      intro M hLM
      have hM5 : 5 ≤ M := hL5.trans hLM
      have hMR : (5 : ℝ) ≤ M := by exact_mod_cast hM5
      have hlarge : 2 < movingLowRatio K₀ L * (M : ℝ) := by
        nlinarith
      have hfloor :
          movingLowRatio K₀ L * (M : ℝ) - 1 <
            (⌊movingLowRatio K₀ L * (M : ℝ)⌋₊ : ℝ) :=
        Nat.sub_one_lt_floor _
      have hfloorR :
          (1 : ℝ) <
            (⌊movingLowRatio K₀ L * (M : ℝ)⌋₊ : ℝ) := by
        linarith
      have hfloorNat :
          1 < ⌊movingLowRatio K₀ L * (M : ℝ)⌋₊ := by
        exact_mod_cast hfloorR
      unfold targetScale
      exact Nat.one_lt_pow (by omega) (by omega)
    target_lt_shell := by
      intro M hLM
      have hMpos : 0 < M := hLpos.trans_le hLM
      have hx0 : 0 ≤ movingLowRatio K₀ L * (M : ℝ) := by positivity
      have hfloorLe :
          (⌊movingLowRatio K₀ L * (M : ℝ)⌋₊ : ℝ) ≤
            movingLowRatio K₀ L * M := Nat.floor_le hx0
      have hlt :
          (⌊movingLowRatio K₀ L * (M : ℝ)⌋₊ : ℝ) < M := by
        have hMR : (0 : ℝ) < M := by exact_mod_cast hMpos
        nlinarith
      have hfloorNat :
          ⌊movingLowRatio K₀ L * (M : ℝ)⌋₊ < M := by
        exact_mod_cast hlt
      unfold targetScale
      exact Nat.pow_lt_pow_right (by norm_num) hfloorNat
    horizon_small := by
      intro M hLM
      have hHalfTarget :
          targetScale (1 / 2 : ℝ) M ≤
            targetScale (movingLowRatio K₀ L) M := by
        unfold targetScale
        apply Nat.pow_le_pow_right (by norm_num)
        apply Nat.floor_mono
        exact mul_le_mul_of_nonneg_right hRatioHalf.le (Nat.cast_nonneg M)
      have hBase := hMhor M (hMhorL.trans hLM)
      have hReal :
          (M : ℝ) /
                (2 * (targetScale (movingLowRatio K₀ L) M : ℝ)) ≤
              1 / 3 := by
        calc
          (M : ℝ) /
                (2 * (targetScale (movingLowRatio K₀ L) M : ℝ)) ≤
              (M : ℝ) / (2 * (targetScale (1 / 2 : ℝ) M : ℝ)) := by
            apply div_le_div_of_nonneg_left (Nat.cast_nonneg M)
              (mul_pos (by norm_num)
                (by exact_mod_cast targetScale_pos (1 / 2 : ℝ) M))
            exact mul_le_mul_of_nonneg_left
              (by exact_mod_cast hHalfTarget) (by norm_num)
          _ ≤ 1 / 3 := hBase
      have hCast :
          (((M : ℚ) /
              (2 * (targetScale (movingLowRatio K₀ L) M : ℚ)) : ℚ) : ℝ) ≤
            (((1 / 3 : ℚ) : ℚ) : ℝ) := by
        norm_num
        exact hReal
      exact Rat.cast_le.1 hCast
    terminal_budget := by
      intro M hLM
      have hreserve := movingLow_passageMargin_mul_parent
        hK₀pos.le hLpos hLM
      have hgapM :
          2 + movingLowTolerance K₀ L <
            (movingLowRatio K₀ L - a0 - movingLowTolerance K₀ L) *
              (M : ℝ) := by
        have hthree :
            2 + movingLowTolerance K₀ L ≤ 3 := by linarith
        have hKhalf : 3 < K₀ / 2 := by linarith
        linarith
      have hfloor :
          movingLowRatio K₀ L * (M : ℝ) - 1 <
            (⌊movingLowRatio K₀ L * (M : ℝ)⌋₊ : ℝ) :=
        Nat.sub_one_lt_floor _
      have hExp :
          (a0 + movingLowTolerance K₀ L) * M + 1 +
              movingLowTolerance K₀ L ≤
            (⌊movingLowRatio K₀ L * (M : ℝ)⌋₊ : ℝ) := by
        linarith
      rw [central_terminal_identity (movingLowTolerance K₀ L) M]
      unfold targetScale
      rw [Nat.cast_pow, ← Real.rpow_natCast]
      exact Real.rpow_le_rpow_of_exponent_le (by norm_num) hExp
    }
  exact ⟨p, le_rfl⟩

end

end FirstPassageLinearTransport
