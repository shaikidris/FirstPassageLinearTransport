# Palomar Version 4 release-cone contract

**Date:** 5 September 2026
**Status:** local selected surface complete; public extraction and independent
Palomar replay pending
**Repository mode:** `RESEARCH-FIRST`

This contract governs the Lean closure of the strengthened Version 4 paper.
The research proof is developed and checked in this isolated worktree first.
Only the final checked transitive cone of the selected declarations will be
ported to `FirstPassageLinearTransport-Palomar`.  The public Palomar repository
must not be used for proof search.

## 1. Authoritative artifacts

| Role | Artifact |
|---|---|
| Version 4 manuscript source | `../paper/collatz_first_passage_natural_density.md` |
| Version 4 result/proof source | `/Users/shaik.i/Downloads/collatz_strengthened_results_and_proofs_2026-09-05.md` |
| Version 4 theorem ledger | `../audits/v4_strengthened_revision_ledger_2026_09_05.md` |
| Research repository/worktree | `publishable-v4`, branch `revision/v4-ballot-strengthening`, base commit `38c23dc74c2f0ad3fa04f3e6550f5d7041c4e18f` |
| Existing Palomar repository | `shaikidris/FirstPassageLinearTransport-Palomar`; inspected commit `88a9646e818feff240f52a4d14d8e2656665a532` |
| Existing verified surface | Version 3 Palomar record; four declarations; not evidence for Version 4 |

The substantive proof remains in this project.  The later Palomar tree will be
an extracted substantive proof cone, not a thin wrapper.  Reused Version 3
lemmas remain project-local checked dependencies; Mathlib is the only trusted
Challenge dependency.

## 2. Intended Challenge surface

The mathematical surface is fixed to the following four existing declarations.
Their exact types are the source of truth; Challenge and Solution will copy
those types literally.  This selection favors four reader-facing consequences
over the larger moving shell engine.  See `V4_API_AUDIT.md` for the
target-sanity and interface audit.

| Intended Challenge name | Exact mathematical content | Paper source | Status |
|---|---|---|---|
| `CollatzFirstPassage.critical_polylogarithmic_descent_with_arbitrary_multipliers` | For arbitrary positive, not necessarily monotone, functions `U,R : N -> R` tending to infinity, a natural-density-one set has shortcut and raw witnesses at one common landing below `(log n)^A_FP * U(n)`.  Both centered clock estimates, all three trajectory/parity tubes, both path ceilings `nR(n)`, and the actual shortcut/raw first-passage comparison to every intermediate level are exposed. | Corollary 1.2(4), Proposition 6.5 and Corollary 6.6 | `LOCAL-COMPLETE` |
| `CollatzFirstPassage.fixed_polylogarithmic_common_landing_centered_clocks_exact_rate` | For every fixed `A > A_FP`, the global exceptional count has the endpoint exponent `q = kappaStar * A - 1/2`; the same shortcut and raw witnesses reach one landing, satisfy centered clocks, and retain the balanced height allowance.  The Lean target is `C * (log n)^A`; the paper's normalization of the landing constant to one is a separate written terminal-rank adjustment. | Corollary 1.2(1) | `LOCAL-COMPLETE` |
| `CollatzFirstPassage.eventually_fixedJointPolylogHeightFailureCount_ge_log_order` | For fixed positive target constant, nonnegative target exponent, and positive height exponent, target-and-height failure is eventually bounded below by an explicit constant times `X * (log X)^(-q)`.  This is a height-forced joint lower bound, not a target-only lower bound. | Corollary 1.2 sharpness qualification and Proposition 8.1 | `LOCAL-COMPLETE` |
| `CollatzFirstPassage.stretchedLogCommonLandingWithRelativeHeightQuantitative` | For `0 < delta < 1`, every strict `0 < sigma < 1-delta`, and `zeta > 0`, the strict-subendpoint stretched exceptional count, one common shortcut/raw landing, fixed `6.953 log n` and `10.44 log n` clocks, and both `n exp(zeta (log n)^(1-delta))` ceilings are exposed. | Theorem 1.3 and Corollary 1.4, selected strict-clock projection | `LOCAL-COMPLETE` |

The Challenge statement must expose the exact definitions used by these four
types, including the shortcut and raw iterates, natural-density and counting
predicates, entropy constants, common landing, clock errors, first-passage
times, and path maxima.  No opaque helper definition may make a material claim
vacuous.

### Explicitly unselected results

- Lemmas B.1--B.4 and Lemma 6.3 are proof obligations, not advertised results.
- Proposition 6.4 is the load-bearing shell engine.  It remains a public
  checked Solution dependency unless the first selected theorem exposes its
  entire useful statement without hiding material hypotheses.
