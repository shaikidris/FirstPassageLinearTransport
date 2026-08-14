/-
Copyright (c) 2026 Idris Ali Shaik. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Idris Ali Shaik
-/
/- Generated source-preserving extraction: declarations in this module are outside the canonical referee-facing roots. -/
import FirstPassageLinearTransport.TimeoutEnvelope

import FirstPassageLinearTransport.TimeoutExecution
/-!
# Literal execution of the timeout re-certification chain

Every outer-shell source is totalized into one of four cases: an initial
high failure, a first failed high certification, a first low timeout, or a
genuine orbit witness below the terminal threshold.  A dyadic upper endpoint
in the low phase is completed by exact halving; it is not inserted into the
timeout target as an artificial boundary atom.
-/

namespace FirstPassageLinearTransport

noncomputable section


/-- Either form of terminal landing gives an actual iterate below `2^L`. -/
theorem HasTimeoutTerminalLanding.orbit_le
    {P : TimeoutHighRunData} {K₀ : ℝ}
    {L M S n : ℕ}
    (hterm : HasTimeoutTerminalLanding P K₀ L M S n) :
    ∃ h : ℕ, orbit h n ≤ 2 ^ L := by
  rcases hterm with hrun | hdyadic
  · rcases hrun with ⟨elapsed, q, hqL, hrun⟩
    exact ⟨elapsed, hrun.directFirstPassage.1.trans
      (Nat.pow_le_pow_right (by omega) hqL)⟩
  · rcases hdyadic with ⟨elapsed, q, hLq, _hqS, hrun, heq⟩
    let j := q - L
    have hjq : j ≤ q := Nat.sub_le _ _
    have horbit : orbit j (2 ^ q) = 2 ^ L := by
      rw [timeout_orbit_two_pow hjq]
      congr
      omega
    refine ⟨j + elapsed, ?_⟩
    rw [orbit_add, heq, horbit]




end

end FirstPassageLinearTransport
