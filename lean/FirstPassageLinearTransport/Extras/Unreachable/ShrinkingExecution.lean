/-
Copyright (c) 2026 Idris Ali Shaik. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Idris Ali Shaik
-/
/- Generated source-preserving extraction: declarations in this module are outside the canonical referee-facing roots. -/
import FirstPassageLinearTransport.ShrinkingPolylogProfile
import FirstPassageLinearTransport.FirstPassageLandingShell

import FirstPassageLinearTransport.ShrinkingExecution
/-!
# Termination of shrinking-barrier re-certification

The next block is invoked only after its endpoint passes the rank-dependent
certification test.  Hence the recursion never treats a bad landing as a
certified source.
-/

namespace FirstPassageLinearTransport

noncomputable section


theorem HasShrinkingTerminalLanding.orbit_lt
    {P : ShrinkingBarrierRunData} {M S n L : ℕ}
    (hterm : HasShrinkingTerminalLanding P M S n L) :
    ∃ elapsed : ℕ, orbit elapsed n < 2 ^ L := by
  rcases hterm with ⟨elapsed, q, hqL, hrun⟩
  exact ⟨elapsed, hrun.directFirstPassage.1.trans_lt
    (Nat.pow_lt_pow_right (by omega) hqL)⟩





end

end FirstPassageLinearTransport
