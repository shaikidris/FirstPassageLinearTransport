# First-Passage Linear Transport V2 proof state

**Record date:** 2026-08-06  
**V2 project root:** `/Users/shaik.i/research/collatz/FirstPassageLinearTransport`  
**Frozen V1 repository:** `/Users/shaik.i/research/collatz/CET`  
**Frozen V1 tag:** `v1.0.1`  
**Frozen V1 commit:** `16766542edaf1aac67ea1ad474c1193c9c8939c9`

## Boundary rule

V2 is a new paper and new Lean software package.  It does not amend the V1
tag, consume the V1 endpoint theorem, or place new source under the V1
repository.  Any uncommitted feature work visible in the V1 worktree is out
of scope and must be preserved untouched.

## Historical V2.1 paper snapshot

```text
879c28f6998f0fc9afa235cc4181b6b9092463fc38b8bb50f207bd476a280cae  paper/collatz_first_passage_natural_density.md
557c65e961a2df89bd0366001ece025c394c837b859266d7165e876888d301ce  paper/collatz_first_passage_natural_density_v2.pdf
02c35702910adee223c5f3529e341522e4d0262fa089621bc281535aa298f527  paper/first_passage_v2_print.css
762802f5c6885d35c40f227c5cd4c9b2b880f57e07ff7389aaa14bfbc834ddf0  paper/render_first_passage_v2_manuscript.sh
```

V2.0 base-paper audits for the unchanged headline chain:

```text
dcc1f37227c0e316b3aac4a41a5c64a6a9e2974a7169ebf6280c4f19ea4c2194  audits/review_first_passage_v2_content_2026_08_05.md
a77ad6cb391ad8164f3ef45bcde166db4dd7127a556809b03712fb131ce3dbdd  audits/review_first_passage_v2_literature_2026_08_05.md
2e487c331f875c12d153d075bc3fa4124dfc59c045047397c77ab0484a012c01  audits/review_first_passage_v2_math_text_2026_08_05.md
a627dbfc01352a6b4db6b51f2d8168ecf6e4445558a68a9b0ce17fa2bab28907  audits/review_first_passage_v2_desk_2026_08_05.md
```

V2.1 synchronized Corollary 1.4 delta audit:

```text
c3d19a68b4012243a5ad3fb60079c4d180d450266ae75646f6660da2af464c73  audits/review_fixed_power_corollary_sync_2026_08_06.md
```

V2.3 synchronized paper/formal snapshot:

```text
b6af06e6cc29987e9e9a2752dfd70144daadacab9e6c159e0b10cf2d0a4a6e12  paper/collatz_first_passage_natural_density.md
caf185be4e621e596edab5150ad6af455fc5f935849ce4d5f40a34efeff2c66a  paper/collatz_first_passage_natural_density_v2.pdf
02c35702910adee223c5f3529e341522e4d0262fa089621bc281535aa298f527  paper/first_passage_v2_print.css
762802f5c6885d35c40f227c5cd4c9b2b880f57e07ff7389aaa14bfbc834ddf0  paper/render_first_passage_v2_manuscript.sh
c92a27b28cbbd31f7f6047ed801d844a9dbcfad07e1755681ee5ba28e0145081  audits/review_v23_formal_sync_2026_08_06.md
49cb1e3017b3a59956535b09af5654b65cc4b5245bf272d426171816195d4b10  lean/FirstPassageLinearTransport/Main.lean
ac13d48f617a399d1f395f7edb026111f6241632113512524c2f2b2b8a4dbedd  lean/FirstPassageLinearTransport/QuantitativeNaturalDensityDescent.lean
a3f8c4ae196682a40f43fd5ecfcb539e8485fa2dddb9837c9764c9bb997794f1  lean/FirstPassageLinearTransport/RawNaturalDensityDescent.lean
0c80971eb9f14c88910b6652ffe40df60cadde3570b3bac1e9d77eda1de39f90  lean/FirstPassageLinearTransport/GradedPowerDescent.lean
```

Paper proof-state:

