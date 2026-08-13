/-
Copyright (c) 2026 Idris Ali Shaik. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Idris Ali Shaik
-/
/- Generated source-preserving extraction: declarations in this module are outside the canonical referee-facing roots. -/
import FirstPassageLinearTransport.Transport

import FirstPassageLinearTransport.LossTransport
/-!
# Loss-filtered first-passage transport

This module formalizes the reverse-product loss used by the optimized
first-passage re-certification argument.  The filter is sourcewise and exact:
no generated-distribution or independence hypothesis is introduced.
-/

namespace FirstPassageLinearTransport

open scoped BigOperators

noncomputable section



theorem reverseLossTotal_nonneg (n h : ℕ) :
    0 ≤ reverseLossTotal n h := by
  unfold reverseLossTotal
  exact Finset.sum_nonneg fun i _ => reverseLoss_nonneg n i














end

end FirstPassageLinearTransport
