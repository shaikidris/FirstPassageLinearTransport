# Paper/Lean semantic concordance

**Date:** 2026-08-13
**Mode:** MATH-TEXT + FORMAL + CONSISTENCY
**Classification:** MAINTENANCE/CLOSURE
**Scope:** referee-facing V3.2 theorem contracts, the canonical timeout proof
root, the retained all-prefix alternate, and the exact formalization boundary.

## Purpose and limit

A successful Lean build checks the encoded propositions, not the manuscript's
transcription of them.  This concordance compares quantifiers, constants,
strict endpoints, clocks, targets, exceptional predicates, density notions,
and proof-route dependencies.  The automated gate
`audits/audit_paper_lean_semantics.py` protects selected literal interfaces;
it is a regression guard rather than a proof of semantic equivalence.

## Canonical route separation

The canonical public theorem is

```text
QuantitativeCollatzMain.
  collatz_first_passage_moving_polylogarithmic_natural_density_descent
```

and its compiled proof term consumes
`timeoutEndpointLiteralNaturalDensityDescent`.  It does not consume
`movingEndpointLiteralNaturalDensityDescent`.  The retained V3.1 proof is
exposed only by the optional alternate library under the explicit name

```text
FirstPassageLinearTransport.Alternates.AllPrefix.
  collatz_first_passage_all_prefix_moving_polylogarithmic_natural_density_descent
```

and has the reverse dependency.  It is not imported by canonical `Main.lean`
and is not part of the default `lake build` target.  The compatibility name
`collatz_first_passage_timeout_moving_polylogarithmic_natural_density_descent`
calls the canonical theorem and has the same proposition.  Both a source-level
semantic check and a kernel dependency guard enforce the canonical exclusion;
the alternate has its own direct build and axiom audit.

The timeout route shares endpoint parameters, scalar asymptotics, dyadic
density assembly, orbit-ceiling infrastructure, and some common moving support
lemmas with the alternate.  Route separation means specifically that the
canonical proof excludes the old all-prefix low producer, profile, and literal
assembly; it does not mean that every module whose filename starts with
`Moving` is absent.

## Fragile literal concordance

| Contract | Manuscript | Lean | Result |
|---|---|---|---|
| Natural density one | missing proportion in `[1,X]` tends to zero | `badCount S X / X -> 0` | EXACT |
| One-block duration corridor | `|gh-(m-q)| <= tm+t+2` | `certified_firstPassage_duration_error` | EXACT |
| Accumulated corridor | `sum_i (t_i m_i+t_i+3)` | `durationError t m = t*m+t+3` | EXACT |
| Literal timeout | no crossing through parent-rank time `m` | `LowStageTimeout` | EXACT |
| Timeout target | actual parent shell, endpoint excluded | `timeoutLandingBad`; terminal odd-count containment | EXACT |
| Combined time support | `O(sqrt(M log M))` | `eventually_timeoutFeasibleTimes_card_lt_sqrt` | EXACT SCALE |
| Moving rank buffer | `kappa_* L_M - 1/2 log_2(M+2) - log_2 log(M+3)` | `movingRankBuffer` | EXACT |
| Shell error | `C_exc(2^-Delta_M + M^-epsilon)` | one `C` multiplying the same two terms | LEAN STRONGER BY COMMON CONSTANT |
| Landing inequality | paper uses `<=` | public Lean uses `<` | LEAN STRONGER |
| Same witness | landing, clock, and ceiling use one index | one existential `k` scopes all three conjuncts | EXACT |
| Shortcut clock | every `c > 2/log(4/3)` | identical strict hypothesis | EXACT |
| Graded clock | `(2(1-alpha)/log(4/3)+epsilon) log n` | identical strict witness bound | EXACT |

The `+2` and `+3` entries are intentionally different: the latter pays the
additional rank-offset unit needed after changing the cumulative center.

## Public theorem contract boundary

| Manuscript result | Formal classification | Exact qualification |
|---|---|---|
| Theorem 1.1 | `PROVED-FORMAL` | Canonical public theorem is the timeout proof.  Lean uses one positive constant where the paper permits separate landing and exceptional constants, and uses a strict landing inequality; therefore it implies the paper formulation. |
| Corollary 1.2(1) | `PARTIAL LITERAL MATCH` | Public fixed-`A` theorem gives some positive logarithmic exceptional exponent.  The paper's full range `gamma < kappa_*(A-A_FP)` is not exposed. |
| Corollary 1.2(2)--(3) and functional profile | `GENERIC PRODUCER FORMAL / SPECIALIZATIONS PAPER-ONLY` | The generic moving theorem is formal; the displayed log-log, triple-log, exact rate ranges, and arbitrary-divergent scalar instantiations have no literal public declarations. |
| Theorem 1.3 | `ADJACENT FORMAL PROJECTIONS / JOINT THEOREM PAPER-ONLY` | One declaration gives qualitative same-witness landing/clock/ceiling at `6.953 log n`; another gives an unclocked count for every strict power below `1-delta`.  They do not yield the paper's joint predicate for every `c>c_*`, and the endpoint power `1-delta` is not exposed. |
| Corollary 1.4 | `PARTIAL` | The raw stretched-log landing at `10.44 log n` is public.  The full moving target, same-witness raw ceiling, and transferred rates remain paper-only. |
| Corollary 1.5 | `PROVED-FORMAL` | The quantitative fixed-power and graded-clock clauses have separate public declarations matching their paper predicates. |
| Theorem 5.3 | `FORMAL COMPONENTS / NO LITERAL PUBLIC CAPSTONE` | The run, direct-passage, reverse-loss, and profile components are formal; no one public declaration has the complete shell-bound plus same-witness paper statement. |

The phrase `PROVED-FORMAL` is reserved for an exact proposition or a Lean
statement that visibly implies the paper proposition.  Availability of a
generic producer alone is not called a literal specialization.

## Release gate

Run, in order:

```text
python3 -B audits/audit_paper_lean_semantics.py
cd lean
lake build
lake build FirstPassageLinearTransportAlternates
lake build FirstPassageLinearTransport.TimeoutEndpointAudit \
  FirstPassageLinearTransport.PaperDependencyAudit \
  FirstPassageLinearTransport.PaperAudit FirstPassageLinearTransport.Main
```

The unqualified build is the canonical referee gate.  The explicit alternate
build checks the isolated comparison library without admitting it to that
gate.  `PaperDependencyAudit` fails if the canonical theorem stops using the
timeout assembly, imports anything below `Alternates`, or if the public theorem
set in `Main.lean` changes unexpectedly.  The axiom audits inspect all canonical
public roots and selected load-bearing milestones; the alternate audit is
rooted separately at `Alternates/AllPrefix/Audit.lean`.  Rendering and PDF
inspection occur only after all source and formal gates pass.
