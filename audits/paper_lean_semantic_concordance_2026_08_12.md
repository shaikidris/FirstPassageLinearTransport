# Paper/Lean semantic concordance

**Date:** 2026-08-12
**Mode:** MATH-TEXT + FORMAL + CONSISTENCY
**Classification:** MAINTENANCE
**Scope:** referee-facing headline dependency cone, moving V3.1 additions,
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
| Certified endpoint shell | (6.7b): m_(i+1)=q_i-1 | MovingRecertificationRun.certified_endpoint_shell_eq | MATCH |
| Low potential | Lemma 6.4: V_lo(q)=(S+4)q | movingLowStepCost, low branch of movingTimePotential | MATCH |
| Low step payment | Lemma 6.4: tm+t+3 <= S+3, strict rank drop | movingLow_durationError_le; movingTimePotential_step | MATCH AFTER CORRECTION |
| High-to-low reserve | Lemma 6.4: (S+4)S | high branch of movingTimePotential | MATCH |
| Moving time support | (6.17): O(sqrt((M+2) log(M+2))) | eventually_movingFeasibleTimes_card_lt_sqrt | MATCH |
| Endpoint entropy constant | (1.2): A_FP=1/(2(1-H_2(log_3 2))) | timeSupportCriticalExponent_eq_entropy | MATCH |
| Shortcut clock | c>2/log(4/3) | public Main hypothesis | MATCH / STRICT |
| Parent landing target | J_q=(2^(q-1),2^q], density divided by 2^q | landingBad q; moving density theorems | MATCH |
| Moving target tolerance | (6.4c): use eta_(M,q-1) above the switch | movingTargetTolerance | MATCH |
| Direct reverse loss | (6.5): E_(2^q)(n) < (q+2)/r_* | MovingRecertificationRun.scaledReverseLoss_le | MATCH |
| Rankwise moving transport | support H times (1+6/r_*)(q+1) times target density | movingFirstBadSourcesAtRank_density_le | MATCH |
| Critical low target | (6.16): q^(-1/2) 2^(-kappa_* q) + 2^(-q) | MovingLowDensity producer | MATCH |
| Moving terminal profile | (6.18): sqrt(M log M) times the low target tail, plus high error | movingSeparatedFailureEnvelope_density_terminalProfile | MATCH AT CONDITIONAL SOCKET |
| Sharp low-tail summation | (6.19): (L+1)2^(-L) + sqrt(L) exp(-b(L-1)) | exists_exact_sharp_critical_low_series_bound; moving_low_firstBad_sharp_exact_sum_le | MATCH / EXACT RATE / CONDITIONAL INPUTS |
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
| Theorem 1.1, moving endpoint | PARTIAL FORMALIZATION | producer, moving time support, direct first-bad transport, and exact-rate conditional sharp profile are formalized; uniform low-stage startup, shell/witness assembly, and public theorem remain open |
| Corollary 1.2(1), every fixed A>A_FP | PROVED-FORMAL | public Main theorem; its type exposes a positive log exceptional exponent, not the paper's full sharp range |
| Corollary 1.2(2)--(3), critical secondary profiles | PROVED-PAPER | no public Lean theorem |
| Theorem 1.3, stretched logarithm | PROVED-FORMAL BELOW ENDPOINT | landing, clock, and ceiling are formal; exceptional power is every strict sigma<1-delta, while the paper proves the endpoint 1-delta |
| Corollary 1.4, raw clock | PROVED-FORMAL FOR STRETCHED TARGET | the moving-polylogarithmic raw consequence remains paper-level with Theorem 1.1 |
| Corollary 1.5, fixed power and graded clock | PROVED-FORMAL | public companion declarations |

## Findings repaired in this batch

1. **Moving low-step constant:** the paper said tm+t+2 <= S+3 where the
   telescoping potential actually consumes tm+t+3. Equation (6.7a) remains
   correctly +2; only the moving-potential paragraph is corrected.
2. **Formalization boundary:** MovingFirstBad.lean and MovingProfile.lean now
   formalize the direct moving first-bad transport and the conditional
   terminal-profile socket. Status surfaces that still called this adapter
   absent are updated. This does not promote Theorem 1.1: the concrete
   moving-parameter instantiation and public assembly remain unfinished.
3. **Sharp endpoint rate:** MovingSharpTail.lean now translates q=L+j and
   sums the j-tail uniformly while retaining the actual leading rate b.  Its
   MovingSharpProfile consumer proves the conditional sqrt(L) exp(-b(L-1))
   profile without introducing b'<b.  This closes the sharp-profile cut
   vertex but not uniform startup or the Delta_M shell reassembly.

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
