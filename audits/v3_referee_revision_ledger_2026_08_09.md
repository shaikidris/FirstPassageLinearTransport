# V3 referee-revision ledger

**Opened:** 2026-08-09
**Review input:** external prose assessment supplied as
`9ffe4c82-1621-46dc-aa21-171bdf4f10fe/pasted-text.txt`
**Audited baseline commit:** `6384f13fd32ddb236a1a6e972ac47999284951c1`
**Modes:** `AUTHOR-AUDIT / MATH-TEXT + FORMAL-SYNC + RENDER`
**Theorem status:** unchanged.  Reviewer comments trigger verification and
revision; they do not by themselves promote or demote any theorem.

## Scope and decision rules

This cycle changes exposition, notation, and manuscript self-containedness.
It does not optimize the theorem, reopen Phase 3, or alter the strict headline
ranges.  A load-bearing paper insertion must either be proved directly in the
manuscript or mapped to an already-audited Lean declaration.  Every batch ends
with reference checks, a PDF inspection, and the relevant Lean build.

Status vocabulary:

- `OPEN`: accepted and not yet edited;
- `IN PROGRESS`: active item;
- `DONE`: source, render, and any formal map are checked;
- `ACCEPT-WITH-SCOPE`: the concern is valid but the proposed repair is
  stronger than necessary; use the weakest exact repair;
- `STALE`: already repaired in the audited repository;
- `DEFERRED-TO-FREEZE`: requires the final artifact hash or archive location;
- `SEPARATE-AUDIT`: cannot be discharged by prose editing.

## A. Load-bearing self-containedness

| ID | Status | Finding | Exact repair | Acceptance test |
|---|---|---|---|---|
| A01 | DONE | `I_M` was used without a manuscript definition. | Defined `I_M = [2^M, 2^{M+1}) ∩ ℕ` before Lemma 2.1. | First shell use resolves locally; page 5 of the 19-page A4 render is clean. |
| A02 | DONE | Section 6 did not define the literal two-regime stopped chain or failure set. | Equations (6.4b)–(6.4e) now define the rank rule, landing-selected tolerance, recursive first-passage chain, and exact first-bad union. | Every object in Theorem 6.3 is defined before use; pages 14–15 render cleanly and the Lean dictionary names the literal run and envelope. |
| A03 | DONE | A varying tolerance was used after only the fixed-tolerance density proposition. | Proposition 6.2 proves the inactive-cap identity, exact quadratic exponent, initial density, and high landing-target density, including the endpoint. | The common power `d_hi(M)` is uniform in every high rank; page 16 and all four mapped Lean declarations pass. |
| A04 | DONE | Lemma 6.1 omitted the calculation preventing branching time supports. | Equations (6.7b)–(6.7d) exclude `2^q`, prove `m_(i+1)=q_i-1`, telescope the rank drops, and give one cumulative corridor. | One interval contains every cumulative first-bad time and the high/low geometric sums give `O(√(M log M))`; page 15 and the mapped Lean declarations pass. |
| A05 | DONE | Theorem 6.2 suppressed fixed startup ranks. | Section 6 now defines `L_loss`, `L₀`, and a theorem startup `M₁`; Theorem 6.3 assumes `M ≥ M₁` and `L₀ ≤ L < S_M < M`. | Certification and loss-filter startups are literal and the main specialization verifies `L₀ ≤ L_M` eventually. |
| A06 | DONE | The high/low target split at the switch was implicit. | The target tolerance is selected from `q-1`; the proof splits `q ≥ S_M+1` from `L ≤ q ≤ S_M`, retains `2^q`, and displays both rank sums. | Equations (6.10a)–(6.10c) expose the target estimates and `Σ(q+1) ≪ M²`; page 17 renders cleanly. |
| A07 | DONE | The proof of Theorem 1.1 invoked unnamed polynomial costs. | Equation (6.13a) now imposes `c₀D_hi²>3` and `C_sw log 2>3`, hence the explicit margin `p_hi>3`. | Equation (6.15) uses only the two displayed positive margins; page 18 renders cleanly. |

## B. Local mathematical bridges

| ID | Status | Finding | Exact repair | Acceptance test |
|---|---|---|---|---|
| B01 | DONE | Proposition 3.3 did not identify the uniform unused envelope slack. | The proof now minimizes the pre-replacement slack over all `k ≤ M` and `n ∈ I_M`, obtaining (3.15) at `k = M`, `n = 2^M`. | The uniform-in-`k` step is explicit and page 9 renders cleanly. |
| B02 | DONE | The role of `E_Y` was not explained at definition. | The text now states that `E_Y/Y` bounds the reverse-product defect and that segment losses rescale by `Y/Y'` before adding. | Section 5's rank-scaled loss now has a local conceptual bridge; page 10 renders cleanly. |
| B03 | DONE | Theorem 5.3 used “above that startup” and compressed the `M(q+1)` factor. | The theorem now states `M ≥ L ≥ M₀`; its proof records `H ≪ᵣ M` and `1+3D ≪ᵣ q+1` before (5.14). | Quantifiers and the transport multiplier are locally visible; page 13 renders cleanly. |

