# V3 streamlined headline-cone and literature-table audit

**Review date:** 2026-08-09
**Mode:** `MATH-TEXT + LITERATURE + FORMAL-SYNC + RENDER`
**Branch:** `v3-fixed-polylog`
**Baseline commit:** `83acd4c`
**Verdict:** `PASS / STREAMLINED HEADLINE + ISOLATED GRADED COMPANION`

## 1. Scope of the edit

The manuscript was first reduced from 19 to 17 pages around its final
optimized first-passage dependency cone.  Restoring the compact graded
companion and adding one proof-architecture figure brings the final audited
render to 19 pages without restoring the removed legacy proof section.  The
retained products are:

1. Theorem 1.1, optimized fixed-polylogarithmic natural-density descent;
2. Theorem 1.2, endpoint-rate stretched-logarithmic descent;
3. Corollary 1.3, the raw Collatz clock;
4. Corollary 1.4, the fixed-power exceptional count and graded clock.

The former standalone graded-power section and its manuscript-only unfiltered
transport lemmas remain removed.  The significant graded statement is retained
as a compact independent companion in Section 7.  Its paper proof obtains the
one-step density update directly from the retained loss-filtered Proposition
4.3 and then performs only a fixed finite pullback.  The full optimized
headline chain is unchanged.

The optimized proof chain retained in the paper is:

```text
dyadic density + parity coding + affine iterate
  -> maximal all-prefix barrier
  -> loss-filtered first-passage transport
  -> nested direct re-certification
  -> rank-scaled reverse loss
  -> shrinking high-rank barriers
  -> square-root cumulative-time support
  -> support-sensitive terminal profile
  -> fixed-polylogarithmic natural-density assembly.
```

## 2. Consumer audit

Every reference to the graded clock and the old unfiltered transport
proposition was traced.  Theorems 1.1 and 1.2, the raw-clock conversion, and
the fixed-power exceptional count use only the loss-filtered or
support-sensitive optimized chain.  The restored graded conclusion is not a
consumer of the shrinking-barrier profile: it uses the all-prefix envelope,
loss-filtered transport with the automatic budget E_Y <= H/2, and a fixed
number of stopped-map pullbacks.

The public theorem statements in `Main.lean` are unchanged.  The manuscript's
landing inequality remains weak while the public Lean theorem is strict, so
the formal statement is still slightly stronger at that point.

## 3. V1/V3 comparison and 2026 Tao bridges

The frozen Version-1 submission used a narrative comparison with Korec,
Inselmann, and Tao.  Its submission manifest records that the 2026 Allikvere
and Mazur manuscripts were not retained in the final bibliography.  V3 is
therefore not a literal copy of a V1 table: it adds a current multi-axis table
for density, target, clock, and exceptional rate.

Primary records checked for the new rows:

- Tao, published article and current arXiv source:
  <https://arxiv.org/abs/1909.03562>;
- Allikvere, Version-2 Zenodo preprint:
  <https://doi.org/10.5281/zenodo.21499244>;
- Mazur, Version-2 manuscript and pinned formalization:
  <https://www.proofatlas.ai/formalizations/natural-density-log-time-collatz/>.

The corrected table now distinguishes result strength from proof lineage:

- Tao is the published Syracuse/3-adic first-passage source architecture;
- Allikvere is identified as an unrefereed Tao-to-natural-density bridge,
  conditioning Tao's Syracuse/Fourier inputs on total valuation and adding the
  uniform-measure transfer;
- Mazur is identified as a Tao-to-natural-density bridge through a quantitative
  phase-gap/rate mechanism and a two-adic lift;
- the present paper is identified as an independent first-passage transport
  chain, not as an extension of Tao's renewal/Fourier argument.

The table remains coordinatewise.  It explicitly records that the two 2026
manuscripts claim the stronger arbitrary-diverging target, while the present
paper has a smaller clock and target-specific exceptional rates.  No global
priority or total-order claim is made.

## 4. Prose and flow audit

The introduction now begins with the mathematical question and states the two
headline theorems before discussing software, lineage, or method.  The former
project-status language was removed.  Short causal bridges were inserted at
the starts of Sections 2--5 and 7.  The abstract now states only the final
mechanism and fits on page 1; Theorem 1.1 starts on page 2.