- The technical moving shell theorem is a checked Solution dependency, not a
  selected declaration; the critical selected theorem already exposes its
  strongest reader-facing consequences.
- Corollary 1.5, the graded-power companion, is outside this principal cone.
  It may receive a separately reviewed Comparator configuration after the
  four selected declarations close.
- The Version 3 stretched declarations remain immutable.  The selected Version
  4 stretched theorem is genuinely stronger in its common relative-height
  allowance; its clock and rate restrictions are stated explicitly.
- The pure target `C * (log n)^A_FP`, pointwise Collatz convergence, exclusion
  of exceptional cycles or divergent trajectories, and control after the
  selected witness are not claimed.

## 3. Reverse dependency graph

```text
finite centered survival + uniform binomial atom
  -> tilted three-block fixed-barrier word estimate
  -> actual affine timeout containment and m^(-3/2) timeout density
  -> first-timeout transport over O(sqrt(M log M)) cumulative times
  -> strengthened shell theorem
       -> fixed-A endpoint-rate declaration
       -> arbitrary-U/R critical declaration with trajectory tubes and
          actual first-passage times

finite multiplicative maximum
  -> both-path relative-height part of the strengthened shell theorem
  -> reciprocal fixed-ceiling obstruction
  -> logarithmic-order lower bound for the fixed joint failure set

fixed-barrier chain + finite multiplicative maximum
  -> strict-subendpoint stretched rate with smaller common height allowance

existing exact reverse product + raw/shortcut correspondence
  -> common landing and centered raw clock
```

## 4. Owner-module and obligation map

| ID | Obligation removed | Proposed owner | Selected-root consumer | Exit test | New module? |
|---|---|---|---|---|---|
| S1 | Freeze the four exact Lean types and their transparent statement definitions | this contract and referee-facing roots | all four | Types reviewed against the paper, including constant-multiplier and strict-clock fidelity boundaries | no |
| B1 | Centered finite survival moment and uniform binomial atom | `FiniteBallot.lean` | critical and fixed upper-rate roots | Exact finite statements compile without project axioms | yes: one coherent new analytic interface; existing `SharpEntropyBarrier.lean` is already large and serves terminal entropy tails |
| B2 | Exact product-weight change and three-block fixed-barrier count | `FiniteBallot.lean` | critical and fixed upper-rate roots | Produces the literal `m^(-3/2) * 2^(-kappa*m)` word bound consumed by timeout density | no |
| T1 | Actual affine timeout is contained in the fixed-barrier word language | `TimeoutDensity.lean` | critical and fixed upper-rate roots | Literal timeout set obtains the strengthened normalized density bound | no |
| T2 | Pull back and sum the rankwise ballot timeout density | `TimeoutProfile.lean` | critical and fixed upper-rate roots | Produces the exact terminal factor `L^(-1/2) exp(-kappa_* L)` after reverse loss | no |
| H1 | Finite multiplicative maximum and initial height exception | `OrbitCeiling.lean` | all four through the upper, lower, or stretched height argument | Produces the `R_M^(-1)` exception and both shortcut/raw first-block bounds | no |
| S2 | Strengthened shell estimate and common physical landing | `TimeoutEndpointProfile.lean` | critical and fixed upper-rate roots | Shell bound has the new margin and all witness fields | no |
| C1 | Centered shortcut clock, exact raw time, and centered raw clock | `RawClockBudget.lean` plus the shell assembly owner | critical and fixed upper-rate roots | Same landing and `O(sqrt(log n log log n))` errors for both clocks | no |
| A1 | Natural-density assembly of the strengthened shell result | `TimeoutEndpointNaturalDensity.lean` | critical and fixed upper-rate roots | Moving engine and consequence roots close | no |
| A2 | Exact fixed-`A` endpoint summation | new `CriticalEndpointConsequences.lean` | fixed-`A` root | Endpoint exponent `q`, not every smaller exponent, compiles and matches the paper | yes: distinct public consumer layer |
| A3 | Shell-minimum construction for arbitrary nonmonotone `U,R` | `CriticalEndpointConsequences.lean` | critical root | Natural-density-one root closes with literal pointwise `U(n),R(n)` comparisons | no |
| R1 | Public axiom and dependency audit for the four roots | existing audit owners, extended | all four | `#print axioms`, theorem map, and transitive-use report pass | no |

No alternate low-phase route, legacy two-regime code, all-prefix alternative,
diagnostic-only module, or graded-power development may enter this cone.

## 5. Task list and burn-down

