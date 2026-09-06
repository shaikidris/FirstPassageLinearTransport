# Version 4 strengthened revision ledger

**Date:** 5 September 2026
**Status:** author-audit candidate; written proofs integrated; principal Lean closure locally checked
**Branch:** `revision/v4-ballot-strengthening`
**Base commit:** `38c23dc74c2f0ad3fa04f3e6550f5d7041c4e18f`
**Reviewed Version 3.2.4 manuscript SHA-256:**
`a86b3232b7ef09b2c564c6d0c23de65eb877fe9f110b89e56a6770e811c8c8af`

Inputs:

- external/internal review, SHA-256
  `9f7b1edb829687ffc1da8aedab42e8748ac85c22ce14730e583e644858d3a520`;
- strengthened written proof package, SHA-256
  `d5b4aa58b62ad2b91b69b9ce7961f6163870c9c7cdb60878eef8b7d943a5a59d`;
- independent Version 4 review, SHA-256
  `5d8884078f3b7c81a5f4ad9af07b1f5308c8b9a21737dadcef879e3133997bc3`;
- second exposition review, SHA-256
  `55884e24921a28179c37831ad8806bb61748d45a9a25d023778fdf6f3da597f2`.

This ledger distinguishes mathematical integration from machine verification.
`PROVED-PAPER` means that a finite written proof has been placed in the
manuscript and checked in this revision pass.  It does not mean that the new
argument has been accepted by a journal.  `PROVED-FORMAL` is used only for a
new declaration whose targeted strict build and axiom report have passed;
the full Version 4 public theorem chain remains incomplete.

## Review-response matrix

| Review item | Resolution in Version 4 | Status |
|---|---|---|
| Qualify the subpolynomial aggregate-cost inference | Section 9 now distinguishes a uniformly bounded aggregation cost from a merely subpolynomial one and retains the switch/terminal uniformity caveat. | closed |
| Exact integer split in the dyadic summation | Lemma 2.1 and every endpoint-rate assembly use `M < floor(J/2)`. | closed |
| Exact endpoint-halving language | Section 6 says to halve until the shell rank is below `L_M`. | closed |
| Credit the graded clock and avoid a newness claim | The introduction and Appendix A cite Inselmann's Theorems 1.1 and 1.3 and describe Appendix A as an independent derivation. | closed |
| Reproducible Allikvere and Mazur comparisons | Versioned, public references were added; both are described as publicly archived and unrefereed, without inferring submission status. | closed |
| Fixed-power power-saving exception count | Corollary 1.5 and Appendix A now give `O_alpha(X^(1-d_alpha))`, with shortcut/raw graded clocks and both path ceilings for `0 < alpha < 1`. | closed; Lean pending |
| Secondary endpoint rates | Corollary 1.2 records the exact secondary and tertiary endpoint exponents supplied by the stronger shell estimate. | superseded by ballot strengthening; Lean pending |
| More informative clock and height statements | Theorem 1.1 and Proposition 6.4 give centered shortcut/raw clocks and corresponding relative-height bounds. | closed; principal Lean interfaces checked locally |
| Normalize the target constant | The note following Theorem 1.1 records the alternative floor schedule giving `C_tar = 1`. | closed |
| Retain the full timeout event | Appendix B and Lemma 6.3 establish the fixed-barrier word language and the `m^(-3/2)` timeout bound. | integrated; Lean checked locally |
| Formalization/version identity | The disclosure, this ledger, `proof-state.md`, and `lean/FORMALIZATION.md` distinguish the frozen Lean 4.15 package, Palomar version 3, and the stronger Version 4 manuscript. | closed |
| Terminology for shortcut/raw/odd-count clocks | The terminology section distinguishes `k` or block duration `h`, raw time `ell`, and odd count `s_h`. | closed |
| Figure labeling | The architecture image is explicitly labeled Figure 1 in the source and render. | closed |
| Readability before notation | The abstract and “Main result at a glance” state the qualitative theorem before the full parameter package. | closed |

## Second-pass review triage

The Version 4 referee-style review, the second exposition review, and the
Qwen comments supplied on 5 September 2026 were checked against the Markdown
source and the rendered PDF.  Suggestions were not accepted merely because
they appeared in more than one review.