- manuscript-only mathematical audit: `ACCEPT`;
- literature audit: `PASS WITH BOUNDED PRIORITY SCOPE`;
- formal proof-assistant evidence: `FULL HEADLINE AND STRENGTHENED-COROLLARY CHAIN BUILD PASSED`;
- timed fixed-power Corollary 1.4: `PROVED-ON-PAPER / PROVED-FORMAL / SYNCHRONIZED`;
- quantitative Corollaries 1.2 and 1.5: `PROVED-ON-PAPER / PROVED-FORMAL / SYNCHRONIZED`;
- raw-clock refinement: `PROVED-ON-PAPER / PROVED-FORMAL / SYNCHRONIZED`;
- smooth graded clock: `PROVED-ON-PAPER / PROVED-FORMAL / SYNCHRONIZED`;
- endpoint `delta = 1`: `NOT CLAIMED`;
- global or first-priority claim: `NOT MADE`.

## Formalization triage

**Classification:** `CLOSURE`.

Lean is used to close the accepted paper dependency chain, not as evidence for
an unfinished analytic step.  A successful build of structural fragments is
not formal verification of the headline theorem.

**Package root:** `lean/FirstPassageLinearTransport/`  
**Public module:** `FirstPassageLinearTransport.Main`

Compiled dependency order:

1. `Basic.lean`, `Density.lean`, `VaryingDensity.lean`: dynamics and density
   interfaces;
2. `Parity.lean`: parity-vector bijection and exact affine iterate;
3. `Barrier.lean`, `Envelope.lean`, `BarrierDensity.lean`: maximal Boolean
   barrier, orbit envelope, and dense initial window;
4. `FirstPassage.lean`, `Transport.lean`: reversal, rigidity, tagged fibers,
   and arbitrary-target transport;
5. `Pullback.lean`, `Parameters.lean`, `Bootstrap.lean`: stopped-map pullback,
   stage parameters, and repeated bootstrap;
6. `Scalar.lean`, `Constants.lean`, `HeadlineParameters.lean`: scalar
   asymptotics, exact constants, and strict compatible parameters;
7. `GlobalAssembly.lean`, `BootstrapSchedule.lean`,
   `StretchedExceptionalCount.lean`, `StretchedLogLanding.lean`,
   `ClockBudget.lean`, `NaturalDensityDescent.lean`: shell assembly,
   quantitative summation, landing, clock, and internal final theorem;
8. `HeightSensitiveClock.lean`, `GradedClock.lean`,
   `GradedPowerDescent.lean`: shortened first-passage horizon and smooth
   graded power clock;
9. `RawDynamics.lean`, `RawClockBudget.lean`,
   `RawNaturalDensityDescent.lean`: exact raw conversion and `10.44 log n`
   raw theorem;
10. `QuantitativeNaturalDensityDescent.lean`: literal quantitative
    stretched and fixed-power exceptional counts;
11. `PowerDescent.lean`: qualitative timed fixed-power consequence;
12. `Main.lean`: minimal literal referee-facing API;
13. `PaperDependencyAudit.lean`, `PaperAudit.lean`: declaration/source
   reachability and trusted-axiom reports.

The exact manuscript map is `lean/FORMALIZATION.md`.  The public timed theorem
is
`FirstPassageLinearTransport.QuantitativeCollatzMain.collatz_first_passage_stretched_log_natural_density_descent`;
its type exposes the iterate witness, landing inequality, and `6.953 log n`
clock literally.
The additional public fixed-power theorem is
`FirstPassageLinearTransport.QuantitativeCollatzMain.collatz_first_passage_fixed_power_natural_density_descent`.
The public quantitative, raw-clock, and graded-clock theorems are the four
corresponding `collatz_first_passage_*` declarations mapped in
`lean/FORMALIZATION.md`.

## Lean acceptance gates

The formalization is complete only when:

1. every paper cut vertex has a named Lean declaration;
2. a clean `lake build` succeeds for every retained module in the independent
   V2 package;
3. the V2 source contains no `sorry`, `admit`, `axiom`, `unsafe` proof
   escape, or unreviewed placeholder;
4. `#print axioms` for each public theorem and mapped milestone is audited;
5. a paper-to-formal map records every hypothesis, quantifier, constant, map
   convention, and density notion;
6. the public result retains `0 < delta < 1` and natural density one;
7. no V1/CEP theorem module is imported;
8. finite diagnostics are never substituted for an all-depth proof.
9. the declaration/source dependency audit is rebuilt after every module move
   or public theorem rename;
10. production files follow the CET header, semantic-module, naming, and
    documentation conventions.

## Final Lean audit record

The clean source reconstruction and the subsequent stable-source confirmation
build both passed with Lean `v4.15.0` and the Mathlib revision pinned in
`lean/lake-manifest.json`.  All 32 retained V2 modules are in the default
target.  The V2 modules emit no warnings; the build log contains only upstream
Mathlib doc-string warnings and non-failing `ring_nf` suggestions.

