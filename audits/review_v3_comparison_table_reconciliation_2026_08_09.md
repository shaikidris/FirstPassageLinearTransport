# V3 four-column comparison-table reconciliation

**Mode:** `LITERATURE / AUTHOR-AUDIT`

**Review date:** 2026-08-09

**Manuscript SHA-256:**
`af9bc44ddd97463e17d9b44d49c85c35d29367af397bca0144e51aae3242953f`

**Rendered PDF SHA-256:**
`63853e18e9edcaad317a61b6cbb60178efd6a3f69e09fd5a896f0c428d3f8a01`

## Scope

This is a bounded reconciliation of the four-column table in Version 3.0.
It rechecks only the literal comparison coordinates printed there: density
notion, target, clock, and quantitative exception.  It is not a global
priority search.  No external theorem is an input to the V3 proof.

The detailed primary-source ledger remains
`review_first_passage_v2_literature_2026_08_05.md`, whose Allikvere entry
records the official Zenodo V2 theorem coordinates used below.

## Row audit

| Work | Primary source checked | Literal table coordinates | Verdict |
|---|---|---|---|
| Korec | DML-CZ record, full paper metadata, and the range quoted in Tao's published abstract | natural density; `n^theta` for every fixed `theta > log 3 / log 4` | `PASS` |
| Inselmann | arXiv:2402.03276v3 abstract and source record | natural density; every fixed power `n^epsilon`; shortcut clock `2 log n / log(4/3)` | `PASS` |
| Tao | Forum of Mathematics, Pi 10 (2022), e12, Theorem 1.3 | logarithmic density; every separately fixed `f(n) -> infinity`; no global clock asserted in the headline theorem | `PASS` |
| Mazur | Version-2 ProofAtlas manuscript and its current formalization record | natural density bridged from Tao's logarithmic-density framework; every separately fixed `f(n) -> infinity`; raw clock below `436 log n`; fixed-target logarithmic rate | `PASS AS MANUSCRIPT CLAIM` |
| Allikvere | Zenodo Version-2 PDF, source, scripts, and package README frozen in the dedicated audit | natural density bridged from Tao's logarithmic-density framework; every separately fixed `f(n) -> infinity`; raw clock below `12 log n`; stated fixed-target exception | `PASS AS PREPRINT CLAIM` |
| This paper | Theorems 1.1–1.2 and Corollaries 1.3–1.4 in the frozen source above | natural density; fixed-polylog and stretched-log targets; shortcut/raw clocks and two target-specific exceptional rates | `PASS (INTERNAL)` |

## Presentation audit

The table deliberately omits publication status and proof lineage.  The
surrounding prose identifies the two 2026 works as bridge manuscripts and
explains their relationship to Tao's architecture.  The references identify
the source type.  The post-table paragraph explicitly says that the V3 target
is weaker than an arbitrary diverging function and that the comparison is not
a total ordering.

The current A4 render shows all four columns at readable size with no clipped
cells.  No wording in the table says `first`, `best known`, `strongest`, or
`supersedes`.

## Verdict

`PASS WITH BOUNDED PRIORITY SCOPE`.

The four-column table is faithful to the checked primary sources and is
appropriate for the current manuscript.  A later source revision must trigger
a new row-level check before submission.
