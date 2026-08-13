# Referee-facing Lean surface and packaging audit

## Scope

This audit reuses `PaperDependencyAudit.lean`, `PaperAudit.lean`,
`TimeoutEndpointAudit.lean`, and the earlier paper-to-Lean synchronization
passes.  It does not reassess proved mathematics from scratch.  Its questions
are narrower:

1. Which declarations should a referee meet first?
2. Which modules are genuinely in those declarations' proof terms?
3. Which imported modules are packaging debt rather than theorem dependency?
4. Which manuscript claims still lack one literal public Lean declaration?

This is a maintenance/compression pass.  It does not authorize weakening or
renaming theorem statements.

## Baseline

Before this pass:

- the source tree contained 105 Lean files, including four optional
  `Alternates/AllPrefix` wrapper files;
- canonical `Main.lean` exposed 11 public theorem declarations;
- the source import closure of `Main.lean` contained 97 project modules;
- the combined exact declaration cone contained 88 project modules;
- nine imported modules contained no declarations used by the audited paper
  roots;
- the optional all-prefix wrapper was outside `Main`, but shared imports still
  pulled several moving/all-prefix producer modules into the canonical source
  closure.

The numerical lesson is that raw file count is not the right compression
metric.  A small theorem may justifiably use many short modules.  The relevant
defects are (i) a large public surface, (ii) imported modules absent from exact
proof terms, and (iii) alternate machinery in the canonical import closure.

## Referee-facing declaration tiers

### Tier A: manuscript headline surface

These are the declarations that should ultimately be visible from the
referee-facing `Main` module:

1. Theorem 1.1, the canonical timeout moving-polylogarithmic theorem.
2. Corollary 1.2(1), the fixed-exponent polylogarithmic specialization.
3. Theorem 1.3, in its exact joint quantitative form when formalized.
4. Corollary 1.4, in its exact raw same-witness form when formalized.
5. Corollary 1.5, the quantitative fixed-power and graded-clock conclusions.

The explicit timeout compatibility alias is useful for source navigation but
is not an additional mathematical result.  The unclocked stretched-log
theorem is a derived convenience wrapper.  Neither should determine the
headline package shape.

### Tier B: important isolated paper theorems

The paper audit should continue to expose the cut vertices that a referee may
want to inspect independently:

- parity-vector bijection and exact affine iterate;
- maximal barrier and affine-envelope lemmas;
- first-passage band, reverse product, and reverse-loss fiber bound;
- arbitrary-target transport;
- decreasing-threshold direct passage and rank-scaled reverse loss;
- timeout target density and feasible-time support;
- first-bad transport and sharp rank aggregation;
- dyadic natural-density assembly;
- raw/shortcut time conversion and the graded-clock adapter.

These need not all be re-exported as top-level `Main` theorems.  They belong
in `PaperAudit.lean` and in the theorem dictionary.

### Tier C: companions and compatibility declarations

This tier contains exact but non-headline projections:

- the timeout-named compatibility alias;
- the unclocked stretched-log consequence;
- the explicit `6.953` fixed-parameter clock projection;
- literal `T_min` adapters and other convenience equivalences.

The recommended destination is a small companion or compatibility module,
not deletion.

### Tier D: alternate proof realization

The retained all-prefix moving-low proof is an independent cross-check.  Its
wrapper and axiom audit already live in `Alternates/AllPrefix`.  It must remain
outside canonical `Main` and outside the default build.  Shared neutral scalar
lemmas may be imported by both routes.

### Tier E: legacy assembly

The earlier fixed two-regime and all-prefix producer files are retained source
mathematics, but they should not enter the canonical build merely because a
generic scalar conversion was defined in one of them.  They may be moved only
after the timeout route is fully decoupled from their declarations.

## Paper-to-Lean boundaries that block aggressive pruning

The current formalization map correctly discloses four material boundaries:

1. Theorem 1.3 has separate formal projections for a same-witness
   clock/ceiling and for a strict sub-endpoint exceptional exponent.  No one
   declaration yet has the manuscript's arbitrary `c > c_*`, same-witness
   ceiling, quantitative exceptional count, and endpoint exponent
   `1 - delta` together.
2. Corollary 1.4 has a formal stretched-log raw-clock specialization, but the
   full moving-polylog raw transfer, same-witness raw ceiling, and transferred
   rates remain paper-level.
