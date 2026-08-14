/-
Copyright (c) 2026 Idris Ali Shaik. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Idris Ali Shaik
-/
/- Generated source-preserving extraction: declarations in this module are outside the canonical referee-facing roots. -/
import FirstPassageLinearTransport.VaryingDensity

import FirstPassageLinearTransport.PolylogExceptionalCount
/-!
# Polynomial exceptional-count assembly

This module is a generic dyadic summation result.  A shell exceptional ratio
of order `(M+2)^(-kappa)` gives a prefix count with the same logarithmic
power, apart from an explicit early-shell term.  No Collatz input occurs.
-/

namespace FirstPassageLinearTransport

open Filter
open scoped Real Topology BigOperators

noncomputable section







/-- Natural-logarithm form of the quantitative prefix estimate. -/
theorem eventually_badCount_assembleDyadic_le_natLog_profile
    (S : ℕ → Set ℕ) (M₀ : ℕ) (B kappa : ℝ)
    (hB : 0 ≤ B) (hkappa : 0 ≤ kappa)
    (hshell : ∀ M, M₀ ≤ M →
      shellExceptionalRatio (S M) M ≤
        B * (((M : ℝ) + 2) ^ (-kappa))) :
    ∀ᶠ N : ℕ in atTop,
      (badCount (assembleDyadic S) N : ℝ) ≤
        ((1 + 2 * B) * (2 * Real.log 2) ^ kappa) *
          N * (Real.log N) ^ (-kappa) := by
  have hPrefix := eventually_badCount_assembleDyadic_le_polylog_profile
    S M₀ B kappa hB hkappa hshell
  have hScale := eventually_halfNatLog_profile_le_natLog hkappa
  filter_upwards [hPrefix, hScale] with N hPrefix hScale
  have hCoeff : 0 ≤ (1 + 2 * B) * (N : ℝ) := by positivity
  calc
    (badCount (assembleDyadic S) N : ℝ) ≤
        (1 + 2 * B) * N *
          ((((Nat.log 2 N) / 2 : ℕ) : ℝ) + 2) ^ (-kappa) := hPrefix
    _ ≤ (1 + 2 * B) * N *
          ((2 * Real.log 2) ^ kappa * (Real.log N) ^ (-kappa)) :=
      mul_le_mul_of_nonneg_left hScale hCoeff
    _ = ((1 + 2 * B) * (2 * Real.log 2) ^ kappa) *
          N * (Real.log N) ^ (-kappa) := by ring

end

end FirstPassageLinearTransport
