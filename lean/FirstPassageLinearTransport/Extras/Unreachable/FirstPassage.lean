/-
Copyright (c) 2026 Idris Ali Shaik. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Idris Ali Shaik
-/
/- Generated source-preserving extraction: declarations in this module are outside the canonical referee-facing roots. -/
import FirstPassageLinearTransport.Parity

import FirstPassageLinearTransport.FirstPassage
/-!
# First-passage reversal

This module begins the independent formalization of Section 4.  It first
records the exact stopped-path algebra; estimates and fiber counting are added
only after these identities compile.
-/

namespace FirstPassageLinearTransport


theorem firstPassage_landing_le {Y n h : ℕ} (hfp : IsFirstPassage Y n h) :
    orbit h n ≤ Y := hfp.1

theorem firstPassage_before_gt {Y n h j : ℕ} (hfp : IsFirstPassage Y n h)
    (hj : j < h) : Y < orbit j n := hfp.2 j hj






























end FirstPassageLinearTransport
