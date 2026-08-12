# V3.2 concordance-review response

**Date:** 2026-08-12

**Context:** AUTHOR-AUDIT

**Modes:** REVIEW-RESPONSE + FORMAL BOUNDARY + RENDER
**Scope:** the three mandatory findings and one optional presentation finding
in the post-timeout concordance review.  This is not a new manuscript-only
mathematical audit.

## Finding disposition

1. **Generic Section 5 interfaces — RESOLVED in `2e5e520`.**  The paragraph
   following Lemma 5.1 states that its proof uses only strictly decreasing
   thresholds and genuine first passage, and names the mixed
   high-rank/timeout chain as a consumer.  The paragraph following Lemma 5.2
   states the generic rank-chain hypotheses explicitly: distinct decreasing
   threshold ranks, duration at most the parent rank, and
   `q_j + 1 > r_* m_j`.  Proposition 6.4 invokes these generic forms.

2. **Corollary 1.4 formalization boundary — RESOLVED in `2e5e520`.**  The
   theorem dictionary maps the public raw declaration only to the
   stretched-logarithmic landing specialization.  A separate row labels the
   moving-polylogarithmic raw landing, same-witness raw-orbit ceiling, and
   transferred rates as paper-only.  The manuscript disclosure and
   `proof-state.md` state the same boundary.

3. **Private snapshot — RESOLVED in `2e5e520`.**  The timeout modules,
   manuscript, PDF, theorem map, audits, proof-state ledger, and public
   `Main.lean` are tracked on `v3-fixed-polylog`.  At the start of this
   response audit, local `HEAD` and `origin/v3-fixed-polylog` were both
   `2e5e520e1c93923ac8126d23ee1bb49e9a3e63bb`.

4. **Dense page-25 command — RESOLVED in this response batch.**  The long
   inline build command is now a short displayed command, followed by a
   role-labelled compact description of the four audit files.  This is a
   presentation-only change.

## Validation

The following checks passed after the presentation repair:

- `python3 -B audits/audit_paper_lean_semantics.py`:
  `45` literal contracts, `35` critical declarations, `101` equation labels,
  `88` equation references, `32` anchors, and `63` anchor references;
- unqualified `lake build` from `lean/`;
- placeholder and project-axiom scan: no `sorry`, `admit`, project `axiom`,
  `unsafe`, `sorryAx`, or `native_decide` in the production chain (the word
  “admit” occurs only in ordinary docstring prose);
- public axiom reports: only `propext`, `Classical.choice`, and `Quot.sound`;
- `git diff --check`;
- PDF: tagged, unencrypted, A4, 26 pages;
- visual inspection of pages 1, 12, 20, 25, and 26, including the revised
  command block and complete references: no clipping, overlap, broken display,
  or unresolved marker observed.

Current source/PDF hashes:

```text
0d94e48915ed698a5ab2a2620aef662d8252e868afe99f35b98adb2272fca927  paper/collatz_first_passage_natural_density.md
4782cfbf2bf2357d8e77f8bfedcb48f1e744905623719a101aad46813453c9bd  paper/collatz_first_passage_natural_density_v3.pdf
```

The hashes quoted in the supplied review (`47784683…acdea` for the source and
`599d2110…04e1b` for the PDF) do not match the committed pre-response files or
the newly rendered pair.  They are therefore recorded as an unavailable
reviewed-byte version rather than silently identified with this snapshot.

## Commit boundary

The intended response commit contains only:

- `paper/collatz_first_passage_natural_density.md`;
- `paper/collatz_first_passage_natural_density_v3.pdf`;
- this response record.

Concurrent research-ledger changes, alternate drafts, DOCX output, and
diagnostic scripts are outside this batch.