3. Corollary 1.2(2)--(3) and the arbitrary-divergent multiplier are paper-level
   specializations of the generic moving theorem rather than literal public
   declarations.
4. Theorem 5.3 is represented by checked components, not one literal capstone
   declaration with the manuscript's complete successful-witness conclusion.

Therefore the current 11-theorem `Main` surface should not simply be shortened
and declared final.  The exact manuscript theorems must first replace the
partial projections that currently stand in for them.

## First safe cleanup batch

The following dependency-neutral changes are justified:

- extract `fixedPolylogTargetConstant`, `shellClock_le_natLog`, and
  `shellPolylogTarget_le_natLog` to neutral `PolylogTarget.lean`;
- extract `eventually_sqrt_mul_log_le_linear` to neutral
  `AsymptoticBounds.lean`;
- make the timeout witness import `PolylogTarget`, not the old two-regime
  execution;
- make the timeout orbit-ceiling module import `AsymptoticBounds`, not the
  moving all-prefix orbit-ceiling module;
- remove redundant direct `Main` imports of `OrbitCeiling`,
  `TwoRegimeOrbitCeiling`, and `FiniteStartup`;
- remove superseded two-regime declarations from the canonical axiom audit;
- make the canonical Lake module list import-closed, so a clean checkout does
  not depend on stale `.olean` files.

This lowers the `Main` source import closure from 97 to 95 modules.  It does
not yet eliminate the deeper moving-profile leakage through
`TimeoutEndpointProfile -> MovingEndpointAsymptotics`.

After this batch the exact imported-but-unused remainder has seven modules:

- `MovingEndpointProfile`;
- `MovingFirstBad`;
- `MovingLowDensity`;
- `MovingLowSetup`;
- `MovingProfile`;
- `MovingSharpProfile`;
- `TwoRegimeProfile`.

They are not seven missing proofs. They are old-route source imports whose
declarations do not occur in the audited canonical proof terms.

## Next safe cut vertex

The next refactor is scalar decoupling, not bulk file movement:

1. Extract the common time-support coefficient and endpoint scalar closure
   from the moving execution modules.
2. Prove the timeout profile against those neutral scalar lemmas directly.
3. Confirm that `MovingEndpointProfile`, `MovingSharpProfile`,
   `MovingLowSetup`, `MovingFirstBad`, and their execution modules disappear
   from the canonical source closure.
4. Only then move the complete all-prefix implementation under its optional
   package.

The acceptance gate is stronger than a successful incremental build:

- clean canonical build from an empty project build directory;
- separate alternate build;
- unchanged public theorem types;
- only `propext`, `Classical.choice`, and `Quot.sound` in the axiom audit;
- zero alternate-module imports in canonical `Main`;
- zero imported-but-unused paper modules, or a documented reason for each.

## Decision

Continue systematically.  Do not delete theorem files merely to make the file
count resemble the paper page count.  First reduce the canonical import cone
and complete the literal manuscript declarations.  After those two gates, put
headline, companion, alternate, audit, and legacy modules into visibly
separate packages.

## Verification of this batch

The project build directory was moved to a recoverable temporary backup and
all canonical project modules were rebuilt from source against the pinned
Mathlib cache. The canonical build and the separately registered all-prefix
library both passed. Direct public, timeout, and alternate axiom reports
contain only `propext`, `Classical.choice`, and `Quot.sound`. The semantic
paper/Lean audit passes 47 literal contracts and 34 critical declarations.

Post-change dependency summary:

```text
TIMEOUT_ROUTE_GUARD                     PASS
MAIN_ALTERNATE_IMPORT_GUARD             PASS
MAIN_PUBLIC_SURFACE_GUARD               PASS
PAPER_GRAPH_ROOTS                         89
PAPER_KERNEL_PROJECT_MODULES              88
PAPER_COMBINED_PROJECT_MODULES            88
PAPER_GRAPH_IMPORTED_MODULES              95
PAPER_IMPORT_ONLY_MODULES                   7
MAIN_FILE_THEOREMS                        11
```

The raw source count is now 107 rather than 105 because two shared lemmas were
extracted into neutral one-purpose modules. This is an intentional increase
in physical files that decreases route coupling and the canonical import
cone. The alternate library now owns `MovingExecution` and
`MovingOrbitCeiling` explicitly.