| Comment | Classification | Resolution |
|---|---|---|
| Abstract lacks a plain-language lead | current | Added a qualitative first sentence before the map and constants. |
| `kappa_*` is used before definition | current | Added `kappa_* = (2 A_FP)^(-1)` to the abstract constants display. |
| “including the endpoint exponent” can be misread as allowing `A = A_FP` | current | Replaced it by the literal statement that the rate exponent `kappa_* A - 1/2` is attained. |
| The pure critical target discussion should be less defensive | partly current | Rephrased the abstract positively around every prescribed divergent multiplier, while retaining the exact nonclaim.  The suggested phrase that the pure target “requires” such a multiplier was rejected because necessity is not proved. |
| Fixed-`A` glance joins the endpoint rate to an ambiguous height allowance | current | Defined `q = kappa_* A - 1/2` and stated the rate-compatible common ceiling `n (log n)^q`. |
| Arbitrary `n R(n)` is attributed to Theorem 1.1 | current | Corrected the attribution to Corollary 1.2(4). |
| Theorem 1.3 / Corollary 1.4 asymmetry is unexplained | current | Added a short route distinction: these are fixed-barrier companions, not consequences of the variable-terminal-rank ballot strengthening. |
| Section 8 excludes a bounded tertiary multiplier | current and contradictory | Removed the obsolete exclusion and stated the actual boundary: only the pure critical target remains unproved. |
| Lemma 4.2 says an interval has length strictly less than zero when `D = 0` | current | Changed “less than” to “at most”; the lemma statement and all consumers are unchanged. |
| The final-rank bound (6.19b) is too compressed | current presentation issue | Added the low-block, nonendpoint, and endpoint-halving cases immediately after the display. |
| Proposition 6.4 startup can be read as uniform over delayed schedules | current presentation issue | Distinguished fixed constants from the startup at which the eventual `L_M` bounds begin. |
| Section 7 repeats the new timeout-route raw-clock proof | current presentation issue | Reduced the section to the fixed-barrier stretched-log conversion and pointed to Proposition 6.4 for the centered polylogarithmic raw clock. |
| Section 9 says future improvement “must” use one mechanism | unsupported necessity claim | Replaced it by nonexclusive possible routes, including a better corridor or local estimate. |
| Lean and Palomar links can be read as verifying Version 4 | current scope risk | Labeled the first-page links as preceding-manuscript artifacts and narrowed the disclosure to selected Version 3.2.4 declarations. |
| Missing subscripts, stray exclamation marks, split words, and malformed (1.3)/(6.17) | extraction-only | Rejected after source and visual PDF checks.  The source has the correct subscripts and exponents; `\!` is intentional TeX spacing. |

## Strengthened result map

