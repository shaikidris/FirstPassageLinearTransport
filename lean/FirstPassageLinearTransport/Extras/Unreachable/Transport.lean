/-
Copyright (c) 2026 Idris Ali Shaik. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Idris Ali Shaik
-/
/- Generated source-preserving extraction: declarations in this module are outside the canonical referee-facing roots. -/
import FirstPassageLinearTransport.FirstPassage

import FirstPassageLinearTransport.Transport
/-!
# Arbitrary-target first-passage transport

This module formalizes the uniform tagged-fiber bound and arbitrary-target
linear transport.
-/

namespace FirstPassageLinearTransport






/-- Arbitrary source restriction can only decrease the transported mass. -/
theorem arbitraryTarget_linear_transport_restricted {M Y H : ℕ}
    (B A : Finset ℕ)
    (hY : 0 < Y) (hH : 1 ≤ H)
    (hHY : (H : ℚ) / (2 * (Y : ℚ)) ≤ 1 / 3)
    (hYM : Y < 2 ^ M) :
    (((transportedSources M Y H B) ∩ A).card : ℚ) ≤
      (5 / 2 : ℚ) * (H : ℚ) ^ 2 * (2 : ℚ) ^ M /
        (Y : ℚ) * (B.card : ℚ) := by
  have hcard : ((transportedSources M Y H B ∩ A).card : ℚ) ≤
      ((transportedSources M Y H B).card : ℚ) := by
    exact_mod_cast Finset.card_le_card Finset.inter_subset_left
  exact hcard.trans (arbitraryTarget_linear_transport B hY hH hHY hYM)

end FirstPassageLinearTransport
