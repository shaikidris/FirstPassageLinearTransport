/-
Copyright (c) 2026 Idris Ali Shaik. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Idris Ali Shaik
-/
/- Generated source-preserving extraction: declarations in this module are outside the canonical referee-facing roots. -/
import FirstPassageLinearTransport.Parameters
import FirstPassageLinearTransport.VaryingDensity

import FirstPassageLinearTransport.Bootstrap
/-!
# Varying-scale first-passage bootstrap

The set recurrence in this module is the literal repeated stopped-map
pullback.  Its density exponent is exactly `Dc * chi^R`; no independence or
fresh-randomness premise is introduced between stages.
-/

namespace FirstPassageLinearTransport

open scoped Real Topology BigOperators

noncomputable section



























/-- A member of the `R`-fold pullback remains in the barrier window at every
stage and lands in the base window after `R` stopped blocks. -/
theorem bootstrapSet_stageOrbit_mem {r eta : ℝ} (p : StageSetup r eta)
    {R n : ℕ} (hn : n ∈ bootstrapSet p R) :
    stageOrbit p R n ∈ extendedWindow p := by
  induction R generalizing n with
  | zero => simpa using hn
  | succ R ih =>
      rw [bootstrapSet_succ] at hn
      exact ih hn.2

theorem bootstrapSet_subset_extended {r eta : ℝ} (p : StageSetup r eta) :
    ∀ R, bootstrapSet p R ⊆ extendedWindow p := by
  intro R n hn
  cases R with
  | zero => simpa using hn
  | succ R =>
      rw [bootstrapSet_succ] at hn
      exact hn.1





/-- Positivity is preserved by every total stopped stage. -/
theorem stageOrbit_pos {r eta : ℝ} (p : StageSetup r eta)
    {n : ℕ} (hn : 0 < n) (R : ℕ) : 0 < stageOrbit p R n := by
  rw [stageOrbit_eq_orbit_stageClock]
  exact orbit_pos hn _






end

end FirstPassageLinearTransport