| Supplied result | Manuscript integration | Mathematical status | Formal status |
|---|---|---|---|
| N.1, centered finite survival | Lemma B.1 | `PROVED-PAPER` | `PROVED-FORMAL` in `FiniteBallot.lean` |
| N.2, uniform binomial atom | Lemma B.2 | `PROVED-PAPER` | `PROVED-FORMAL` in `FiniteBallot.lean` |
| N.3, tilted three-block fixed-barrier count | Lemma B.3 | `PROVED-PAPER` | `PROVED-FORMAL`; direct full-word quarter-split estimate checked |
| N.4, actual timeout density and rank sum | Lemma 6.3 and Proposition 6.4, especially the affine-prefix reduction and (6.12) | `PROVED-PAPER` | `PROVED-FORMAL`; literal containment, fixed-parameter `m^(-3/2)` endpoint-rate bound, first-bad pullback, and `L^(-1/2) exp(-kappa_* L)` sum checked |
| N.5, finite multiplicative maximum | Lemma B.4 | `PROVED-PAPER` | `PROVED-FORMAL`; `FiniteBallot.lean` proves the word inequality and `OrbitCeiling.lean` gives the exact `4/R` shell exception plus common shortcut/raw first-block bounds |
| N.6, strengthened shell theorem | Proposition 6.4 | `PROVED-PAPER` | `PROVED-FORMAL`; strengthened shell error, common landing, centered clocks, and both relative-height bounds checked |
| N.7, moving-exponent theorem | Theorem 1.1 and its proof | `PROVED-PAPER` | `PROVED-FORMAL`; the sharp moving-buffer consumer and natural-density assembly checked |
| N.8, explicit endpoint profiles | Corollary 1.2(1)--(3) and its proof | `PROVED-PAPER` | `PROVED-FORMAL-PARTIAL`; fixed-`A` exact rate checked, while literal secondary- and tertiary-log wrappers remain unexposed |
| N.9, arbitrary divergent target and height multipliers | Corollary 1.2(4) and its shell-minimum proof | `PROVED-PAPER` | `PROVED-FORMAL`; arbitrary prescribed positive divergent multipliers and their shell-minimum assembly checked |
| N.10, reciprocal fixed and moving relative-height obstructions | Propositions 8.1--8.2 and Lemma B.5 | `PROVED-PAPER` | `PROVED-FORMAL`; `FiniteBallot.lean` proves the reciprocal finite maximum, and `ReciprocalHeightObstruction.lean` proves the exact moving-shell obstruction and the fixed-ceiling lower-density theorem with constant `2/(3u)` |
| N.11, quantitative graded-power companion | Corollary 1.5 and Appendix A | `PROVED-PAPER` | `LEAN-PENDING` |
| N.12, uniform shortcut/raw trajectory and parity-count tubes | Proposition 6.5 and Theorem 1.1 | `PROVED-PAPER` | `PROVED-FORMAL` in `TimeoutTrajectoryProfile.lean` and its public consumer |
| N.13, simultaneous actual first-passage profile | Proposition 6.5 and Theorem 1.1 | `PROVED-PAPER` | `PROVED-FORMAL` in `TimeoutTrajectoryProfile.lean` and `CriticalEndpointConsequences.lean` |
| N.14, sharp balanced joint exceptional orders | Corollary 8.3 | `PROVED-PAPER`; height-forced only | `PROVED-FORMAL-PARTIAL`; `SharpJointExceptionalOrders.lean` handles source-dependent ceilings and converts the exact reciprocal bound on the last complete shell into a global prefix lower bound; `FixedJointExceptionalOrder.lean` proves the fixed-polylogarithmic height-forced lower bound of order `X (log X)^(-q)`; the secondary- and tertiary-log profile specializations, and the final upper/lower `Theta` packaging for the full joint event, remain pending |
| N.15, stretched-logarithmic common relative-height ceiling | Proposition 5.4 and Theorem 1.3 | `PROVED-PAPER` | `PROVED-FORMAL-PARTIAL`; `StretchedRelativeHeight.lean` proves a common shortcut/raw landing with ceiling `n exp(zeta (log n)^(1-delta))`, fixed clocks `6.953 log n` and `10.44 log n`, and a quantitative exceptional bound for every strict exponent `sigma < 1-delta`; the manuscript's endpoint exponent `1-delta` and arbitrary strict clocks remain pending |
| N.16, exact prefix-entropy endpoint with square-root prefactor | Proposition 3.3 | `PROVED-PAPER`; companion refinement | `LEAN-PENDING` |

## Third-pass strengthening intake

The additional review supplied on 5 September 2026 was checked against the
actual Version 4 definitions and proofs rather than accepted as a package.
The following statuses are intentionally more conservative than the review's
description of several claims as mere reorganizations.

