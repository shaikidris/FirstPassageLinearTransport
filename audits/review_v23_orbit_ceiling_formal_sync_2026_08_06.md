# V2.3.1 Corollary 1.3 orbit-ceiling formal synchronization audit

## Status-change card

- **Literal statement before:** the manuscript proved that, for separately
  fixed `beta > 0`, the `6.953 log n` shortcut witness could be selected so
  that every shortcut iterate through the witness is at most `n^(1+beta)`.
  The public Lean API exposed the clock and landing but not their conjunction
  with this all-prefix ceiling.
- **Literal statement after:** one public Lean theorem returns one
  natural-density-one set and one witness `k` carrying all three conclusions:
  the `6.953 log n` clock, the stretched-logarithmic landing, and
  `forall j <= k, orbit j n <= n^(1+beta)`.
- **Exact logical difference:** no manuscript theorem was strengthened or
  weakened.  A paper-proved conjunct was promoted from an audited manuscript
  result to a literal formal public declaration.
- **Paper proof location:** Corollary 1.3, equations (6.21)--(6.24), in
  `paper/collatz_first_passage_natural_density.md`.
- **Quantifier audit:** `delta` and `beta` are separately fixed and positive;
  the retained set may depend on both.  The ceiling ends at the selected
  witness and makes no assertion after it.
- **Formal declaration:**
  `QuantitativeCollatzMain.collatz_first_passage_stretched_log_descent_with_orbit_ceiling`
  in `Main.lean`, backed by `firstPassageLinearTransportOrbitCeiling` in
  `OrbitCeiling.lean`.
- **Public surfaces affected:** `Main.lean`, `FORMALIZATION.md`, both paper
  audit modules, the manuscript disclosure, README, and `proof-state.md`.

## Formal proof decomposition

1. `orbit_le_one_add_eta_of_le_stageLength` applies the already-proved
   maximal-barrier envelope at every prefix of a nonstartup stopped block;
   the startup branch has length zero.
2. `stageMap_rpow_one_add_eta_le` combines the one-stage contraction with
   `eta <= 1`, costing at most `stageK^2` while preserving the exponent
   `1+eta`.
3. `orbit_le_stageClock_ceiling` inducts over stopped blocks and proves the
   exact all-prefix bound
   ```text
   orbit j n <= stageK^(2R) * n^(1+eta)
   ```
   for every `j <= stageClock p R n`.
4. `eventuallyShellOrbitCeiling` uses
   `R <= omega log(M+4)` and the dyadic-shell lower bound
   `M log 2 <= log n`.  Since `eta < beta`, logarithmic growth of
   `stageK^(2R)` is eventually at most `(beta-eta) log n`, giving the desired
   `n^(1+beta)` ceiling.
5. `firstPassageLinearTransportOrbitCeiling` selects
   `eta < min(r-a0,beta)`, reuses the proved density, landing, and clock
   estimates, and retains the literal cumulative stage clock as the common
   witness for all three conjuncts.

No empirical input, independence premise, fixed-time endpoint theorem, or
post-witness orbit claim is introduced.

## Referee-facing semantic surface

`Main.lean` now displays, before its public declarations, the exact piecewise
shortcut and raw Collatz maps, their iterate conventions, the missing-count
definition of natural density one, and the literal meanings of the stretched
and fixed-power descent predicates.  This is a non-semantic packaging
clarification: the underlying definitions and every public theorem type are
unchanged.  The same dictionary is mirrored in `FORMALIZATION.md`, while the
manuscript disclosure explicitly records that these are concrete definitions
rather than hypotheses supplied to the formal results.

## Verification record

- `lake build FirstPassageLinearTransport.OrbitCeiling`: passed.
- `lake build FirstPassageLinearTransport.Main
  FirstPassageLinearTransport.PaperDependencyAudit
  FirstPassageLinearTransport.PaperAudit`: passed.
- Full default `lake build`: passed for all 33 retained V2 modules.
- The synchronized manuscript PDF was regenerated as a 17-page tagged A4
  document.  Visual inspection of the title page, disclosure page, and final
  page found no clipping, overlap, or malformed displayed mathematics.
- Declaration/source audit after promotion:

```text
PAPER_GRAPH_ROOTS                         48
PAPER_KERNEL_PROJECT_DECLARATIONS        470
PAPER_KERNEL_PROJECT_MODULES              31
PAPER_COMBINED_PROJECT_DECLARATIONS      470
PAPER_COMBINED_PROJECT_MODULES            31
PAPER_GRAPH_IMPORTED_MODULES              31
PAPER_SOURCE_REFERENCE_EDGES            3248
MAIN_FILE_THEOREMS                         9
PUBLIC_TERMINAL_ROOTS                     49
RETAINED_PROJECT_THEOREMS                427
RETAINED_SOURCE_THEOREMS                 317
MAIN_REACHABLE_PROJECT_DECLARATIONS      471
MAIN_UNREACHABLE_PROJECT_THEOREMS         64
MAIN_UNREACHABLE_SOURCE_THEOREMS          18
```

All five source theorems in `OrbitCeiling.lean` are reachable from the
declared referee-facing roots.  The reverse complement decreased from 19 to
18 source theorems because the public all-prefix proof consumes an existing
support theorem that was previously terminal.

`PaperAudit.lean` reports only `propext`, `Classical.choice`, and
`Quot.sound` for the new internal milestones and public theorem.  It reports
no project axiom, `sorryAx`, `native_decide`, or enlarged trust mechanism.

## Verdict

`PROVED-PAPER / PROVED-FORMAL / SYNCHRONIZED`.  The public Lean API now
matches every mathematical conjunct in Corollary 1.3.  The theorem is an
intermediate-prefix statement through the chosen witness, not a global orbit
ceiling.

Synchronized artifact hashes before the proof-state record was updated:

```text
8ee564516cace4c061504f4f95817b829ce6f980eb04568a3c1a71b31fc440ee  paper/collatz_first_passage_natural_density.md
d71f093503a7cc19d3fffdfc76368c895fc039351b05b27d63a6322dbf9a44ee  paper/collatz_first_passage_natural_density_v2.pdf
```
