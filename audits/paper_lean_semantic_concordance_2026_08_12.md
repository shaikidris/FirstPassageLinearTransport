# Paper/Lean semantic concordance

**Date:** 2026-08-12
**Mode:** MATH-TEXT + FORMAL + CONSISTENCY
**Classification:** MAINTENANCE
**Scope:** referee-facing headline dependency cone, V3.2 timeout replacement,
public companion theorems, and formalization-boundary language.

## Purpose and limit

A Lean build checks the encoded proposition. It cannot detect a manuscript
transcription error. This audit therefore compares the paper and formal
artifact at the semantic interfaces most vulnerable to small drift: constants,
rank offsets, strict endpoints, logarithm bases, shell normalizations, and
formalization status.

The automated gate in audits/audit_paper_lean_semantics.py protects the
literal contracts below, declaration presence, equation labels, and
manuscript anchors. It is a regression guard, not a proof of semantic
equivalence. The human concordance and manuscript-only proof audit remain
necessary.

## Fragile literal concordance

| Contract | Manuscript | Lean source | Result |
|---|---|---|---|
| One-block duration corridor | (6.7a): abs(gh-(m-q)) <= tm+t+2 | certified_firstPassage_duration_error | MATCH |
| Accumulated corridor-and-offset budget | (6.7d): sum (t_i m_i+t_i+3) | durationError t m = t*m+t+3 | MATCH |
| Certified high endpoint shell | (6.7b): m_(i+1)=q_i-1 | ShrinkingRecertificationRun.certified_endpoint_shell_eq | MATCH |
| Timeout event | (6.11): no crossing through the parent-rank time m | no separate timeout declaration | PAPER-ONLY ROUTE |
| Timeout parity implication | (6.14): s > q_L(m) log_3 2 - 1 | exact_affine_iterate and parityCode_bijective formalize the inputs, not this consumer | PAPER-ONLY ROUTE |
| Switch endpoint | power of two at q<=S is discharged by deterministic halving; high endpoint failure only for q>S | no timeout analogue needed | PAPER-ONLY BOUNDARY |
| Timeout landing target | (6.15): actual parent shell p-1, endpoint excluded | no separate timeout target | PAPER-ONLY ROUTE |
| Combined timeout time support | (6.13), (6.16): high interval plus O(S^2) low duration | public theorem uses the independent moving-potential producer | SAME ORDER / DIFFERENT ROUTE |
| Endpoint entropy constant | (1.2): A_FP=1/(2(1-H_2(log_3 2))) | timeSupportCriticalExponent_eq_entropy | MATCH |
| Shortcut clock | c>2/log(4/3) | public Main hypothesis | MATCH / STRICT |
| Parent landing target | J_q=(2^(q-1),2^q], density divided by 2^q | landingBad q; moving density theorems | MATCH |
| High target tolerance | (6.4a), (6.8c): use eta_(M,q-1) above the switch | shrinkingTargetTolerance; shrinking high-density producer | MATCH |
| Direct reverse loss | Proposition 6.4: E_(2^p)(n) < (p+2)/r_* | rank-scaled loss theorem; formal all-prefix route has the analogous literal bound | MATCH AT SHARED INTERFACE |
| Rankwise timeout transport | support H times O(p+1) times target density | lossFiltered_arbitraryTarget_transport_atTimes_uniform | MATCH AT SHARED INTERFACE |
| Critical timeout target | (6.15): p^(-1/2) 2^(-kappa_* p), with no endpoint term | no separate timeout producer | PAPER-ONLY ROUTE |
| Timeout terminal profile | (6.17): sqrt(M log M) sqrt(L) 2^(-kappa_* L), plus high error | public theorem uses the independent all-prefix moving profile | SAME SCALAR CONCLUSION / DIFFERENT ROUTE |
| Formal alternate sharp low-tail summation | not a V3.2 manuscript dependency | exists_exact_sharp_critical_low_series_bound; moving_low_firstBad_sharp_exact_sum_le | PROVED-FORMAL ALTERNATE |
| Moving rank buffer | (1.3): kappa_* L_M - 1/2 log_2(M+2) - log_2 log(M+3) | movingRankBuffer | MATCH |
| Moving shell conclusion | (1.5): 2^(-Delta_M) + M^(-epsilon) | movingEndpointNaturalDensityAssembly | MATCH AT CONDITIONAL CONSUMER |
| Stretched endpoint | delta=1 excluded; formal rate has strict sigma<1-delta | Main quantitative theorem | MATCH / FORMAL THEOREM IS STRICTLY WEAKER AT RATE ENDPOINT |
| Fixed-power rate | every strict sigma<1 | Main quantitative fixed-power theorem | MATCH |
| Graded clock | (2(1-alpha)/log(4/3)+epsilon) log n | Main graded theorem | MATCH |

