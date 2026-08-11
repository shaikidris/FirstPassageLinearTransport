/-
Copyright (c) 2026 Idris Ali Shaik. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Idris Ali Shaik
-/
import FirstPassageLinearTransport.FirstBadEnvelope
import FirstPassageLinearTransport.MovingLowParameters

/-!
# Sharp density for the moving low barrier

This module connects the sharp Boolean-walk prefactor to the literal Collatz
orbit-envelope failure set.  The real barrier is rounded down to a lattice
barrier, and the rounded entropy argument is retained explicitly.
-/

namespace FirstPassageLinearTransport

open Filter
open scoped Real Topology

noncomputable section

/-- Integer barrier immediately below the real walk height `2 d m`. -/
def roundedBarrierLevel (d : ℝ) (m : ℕ) : ℕ :=
  ⌊2 * d * (m : ℝ)⌋₊

/-- Entropy displacement of the first reachable terminal layer associated
with `roundedBarrierLevel`. -/
def roundedBarrierDisplacement (d : ℝ) (m : ℕ) : ℝ :=
  (endpointThreshold m (roundedBarrierLevel d m) : ℝ) / (m : ℝ) - 1 / 2

/-- Fixed positive displacement used to keep every moving barrier uniformly
away from the centre. -/
def movingLowEndpointT₀ : ℝ :=
  firstPassageEndpointDisplacement / 4

/-- Fixed upper displacement strictly below the central quarter-window. -/
def movingLowUpperDisplacement : ℝ :=
  (firstPassageEndpointDisplacement + 1 / 4) / 2

theorem movingLowEndpointT₀_pos : 0 < movingLowEndpointT₀ := by
  unfold movingLowEndpointT₀
  exact div_pos firstPassageEndpointDisplacement_pos (by norm_num)

theorem movingLowUpperDisplacement_lt_quarter :
    movingLowUpperDisplacement < 1 / 4 := by
  unfold movingLowUpperDisplacement
  linarith [firstPassageEndpointDisplacement_lt_quarter]

/-- The rounded half-integer barrier is no higher than the real barrier. -/
theorem roundedBarrierLevel_half_le
    {d : ℝ} {m : ℕ} (hd : 0 ≤ d) :
    (roundedBarrierLevel d m : ℝ) - 1 / 2 ≤
      2 * d * (m : ℝ) := by
  have hx : 0 ≤ 2 * d * (m : ℝ) := by positivity
  have hfloor : (roundedBarrierLevel d m : ℝ) ≤
      2 * d * (m : ℝ) := by
    simpa [roundedBarrierLevel] using Nat.floor_le hx
  linarith

/-- Rounding changes the terminal displacement by at most one lattice unit
on the lower side. -/
theorem roundedBarrierDisplacement_gt_sub_inv
    {d : ℝ} {m : ℕ} (hm : 0 < m) :
    d - 1 / (m : ℝ) < roundedBarrierDisplacement d m := by
  have hmR : 0 < (m : ℝ) := by positivity
  have hfloor :
      2 * d * (m : ℝ) < (roundedBarrierLevel d m : ℝ) + 1 := by
    simpa [roundedBarrierLevel] using
      (Nat.lt_floor_add_one (2 * d * (m : ℝ)))
  have hthreshold :=
    (endpointThreshold_double_bounds m (roundedBarrierLevel d m)).1
  have hthresholdR :
      (m : ℝ) + (roundedBarrierLevel d m : ℝ) ≤
        2 * (endpointThreshold m (roundedBarrierLevel d m) : ℝ) := by
    exact_mod_cast hthreshold
  unfold roundedBarrierDisplacement
  have hinv : (1 / (m : ℝ)) * (m : ℝ) = 1 := by
    field_simp
  have hmain :
      d - 1 / (m : ℝ) + 1 / 2 <
        (endpointThreshold m (roundedBarrierLevel d m) : ℝ) / (m : ℝ) := by
    rw [lt_div_iff₀ hmR]
    nlinarith [hfloor, hthresholdR]
  linarith

/-- Rounding changes the terminal displacement by at most one lattice unit
on the upper side. -/
theorem roundedBarrierDisplacement_lt_add_inv
    {d : ℝ} {m : ℕ} (hd : 0 ≤ d) (hm : 0 < m) :
    roundedBarrierDisplacement d m < d + 1 / (m : ℝ) := by
  have hmR : 0 < (m : ℝ) := by positivity
  have hx : 0 ≤ 2 * d * (m : ℝ) := by positivity
  have hfloor : (roundedBarrierLevel d m : ℝ) ≤
      2 * d * (m : ℝ) := by
    simpa [roundedBarrierLevel] using Nat.floor_le hx
  have hthreshold :=
    (endpointThreshold_double_bounds m (roundedBarrierLevel d m)).2
  have hthresholdR :
      2 * (endpointThreshold m (roundedBarrierLevel d m) : ℝ) <
        (m : ℝ) + (roundedBarrierLevel d m : ℝ) + 2 := by
    exact_mod_cast hthreshold
  unfold roundedBarrierDisplacement
  have hinv : (1 / (m : ℝ)) * (m : ℝ) = 1 := by
    field_simp
  have hmain :
      (endpointThreshold m (roundedBarrierLevel d m) : ℝ) / (m : ℝ) <
        d + 1 / (m : ℝ) + 1 / 2 := by
    rw [div_lt_iff₀ hmR]
    nlinarith [hfloor, hthresholdR]
  linarith

