# Methodological-interface and Version-1 lineage exposition audit

**Date:** 2026-08-09

## Scope

This is an exposition-only synchronization check for the V3 manuscript.  It
does not re-audit the mathematical proof and does not alter a theorem,
hypothesis, endpoint, constant, equation, proof step, Lean declaration, or
dependency root.

The edit makes two already-established architectural facts explicit:

- the probabilistic input is exact finite counting on the parity cube, made
  literal by the parity-vector bijection;
- that counting is used to certify sparse barrier failure, not to model an
  individual Collatz orbit as random;
- the first-passage transport and re-certification side is deterministic;
- no mixing theorem, Diophantine reduction, block-independence hypothesis, or
  generated-landing equidistribution statement is a proof input.

It also identifies the public predecessor precisely.  The Zenodo record
`21851173` is the preprint *Quantitative Collatz Descent to
Stretched-Logarithmic Scale in Natural Density, with a Lean 4 Formalization*,
version 2.0.2, DOI `10.5281/zenodo.21851173`.  Its manuscript proves only the
strict range
`delta < 0.251245530155874...` through fixed-time endpoint-fiber/Rényi
transport and endpoint iteration.  The V3 Introduction now states, in one
lineage paragraph, that the current first-passage proof does not import that
theorem and explains exactly which new chain yields the stronger headline.
This is a bibliographic and expository comparison, not a proof dependency.

The clarification appears in the Abstract, the opening methodological
paragraphs of the Introduction, the two-part proof outline, Scope, and one new
bibliography entry.  In accordance with the manuscript headline-cone gate,
there is no chronological research narrative: the main text remains ordered
by the dependency chain into Theorems 1.1--1.2 and Corollaries 1.3--1.4.

## Source basis for the predecessor comparison

- official Zenodo REST metadata for record `21851173`, retrieved 2026-08-09;
- the record's 25-page PDF, extracted through its usable text layer;
- visual inspection of PDF pages 1--4 and 25, covering the abstract, theorem,
  proof outline, relation-to-literature section, and references.

## Frozen artifacts

```text
d12a2a27ae5a363081d48933a3f51b8cca577ac69a2ffd87c61d0f52931c4015  pre-edit manuscript source
d57b544ce51666b5284d710e1bb6c561962b3736f9110701387d7ecc5735fb7c  pre-edit rendered PDF
d7d095853ace3d5b8871f27cb6eaaf909b5ff676efcbc340fe6de55e85e390d6  interface-only manuscript source
7de9580ad1c901978ab00e3905e54013e587223413aeff03368fd87300f2e750  interface-only rendered PDF
f768fdfcac7d9a5277fb50fcf4f8d3dab6520d6f5377610a68a647c33df93144  final manuscript source
29a16c67e885dd1aac380f24a24fb2ae47e0440eb9b52def559fb4d4bdbecb58  final rendered PDF
f01c074c5732442eceb0e483b086a471f40fc8829156676dfa0fe27216308bef  unchanged public Main.lean
```

## Semantic comparison

The pre-edit and post-edit source diff changes prose plus one bibliography
entry.  The displayed headline statements, parameter ranges, numbered
equations, named results, proof bodies, mathematical proof inputs, and public
Lean mapping are unchanged.  The new citation records project lineage and is
not used to discharge a theorem.  Therefore this is a permitted one-sided
nonsemantic manuscript revision; no Lean source change is required.

## Render check

The canonical render remains a 19-page A4 PDF.  Pages 1--5 and 19 were
visually inspected at 130 dpi, covering the Abstract, the new Introduction
paragraphs, both halves of the proof outline, headline corollaries, Scope,
disclosures, and references.  The internal `[7]` link and DOI render
correctly.  No clipping, overlap, broken heading, malformed formula, or
unresolved reference marker was found.

## Verdict

`PASS / NONSEMANTIC EXPOSITION`.

The earlier formal synchronization audit remains the theorem-status source;
this note records only the later methodological clarification, predecessor
lineage, headline-cone check, and render.