| Order | Selected-root obligation | Before | Required evidence | Status |
|---:|---|---|---|---|
| 1 | S1: mathematical public surface | open | literal paper/Lean quantifier and constant comparison | `COMPLETE`; exact Lean types deliberately deferred to the shell-witness boundary |
| 2 | B1: finite survival and atom | open | targeted Lake build and axiom report | `COMPLETE`; explicit and `O((h+1)/sqrt n)` survival forms plus the uniform atom bound check with only the three standard axioms |
| 3 | B2: fixed-barrier ballot | open | targeted Lake build, exact normalization audit | `COMPLETE`; the direct full-word quarter-split estimate is checked and the coordinate equivalence proves that no word is lost or duplicated |
| 4 | T1: actual timeout density | open | set-containment proof and strengthened finite bound | `COMPLETE`; literal affine timeouts satisfy one uniform low-window barrier and `exists_timeoutShellBad_ballot_fixed_constant` gives the normalized `m^(-3/2)` endpoint-rate bound |
| 5 | T2: rankwise timeout transport and sum | open | exact terminal prefactor and axiom report | `COMPLETE`; `exists_timeout_low_firstBad_ballot_sum_canonical_le` consumes the literal shell bound and leaves `L^(-1/2) exp(-kappa_* L)` with only the three standard axioms |
| 6 | H1: initial multiplicative maximum | open | targeted build and raw/shortcut height consumer | `COMPLETE`; exact shell parity transfer gives `4/R`, shortcut prefixes stay below `nR/2`, and every corresponding raw prefix stays below `nR` |
| 7 | S2+C1: strengthened shell theorem and clocks | open | shell theorem build; common-witness field audit | `COMPLETE` |
| 8 | A2: fixed-`A` endpoint rate | open | exact endpoint global-count theorem builds | `COMPLETE` |
| 9 | A3: arbitrary `U,R`, tubes and first passages | open | nonmonotone shell-minimum theorem and literal consequence fields build | `COMPLETE` |
| 10 | Height lower bound and stretched-height consumer | post-core | selected roots build and match the guarded written claims | `COMPLETE` |
| 11 | R1: full research validation | open | full Lake build, scans, axiom and dependency reports | `COMPLETE-LOCAL`; 5940/5940 build and only the three standard axioms |
| 12 | Minimal Palomar extraction | open | exact transitive closure; zero unreachable modules; synchronized surface | `PENDING` |
| 13 | Comparator/NanoDa and author review | open | exact Lean 4.33 exporter-compatible replay | `PENDING` |

### Post-core candidate extensions

An independently audited third review proposed three additional theorem
families: a uniform trajectory tube with actual first-passage clocks, a
reciprocal relative-ceiling obstruction with sharp joint exceptional orders,
and a smaller relative-height ceiling for the stretched-logarithmic companion.
Their written arguments are accepted for the revision queue, subject to the
scope guards in `../audits/v4_strengthened_revision_ledger_2026_09_05.md`.

The trajectory/first-passage and reciprocal-height families are now locally
formalized and included in the selected surface above.  The stretched-height
family is represented by its strongest currently exposed strict-clock,
strict-rate quantitative declaration.  This does not silently promote the
paper's arbitrary-clock endpoint form.

## 6. Provisional size and cone budgets

These are pause-and-review ceilings, not targets.

| Metric | Baseline | Approved ceiling |
|---|---:|---:|
| Selected declarations in the Version 4 Comparator | 4 in Version 3 | 4 Version 4 declarations |
| Challenge lines | 206 in Version 3 | below Palomar's 300-line review warning if possible; 1000 hard maximum |
| New Version 4 production modules in the research tree | 0 | 9 added and individually justified by the audit ledger |
| Exact selected transitive closure | not applicable | 85 modules; 31,771 Lean lines in the current source tree |
| Unreachable modules in the extracted release cone | to be recomputed | 0 |

Crossing a ceiling, changing a selected signature, or requiring an unplanned
analytic theorem stops the release track and requires an explicit contract
revision.  It must not be repaired by silently copying more of the research
tree.

## 7. Per-stage gates

Every completed batch must record:

1. selected-root obligations before and after;
2. owner modules changed and any new module justification;
3. targeted Lake build output;
4. placeholder, `sorry`, `admit`, and project-axiom scan;
5. `#print axioms` for each newly closed public root;
6. total and selected-cone module/line counts;
7. paper/Lean comparison of maps, quantifiers, constants, clocks, ceilings,
   exception rates, endpoints, and nonclaims; and
8. exact uncommitted or committed recovery boundary.

## 8. Publication stop

Completing the written proof or a partial Lean module does not authorize a
commit, push, paper revision upload, Zenodo or SSRN update, website change,
Palomar submission, or Palomar registration.  After the four selected roots
and all readiness gates pass, present the exact diff and evidence to the author
for separate authorization of each publication action.