theorem abs_roundedBarrierDisplacement_sub_lt_inv
    {d : ℝ} {m : ℕ} (hd : 0 ≤ d) (hm : 0 < m) :
    |roundedBarrierDisplacement d m - d| < 1 / (m : ℝ) := by
  rw [abs_lt]
  constructor
  · have h := roundedBarrierDisplacement_gt_sub_inv (d := d) hm
    linarith
  · have h := roundedBarrierDisplacement_lt_add_inv hd hm
    linarith

/-- A lower bound on the real displacement and one explicit lattice-size
condition place the rounded terminal layer uniformly away from the centre. -/
theorem movingLowEndpointT₀_le_roundedBarrierDisplacement
    {d : ℝ} {m : ℕ} (hm : 0 < m)
    (hd : firstPassageEndpointDisplacement / 2 ≤ d)
    (hscale : 4 ≤ firstPassageEndpointDisplacement * (m : ℝ)) :
    movingLowEndpointT₀ ≤ roundedBarrierDisplacement d m := by
  have hmR : 0 < (m : ℝ) := by positivity
  have hinv : 1 / (m : ℝ) ≤ firstPassageEndpointDisplacement / 4 := by
    rw [div_le_iff₀ hmR]
    nlinarith
  have hround := roundedBarrierDisplacement_gt_sub_inv (d := d) hm
  unfold movingLowEndpointT₀
  linarith

/-- An upper displacement strictly below `1/4`, together with a linear
lattice reserve, places the rounded endpoint layer in the central
quarter-window. -/
theorem roundedBarrierLevel_central_quarter
    {d : ℝ} {m : ℕ} (hd0 : 0 ≤ d)
    (hd : d ≤ movingLowUpperDisplacement)
    (hscale :
      4 ≤ (1 - 4 * movingLowUpperDisplacement) * (m : ℝ)) :
    2 * roundedBarrierLevel d m + 4 ≤ m := by
  have hx : 0 ≤ 2 * d * (m : ℝ) := by positivity
  have hfloor : (roundedBarrierLevel d m : ℝ) ≤
      2 * d * (m : ℝ) := by
    simpa [roundedBarrierLevel] using Nat.floor_le hx
  have hm0 : 0 ≤ (m : ℝ) := by positivity
  have hdScaled : 4 * d * (m : ℝ) ≤
      4 * movingLowUpperDisplacement * (m : ℝ) := by
    nlinarith
  have hreal :
      (2 * roundedBarrierLevel d m + 4 : ℕ) ≤ m := by
    exact_mod_cast (show
      (2 : ℝ) * roundedBarrierLevel d m + 4 ≤ (m : ℝ) by
        nlinarith [hfloor, hdScaled])
  exact hreal

