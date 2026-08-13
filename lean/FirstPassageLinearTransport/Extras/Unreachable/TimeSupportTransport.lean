/-
Copyright (c) 2026 Idris Ali Shaik. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Idris Ali Shaik
-/
/- Generated source-preserving extraction: declarations in this module are outside the canonical referee-facing roots. -/
import FirstPassageLinearTransport.LossTransport

import FirstPassageLinearTransport.TimeSupportTransport
/-!
# First-passage transport on an explicit time support

The older transport interface sums over every positive time up to one global
horizon.  The shrinking-barrier argument knows a smaller finite set of
feasible cumulative times.  This module records the exact replacement: the
transport cost is the cardinality of that set, with no interval or density
assumption on it.
-/

namespace FirstPassageLinearTransport

noncomputable section





/-- An arbitrary source restriction cannot increase the support-sensitive
transport count. -/
theorem lossFiltered_arbitraryTarget_transport_atTimes_restricted
    {M Y : ℕ} (times B A : Finset ℕ) {D : ℚ}
    (hY : 0 < Y) (hD : 0 ≤ D)
    (hsmall : D / (Y : ℚ) ≤ 1 / 3) (hYM : Y < 2 ^ M) :
    (((lossFilteredTransportedSourcesAtTimes M Y times B D) ∩ A).card : ℚ) ≤
      (times.card : ℚ) * (1 + 3 * D) *
        (2 : ℚ) ^ M / (Y : ℚ) * (B.card : ℚ) := by
  have hcard :
      (((lossFilteredTransportedSourcesAtTimes M Y times B D) ∩ A).card : ℚ) ≤
        ((lossFilteredTransportedSourcesAtTimes M Y times B D).card : ℚ) := by
    exact_mod_cast Finset.card_le_card Finset.inter_subset_left
  exact hcard.trans
    (lossFiltered_arbitraryTarget_transport_atTimes_uniform
      times B hY hD hsmall hYM)

end

end FirstPassageLinearTransport
