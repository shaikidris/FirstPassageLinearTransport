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

## Frozen paper snapshot

```text
533158a16798aed30da8eb425166059071b4ff815b7b837094851e6729253304  paper/collatz_first_passage_natural_density.md
264337560591d285da60bed86a3d42afa7fb38668b84cf73d9e3075dfeddd3bf  paper/collatz_first_passage_natural_density_v2.pdf
02c35702910adee223c5f3529e341522e4d0262fa089621bc281535aa298f527  paper/first_passage_v2_print.css
762802f5c6885d35c40f227c5cd4c9b2b880f57e07ff7389aaa14bfbc834ddf0  paper/render_first_passage_v2_manuscript.sh
```

Final paper audits:

```text
dcc1f37227c0e316b3aac4a41a5c64a6a9e2974a7169ebf6280c4f19ea4c2194  audits/review_first_passage_v2_content_2026_08_05.md
a77ad6cb391ad8164f3ef45bcde166db4dd7127a556809b03712fb131ce3dbdd  audits/review_first_passage_v2_literature_2026_08_05.md
2e487c331f875c12d153d075bc3fa4124dfc59c045047397c77ab0484a012c01  audits/review_first_passage_v2_math_text_2026_08_05.md
a627dbfc01352a6b4db6b51f2d8168ecf6e4445558a68a9b0ce17fa2bab28907  audits/review_first_passage_v2_desk_2026_08_05.md
```

Paper proof-state:

- manuscript-only mathematical audit: `ACCEPT`;
- literature audit: `PASS WITH BOUNDED PRIORITY SCOPE`;
- formal proof-assistant evidence: `FULL HEADLINE CHAIN BUILD PASSED`;
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
   `StretchedLogLanding.lean`, `ClockBudget.lean`,
   `NaturalDensityDescent.lean`: shell assembly, schedule, landing, clock,
   and internal final theorem;
8. `PowerDescent.lean`: fixed-power timed consequence;
9. `Main.lean`: minimal literal referee-facing API;
10. `PaperDependencyAudit.lean`, `PaperAudit.lean`: declaration/source
   reachability and trusted-axiom reports.

The exact manuscript map is `lean/FORMALIZATION.md`.  The public timed theorem
is
`FirstPassageLinearTransport.QuantitativeCollatzMain.collatz_first_passage_stretched_log_natural_density_descent`;
its type exposes the iterate witness, landing inequality, and `6.953 log n`
clock literally.
The additional public fixed-power theorem is
`FirstPassageLinearTransport.QuantitativeCollatzMain.collatz_first_passage_fixed_power_natural_density_descent`.

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
`lean/lake-manifest.json`.  All 24 retained V2 modules are in the default
target.  The V2 modules emit no warnings; the build log contains only upstream
Mathlib doc-string warnings and non-failing `ring_nf` suggestions.

Direct `PaperDependencyAudit` output:

```text
PAPER_GRAPH_ROOTS                         30
PAPER_KERNEL_PROJECT_DECLARATIONS        383
PAPER_KERNEL_PROJECT_MODULES              22
PAPER_COMBINED_PROJECT_DECLARATIONS      383
PAPER_COMBINED_PROJECT_MODULES            22
PAPER_GRAPH_IMPORTED_MODULES              22
PAPER_SOURCE_REFERENCE_EDGES            2149
PUBLIC_TERMINAL_ROOTS                     31
RETAINED_SOURCE_THEOREMS                 258
MAIN_REACHABLE_PROJECT_DECLARATIONS      384
MAIN_UNREACHABLE_SOURCE_THEOREMS          18
```

The 18-theorem reverse-reachability complement is classified as retained
standalone API and local simplification/support mathematics, not as part of
the headline dependency chain.  It consists of elementary zero/successor
lemmas for the shortcut, Boolean walk, and bootstrap recurrences; two direct
first-passage projection lemmas; one central-scale identity; and the
standalone convergence theorem `stageCount_tendsto_atTop`.  No optional or
experimental research branch is imported.

Direct `PaperAudit` output for every mapped milestone and all three public theorems
contains only Lean's standard axioms `propext`, `Classical.choice`, and
`Quot.sound`.  It contains no project axiom, `sorryAx`, `native_decide`, or
other enlarged trust mechanism.

## Ledger

```text
CET V1 tag and commit                         FROZEN
V2 manuscript theorem chain                   PROVED-ON-PAPER / ACCEPTED-AUDIT
V2 reproducible PDF                           VERIFIED
V2 standalone repository                      INITIALIZED / UNCOMMITTED
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
V2 timed fixed-power consequence               PROVED-FORMAL / BUILD PASSED
V2 quantitative fixed-power rate               PROVED / NEXT MANUSCRIPT REVISION
V2 smooth graded-clock formula                 OPEN / NEW WITHIN-BLOCK INPUT NEEDED
V2 raw clock below 10.44 log n                 OPEN / EXACT CLOSURE TARGET RECORDED
V2 explicit diagonal target                    OPEN / PARKED FOR UNIFORM CONSTANTS
V2 CET-style module and public-API standard    PASS
V2 placeholder/forbidden-import scan           PASS
V2 declaration/source dependency audit         PASS / 30 ROOTS / 22 MODULES
V2 reverse-reachability complement             18 RETAINED STANDALONE API THEOREMS
V2 public axiom audit                          PASS / STANDARD LEAN AXIOMS ONLY
V2 final stable-source full build              PASS / 24 MODULES
V2 public release                             NOT TAGGED
```