| Proposed change | Independent assessment | Revision status | Lean consequence |
|---|---|---|---|
| Replace the schedule-dependent constant in Proposition 6.4 by one depending only on `c_-` and `C_sw` | Correct.  Since `S_M = C_sw log(M+2) + O(1)` and `L_M >= c_- log(M+2)`, any fixed `C > max(1, 2 C_sw / c_-)` works after a fixed startup. | `INTEGRATED-PRESENTATION` in Proposition 6.4 | no theorem-strength change |
| Uniform shortcut trajectory tube through the selected witness | Correct.  Prefix certification controls every time in a high block; telescoping the checkpoint errors costs `O(sqrt(M log M))`; the low part costs only `O((log M)^2)`. | `INTEGRATED-PAPER` in Proposition 6.5 and Theorem 1.1 | substantial new pathwise theorem |
| Uniform parity-count and raw trajectory tubes | Correct, but the proof must explicitly use the complete-chain product identity.  For the final direct first passage, `P = exp(-A_k)` and Proposition 6.4 gives `-log P = O(L_M 2^(-L_M))`; monotonicity then gives `0 <= A_j <= A_k` for every prefix. | `INTEGRATED-PAPER-WITH-EXPLICIT-DEPENDENCY` in Proposition 6.5 | new affine-prefix and raw-time adapters |
| Actual first-passage profile for every level between the landing and the source | Correct once the trajectory tubes are available.  A shortcut downward crossing is an even halving and lands in `(z/2,z]`; a raw odd image is upward and cannot create an earlier downward crossing.  The statement must retain `y <= z <= n` (or clip a prescribed target). | `INTEGRATED-PAPER-WITH-SCOPE-GUARD` in Proposition 6.5 and Theorem 1.1 | new quantified first-passage consumer |
| Reciprocal lower bound for the finite multiplicative maximum | Correct.  The stopped-tree mean, overshoot `F_sigma <= 3u/2`, exact `1/2 -> 3/4` word-weight change, and a Chebyshev lower-tail bound yield the stated finite inequality when `log u = o(h)`. | `INTEGRATED-PAPER` as Lemma B.5 | new finite-word theorem extending B.4 |
| Fixed and moving relative-ceiling obstructions | Correct with uniform shell hypotheses for moving targets and ceilings.  The lower bound concerns failure of the joint target-and-height conclusion, and therefore also the fuller target-clock-height conclusion. | `INTEGRATED-PAPER` as Propositions 8.1--8.2 | new shell parity and density assembly |
| `Theta` exceptional orders for Corollary 1.2's balanced profiles | Correct only when `E` is defined as failure of the complete simultaneous conclusion with its stated height ceiling.  It is not a lower bound for target-only failure and proves no optimality of `A_FP`. | `INTEGRATED-PAPER-WITH-SCOPE-GUARD` as Corollary 8.3 | new global lower-bound consumers |
| Stretched-logarithmic ceiling `n exp(zeta (log n)^(1-delta))` with the existing stretched-exponential error form | Correct.  Apply the multiplicative maximum only to the first fixed-barrier block, impose `r(1+eta)<1`, and take `R_M = exp(zeta (M log 2)^(1-delta))`; later certified blocks lie below `n`.  The new rate constant may depend on `zeta`. | `INTEGRATED-PAPER` in Proposition 5.4 and Theorem 1.3 | `PROVED-FORMAL-PARTIAL` in `StretchedRelativeHeight.lean`: density one and every strict exceptional exponent `sigma < 1-delta` are formal with fixed clocks; the endpoint exponent and arbitrary strict clocks remain open in Lean |
| Exact prefix-entropy rate with an `M^(-1/2)` prefactor | Correct by replacing proportional slack by the constant-slack barrier `h_M = (eta M - 1)/log_2 3` and applying (3.3a) on a compact slope interval.  This sharpens only the fixed-barrier companion. | `INTEGRATED-PAPER` in Proposition 3.3; remains non-principal | optional refinement of the existing prefix module |
| Conditional effective-time-factor thresholds in Section 9 | Correct budget algebra, but not a proved transport improvement. | `INTEGRATED-DISCUSSION-ONLY` with both endpoint objectives kept conditional | none |

The attribution suggestion concerning exact theorem numbers in Inselmann must
be checked against the cited primary version before editing the bibliography or
comparison text.  It is not treated as verified by this intake.

### Formalization order after this intake

The new proposals do not displace the existing load-bearing order:

1. finish Lemma B.3 in the common finite-word language;
2. formalize actual timeout containment and the strengthened shell theorem;
3. close the three frozen Version 4 public roots and their audits;
4. add the trajectory-tube/actual-first-passage interface;
5. add the reciprocal maximum lower bound and joint-rate sharpness consumers;
6. strengthen the formal stretched-logarithmic relative-height consumer from strict exceptional exponents and fixed clocks to the manuscript's endpoint exceptional exponent and arbitrary strict clocks;
7. consider the prefix-entropy endpoint only as optional cleanup.

Changing the Comparator selection to advertise any of items 4--6 requires a
separate release-contract revision and author review; this ledger does not make
that publication decision implicitly.

## Dependency reconstruction

The new principal chain is:

```text
finite survival + binomial atom
  -> fixed-barrier fair-word count
  -> actual timeout density m^(-3/2) 2^(-kappa_* m)
  -> first-timeout transport with O(sqrt(M log M)) time support
  -> strengthened shell profile
  -> moving endpoint and explicit endpoint-rate consumers
  -> common shortcut/raw landing, centered clocks, and relative heights.
```