The +2 and +3 lines are not interchangeable. The former is the literal
one-block first-passage corridor. The latter pays one additional unit when
the cumulative center is changed using the exact shell identity.

## Headline and companion boundary

| Paper result | Formal status | Qualification |
|---|---|---|
| Theorem 1.1, moving endpoint | PROVED-PAPER / PROVED-FORMAL | identical theorem surface; manuscript uses timeout low blocks, Lean uses the independently completed all-prefix low producer |
| Corollary 1.2(1), every fixed A>A_FP | PROVED-FORMAL | public Main theorem; its type exposes a positive log exceptional exponent, not the paper's full sharp range |
| Corollary 1.2(2)--(3), critical secondary profiles | PROVED-PAPER | no public Lean theorem |
| Theorem 1.3, stretched logarithm | PROVED-FORMAL BELOW ENDPOINT | landing, clock, and ceiling are formal; exceptional power is every strict sigma<1-delta, while the paper proves the endpoint 1-delta |
| Corollary 1.4, raw clock | PROVED-FORMAL FOR STRETCHED TARGET | the moving-polylogarithmic raw consequence remains paper-level with Theorem 1.1 |
| Corollary 1.5, fixed power and graded clock | PROVED-FORMAL | public companion declarations |

## Findings repaired in this batch

1. **Subtractive manuscript cone:** the moving low all-prefix certificate,
   decreasing potential, startup package, and former intermediate fixed
   profile were removed from the written headline chain.  The replacement is
   the totalized timeout event and its terminal binomial tail.
2. **Endpoint and shell indexing:** above the switch the upper endpoint is a
   high failure; at or below the switch its power-of-two orbit is discharged
   deterministically in O(S) steps.  It cannot be a timeout.  A first timeout
   reached through threshold p therefore lies in the actual parent shell
   I_(p-1), so the low rank range begins at p=L+1 and the target is normalized
   by the full band size 2^p.
3. **Formalization boundary:** the public theorem is fully kernel-checked, but
   through the earlier all-prefix low producer.  The timeout proof is not
   represented as a second Lean term.  The map and manuscript now state this
   rather than claiming proof-route synchronization.
4. **Scalar preservation:** both routes expose the same rank buffer, shell
   exceptional ratio, landing, logarithmic clock, and same-witness ceiling.
   Equality of those outputs does not identify the internal proofs.

## Release gate

Before rendering or freezing the paper, run:

    python3 -B audits/audit_paper_lean_semantics.py
    cd lean && lake build
    lake build FirstPassageLinearTransport.MovingEndpointAudit
    lake build FirstPassageLinearTransport.PaperDependencyAudit
    lake build FirstPassageLinearTransport.PaperAudit
    lake build FirstPassageLinearTransport.Main

The V3 render script runs the semantic audit automatically. A pass means the
declared contracts have not drifted; the gate itself also checks that the
render script invokes it exactly once. It does not replace the independent
manuscript-only proof review. The unqualified `lake build` is required to
catch source modules that are not imported by a current headline or audit
root.