/-- Sharp probability bound for the literal initial-window failure set under
explicit deterministic startup and rounded-lattice side conditions. -/
theorem exists_card_shellInitialWindowBad_sharp_adjustable_le
    {t₀ : ℝ} (ht₀ : 0 < t₀) :
    ∃ C : ℝ, 0 < C ∧
      ∀ lambda t : ℝ, ∀ m a : ℕ,
        0 ≤ lambda → lambda ≤ 1 → 0 ≤ t → t < a0 →
        1 ≤ (1 - lambda) * t * (m : ℝ) →
        2 * (2 + Real.sqrt 3) ≤
          (2 : ℝ) ^ ((a0 + t - 2 * lambda * t) * (m : ℝ)) →
        (a : ℝ) - 1 / 2 ≤ 2 * adjustableBarrierHeight lambda t m →
        0 < m → a ≤ m →
        let k := endpointThreshold m a
        0 < k → k < m →
        (m : ℝ) * (1 / 2 + t₀) ≤ (k : ℝ) →
        (m : ℝ) / 4 ≤ (k : ℝ) →
        (m : ℝ) / 4 ≤ ((m - k : ℕ) : ℝ) →
        ((shellInitialWindowBad m t).card : ℝ) / (2 : ℝ) ^ m ≤
          (C / Real.sqrt m) *
            Real.exp (-((m : ℝ) *
              binaryBarrierRate ((k : ℝ) / (m : ℝ) - 1 / 2))) := by
  obtain ⟨C, hC, hwalk⟩ :=
    exists_barrierHitCount_real_normalized_le_binaryBarrierRate ht₀
  refine ⟨C, hC, ?_⟩
  intro lambda t m a hlambda0 hlambda1 ht0 htA hmain hcorr hah hm ham
  dsimp only
  intro hk hklt hgap hkLower hmkLower
  have hsubset := shellInitialWindowBad_subset_adjustable
    hlambda1 ht0 hmain hcorr
  have hcard₁ :
      (shellInitialWindowBad m t).card ≤
        (shellMaximalParityBad m (adjustableBarrierHeight lambda t m)).card :=
    Finset.card_le_card hsubset
  have hcard₂ :
      (shellMaximalParityBad m (adjustableBarrierHeight lambda t m)).card ≤
        (shellBarrierHit m (adjustableBarrierHeight lambda t m)).card :=
    Finset.card_le_card
      (shellMaximalParityBad_subset_hit m (adjustableBarrierHeight lambda t m))
  have hcardR :
      ((shellInitialWindowBad m t).card : ℝ) ≤
        (barrierHitCount (2 * adjustableBarrierHeight lambda t m) m 0 : ℝ) := by
    rw [← card_shellBarrierHit]
    exact_mod_cast hcard₁.trans hcard₂
  have hpowPos : 0 < (2 : ℝ) ^ m := by positivity
  calc
    ((shellInitialWindowBad m t).card : ℝ) / (2 : ℝ) ^ m ≤
        (barrierHitCount (2 * adjustableBarrierHeight lambda t m) m 0 : ℝ) /
          (2 : ℝ) ^ m := (div_le_div_iff_of_pos_right hpowPos).2 hcardR
    _ ≤ (C / Real.sqrt m) *
          Real.exp (-((m : ℝ) *
            binaryBarrierRate ((endpointThreshold m a : ℝ) /
              (m : ℝ) - 1 / 2))) :=
      hwalk m a (2 * adjustableBarrierHeight lambda t m) hah hm ham
        hk hklt hgap hkLower hmkLower

