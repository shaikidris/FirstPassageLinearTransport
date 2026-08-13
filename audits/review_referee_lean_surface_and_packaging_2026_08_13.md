# Referee-facing Lean declaration surface and packaging audit

## Scope

This audit reuses `PaperDependencyAudit.lean`, `PaperAudit.lean`,
`TimeoutEndpointAudit.lean`, and the earlier paper-to-Lean synchronization
passes.  It does not reassess proved mathematics from scratch.  Its questions
are narrower:

1. Which declarations should a referee meet first?
2. Which modules are genuinely in those declarations' proof terms?
3. Which imported modules are packaging debt rather than theorem dependency?
4. Which theorems, definitions, structures, and opaque declarations inside a
   mixed module actually feed those retained roots?
5. Which manuscript claims still lack one literal public Lean declaration?

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
generic scalar conversion was defined in one of them.  The fixed two-regime
route now builds through `FirstPassageLinearTransportLegacy`; the all-prefix
route builds through `FirstPassageLinearTransportAlternates`. Neither belongs
to the canonical default library.

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

## Two-resolution audit

The earlier module-only report was insufficient.  An imported file can contain
one necessary scalar and twenty declarations from an obsolete route.  The
audit now uses two distinct graphs:

1. the module import graph, including `.ilean` source-elaboration edges; and
2. the declaration dependency graph, rooted separately at the 11 public
   `Main` declarations and the named manuscript cut vertices.

The declaration pass includes source-declared definitions, theorems, opaque
declarations, and inductive types.  Compiler-generated eliminators such as
`recOn`, `casesOn`, and `noConfusion` are excluded from the primary-source
count. `audits/partition_lean_reachability.py` combines that compiled result
with the recursive import graph and exact source ranges, emits the reproducible
manifest, and performs rollback-protected moves. “Outside” means outside the
declared retained cones; environment attributes and clean reconstruction are
additional reachability gates, so kernel unreachability alone never authorizes
a move.

## Safe separation completed in this pass

The timeout route no longer imports the six all-prefix producer modules
`MovingEndpointProfile`, `MovingFirstBad`, `MovingLowDensity`,
`MovingLowSetup`, `MovingProfile`, and `MovingSharpProfile`.  Their Lake globs
belong to the separately built alternate library.

Two small all-prefix adapters were moved to
`Alternates/AllPrefix/LowStagePackage.lean` and
`Alternates/AllPrefix/Asymptotics.lean`.  Their theorem names and statements
were preserved.  The canonical timeout scalar consumer now imports the
neutral `TimeSupportScalars.lean`; it no longer imports the 21-declaration
`Alternates/AllPrefix/Implementation/MovingTimeSupport.lean` merely for
`movingTimeSupportConstant`.

Together with the earlier `PolylogTarget.lean` and
`AsymptoticBounds.lean` extractions, this lowers the canonical source import
closure from 97 modules at the original baseline, through 95, to 89.  The
exact combined proof/source cone is now also 89 modules: there is no remaining
import-only project module in the canonical graph.

The historical fixed two-regime parameter package, schedules, tail profile,
literal recertification run, execution, and orbit-ceiling modules have moved
to the separately built legacy library. Route-neutral material was retained
in `PolylogTerminalSchedule.lean`, `RankTransportAsymptotics.lean`,
`TerminalTailAsymptotics.lean`, `FirstPassageLandingShell.lean`, and
`TimeSupportScalars.lean`.

At declaration resolution, eleven all-prefix-only moving-low displacement,
margin, and entropy-rate declarations were moved to
`Alternates/AllPrefix/MovingLowParameters.lean`. The canonical
`MovingLowParameters.lean` is now pure: all 12 of its primary declarations
are reachable from public `Main`. Six compatibility-only projection lemmas
were moved from `TimeoutRun.lean` to
`Legacy/TimeoutRunProjections.lean`; all 28 declarations remaining in the
canonical timeout-run module are now reachable from public `Main`.

## Declaration-level result

The recursive partition is now executable, rather than a manual review list.
`audits/partition_lean_reachability.py` scans the local import graph from the
canonical, alternate, and legacy roots and consumes exact declaration
reachability and source ranges from the compiled Lean audit. Its write modes
relocate whole modules and mixed-file declarations transactionally, with
automatic rollback unless every affected library rebuilds.

The canonical import closure now contains 908 primary source declarations:

| Class | Declarations |
|---|---:|
| In the public `Main` dependency cone | 865 |
| In named manuscript cut-vertex cones only | 33 |
| Environment-registered reconstruction dependencies | 10 |
| Movable outside both retained cones | 0 |

Before the declaration-aware separation, the corresponding total was 1,142,
with 244 outside the retained cones. Thus 234 declarations have left the
canonical surface without changing a public theorem type. Fifty-eight from
the final mixed-file queue are preserved under `Extras/Unreachable/`; the
earlier alternate and legacy cuts preserve the others in their route-specific
libraries. The optional
all-prefix and legacy libraries are compiled and axiom-audited separately, so
their private dependency cones are intentionally not counted as a canonical
`Main` cone. No canonical module is now wholly outside all retained
declaration cones.

The ten retained complement declarations are `[simp]`-registered rules. A
first clean reconstruction demonstrated why they are genuine dependencies:
proof-term and `.ilean` reachability alone omitted the two Boolean-walk rules,
but later `simp` calls consumed them through Lean's environment. The harness
therefore classifies registered declarations before extraction and the clean
build is the final authority.

Whole optional implementations are now physically separate as well: nine
all-prefix modules live under `Alternates/AllPrefix/Implementation/`, and
seven historical two-regime modules live under `Legacy/Implementation/`.
The default canonical Lake target includes neither directory nor the extras
archive.

## Decision

Freeze this recursive partition as the packaging gate. Physical file count is
not the theorem count: all 89 modules in the canonical import closure are
actual dependencies of `Main`. Future declarations outside the public or
named referee roots must be placed in the extras, alternate, or legacy
library, or explicitly justified as an environment-registered reconstruction
dependency. No theorem was deleted merely because it was unreachable.

## Verification of this batch

The canonical `Main` and dependency audit build, and the separately
registered extras, all-prefix, and legacy library builds, pass after the separation. The public
theorem count and theorem types are unchanged.  The trust guards remain
green; direct axiom reports contain only `propext`, `Classical.choice`, and
`Quot.sound`.

```text
TIMEOUT_ROUTE_GUARD                     PASS
MAIN_ALTERNATE_IMPORT_GUARD             PASS
MAIN_PUBLIC_SURFACE_GUARD               PASS
PAPER_GRAPH_ROOTS                         89
PAPER_KERNEL_PROJECT_MODULES              89
PAPER_COMBINED_PROJECT_MODULES            89
PAPER_GRAPH_IMPORTED_MODULES              89
PAPER_IMPORT_ONLY_MODULES                   0
MAIN_FILE_THEOREMS                        11
RETAINED_PRIMARY_SOURCE_DECLARATIONS      908
MAIN_REACHABLE_SOURCE_DECLARATIONS        865
PAPER_ONLY_REACHABLE_SOURCE_DECLARATIONS   33
UNREACHABLE_SOURCE_DECLARATIONS            10
MOVABLE_UNREACHABLE_DECLARATIONS             0
ENVIRONMENT_REGISTERED_DECLARATIONS         10
```
