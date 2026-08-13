/-
Copyright (c) 2026 Idris Ali Shaik. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Idris Ali Shaik
-/
/- Generated source-preserving extraction: declarations in this module are outside the canonical referee-facing roots. -/
import Mathlib

import FirstPassageLinearTransport.Basic
/-!
# First-passage V2: independent basic definitions

This module restates the shortcut Collatz dynamics and the quantitative
density language used by the standalone V2 paper.  It imports only Mathlib.
-/

namespace FirstPassageLinearTransport





























theorem oddCount_le (n k : ℕ) : oddCount n k ≤ k := by
  unfold oddCount
  calc
    ∑ i ∈ Finset.range k, (parityBit n i : ℕ)
        ≤ ∑ _i ∈ Finset.range k, 1 := by
          exact Finset.sum_le_sum fun i hi => by
            omega
    _ = k := by simp



theorem timedDescent_implies_descent {δ clock : ℝ} {n : ℕ}
    (h : HasTimedStretchedLogDescent δ clock n) :
    HasStretchedLogDescent δ n := by
  rcases h with ⟨k, _hk, hdrop⟩
  exact ⟨k, hdrop⟩

end FirstPassageLinearTransport
