# V3.2 integrated timeout-replacement audit

> **Formalization update.** The `FORMALIZATION-PENDING` entries below record
> the state at the time of this audit.  The timeout route has since been
> completed through the public `Main.lean` theorem and is mapped and audited in
> `lean/FORMALIZATION.md`, `TimeoutEndpointAudit.lean`, and `proof-state.md`.

**Date:** 2026-08-12
**Mode:** MATH-TEXT + CONSISTENCY + RENDER
**Classification:** THEOREM-PRESERVING PROOF REPLACEMENT
**Verdict:** ACCEPT AS THE MANUSCRIPT LOW-RANK PRODUCER

## Scope

This audit covers the replacement of the moving low all-prefix certificate in
Section 6 by the timeout producer.  It does not re-audit the inherited
high-rank barrier, first-passage reversal, tagged-fiber transport, nested
direct-passage lemma, or rank-scaled loss theorem except at their interfaces
with the new producer.

The public theorem surface is unchanged:

- the moving rank buffer `Delta_M`;
- shell failure `O(2^(-Delta_M) + M^(-epsilon))`;
- the moving polylogarithmic landing;
- every shortcut clock constant above `2/log(4/3)`;
- the same-witness orbit ceiling.

## Exact replacement chain

1. At a low parent rank `m`, the threshold is
   `q_L(m) = floor((1-K_0/(2L))m)`.
2. The timeout event is totalized: no eventual-hitting assumption is made.  It
   says only that no crossing occurs at any integer time `0 <= j <= m`.
3. On the complement, the least crossing time exists within the parent rank
   and is an actual successful first passage.
4. On the timeout event, the exact affine iterate at time `m` gives
   `T^m(x) < 3^(s_m(x)+1)`.  Therefore
   `s_m(x) > q_L(m) log_3(2)-1`.
5. Exact parity coding makes `s_m` binomial on the complete shell.  Uniformly
   for `L <= m <= C L`, the compact upper-tail estimate gives
   `m^(-1/2) 2^(-kappa_* m)` without spending the endpoint rate.
6. A first timeout at a generated checkpoint is a sparse subset of the
   previous landing band.  Nested passage turns its cumulative time into a
   direct first-passage time from the original shell.
7. High entry times occupy one interval of length `O(sqrt(M log M))`.  All
   possible low durations add at most `S(S+1)=O((log M)^2)`, so the combined
   support retains the same square-root order.
8. Rank-scaled reverse loss and support-sensitive arbitrary-target transport
   give the rankwise factor `O((p+1) sqrt(M log M))`.
9. Summing the geometric timeout tail yields
   `sqrt(M log M) sqrt(L) 2^(-kappa_* L)`.  This is exactly the scalar term
   consumed by the moving rank buffer.

No timeout estimate is used to prove its own transport or direct-passage
interface.  No failed checkpoint is reused as certified input.

## Boundary audit

The replacement required one explicit endpoint split.

- A nonendpoint landing through threshold `p` lies in the actual parent shell
  `I_(p-1)`.
- The upper endpoint `2^p` cannot time out: repeated halving crosses every
  lower dyadic threshold.
- Above the switch, that endpoint remains part of the high failure target.
- At or below the switch, it is discharged deterministically to the terminal
  rank in `O(S)` steps.  This case consumes neither timeout density nor an
  uncovered singleton term.
- Hence first-timeout bands satisfy `L+1 <= p <= S` and are normalized by the
  full threshold-band size `2^p`.

This repair is now guarded literally by
`audits/audit_paper_lean_semantics.py`.

## Subtractive result

Relative to the committed V3.1 manuscript at `HEAD` before this batch:

```text
whole manuscript:  -117 lines, -402 words, -3895 characters
Section 6:          -113 lines, -339 words, -3304 characters
render:              25 pages -> 24 pages
```

The written headline cone no longer consumes:

- moving low all-prefix certification;
- the moving low potential and high-to-low reserve;
- the moving-stage startup package;
- the former intermediate support-sensitive fixed profile.

The standalone alternate draft is longer because it preserves frozen
interfaces, alternative routes, audit commentary, and integration guidance.
Those functions are useful in a research note but are not part of the final
paper proof.

## Formalization boundary

The Lean package proves the same public theorem through the independently
completed V3.1 all-prefix low producer.  It does not yet contain a second proof
term for the timeout substitution.  Therefore the correct status is:

```text
V3.2 timeout low producer:       PROVED-PAPER / FORMALIZATION-PENDING
public moving theorem surface:   PROVED-PAPER / PROVED-FORMAL
proof-route identity:            NOT CLAIMED
```

The manuscript disclosure, `lean/FORMALIZATION.md`, `README.md`,
`proof-state.md`, and the semantic concordance all state this distinction.

## Verification

The following gates passed after the final renumbering:

- semantic-drift gate: `PASS`, 38 literal contracts, 19 critical Lean
  declarations, 101 equation labels, and 32 manuscript anchors;
- display tag/label concordance: `PASS`;
- `git diff --check`: `PASS`;
- unqualified `lake build`: `PASS`;
- moving, dependency, public-axiom, and `Main` roots: `PASS`;
- axiom output: only `propext`, `Classical.choice`, and `Quot.sound`;
- PDF: tagged, unencrypted, 24 A4 pages;
- visual inspection: all 24 pages, with high-resolution reinspection of pages
  15--21; no clipping, overlap, broken display, or unresolved reference.

Frozen post-audit artifact hashes:

```text
ecac7d603adf5da4cd06c7040a9d8e857954a6303787541c1649b146d71c7fb7  paper/collatz_first_passage_natural_density.md
9f57569c744edfd1ef59db2125b2e41995cf4f24ca72c8d1881c7780b9535055  paper/collatz_first_passage_natural_density_v3.pdf
d969229c46c7238f78c55f2000da5925a6a2787026f47735a085ca6223435ac7  paper/make_architecture_figure.py
6078d8fbca016f158ba6273acd2176ade1a9a919dea5b2cf560e307c816e92c2  paper/fig-architecture.svg
75063b49e2c8b18078c23991d44dddb5b80faa4a9f550d475d4cc34f3fbbbe34  audits/audit_paper_lean_semantics.py
```

## Decision

Use the timeout proof as the sole low-rank manuscript route.  Retain the
all-prefix low development as the current formal proof and as reusable
companion mathematics.  Do not restore the deleted intermediate theorem to
the headline cone.  A later Lean timeout formalization is synchronization
work, not a prerequisite for the clean manuscript replacement.