## C. Introduction and proof flow

| ID | Status | Finding | Exact repair | Acceptance test |
|---|---|---|---|---|
| C01 | DONE | Literature preceded the proof map. | The six-step architecture and figure now precede the comparison section. | Pages 3–4 give theorem → mechanism → literature in that order. |
| C02 | DONE | The six-column comparison table was too wide. | Reduced the table to `Work / Density / Target / Clock or quantitative feature`; lineage and publication status are in prose and references. | The four-column table renders legibly at A4 width on page 5. |
| C03 | DONE | Scope disclaimers repeated. | Retained one short abstract qualification, one post-Theorem-1.1 qualification, and the complete Section 8 statement; removed the duplicate method disclaimer from the literature discussion. | Scope remains literal without repeated paragraph-level caveats. |
| C04 | DONE | The graded-clock proof opened a second architecture near the end. | Corollary 1.4 remains in the introduction; Section 7 gives a short pointer and the independent proof is Appendix A. | The headline technical arc closes before Scope, while pages 21–22 preserve the companion proof. |

## D. Notation and theorem readability

| ID | Status | Finding | Exact repair | Acceptance test |
|---|---|---|---|---|
| D01 | DONE | Theorem 1.1 reused `C` for target and exception constants. | Introduced `C_tar` and `C_exc` in Theorem 1.1, Corollary 1.3, the abstract, and the semantic dictionary. | Constant roles are unambiguous; the Lean theorem's single larger constant is documented as a stronger packaging. |
| D02 | DONE | Theorem 1.2 overloaded clock `c` and its decay constant. | Renamed the decay rate `gamma_(delta,c,beta)` throughout. | Clock and exceptional decay are visually distinct on pages 1–2. |
| D03 | DONE | `D` was overloaded across density, loss, entropy, and Section 6. | Renamed the high schedule coefficient `D_hi`; the appendix uses `D_dens` and `D_loss`, while relative entropy retains standard `D(p∥q)`. | Role-specific notation renders consistently on pages 18 and 21. |
| D04 | DONE | The `a₀−1` sentence could be read as describing the affine map. | Identified it as the mean base-two logarithm of the multiplicative main term under exact uniform parity coding and deferred affine correction to Section 3. | Page 2 makes no probabilistic assertion about the full affine iterate. |
| D05 | DONE | Abstract terminology and constant reuse could be cleaner. | Used “unaccelerated Collatz map,” separated the two theorem products, and introduced distinct target/exception constants. | Page 1 remains concise, literal, and free of undefined “raw” terminology. |

## E. Reproducibility and external checks

| ID | Status | Finding | Exact repair | Acceptance test |
|---|---|---|---|---|
| E01 | STALE | Figure asset was absent from the review attachment. | No manuscript change: SVG and deterministic generator are present in commit `6384f13`. | Asset is included in the final source manifest and journal conversion. |
| E02 | DONE | Lean disclosure lacked an immutable artifact pointer and full metadata. | The manuscript and formal dictionary now identify the access-controlled repository at commit `e382a241e73ac2f0a958b7411f7778584f3dc48d`, Lean `4.15.0`, Mathlib revision `9837ca9d...`, the exact referee build command, and both audit modules. | An authorized referee can fetch and replay exactly the claimed artifact; private visibility is preserved. |
| E03 | DONE | The prose review did not independently check the 2026 comparison rows. | Reconciled the four-column table against the frozen primary-source ledger, the dedicated Allikvere V2 audit, and current primary records in `review_v3_comparison_table_reconciliation_2026_08_09.md`. | Every row has a literal source record; the audit returns `PASS WITH BOUNDED PRIORITY SCOPE`. |
| E04 | DONE | Revised Section 6 needed a bounded independent re-audit. | Froze source/PDF hashes and audited only Proposition 6.2, Lemma 6.1, Theorem 6.3, and the Theorem 1.1 parameter selection in `review_v3_section6_cut_vertices_2026_08_09.md`. | The audit returns complete coverage with no circular dependency or missing rate margin. |

## Closure order

1. `A01`, then `B01`--`B03` (low-risk self-containedness).
2. `A02`--`A04` (literal Section-6 definitions and compression proof).
3. `A05`--`A07` (terminal profile and parameter margins).
4. `D01`--`D05` (notation after mathematics stops moving).
5. `C01`--`C04` (structural prose moves after numbering is stable).
6. `E02`--`E04` (freeze metadata, literature, and focused audit).

No new research optimization enters this queue.
