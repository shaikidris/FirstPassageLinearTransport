# First-Passage V2 literature and provenance audit

**Mode:** `LITERATURE`  
**Reviewer context:** `AUTHOR-AUDIT`  
**Retrieval date:** 2026-08-05  
**Frozen manuscript SHA-256:**
`533158a16798aed30da8eb425166059071b4ff815b7b837094851e6729253304`  
**Access boundary:** primary papers, primary repository records, and publisher
or archive metadata; no secondary summary is used as theorem evidence

## 1. Search record

Sources and corpora checked:

- arXiv title/author/theorem pages for Tao and Inselmann;
- the published Tao article and DOI metadata;
- Zenodo record and full V2 PDF for Allikvere;
- the full ProofAtlas-hosted V2 PDF and pinned-artifact metadata for Mazur;
- DML-CZ bibliographic record for Korec;
- the Terras bibliographic record cited in the primary literature.

Search concepts included `Collatz natural density`, `almost bounded`,
`first passage`, `logarithmic time`, `shortcut map`, `stopping time`, and
`arbitrary diverging threshold`.

This was a targeted nearest-predecessor audit, not a proof that no additional
unpublished or unindexed predecessor exists.  Accordingly the manuscript
makes no `first`, `best known`, or global-priority claim.

## 2. Primary-source theorem ledger

### [1] Allikvere, V2 preprint

Primary record:
<https://doi.org/10.5281/zenodo.21499244>.

The Zenodo record identifies the artifact as a preprint, version 2, deposited
22 July 2026.  The PDF states:

- natural-density descent below every function \(f(N)\to\infty\);
- a fixed-target odd-Syracuse exception ratio
  \(O((\log N_0)^{-1/29}+X^{-1/2000})\);
- a Syracuse clock
  \(\log N/\log(4/3)+O((\log N)^{0.8})\);
- a raw Collatz clock below \(12\log N\) for sufficiently large \(N\).

Classification: `TYPE A` stated results.  The present V2 paper does not use
them as inputs.

### [2] Inselmann, arXiv:2402.03276v3

Primary record:
<https://arxiv.org/abs/2402.03276>.

The abstract states natural-density simultaneous trajectory approximation for
the shortcut map through
\(2\log N/\log(4/3)\), and in particular descent below \(N^\varepsilon\) for
every separately fixed \(\varepsilon>0\).

Classification: `TYPE A` stated result.  The present V2 paper locally proves
only the shorter one-shell barrier it consumes and does not import
Inselmann's theorem.

### [3] Korec, Math. Slovaca 44 (1994)

Primary metadata:
<https://dml.cz/handle/10338.dmlcz/133225>.

The natural-density power threshold used in the comparison is
\(N^\theta\) for every fixed \(\theta>\log 3/\log4\).  This range is also
quoted in Tao's published abstract.

Classification: `TYPE A` historical theorem.  It is comparison only.

### [4] Mazur, V2 manuscript and pinned formal artifact

Primary manuscript:
<https://www.proofatlas.ai/papers/natural-density-log-time-collatz/Mazur_Natural_Density_Collatz_Orbits_in_Logarithmic_Time_v2.pdf>.

Theorem 1.1 states natural-density descent below every diverging threshold,
with raw clock \(<436\log N\); the odd-relative Syracuse version has clock
\(<145\log N\).  Theorem 1.2 gives a fixed-target logarithmic rate for every
\(d<5/143\).  The manuscript identifies a pinned Lean artifact and labels its
paper/formal relationship explicitly.

Classification: `TYPE A` stated results plus a separate formal-artifact claim.
No formal claim from this source is used to prove the present V2 theorem.

### [5] Tao, Forum of Mathematics, Pi 10 (2022), e12

Primary article:
<https://doi.org/10.1017/fmp.2022.8> and
<https://arxiv.org/abs/1909.03562>.

Theorem 1.3 states descent below every function \(f(N)\to\infty\) for almost
all starts in logarithmic density.  The article separately records Korec's
natural-density fixed-power predecessor.

Classification: `TYPE A` published theorem.  Tao's method is not imported by
the present V2 proof.

### [6] Terras, Acta Arith. 30 (1976)

The citation is historical provenance for parity-vector/stopping-time coding.
The present manuscript proves the exact parity bijection locally, so no
proof-internal claim is deferred to Terras.

Classification: background provenance; no external theorem application.

## 3. Multi-axis comparison audit

| Axis | Present V2 | Nearest stronger or adjacent result | Verdict |
|---|---|---|---|
| Density | natural | Korec, Inselmann, Allikvere, Mazur also natural | not new alone |
| Target | \(\exp((\log N)^{1-\delta})\), fixed \(\delta<1\) | Allikvere and Mazur state every diverging target | strictly weaker than arbitrary-threshold preprints |
| Fixed-power comparison | smaller than \(N^\varepsilon\) for every fixed \(\varepsilon>0\) | Inselmann reaches fixed powers on the same shortcut-time scale | genuine target-scale gain relative to this axis |
| Shortcut time | \(<6.953\log N\) | Inselmann identifies \(2/\log(4/3)\) | same asymptotic scale, not claimed new |
| Raw time | \(<13.906\log N\) by deterministic conversion | Allikvere states \(<12\log N\) | present raw constant is weaker |
| Exceptional rate | \(X\exp(-c(\log X)^\sigma)\) for the displayed stretched-log target | Allikvere and Mazur give different fixed-target logarithmic rates | distinct target-specific quantitative axis; no total ordering claimed |
| Structural interface | arbitrary-target first-passage linear transport | not exhaustively priority-audited | mathematical content proved locally; priority `NOT CHECKED` |
| Orbit ceiling | \(N^{1+\beta}\) through the witness | trajectory envelopes occur in Inselmann | useful companion conclusion, not claimed globally novel |

The manuscript's comparison paragraph and table agree with this ledger.  In
particular it explicitly says that its target is weaker than an arbitrary
diverging function and that it does not supersede [1] or [4].

## 4. Provenance and overclaim findings

Confirmed priority error: none.

Confirmed provenance gap: none among the six claims actually printed.

Residual limitation:

```text
EVIDENCE: NOT CHECKED
SEVERITY: MINOR for correctness; material for any future priority claim
ITEM: global novelty of the exact arbitrary-target tagged-fiber lemma
REASON: no exhaustive historical or unpublished-manuscript search was run
ACTION: retain the current mechanism-level wording and avoid first/best claims
```

## 5. Literature verdict

`PASS WITH BOUNDED PRIORITY SCOPE`.

The comparison table is accurate on the checked primary sources and is
appropriately non-total.  The present theorem is not marketed as the strongest
natural-density threshold theorem.  A future claim of priority for Proposition
4.4 would require a dedicated search beyond this audit.

