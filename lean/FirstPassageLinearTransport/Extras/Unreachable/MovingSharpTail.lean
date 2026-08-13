/-
Copyright (c) 2026 Idris Ali Shaik. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Idris Ali Shaik
-/
/- Generated source-preserving extraction: declarations in this module are outside the canonical referee-facing roots. -/
import Mathlib.Algebra.GeomSum
import FirstPassageLinearTransport.TerminalTail

import FirstPassageLinearTransport.MovingSharpTail
/-!
# Sharp square-root terminal tails

The critical moving producer supplies a density of shape

```text
d_q ≪ 2^{-q} + q^{-1/2} exp(-b (q-1)).
```

Multiplying by the reverse-loss factor `(q+1)` and summing over
`q ∈ [L, S]` retains the original exponential rate:

```text
O((L+1) 2^{-L} + √L exp(-b (L-1))).
```

The constant is uniform for `b` bounded below by one fixed positive rate.
No replacement `b ↦ b' < b` is made.  After the `O(√(M log M))`
time-support factor this is the endpoint-sensitive input for the critical
buffer

```text
Δ_M = κ_* L - ½ log₂ M - log₂ log M.
```

The coarser `terminalTailBound` route replaces `q^{-1/2}` by `1` and therefore
spends an extra polynomial rank factor.  This module exposes only the
exact-rate endpoint-sensitive consumer.
-/

namespace FirstPassageLinearTransport

open Filter
open scoped BigOperators Real Topology

noncomputable section








/-- Existential compatibility wrapper for the canonical sharp-tail
constant. -/
theorem exists_exact_sharp_critical_low_series_bound
    {b₀ Cpref : ℝ} (hb₀ : 0 < b₀) (hCpref : 0 ≤ Cpref) :
    ∃ K : ℝ, 0 < K ∧ ∀ {b : ℝ}, b₀ ≤ b → ∀ {L U : ℕ},
      2 ≤ L → L ≤ U →
      ∑ q in Finset.Icc L U,
          ((q + 1 : ℕ) : ℝ) *
            (Real.exp (-(Real.log 2 * (q : ℝ))) +
              Cpref / Real.sqrt ((q - 1 : ℕ) : ℝ) *
                Real.exp (-(b * ((q - 1 : ℕ) : ℝ)))) ≤
        K * (((L + 1 : ℕ) : ℝ) * Real.exp (-(Real.log 2 * (L : ℝ))) +
          Real.sqrt L * Real.exp (-(b * ((L - 1 : ℕ) : ℝ)))) := by
  refine ⟨exactSharpCriticalLowSeriesConstant b₀ Cpref, ?_⟩
  exact exactSharpCriticalLowSeriesConstant_spec hb₀ hCpref
end

end FirstPassageLinearTransport