Direct `PaperDependencyAudit` output:

```text
PAPER_GRAPH_ROOTS                         44
PAPER_KERNEL_PROJECT_DECLARATIONS        463
PAPER_KERNEL_PROJECT_MODULES              30
PAPER_COMBINED_PROJECT_DECLARATIONS      463
PAPER_COMBINED_PROJECT_MODULES            30
PAPER_GRAPH_IMPORTED_MODULES              30
PAPER_SOURCE_REFERENCE_EDGES            3064
MAIN_FILE_THEOREMS                         8
PUBLIC_TERMINAL_ROOTS                     45
RETAINED_SOURCE_THEOREMS                 311
MAIN_REACHABLE_PROJECT_DECLARATIONS      464
MAIN_UNREACHABLE_SOURCE_THEOREMS          19
```

The 19-theorem reverse-reachability complement is classified as retained
standalone API and local simplification/support mathematics, not as part of
the headline dependency chain.  It consists of elementary zero/successor
lemmas for the shortcut, Boolean walk, and bootstrap recurrences; two direct
first-passage projection lemmas; one central-scale identity; and the
standalone convergence theorem `stageCount_tendsto_atTop`.  No optional or
experimental research branch is imported.

Direct `PaperAudit` output for every mapped milestone and all public theorems
contains only Lean's standard axioms `propext`, `Classical.choice`, and
`Quot.sound`.  It contains no project axiom, `sorryAx`, `native_decide`, or
other enlarged trust mechanism.

## Ledger

```text
CET V1 tag and commit                         FROZEN
V2 manuscript theorem chain                   V2.3 PROVED-PAPER / PROVED-FORMAL / SYNCHRONIZED
V2 reproducible PDF                           V2.3 VERIFIED / 17 A4 PAGES / VISUAL PASS
V2 standalone repository                      PRIVATE VERIFIED / MAIN / V2.3 SYNCHRONIZED
V2 Basic Lean module                          PROVED-FORMAL / BUILD PASSED
V2 parity-vector bijection                    PROVED-FORMAL / BUILD PASSED
V2 exact affine iterate                       PROVED-FORMAL / BUILD PASSED
V2 first-passage band and reverse product     PROVED-FORMAL / BUILD PASSED
V2 odd-count rigidity                         PROVED-FORMAL / BUILD PASSED
V2 tagged-fiber bound                         PROVED-FORMAL / BUILD PASSED
V2 arbitrary-target linear transport          PROVED-FORMAL / BUILD PASSED
V2 maximal-barrier and dense good set          PROVED-FORMAL / BUILD PASSED
V2 stopped-map pullback and bootstrap          PROVED-FORMAL / BUILD PASSED
V2 shell exceptional ratio convergence         PROVED-FORMAL / BUILD PASSED
V2 stretched-log landing                       PROVED-FORMAL / BUILD PASSED
V2 exact 6.953 shortcut clock                  PROVED-FORMAL / BUILD PASSED
V2 strict delta<1 parameter selection          PROVED-FORMAL / BUILD PASSED
V2 headline Lean theorem                      PROVED-FORMAL / BUILD PASSED
V2 timed fixed-power consequence               PROVED-PAPER / PROVED-FORMAL / SYNCHRONIZED
V2 quantitative stretched-log rate             PROVED-PAPER / PROVED-FORMAL / SYNCHRONIZED
V2 quantitative fixed-power rate               PROVED-PAPER / PROVED-FORMAL / SYNCHRONIZED
V2 smooth graded-clock formula                 PROVED-PAPER / PROVED-FORMAL / SYNCHRONIZED
V2 raw clock below 10.44 log n                 PROVED-PAPER / PROVED-FORMAL / SYNCHRONIZED
V2 explicit diagonal target                    OPEN / PARKED FOR UNIFORM CONSTANTS
V2 CET-style module and public-API standard    PASS
V2 placeholder/forbidden-import scan           PASS
V2 declaration/source dependency audit         PASS / 44 ROOTS / 30 MODULES
V2 reverse-reachability complement             19 RETAINED STANDALONE API THEOREMS
V2 public axiom audit                          PASS / STANDARD LEAN AXIOMS ONLY
V2 final stable-source full build              PASS / 32 MODULES
V2 public release                             NOT TAGGED
```
