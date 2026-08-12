# V3.2 full paper-to-Lean synchronization audit

Date: 2026-08-13

## Verdict

The synchronization gate passes for every theorem portion advertised as
formal. The canonical public moving-endpoint theorem is proved through the
timeout route used by the V3.2 manuscript, not through the retained all-prefix
alternate. The manuscript, formalization map, public API, dependency audit,
and axiom audits now use one explicit and qualified contract boundary.

This audit does not upgrade paper-only theorem portions to formal status.
Instead, it records those portions exactly so a referee cannot mistake formal
components for a literal capstone.

## Six-heading contract matrix

| Manuscript heading | Exact formal status |
|---|---|
| Theorem 1.1 | `PROVED-FORMAL`, with a stronger common constant and strict landing inequality. The canonical `Main` proof term consumes `timeoutEndpointLiteralNaturalDensityDescent`. |
| Corollary 1.2 | The fixed-`A` theorem with some positive logarithmic rate is `PROVED-FORMAL`. The exact full rate range, log-log and triple-log specializations, and arbitrary-divergent multiplier are paper-only specializations of the generic producer. |
| Theorem 1.3 | Lean proves a qualitative same-witness landing/clock/ceiling theorem at `6.953 log n` and, separately, an unclocked exceptional count for every strict exponent below `1-delta`. The manuscript's joint arbitrary-`c` predicate and endpoint exceptional power remain paper-only. |
| Corollary 1.4 | The raw `10.44 log n` stretched-log landing is `PROVED-FORMAL`. The full moving raw profile, same-witness raw ceiling, and transferred quantitative rates remain paper-only. |
| Corollary 1.5 | The quantitative fixed-power count, timed fixed-power consequence, and graded clock are `PROVED-FORMAL`. `orbitMinimum_le_power_iff_hasFixedPowerDescent` now checks the literal equivalence between the manuscript's `T_min` formulation and Lean's existential landing predicate. |
| Theorem 5.3 | Its finite aggregation, recursive-run, and terminal-profile components are formal. The literal real-parameter capstone and full successful-witness totalization remain paper-only. |

## Route-separation negative control

`PaperDependencyAudit.lean` fails unless all of the following remain true:

- the canonical moving theorem transitively uses the timeout natural-density
  assembly;
- it does not use the all-prefix natural-density assembly, shell producer,
  conditional profile, or moving-low startup package;
- no module below `FirstPassageLinearTransport.Alternates` occurs in the
  canonical import environment;
- `Main.lean` contains exactly its 11 source-declared public theorems.

The retained all-prefix theorem is no longer a canonical terminal root.  It is
compiled and audited through the optional
`FirstPassageLinearTransportAlternates` library.

The audit recognizes the range-free compiler helper
`HasTimedStretchedLogDescent.eq_1` as generated implementation metadata rather
than as a twelfth source-level entry.

## Current dependency report

```text
TIMEOUT_ROUTE_GUARD                     PASS
MAIN_ALTERNATE_IMPORT_GUARD             PASS
MAIN_PUBLIC_SURFACE_GUARD               PASS
PAPER_GRAPH_ROOTS                         89
PAPER_KERNEL_PROJECT_DECLARATIONS       1071
PAPER_KERNEL_PROJECT_MODULES              88
PAPER_COMBINED_PROJECT_DECLARATIONS     1088
PAPER_COMBINED_PROJECT_MODULES            88
PAPER_GRAPH_IMPORTED_MODULES              97
PAPER_SOURCE_REFERENCE_EDGES           11981
MAIN_FILE_THEOREMS                        11
PUBLIC_TERMINAL_ROOTS                     87
RETAINED_PROJECT_THEOREMS               1188
RETAINED_SOURCE_THEOREMS                 885
MAIN_REACHABLE_PROJECT_DECLARATIONS     1088
MAIN_UNREACHABLE_PROJECT_THEOREMS        363
MAIN_UNREACHABLE_SOURCE_THEOREMS         215
```

The dependency traversal indexes source references by parent declaration.
This changes only audit runtime, not the graph or reachability semantics.

## Verification

The following gates pass:

```text
python3 -B audits/audit_paper_lean_semantics.py
git diff --check
lake build
lake build FirstPassageLinearTransportAlternates
lake build FirstPassageLinearTransport.PaperDependencyAudit
```

The semantic audit reports 47 literal contracts, 34 canonical critical declarations,
101 equation labels, 88 equation references, 32 anchors, and 64 anchor
references. The placeholder scan finds no `sorry`, `admit`, project `axiom`,
`unsafe` proof escape, or `native_decide` in production Lean declarations.

`PaperAudit` and `TimeoutEndpointAudit` report only Lean's standard `propext`,
`Classical.choice`, and `Quot.sound`.  The isolated
`Alternates/AllPrefix/Audit` has the same trust footprint, as does the newly
formalized orbit-minimum adapter.

## Frozen source identities

```text
manuscript sha256  d3476ad83fa34978683a1d6124a01f7ad3a4687937bb57f4155278fad1475f89
Main.lean sha256   7376a99f0ca2c174c35a71728cb49d86bc3deccbab0cf270a494f3773e23a8ef
Basic.lean sha256  bd69548b7dc1d014cabf25e1da5a9d0127f033451c2cf92806e9698b5fd3b758
alternate Main sha256  2459ec9144d82219235596bf447baf3b944f8c1bebea2f46e164445c12d3faf5
lakefile sha256    249f08a3346b482f10c2785878dc9163a378d44d90fc71221d943abf253f8097
```

## PDF render and visual inspection

The repository render script regenerated a tagged 27-page A4 PDF and reran
the semantic gate. Its identity is:

```text
PDF sha256  f8208c6366606631fc87b52382b6cb33c9f5e17a3ed4f704473115166fe09295
```

Every page was rendered to an image and inspected in complete contact sheets;
the title page, main statements, proof-architecture figure, comparison table,
Theorem 5.3, formalization disclosure, appendix, and references were also
checked at full page resolution. No clipped or overlapping content, broken
table, black glyph, unreadable equation, missing page number, or unresolved
render token was found. Text extraction reports nonempty content on all 27
pages and no occurrences of `undefined`, `NaN`, `MathJax`, `Error`, or
`Warning`.
