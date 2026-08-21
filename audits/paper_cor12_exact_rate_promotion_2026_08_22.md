# Exact Corollary 1.2(1) Lean promotion audit

**Review date:** 2026-08-22
**Mode:** `FORMAL-BOUNDARY + RELEASE-GATE`
**Reviewer context:** `AUTHOR-AUDIT` (internal; not independent verification)
**Verdict:** `EXACT PAPER STATEMENT PROVED / PALOMAR PACKAGE MECHANICALLY VERIFIED`

## 1. Promoted statement

For the shortcut Collatz map, fix

\[
A>A_{\rm FP},\qquad c>\frac{2}{\log(4/3)},\qquad \beta>0,
\]

and every

\[
0<\gamma<\kappa_*(A-A_{\rm FP}).
\]

The promoted declaration gives separate constants \(C_{\rm tar}>0\) and
\(C_{\rm exc}>0\).  Almost every positive integer \(n\) has a witness
\(k<c\log n\) with

\[
T^k(n)\le C_{\rm tar}(\log n)^A,
\qquad
\max_{0\le j\le k}T^j(n)\le n^{1+\beta},
\]

and, eventually in \(X\), the bad count is at most

\[
C_{\rm exc}X(\log X)^{-\gamma}.
\]

This is the literal fixed-exponent quantitative statement in Corollary
1.2(1).  It strictly strengthens the earlier public wrapper, which exposed
only one shared constant and an existential positive exceptional exponent.

## 2. Formal declaration and source boundary

The exact theorem is

```text
FirstPassageLinearTransport.paper_cor12_item1_fixed_polylog
```

in `lean/FirstPassageLinearTransport/PaperCor12Item1.lean`.  The module is an
isolated paper/submission wrapper over already proved producers and is not
imported by canonical `Main.lean`.  No claim is made here for the moving
endpoint, the critical log-log specializations, or the stretched-logarithmic
companion.

The manuscript already stated the stronger result, so this promotion required
no theorem or quantifier change to the paper.  It closes a public Lean
interface gap and updates the formalization map, audit roots, README surfaces,
and proof-state ledger.

## 3. Initial-draft repairs

The first isolated wrapper did not compile.  The repaired draft corrected:

- direction and factor ordering in two positive-denominator inequalities;
- one missing algebraic normalization after `field_simp`;
- the current name of the logarithm-versus-power little-o theorem;
- explicit types for constant functions in two `Tendsto` compositions;
- the domain of the helper for `log^gamma / X^rho`;
- the required threshold `rho < 1/2`, rather than `rho < 1`;
- multiplication/division association in the final exceptional-count bound;
- unfolding of `fixedPolylogTargetConstant` at the witness target.

These were Lean proof-term/interface repairs.  The promoted mathematical
statement was not weakened.

The final fidelity review also replaced the wrapper's initially advertised
strict landing by the manuscript's literal non-strict inequality
`T^k(n) ≤ Ctar (log n)^A`.  The underlying producer proves the stronger strict
inequality, and the wrapper weakens it only at the exported paper interface.

## 4. Lean 4.15 verification

Commands:

```text
lake build FirstPassageLinearTransportPaperCor12
lake build FirstPassageLinearTransport.PaperAudit
```

Both completed successfully under Lean 4.15.0 with the repository's pinned
Mathlib revision.  The full paper audit reports

```text
FirstPassageLinearTransport.paper_cor12_item1_fixed_polylog
  [propext, Classical.choice, Quot.sound]
```

and no project-specific axioms.

## 5. Palomar port

The clean Palomar package copies the 58-module proof cone and adds the exact
wrapper as its 59th project module.  `Challenge.lean` states the exact theorem
with one deliberate `sorry`; `Solution.lean` has the identical theorem type
and reduces it to the promoted declaration.  `comparator.json` checks that
single theorem.

The Lean 4.28 port required two proof-term-only adjustments:

- removal of an algebraic tactic call that became redundant;
- replacement of a right-addition monotonicity application by an explicit
  two-sided `add_le_add` call.

Local Palomar gates passed:

```text
lake build FirstPassageLinearTransport.PaperCor12Item1
lake build Challenge Solution Audit FirstPassageLinearTransport
./scripts/check-submission.sh
ruby -Itest test/validate_formalization_test.rb
bash test/landrun_wrapper_test.sh
```

The Palomar audit reports exactly `propext`, `Classical.choice`, and
`Quot.sound`.  The metadata validator passed 16 runs and 83 assertions.

## 6. Linux Comparator and NanoDa replay

The package was copied without build artifacts into a disposable Ubuntu
`aarch64` VM and checked with the repository's pinned verifier revisions:

```text
./scripts/verify-comparator.sh
```

The replay rebuilt `Challenge.lean` and the 59-module solution cone, exported
the advertised declaration from both files, and ended with:

```text
Running nanoda kernel on solution
Nanoda kernel accepts the solution
Running Lean default kernel on solution.
Lean default kernel accepts the solution
Your solution is okay!
```

The preserved host log is
`/private/tmp/palomar-cor12-comparator-nanoda-final.log`, with SHA-256
`2b985a66017492e62c6961d75d1b501ffc0f1e13e65157074159afecd3b0ee79`.
This final replay used the manuscript-exact non-strict landing statement.  It
completes the mechanical release gate; it does not constitute Palomar review,
journal peer review, or a novelty judgment.  No commit, push, release, or
Palomar registration is authorized by this audit.
