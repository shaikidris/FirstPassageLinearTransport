/-
Copyright (c) 2026 Idris Ali Shaik. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Idris Ali Shaik
-/
import FirstPassageLinearTransport.NaturalDensityDescent

/-!
# Fixed-power descent consequence

Conversion of the stretched-logarithmic landing threshold to every fixed
positive power.  This module records only the qualitative natural-density
consequence; the manuscript's quantitative exceptional-count refinement uses
its stronger shell-counting statement rather than the qualitative public API.
-/

namespace FirstPassageLinearTransport

open Filter
open scoped Real Topology

noncomputable section

/-- The fixed stretched-logarithmic threshold with exponent `1 / 2` is
eventually bounded by every fixed positive power. -/
theorem eventuallyStretchedHalfLePower {alpha : ℝ} (halpha : 0 < alpha) :
    ∀ᶠ n : ℕ in atTop,
      Real.exp ((Real.log n) ^ (1 / 2 : ℝ)) ≤ (n : ℝ) ^ alpha := by
  have hlog : Tendsto (fun n : ℕ => Real.log n) atTop atTop :=
    Real.tendsto_log_atTop.comp tendsto_natCast_atTop_atTop
  have hneg : Tendsto
      (fun n : ℕ => (Real.log n) ^ (-(1 / 2 : ℝ))) atTop (nhds 0) :=
    (tendsto_rpow_neg_atTop (by norm_num : (0 : ℝ) < 1 / 2)).comp hlog
  have hsmall : ∀ᶠ n : ℕ in atTop,
      (Real.log n) ^ (-(1 / 2 : ℝ)) < alpha :=
    (tendsto_order.1 hneg).2 alpha halpha
  filter_upwards [hsmall, eventually_gt_atTop (1 : ℕ)] with n hnsmall hn
  have hnReal : (0 : ℝ) < n := by
    exact_mod_cast (show 0 < n by omega)
  have hlogpos : 0 < Real.log n :=
    Real.log_pos (by exact_mod_cast hn)
  have hpow : (Real.log n) ^ (1 / 2 : ℝ) < alpha * Real.log n := by
    calc
      (Real.log n) ^ (1 / 2 : ℝ) =
          (Real.log n) ^ ((1 : ℝ) + (-(1 / 2 : ℝ))) := by
            congr 1
            ring
      _ = (Real.log n) ^ (1 : ℝ) *
          (Real.log n) ^ (-(1 / 2 : ℝ)) :=
        Real.rpow_add hlogpos _ _
      _ = (Real.log n) * (Real.log n) ^ (-(1 / 2 : ℝ)) := by
        rw [Real.rpow_one]
      _ < (Real.log n) * alpha :=
        mul_lt_mul_of_pos_left hnsmall hlogpos
      _ = alpha * Real.log n := by ring
  rw [Real.rpow_def_of_pos hnReal]
  exact Real.exp_le_exp.2 (by simpa [mul_comm] using hpow.le)

/-- Internal fixed-power consequence with the same explicit shortcut clock as
the stretched-logarithmic theorem. -/
theorem firstPassageLinearTransportFixedPower
    {alpha : ℝ} (halpha : 0 < alpha) :
    ∃ S : Set ℕ,
      NaturalDensityOne S ∧
        ∀ᶠ n : ℕ in atTop,
          n ∈ S →
            ∃ k : ℕ,
              (k : ℝ) < (6953 / 1000 : ℝ) * Real.log n ∧
                (orbit k n : ℝ) ≤ (n : ℝ) ^ alpha := by
  obtain ⟨S, hSdense, hS⟩ :=
    firstPassageLinearTransportMain
      (delta := (1 / 2 : ℝ)) (by norm_num) (by norm_num)
  refine ⟨S, hSdense, ?_⟩
  filter_upwards [hS, eventuallyStretchedHalfLePower halpha] with n hn hcompare
  intro hnS
  obtain ⟨k, hclock, hlanding⟩ := hn hnS
  have hcompare' :
      Real.exp ((Real.log n) ^ (1 - (1 / 2 : ℝ))) ≤
        (n : ℝ) ^ alpha := by
    have hexponent : (1 - (1 / 2 : ℝ)) = (1 / 2 : ℝ) := by
      norm_num
    rw [hexponent]
    exact hcompare
  exact ⟨k, hclock, hlanding.trans hcompare'⟩

end

end FirstPassageLinearTransport