/-- Sharp density bound for the literal first-passage landing target with
moving low parameters.  The statement deliberately retains the rounded
entropy displacement.  Replacing it by the endpoint rate is a separate
uniform comparison, not a definitional simplification. -/
theorem exists_card_landingBad_movingLow_sharp_le
    {t₀ : ℝ} (ht₀ : 0 < t₀) :
    ∃ C : ℝ, 0 < C ∧
      ∀ K₀ K₁ : ℝ, ∀ L q : ℕ,
        let m := q - 1
        let d := movingLowDisplacement K₀ K₁ L
        let a := roundedBarrierLevel d m
        0 ≤ movingLowLambda K₁ L →
        movingLowLambda K₁ L ≤ 1 →
        0 ≤ movingLowTolerance K₀ L →
        movingLowTolerance K₀ L < a0 →
        1 ≤ (1 - movingLowLambda K₁ L) *
          movingLowTolerance K₀ L * (m : ℝ) →
        2 * (2 + Real.sqrt 3) ≤
          (2 : ℝ) ^ ((a0 + movingLowTolerance K₀ L -
            2 * movingLowLambda K₁ L * movingLowTolerance K₀ L) *
              (m : ℝ)) →
        0 ≤ d →
        0 < m →
        2 * a + 4 ≤ m →
        t₀ ≤ roundedBarrierDisplacement d m →
        ((landingBad q (movingLowTolerance K₀ L)).card : ℝ) /
            (2 : ℝ) ^ q ≤
          1 / (2 : ℝ) ^ q +
            (C / (2 * Real.sqrt m)) *
              Real.exp (-((m : ℝ) *
                binaryBarrierRate (roundedBarrierDisplacement d m))) := by
  obtain ⟨C, hC, hshell⟩ :=
    exists_card_shellInitialWindowBad_sharp_adjustable_le ht₀
  refine ⟨C, hC, ?_⟩
  intro K₀ K₁ L q
  dsimp only
  intro hlam0 hlam1 htol0 htolA hmain hcorr hd hm hcentral hgap
  let m := q - 1
  let d := movingLowDisplacement K₀ K₁ L
  let a := roundedBarrierLevel d m
  change 0 < m at hm
  change 2 * a + 4 ≤ m at hcentral
  change 0 ≤ d at hd
  change t₀ ≤ roundedBarrierDisplacement d m at hgap
  have hq1 : 1 ≤ q := by
    dsimp [m] at hm
    omega
  have hmq : m + 1 = q := by
    dsimp [m]
    omega
  have ha_le_m : a ≤ m := by omega
  have ha_succ_lt : a + 1 < m := by omega
  have hk_pos : 0 < endpointThreshold m a := endpointThreshold_pos hm
  have hk_lt : endpointThreshold m a < m :=
    endpointThreshold_lt_of_add_one_lt ha_succ_lt
  have hk_lower : (m : ℝ) / 4 ≤ (endpointThreshold m a : ℝ) :=
    endpointThreshold_quarter_lower
  have hmk_lower :
      (m : ℝ) / 4 ≤ ((m - endpointThreshold m a : ℕ) : ℝ) :=
    endpointThreshold_complement_quarter_lower hcentral
  have hgap' :
      (m : ℝ) * (1 / 2 + t₀) ≤ (endpointThreshold m a : ℝ) := by
    have hmR : 0 < (m : ℝ) := by positivity
    have hscaled := mul_le_mul_of_nonneg_left hgap hmR.le
    dsimp [roundedBarrierDisplacement] at hscaled
    rw [mul_sub, mul_div_cancel₀ _ hmR.ne'] at hscaled
    linarith
  have hah :
      (a : ℝ) - 1 / 2 ≤
        2 * adjustableBarrierHeight (movingLowLambda K₁ L)
          (movingLowTolerance K₀ L) m := by
    have hround := roundedBarrierLevel_half_le (d := d) (m := m) hd
    rw [adjustableBarrierHeight_eq_displacement_mul]
    change (a : ℝ) - 1 / 2 ≤ 2 * (d * (m : ℝ))
    simpa [mul_assoc] using hround
  have hshellBound := hshell
    (movingLowLambda K₁ L) (movingLowTolerance K₀ L) m a
    hlam0 hlam1 htol0 htolA hmain hcorr hah hm ha_le_m
    hk_pos hk_lt hgap' hk_lower hmk_lower
  have hlandNat := card_landingBad_le_shellBad_add_one hq1
    (movingLowTolerance K₀ L)
  have hland :
      ((landingBad q (movingLowTolerance K₀ L)).card : ℝ) ≤
        ((shellInitialWindowBad m (movingLowTolerance K₀ L)).card : ℝ) + 1 := by
    simpa [m] using (show
      ((landingBad q (movingLowTolerance K₀ L)).card : ℝ) ≤
        ((shellInitialWindowBad (q - 1)
          (movingLowTolerance K₀ L)).card : ℝ) + 1 by
      exact_mod_cast hlandNat)
  have hpowq : 0 < (2 : ℝ) ^ q := by positivity
  have hpowm : 0 < (2 : ℝ) ^ m := by positivity
  have hratio : (2 : ℝ) ^ m / (2 : ℝ) ^ q = 1 / 2 := by
    rw [← hmq, pow_succ]
    field_simp
  have hshellScaled :
      ((shellInitialWindowBad m (movingLowTolerance K₀ L)).card : ℝ) /
          (2 : ℝ) ^ q ≤
        (C / (2 * Real.sqrt m)) *
          Real.exp (-((m : ℝ) *
            binaryBarrierRate (roundedBarrierDisplacement d m))) := by
    calc
      ((shellInitialWindowBad m (movingLowTolerance K₀ L)).card : ℝ) /
          (2 : ℝ) ^ q =
        (((shellInitialWindowBad m (movingLowTolerance K₀ L)).card : ℝ) /
          (2 : ℝ) ^ m) * ((2 : ℝ) ^ m / (2 : ℝ) ^ q) := by
            field_simp [hpowm.ne', hpowq.ne']
      _ ≤ ((C / Real.sqrt m) *
          Real.exp (-((m : ℝ) *
            binaryBarrierRate (roundedBarrierDisplacement d m)))) *
          ((2 : ℝ) ^ m / (2 : ℝ) ^ q) :=
        mul_le_mul_of_nonneg_right hshellBound (by positivity)
      _ = (C / (2 * Real.sqrt m)) *
          Real.exp (-((m : ℝ) *
            binaryBarrierRate (roundedBarrierDisplacement d m))) := by
        rw [hratio]
        ring
  calc
    ((landingBad q (movingLowTolerance K₀ L)).card : ℝ) /
        (2 : ℝ) ^ q ≤
      (((shellInitialWindowBad m (movingLowTolerance K₀ L)).card : ℝ) + 1) /
        (2 : ℝ) ^ q := (div_le_div_iff_of_pos_right hpowq).2 hland
    _ = 1 / (2 : ℝ) ^ q +
        ((shellInitialWindowBad m (movingLowTolerance K₀ L)).card : ℝ) /
          (2 : ℝ) ^ q := by ring
    _ ≤ 1 / (2 : ℝ) ^ q +
        (C / (2 * Real.sqrt m)) *
          Real.exp (-((m : ℝ) *
            binaryBarrierRate (roundedBarrierDisplacement d m))) :=
      add_le_add_left hshellScaled _

/-- After one finite startup, the literal moving landing estimate holds
uniformly for every landing rank `q ≥ L`.  The hypothesis on `K₁` is an
explicit reserve for the honest parent shell `q - 1`; it avoids replacing
that shell by `q` in the startup calculation. -/
theorem exists_eventually_card_landingBad_movingLow_sharp_le
    {K₀ K₁ : ℝ} (hK₀ : 0 < K₀) (hK₁ : 0 < K₁)
    (hK₁Reserve : 8 ≤ K₁ * driftGap) :
    ∃ C : ℝ, 0 < C ∧
      ∀ᶠ L : ℕ in atTop, ∀ q : ℕ, L ≤ q →
        let m := q - 1
        let d := movingLowDisplacement K₀ K₁ L
        ((landingBad q (movingLowTolerance K₀ L)).card : ℝ) /
            (2 : ℝ) ^ q ≤
          1 / (2 : ℝ) ^ q +
            (C / (2 * Real.sqrt m)) *
              Real.exp (-((m : ℝ) *
                binaryBarrierRate (roundedBarrierDisplacement d m))) := by
  obtain ⟨C, hC, hlanding⟩ :=
    exists_card_landingBad_movingLow_sharp_le movingLowEndpointT₀_pos
  refine ⟨C, hC, ?_⟩
  let D := firstPassageEndpointDisplacement
  let U := movingLowUpperDisplacement
  let g := 2 * a0 - 1
  have hD : 0 < D := firstPassageEndpointDisplacement_pos
  have hU : D < U := by
    dsimp [D, U, movingLowUpperDisplacement]
    linarith [firstPassageEndpointDisplacement_lt_quarter]
  have hc : 0 < 1 - 4 * U := by
    dsimp [U]
    linarith [movingLowUpperDisplacement_lt_quarter]
  have hg : 0 < g := two_mul_a0_sub_one_pos
  have hAdm := eventually_movingLow_admissible hK₀ hK₁
  have hTolLower := (tendsto_movingLowTolerance K₀).eventually
    (Ioi_mem_nhds (show driftGap / 2 < driftGap by
      linarith [driftGap_pos]))
  have hDispLower := (tendsto_movingLowDisplacement K₀ K₁).eventually
    (Ioi_mem_nhds (show D / 2 < D by linarith))
  have hDispUpper := (tendsto_movingLowDisplacement K₀ K₁).eventually
    (Iio_mem_nhds hU)
  have hCorrLower := (tendsto_movingLowCorrectionGap K₀ K₁).eventually
    (Ioi_mem_nhds (show g / 2 < g by
      exact div_lt_self hg (by norm_num)))
  have hsubT : Tendsto (fun L : ℕ => (((L - 1 : ℕ) : ℝ))) atTop atTop :=
    tendsto_natCast_atTop_atTop.comp (tendsto_sub_atTop_nat 1)
  have hDScaleT : Tendsto
      (fun L : ℕ => D * (((L - 1 : ℕ) : ℝ))) atTop atTop :=
    hsubT.const_mul_atTop hD
  have hCScaleT : Tendsto
      (fun L : ℕ => (1 - 4 * U) * (((L - 1 : ℕ) : ℝ))) atTop atTop :=
    hsubT.const_mul_atTop hc
  have hDScale := (tendsto_atTop.1 hDScaleT) 4
  have hCScale := (tendsto_atTop.1 hCScaleT) 4
  have hpowT : Tendsto (fun N : ℕ => (2 : ℝ) ^ N) atTop atTop :=
    tendsto_pow_atTop_atTop_of_one_lt (by norm_num)
  have hpowEventually := (tendsto_atTop.1 hpowT)
    (2 * (2 + Real.sqrt 3))
  rw [eventually_atTop] at hpowEventually
  obtain ⟨Npow, hNpow⟩ := hpowEventually
  have hNpowBase :
      2 * (2 + Real.sqrt 3) ≤ (2 : ℝ) ^ Npow :=
    hNpow Npow le_rfl
  have hGScaleT : Tendsto
      (fun L : ℕ => (g / 2) * (((L - 1 : ℕ) : ℝ))) atTop atTop :=
    hsubT.const_mul_atTop (div_pos hg (by norm_num))
  have hGScale := (tendsto_atTop.1 hGScaleT) (Npow : ℝ)
  filter_upwards [hAdm, hTolLower, hDispLower, hDispUpper,
      hCorrLower, hDScale, hCScale, hGScale,
      eventually_ge_atTop (2 : ℕ)] with L hAdmL hTolL hDispLo hDispHi
        hCorrL hDScaleL hCScaleL hGScaleL hL
  intro q hLq
  let m := q - 1
  let d := movingLowDisplacement K₀ K₁ L
  have hmLowerNat : L - 1 ≤ m := by
    dsimp [m]
    omega
  have hm : 0 < m := by
    dsimp [m]
    omega
  have hLmRatio : (1 / 2 : ℝ) ≤ (m : ℝ) / (L : ℝ) := by
    have hLR : 0 < (L : ℝ) := by positivity
    rw [le_div_iff₀ hLR]
    have hmCast : ((L - 1 : ℕ) : ℝ) ≤ (m : ℝ) := by exact_mod_cast hmLowerNat
    have hLsub : (L : ℝ) - 1 = ((L - 1 : ℕ) : ℝ) := by
      rw [Nat.cast_sub (by omega : 1 ≤ L)]
      norm_num
    rw [← hLsub] at hmCast
    nlinarith
  have hMain :
      1 ≤ (1 - movingLowLambda K₁ L) * movingLowTolerance K₀ L *
        (m : ℝ) := by
    rw [movingLow_multiplicativeMargin]
    have hKtol : 4 ≤ K₁ * movingLowTolerance K₀ L := by
      have hmul := mul_le_mul_of_nonneg_left hTolL.le hK₁.le
      nlinarith [hK₁Reserve]
    have hprod := mul_le_mul hKtol hLmRatio (by norm_num)
      (mul_nonneg hK₁.le hAdmL.1.le)
    nlinarith
  have hCorr :
      2 * (2 + Real.sqrt 3) ≤
        (2 : ℝ) ^ ((a0 + movingLowTolerance K₀ L -
          2 * movingLowLambda K₁ L * movingLowTolerance K₀ L) *
            (m : ℝ)) := by
    have hmCast : ((L - 1 : ℕ) : ℝ) ≤ (m : ℝ) := by exact_mod_cast hmLowerNat
    have hExp : (Npow : ℝ) ≤
        (a0 + movingLowTolerance K₀ L -
          2 * movingLowLambda K₁ L * movingLowTolerance K₀ L) *
            (m : ℝ) := by
      have hmul := mul_le_mul hCorrL.le hmCast
        (by positivity) (by linarith [hCorrL, hg])
      exact hGScaleL.trans hmul
    have hrpow := Real.rpow_le_rpow_of_exponent_le
      (by norm_num : (1 : ℝ) ≤ 2) hExp
    calc
      2 * (2 + Real.sqrt 3) ≤ (2 : ℝ) ^ Npow := hNpowBase
      _ = (2 : ℝ) ^ (Npow : ℝ) := by rw [Real.rpow_natCast]
      _ ≤ _ := hrpow
  have hd0 : 0 ≤ d := by
    dsimp [d, D] at hDispLo ⊢
    linarith [hD]
  have hDScaleM : 4 ≤ firstPassageEndpointDisplacement * (m : ℝ) := by
    have hmCast : ((L - 1 : ℕ) : ℝ) ≤ (m : ℝ) := by exact_mod_cast hmLowerNat
    dsimp [D] at hDScaleL
    exact hDScaleL.trans (mul_le_mul_of_nonneg_left hmCast hD.le)
  have hCScaleM :
      4 ≤ (1 - 4 * movingLowUpperDisplacement) * (m : ℝ) := by
    have hmCast : ((L - 1 : ℕ) : ℝ) ≤ (m : ℝ) := by exact_mod_cast hmLowerNat
    dsimp [U] at hCScaleL
    exact hCScaleL.trans (mul_le_mul_of_nonneg_left hmCast hc.le)
  have hcentral : 2 * roundedBarrierLevel d m + 4 ≤ m :=
    roundedBarrierLevel_central_quarter hd0 hDispHi.le hCScaleM
  have hgap : movingLowEndpointT₀ ≤ roundedBarrierDisplacement d m :=
    movingLowEndpointT₀_le_roundedBarrierDisplacement hm hDispLo.le hDScaleM
  exact hlanding K₀ K₁ L q
    hAdmL.2.2.2.2.1.le hAdmL.2.2.2.2.2.1.le
    hAdmL.1.le (hAdmL.2.1.trans driftGap_lt_a0) hMain hCorr hd0 hm hcentral hgap

/-- Uniform endpoint-rate comparison for the rounded moving barrier.  If a
rounded layer lies above the limiting endpoint, monotonicity gives the result
for free; otherwise the compact Lipschitz estimate pays only `O(1/L)`. -/
theorem exists_eventually_roundedMovingLowRate_ge_sub_div
    {K₀ K₁ : ℝ} (hK₀ : 0 < K₀) (hK₁ : 0 < K₁) :
    ∃ C : ℝ, 0 < C ∧
      ∀ᶠ L : ℕ in atTop, ∀ q : ℕ, L ≤ q →
        firstPassageEndpointRate - C / (L : ℝ) ≤
          binaryBarrierRate
            (roundedBarrierDisplacement (movingLowDisplacement K₀ K₁ L)
              (q - 1)) := by
  obtain ⟨C₀, hC₀, hLip⟩ := exists_binaryBarrierRate_endpoint_lipschitz
  let A := (K₀ + K₁ * driftGap) / logTwoThree
  let C := C₀ * (A + 2)
  have hA : 0 < A := by
    dsimp [A]
    exact div_pos (add_pos hK₀ (mul_pos hK₁ driftGap_pos)) logTwoThree_pos
  have hC : 0 < C := mul_pos hC₀ (by linarith)
  refine ⟨C, hC, ?_⟩
  let D := firstPassageEndpointDisplacement
  have hD : 0 < D := firstPassageEndpointDisplacement_pos
  have hAdm := eventually_movingLow_admissible hK₀ hK₁
  have hDispLower := (tendsto_movingLowDisplacement K₀ K₁).eventually
    (Ioi_mem_nhds (show 3 * D / 4 < D by linarith))
  have hsubT : Tendsto (fun L : ℕ => (((L - 1 : ℕ) : ℝ))) atTop atTop :=
    tendsto_natCast_atTop_atTop.comp (tendsto_sub_atTop_nat 1)
  have hDScaleT : Tendsto
      (fun L : ℕ => D * (((L - 1 : ℕ) : ℝ))) atTop atTop :=
    hsubT.const_mul_atTop hD
  have hDScale := (tendsto_atTop.1 hDScaleT) 4
  filter_upwards [hAdm, hDispLower, hDScale,
      eventually_ge_atTop (2 : ℕ)] with L hAdmL hDispLo hDScaleL hL
  intro q hLq
  let m := q - 1
  let d := movingLowDisplacement K₀ K₁ L
  let z := roundedBarrierDisplacement d m
  have hmLowerNat : L - 1 ≤ m := by
    dsimp [m]
    omega
  have hm : 0 < m := by
    dsimp [m]
    omega
  have hmCast : ((L - 1 : ℕ) : ℝ) ≤ (m : ℝ) := by
    exact_mod_cast hmLowerNat
  have hinvD : 1 / (m : ℝ) ≤ D / 4 := by
    have hmR : 0 < (m : ℝ) := by positivity
    rw [div_le_iff₀ hmR]
    have hscale := hDScaleL.trans
      (mul_le_mul_of_nonneg_left hmCast hD.le)
    nlinarith
  have hhalfRatio : (1 / 2 : ℝ) ≤ (m : ℝ) / (L : ℝ) := by
    have hLR : 0 < (L : ℝ) := by positivity
    have hnat : L ≤ 2 * m := by
      dsimp [m]
      omega
    have hreal : (L : ℝ) ≤ 2 * (m : ℝ) := by exact_mod_cast hnat
    rw [le_div_iff₀ hLR]
    nlinarith
  have hinvL : 1 / (m : ℝ) ≤ 2 / (L : ℝ) := by
    have hmR : 0 < (m : ℝ) := by positivity
    have hLR : 0 < (L : ℝ) := by positivity
    rw [div_le_div_iff₀ hmR hLR]
    have hcross := (le_div_iff₀ hLR).1 hhalfRatio
    norm_num at hcross
    norm_num
    nlinarith
  have hd0 : 0 ≤ d := by
    dsimp [d, D] at hDispLo ⊢
    linarith [hD]
  have hroundLower := roundedBarrierDisplacement_gt_sub_inv (d := d) hm
  have hroundUpper := roundedBarrierDisplacement_lt_add_inv hd0 hm
  have hzLower : D / 2 ≤ z := by
    dsimp [z, d, D] at hroundLower hDispLo ⊢
    linarith
  have hzHalf : z ≤ 1 / 2 := by
    dsimp [z, d, D] at hroundUpper hAdmL hDispLo ⊢
    have hDquarter := firstPassageEndpointDisplacement_lt_quarter
    have hdUpper : movingLowDisplacement K₀ K₁ L ≤
        firstPassageEndpointDisplacement := by
      unfold movingLowDisplacement adjustableBarrierDisplacement
        firstPassageEndpointDisplacement
      apply (div_le_div_iff_of_pos_right logTwoThree_pos).2
      have hmul : movingLowLambda K₁ L * movingLowTolerance K₀ L ≤
          movingLowTolerance K₀ L := by
        exact mul_le_of_le_one_left hAdmL.1.le hAdmL.2.2.2.2.2.1.le
      exact hmul.trans hAdmL.2.1.le
    linarith
  by_cases hzD : D ≤ z
  · have hmono := binaryBarrierRate_monotoneOn
      (show D ∈ Set.Icc (0 : ℝ) (1 / 2) by
        constructor
        · exact hD.le
        · linarith [firstPassageEndpointDisplacement_lt_half])
      (show z ∈ Set.Icc (0 : ℝ) (1 / 2) by
        constructor <;> linarith [hzLower, hD]) hzD
    have hCL : 0 ≤ C / (L : ℝ) := by positivity
    change binaryBarrierRate D - C / (L : ℝ) ≤ binaryBarrierRate z
    linarith
  · have hzD' : z ≤ D := le_of_not_ge hzD
    have hzWindow : z ∈ Set.Icc (D / 2) D := ⟨hzLower, hzD'⟩
    have hDWindow : D ∈ Set.Icc (D / 2) D := by
      constructor <;> linarith
    have hrateNorm := hLip z hzWindow D hDWindow
    have hdispError := movingLowDisplacement_error_le
      hK₀.le hK₁.le (by omega : 0 < L)
    have hDz : D - z ≤ (A + 2) / (L : ℝ) := by
      have hround := roundedBarrierDisplacement_gt_sub_inv (d := d) hm
      change d - 1 / (m : ℝ) < z at hround
      have hmove : D - d ≤ A / (L : ℝ) := by
        dsimp [D, d, A]
        simpa [div_eq_mul_inv, mul_assoc, mul_left_comm, mul_comm] using hdispError
      exact (calc
        D - z < (D - d) + 1 / (m : ℝ) := by linarith
        _ ≤ A / (L : ℝ) + 2 / (L : ℝ) := add_le_add hmove hinvL
        _ = (A + 2) / (L : ℝ) := by ring).le
    have hrate : firstPassageEndpointRate - binaryBarrierRate z ≤
        C₀ * (D - z) := by
      calc
        firstPassageEndpointRate - binaryBarrierRate z ≤
            ‖firstPassageEndpointRate - binaryBarrierRate z‖ := le_abs_self _
        _ ≤ C₀ * ‖D - z‖ := by
          simpa [firstPassageEndpointRate, D] using hrateNorm
        _ = C₀ * (D - z) := by
          rw [Real.norm_eq_abs, abs_of_nonneg (sub_nonneg.mpr hzD')]
    have hscaled := mul_le_mul_of_nonneg_left hDz hC₀.le
    have hLR : 0 < (L : ℝ) := by positivity
    have hbudget :
        firstPassageEndpointRate - binaryBarrierRate z ≤ C / (L : ℝ) := by
      calc
        firstPassageEndpointRate - binaryBarrierRate z ≤ C₀ * (D - z) := hrate
        _ ≤ C₀ * ((A + 2) / (L : ℝ)) := hscaled
        _ = C / (L : ℝ) := by
          dsimp [C]
          ring
    change firstPassageEndpointRate - C / (L : ℝ) ≤ binaryBarrierRate z
    linarith

/-- Literal moving low-rank target density at the limiting endpoint rate,
with the full `O(1/L)` loss visible in the exponent.  This is the analytic
producer required by the moving-endpoint assembly; no fixed-`A` theorem is
used in its statement. -/
theorem exists_eventually_card_landingBad_movingLow_endpointRate_le
    {K₀ K₁ : ℝ} (hK₀ : 0 < K₀) (hK₁ : 0 < K₁)
    (hK₁Reserve : 8 ≤ K₁ * driftGap) :
    ∃ C D : ℝ, 0 < C ∧ 0 < D ∧
      ∀ᶠ L : ℕ in atTop, ∀ q : ℕ, L ≤ q →
        let m := q - 1
        ((landingBad q (movingLowTolerance K₀ L)).card : ℝ) /
            (2 : ℝ) ^ q ≤
          1 / (2 : ℝ) ^ q +
            (C / (2 * Real.sqrt m)) *
              Real.exp (-((m : ℝ) *
                (firstPassageEndpointRate - D / (L : ℝ)))) := by
  obtain ⟨C, hC, hlanding⟩ :=
    exists_eventually_card_landingBad_movingLow_sharp_le
      hK₀ hK₁ hK₁Reserve
  obtain ⟨D, hD, hrate⟩ :=
    exists_eventually_roundedMovingLowRate_ge_sub_div hK₀ hK₁
  refine ⟨C, D, hC, hD, ?_⟩
  filter_upwards [hlanding, hrate] with L hlandingL hrateL
  intro q hLq
  let m := q - 1
  let d := movingLowDisplacement K₀ K₁ L
  have hm0 : 0 ≤ (m : ℝ) := by positivity
  have hrateQ := hrateL q hLq
  have hexponent :
      -((m : ℝ) * binaryBarrierRate (roundedBarrierDisplacement d m)) ≤
        -((m : ℝ) * (firstPassageEndpointRate - D / (L : ℝ))) := by
    dsimp [d, m] at hrateQ ⊢
    nlinarith
  have hexp := Real.exp_le_exp.mpr hexponent
  have hpref : 0 ≤ C / (2 * Real.sqrt m) := by positivity
  exact (hlandingL q hLq).trans
    (add_le_add_left (mul_le_mul_of_nonneg_left hexp hpref) _)

end

end FirstPassageLinearTransport
