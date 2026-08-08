# Shrinking-time-support paper/Lean synchronization audit

**Date:** 2026-08-08
**Scope:** synchronization and formal closure of the strengthened existing
Theorem 1.1; no new corollary and no arbitrary-diverging or bounded-descent
claim.

## Verdict

`PASS / FORMAL-SYNC`.

The manuscript and public Lean API now state the same strict endpoint

\[
A>\frac1{2(1-H_2(\log_3 2))}=9.9911133419\ldots.
\]

The older fixed-tolerance endpoint
`1 / (1 - H₂(log₃ 2))` remains compiled as comparison mathematics but is no
longer the public headline.

This record is not an independent mathematical referee report. A separate
adversarial paper audit remains appropriate before release.

## Load-bearing formal chain

1. `TimeSupportTransport.lean` proves loss-filtered arbitrary-target transport
   over an explicit finite set of actual first-passage times.
2. `ShrinkingBarrierCore.lean` proves the lower-tolerance adapter, exclusion
   of the power-of-two boundary from certification, and the exact one-block
   duration corridor.
3. `ShrinkingBarrierRun.lean` defines the literal rank-dependent high-barrier
   recursion and preserves direct first passage, reverse-loss, and clock
   semantics.
4. `ShrinkingTimeSupport.lean` and `ShrinkingSchedules.lean` prove that every
   cumulative first-bad time belongs to a common support of cardinality
   `O(sqrt (M log M))`.
5. `ShrinkingFirstBad.lean`, `ShrinkingProfile.lean`, and
   `ShrinkingHighDensity.lean` connect that support to the exact first-bad
   target counts without treating a bad endpoint as certified.
6. `ShrinkingTailAsymptotics.lean` and `ShrinkingPolylogProfile.lean` prove the
   half-power terminal loss and the quantitative shell profile.
7. `ShrinkingParameters.lean` selects a complete strict parameter package for
   every exponent above the displayed endpoint.
8. `ShrinkingExecution.lean`, `ShrinkingOrbitCeiling.lean`, and
   `ShrinkingNaturalDensityDescent.lean` prove literal termination below the
   polylogarithmic target, the same-witness orbit ceiling, the prefix count,
   and natural density one.
9. `Main.lean` exposes the literal Collatz theorem and absorbs finite startup
   into the witness set itself.

## Anti-circularity checks

- No generated-distribution, checkpoint-congestion, LC.28, or equidistribution
  hypothesis enters the headline dependency graph.
- A failed endpoint is used only as the terminal bad landing; it is never fed
  back into the certified recursion.
- The time-support transport theorem charges exactly the declared finite time
  set. It does not replace that set by an assumed interval distribution.
- The half-power saving is proved from the duration corridor and geometric
  rank decrease, not inferred from finite diagnostics.
- The public theorem's `badCount` counts integers lacking its displayed
  clock/landing/orbit-ceiling witness; no auxiliary good-set discrepancy is
  hidden in the statement.

## Verification

The following targets passed:

```text
lake build FirstPassageLinearTransport.Main
lake build FirstPassageLinearTransport.PaperAudit
lake build FirstPassageLinearTransport.V3CutVertexAudit
lake build FirstPassageLinearTransport.PaperDependencyAudit
```

The dependency report reaches the support-sensitive transport,
square-root feasible-time support, shrinking first-bad profile, strict
parameter package, same-witness orbit ceiling, and quantitative assembly.
`#print axioms` reports only the standard Lean/Mathlib foundations
`propext`, `Classical.choice`, and `Quot.sound`; there is no project axiom.
The production Lean source scan found no `sorry`, `admit`, declared `axiom`,
or `unsafe` proof.

The V3 manuscript rendered to a 19-page A4 PDF. All pages were rendered to
images and inspected; the strengthened theorem, new Section 6, theorem box,
section transitions, and references are legible with no clipping or overlap.
PDF text extraction confirms the new endpoint and contains no MathJax
`Math input error` marker.

## Status boundary

The strengthened fixed-polylogarithmic theorem is synchronized and formally
closed. The endpoint is strict and is not attained. The stretched-logarithmic,
fixed-power, raw-clock, and graded-clock results remain companion statements.
Arbitrary-diverging descent, bounded descent, and the paused checkpoint route
remain outside this theorem and this audit.