The probabilistic/deterministic boundary is explicit: exact Boolean-cube
counting certifies the all-prefix barrier, and the later transport and
re-certification steps are deterministic.  The scope section retains the
almost-all limitation and makes no universal-orbit, cycle-exclusion, or
convergence claim.  It now also states explicitly that no stochastic
independence between orbit blocks is assumed.

One reproducible architecture figure was inserted after the six-step proof
map.  Its first panel follows an actual shortcut-Collatz orbit satisfying the
displayed all-prefix envelope.  Its second panel is deliberately schematic:
it records only the proved transition from an \(O(M)\) time-tag horizon to
\(O(\sqrt{M\log M})\) feasible support and introduces no numerical value for
the unspecified constant in Lemma 6.1.  The generating script reproduces the
SVG and prints the selected source and its three first-passage tags.

The introduction now places the sparse-failure transport obstruction before
the comparison table and names the linear-to-square-root compression as the
quantitative pivot.  Lemmas 4.1, 4.2, and 6.1 are cited explicitly at their
consumer sites, and the two headline proof sites restate their terminal
targets locally.

## 5. Formal synchronization

`PaperDependencyAudit.lean` maps the manuscript's actual Section-4--6
roots: loss-filtered fibers and transport, nested direct first passage,
rank-scaled loss, first-bad terminal profile, duration corridors, and
support-sensitive aggregation.  It also maps the isolated Corollary-1.4
graded roots, while keeping them outside the headline dependency cone.

`PaperAudit.lean` prints axioms for the optimized manuscript chain and its
retained quantitative companions, including the graded theorem.  The
resulting logical dependencies
are the standard Mathlib principles `propext`, `Classical.choice`, and
`Quot.sound`; no project axiom or placeholder appears.

The following build completed successfully:

```text
lake build FirstPassageLinearTransport.PaperDependencyAudit \
  FirstPassageLinearTransport.PaperAudit \
  FirstPassageLinearTransport.Main
```

## 6. Reference and render gates

The source passed:

- `git diff --check`;
- equation-reference/label consistency;
- duplicate-equation-label scan;
- internal-anchor consistency, including bibliography span identifiers.

The latest PDF is a tagged, unencrypted, 19-page A4 document.  Pages 3, 5,
9--10, 14--15, and 18--19 were re-rendered after the final edits; the
comparison table, architecture figure, lemma consumers, headline assemblies,
compact companion proof, scope/disclosure, and references have no clipping,
overlap, broken formula, or unresolved reference.  The 46 equation labels
without an in-text `eqref` were retained intentionally: they support local
proof navigation and formal-map stability, and none is duplicated or broken.

## 7. Frozen hashes

```text
6a892e0137fbbd00a7e04fd919441bbc91c78fa12d844ffc4a037abc9f85ade4  paper/collatz_first_passage_natural_density.md
02d4bfa787eaaf3ff1f5fb4345c83292eb90a600ac1e95458a1031f120eb9148  paper/collatz_first_passage_natural_density_v3.pdf
cdb8aaffa384f68f84d1ff0dc1e4498234bf97e43d4317c21ea3f2d912b5de17  paper/fig-architecture.svg
8a731b16bceacecc9bf63e90f828d753c720c9842f2c2b13cfdc336a99b86477  paper/make_architecture_figure.py
f01c074c5732442eceb0e483b086a471f40fc8829156676dfa0fe27216308bef  lean/FirstPassageLinearTransport/Main.lean
fa5d2f046b24b812e94a8fb400c411e6742b8a38ac973428a84ed4683a8faeee  lean/FirstPassageLinearTransport/PaperAudit.lean
12229761cf259e9f118420210cfd5676aef0c9d1cf9b0e54ea368e91570abfd5  lean/FirstPassageLinearTransport/PaperDependencyAudit.lean
0a64ce9a5c993b4fda8b0dfa81d612d524479324c82dcc49c439191d1d3313f4  lean/FORMALIZATION.md
```

## 8. Decision

The streamlined manuscript preserves the optimized headline cone and restores
one nonredundant theorem without restoring its former standalone section.
The time--descent tradeoff and its geometric mechanism are now visible to
referees, while the fixed-depth pullback remains explicitly independent of the
fixed-polylogarithmic proof.  The formal library may remain a conservative
superset of the manuscript.