The unchanged dependencies are the exact parity-word bijection, affine iterate,
large-rank all-prefix certification, first-passage band, bounded reverse loss,
decreasing-threshold direct passage, and compressed cumulative-time corridor.
The only new analytic input is the finite survival/ballot layer; no independence
between successive descent blocks is assumed.

## Nonclaims and release gates

- The pure target `C (log n)^A_FP` remains unproved.
- The leading exponent `A_FP` is a threshold of this method, not an intrinsic
  Collatz constant or an optimality claim.
- No pointwise convergence, exclusion of exceptional cycles, or exclusion of
  divergent trajectories is claimed.
- Finite diagnostics are checks of formulas and interfaces, not premises of a
  theorem.
- The Version 4 PDF must remain a revision candidate until the manuscript
  audit and visual render pass are recorded.
- It must not be described as Lean- or Palomar-verified until the new interfaces
  in `lean/FORMALIZATION.md` are implemented, built, dependency-audited,
  axiom-audited, and replayed.
- Because the paper is already under review, any Version 4 journal upload must
  be made as a revision through the existing submission record or after editor
  instruction; it must not be submitted concurrently as a new manuscript.
- A final numbered release requires a fresh version--DOI identity check and
  synchronized Markdown, neutral PDF, journal PDF, public repository, Zenodo,
  SSRN, website, and Palomar metadata.

## Reproducible gates

From the repository root:

```bash
python3 -B audits/audit_paper_lean_semantics.py
python3 -B audits/audit_v4_ballot_strengthening.py
bash paper/render_first_passage_v4_manuscript.sh
```

From `lean/`, a clean `lake build` is a regression gate for the frozen Version
3 theorem surface only.  The new Version 4 formalization gate remains open.

## Execution record

On 5 September 2026:

- `audit_paper_lean_semantics.py`: `PASS` (67 literal contracts, 34 frozen
  critical declarations, 140 equation labels, 138 equation references, 51
  anchors, 96 anchor references, no orphan anchor);
- `audit_v4_ballot_strengthening.py`: `PASS` (change-of-measure identities,
  ballot counts through length 1,600, 121,474 actual timeout cases, and 60
  finite maximal-inequality checks);
- Version 4 PDF render: `PASS`, 37 A4 pages, tagged and unencrypted; visual
  inspection covered the opening theorem package, fixed-barrier height
  result, trajectory-profile result, reciprocal obstruction, method-ceiling
  discussion, and both ballot pages.  It found no clipping, overlap, or table
  overflow, and text extraction found no unresolved placeholder or replacement
  glyph;
- frozen Lean 4.15 regression rebuild: `INCOMPLETE -- ENVIRONMENT`, not a
  proof failure.  A fresh dependency/cache reconstruction exhausted the local
  disk before Mathlib completed.  The generated 4.5 GB isolated-worktree
  `.lake` directory was removed.  The prior frozen build and Palomar records
  remain the applicable evidence for Version 3;
- targeted Version 4 analytical closure: `PASS`.  Strict direct compilation
  and Lake artifact builds pass for `FiniteBallot.lean` and
  `TimeoutDensity.lean`, and `TimeoutProfile.lean`.  The checked chain now includes the exact
  three-block/full-word equivalence, the quarter-split `m^(-3/2)` ballot mass,
  actual affine-timeout containment, exact dyadic-shell parity transport, and
  `exists_timeoutShellBad_ballot_fixed_constant`, followed by the literal
  first-bad pullback and terminal `L^(-1/2) exp(-kappa_* L)` summation.  The
  initial-height adapter additionally proves the exact `4/R` shell exception
  and both shortcut/raw prefix bounds.  Axiom reports for all load-bearing new
  roots contain exactly `propext`, `Classical.choice`, and `Quot.sound`.  The
  strengthened shell/profile and public Version 4 consumers remain
  `LEAN-PENDING`.

Current candidate hashes:

```text
a70b7f99eb34eeab53ab2d34c5cdff94c58dcde144364064e7a3541d1c915104  paper/collatz_first_passage_natural_density.md
d9af8ec6ce2a169694094619222c58863b989c19ee528c310334253778478f0e  paper/collatz_first_passage_natural_density_v4.0.0-rc1.pdf
```
