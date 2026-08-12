# First-Passage Linear Transport V3 promotion state

**Record date:** 2026-08-11
**V3 project root:** `/Users/shaik.i/research/collatz/FirstPassageLinearTransport`

**Frozen V1 repository:** `/Users/shaik.i/research/collatz/CET`
**Frozen V1 tag:** `v1.0.1`
**Frozen V1 commit:** `16766542edaf1aac67ea1ad474c1193c9c8939c9`

## Active V3 promotion

### V3.1 moving-endpoint paper promotion

The current worktree strengthens the fixed-exponent V3 theorem at the
terminal-scale endpoint.  Put

```text
kappa_* = 1 - H_2(log_3 2),
A_FP = 1 / (2 * kappa_*) = 9.9911133419....
```

For a bounded shell exponent profile `A_M`, set

```text
L_M = ceil(A_M log_2(M+2)),
Delta_M = kappa_* L_M
  - (1/2) log_2(M+2) - log_2 log(M+3).
```

The paper now proves that `Delta_M -> +infinity` gives shell failure

```text
O(2^(-Delta_M) + M^(-epsilon))
```

and hence natural-density-one descent to `C (log n)^A_M` with every shortcut
clock `c > 2/log(4/3)` and the same-witness ceiling `n^(1+beta)`.  Its explicit
endpoint specialization is

```text
C (log n)^A_FP
  (log log n)^(2 A_FP)
  (log log log n)^D,
```

for every fixed `D > 0`; an arbitrary prescribed divergent multiplier of
`log log n` is also allowed qualitatively.  The pure endpoint with a bounded
final multiplier is not claimed.

V3.1 status:

- sharp compact-regime maximal-walk prefactor:
  `PROVED-PAPER / PROVED-FORMAL`;
- moving low-parameter deterministic envelope and endpoint-rate loss:
  `PROVED-PAPER / PROVED-FORMAL`;
- critical rank-buffer profile and shell failure bound: `PROVED-PAPER`;
- moving endpoint, fixed-`A`, log-log, triple-log, and functional consumers:
  `PROVED-PAPER`;
- exact finite positive and boundary controls:
  `EMPIRICAL-SUPPORT / PASS`;
- manuscript integration, reference audit, and 25-page PDF render:
  `PASS / VISUAL PASS`;
- private repository milestone `dc7b544`:
  `COMMITTED / PUSHED`;
- fixed-`A` landing/clock/ceiling and some positive logarithmic exceptional
  exponent: `PROVED-FORMAL` by the frozen public theorem;
- exact fixed-`A` exceptional range
  `gamma < kappa_* (A - A_FP)`: `PROVED-PAPER / NOT EXPOSED IN PUBLIC LEAN`;
- sharp prefactor, moving parameters, rounded barrier, and literal endpoint-rate
  landing density: `PROVED-FORMAL / AXIOM AUDIT PASS` in internal modules;
- moving stopped run, certified shell collapse, decreasing potential, and
  `O(sqrt(M log M))` feasible-time support:
  `PROVED-PAPER / PROVED-FORMAL`;
- moving scalar natural-density assembly from a completed shell profile:
  `PROVED-FORMAL / CONDITIONAL CONSUMER`;
- moving direct first-bad transport and conditional terminal profile:
  `PROVED-FORMAL / AXIOM AUDIT PASS`;
- exact-rate sharp `q^(-1/2)` low profile, uniformly for `b >= b0 > 0`:
  `PROVED-FORMAL / AXIOM AUDIT PASS`;
- uniform moving-stage startup with `pLo.M0 <= L`:
  `LEAN-OPEN`;
- moving `Delta_M` shell-density/same-witness producer and public moving endpoint:
  `LEAN-OPEN`;
- public Lean `Main` headline: `UNCHANGED / FIXED-A ONLY`;
- pure `A=A_FP` endpoint with bounded tertiary multiplier: `NOT PROVED`.

This is a real paper theorem upgrade with its analytic producer formalized,
but not yet a fully synchronized formal headline.  No full-formalization claim
may be made until the eventual shell-density and same-witness producer
discharges the conditional profile and is connected to the moving assembly
and downstream public theorem.

Current V3.1 moving-producer synchronization snapshot:

```text
b05006a72642799a8044474ef8454462f89e78f80c135acd1ba6b922b869f436  README.md
c5bb560aeef006478521f47b528b8499f397ceef70098439e010612121bc8057  lean/README.md
e8d6f65b1d0a6103b0ec6875aceccfa81486e798109a2b66945d5c27eca84753  lean/FORMALIZATION.md
dc6ac3c667a2382d0ef9cebce169b548852438a1f7c44393beb53b34916c4bce  lean/FirstPassageLinearTransport/README.md
d5ab34546aebd63c1f2ce6bd5e5e0dd0999e08be7f6b1143a31f21431061186d  lean/FirstPassageLinearTransport/Main.lean
7539545f6e52cd0d1a5315930bb2cbb33763565a94babb8579b19e99243d0afd  lean/FirstPassageLinearTransport/SharpEntropyBarrier.lean
2d06d490579c943d3b19604f499b93c11977fe40264807cb9028aee4bf87f160  lean/FirstPassageLinearTransport/MovingLowParameters.lean
d1124c053d70a292bf9999b6b887d6affe67fdbb84de13a78445335e852f7e64  lean/FirstPassageLinearTransport/MovingLowDensity.lean
327b380fa945d33b7de1337ae9aa70c4ad551246fcd2b8c4772ae90d203ca00b  lean/FirstPassageLinearTransport/MovingTimeSupport.lean
b58030f427c9b923c1e141582a17f08f0ff387f9b0603dff4a4f7e072c795fce  lean/FirstPassageLinearTransport/MovingFirstBad.lean
b801ea266a34cf862fa54919d7f7cd3565c649aa0507fa7376bda7aff813759f  lean/FirstPassageLinearTransport/MovingProfile.lean
4aa652d7a30b8b44299dbfe0c4e2b6d8147e3b3ef46c627fcff20d2dbc4f280e  lean/FirstPassageLinearTransport/MovingEndpointScalars.lean
52ab2f3a00492728f9dfc32a99578d919a0e15601ebfca6281aced6c71b38c00  lean/FirstPassageLinearTransport/MovingEndpointAssembly.lean
7259e7352ced99704f0b7c6b2df4bb97de632727d77d3dc48798a63d25065b8b  lean/FirstPassageLinearTransport/MovingEndpointAudit.lean
688ad6c3d41b55b7a215a383c163edc90bb4429ec6e27281f0870eea17baeeba  lean/FirstPassageLinearTransport/PaperAudit.lean
799e279050c4705eae556d3ebe0de0a9a3b0795a7ffe3648cb9ed0e6b9fbe2bc  lean/FirstPassageLinearTransport/PaperDependencyAudit.lean
66d66e24ddbf3230c66fbfd7eebe8b36dfb2ddd51a7edbd1db9f57a8fbfbe49d  paper/collatz_first_passage_natural_density.md
c88068d4de2f93084f185cad9d221885619d784632f1bc7ccaaac0e524d8635a  paper/collatz_first_passage_natural_density_v3.pdf
acd0a18f10889f9789c2b5a038e8ceb3d0d893e48e1684bfb685741d919e4606  paper/render_first_passage_v3_manuscript.sh
1246951beec3364321a8b5aaf72f44aa4bff4221ff257bf04e403543272987dd  audits/review_v31_moving_endpoint_promotion_2026_08_11.md
655f06b652483487c5d2e31cc1ae7ea828c40ec5c62cb49a06d38ba7df6c8ff6  audits/audit_paper_lean_semantics.py
74465e904c846b4cbd695c5a6af8236521fe22d42705b8f0223d37ae82ad5abf  audits/paper_lean_semantic_concordance_2026_08_12.md
```

### Frozen V3.0 fixed-exponent baseline

The V2.3.1 paper and public Lean API at commit `2816871` remain the frozen
baseline.  The private branch `v3-fixed-polylog` promotes a new paper headline.
Its immutable referee snapshot is commit
`e382a241e73ac2f0a958b7411f7778584f3dc48d`:

```text
T_min(n) <= C (log n)^A
for every fixed A > 9.9911133419...,
with every shortcut clock c > 6.9521189935...
and O(X / (log X)^kappa) exceptions.
```

Paper status:

- shrinking-time-support fixed-polylogarithmic proof:
  `PROVED-PAPER / PROVED-FORMAL / SYNCHRONIZED / RE-AUDIT PASS`;
- stretched-log landing/ceiling and strict sub-endpoint rates:
  `PROVED-PAPER / PROVED-FORMAL / SYNCHRONIZED`;
- exact stretched-log exceptional endpoint:
  `PROVED-PAPER / NOT EXPOSED IN PUBLIC LEAN`;
- shrinking-time-support cut-vertex reconstruction: `PASS`;
- prior fixed-tolerance freeze audit: `PASS / HISTORICAL`;
- streamlined 23-page headline cone with isolated graded appendix, proof-architecture figure, PDF render,
  and visual audit: `PASS`;
- probabilistic/deterministic interface, Version-1 lineage, and current
  Tao-bridge comparison: `PASS / NONSEMANTIC EXPOSITION`;
- referee-flow constants explanation, target-only containment qualification,
  and statement-level path-ceiling comparison: `PASS / NONSEMANTIC EXPOSITION`;
- fixed-parameter manuscript dependency roots: `PASS / 58 ROOTS`;
- moving analytic producer axiom roots: `PASS / SEPARATE AUDIT`.

V3 formal status:

- exact loss-filtered tagged fiber and target transport: `PROVED-FORMAL`;
- nested direct first-passage collapse: `PROVED-FORMAL`;
- exact loss concatenation and threshold rescaling: `PROVED-FORMAL`;
- finite all-block rank-scaled loss budget: `PROVED-FORMAL`;
- exact cosh optimizer and binary-entropy barrier rate: `PROVED-FORMAL`;
- adjustable barrier's deterministic orbit-envelope socket, including the
  affine-correction startup inequality: `PROVED-FORMAL`;
- adjustable barrier eventual-startup and entropy-sharp bad-shell adapter:
  `PROVED-FORMAL`;
- exact finite first-bad rank union and its target-by-target transport bound:
  `PROVED-FORMAL`;
- literal stopped-map blocks initialize and extend the certified rank chain,
  and generated chain witnesses inject into the first-bad envelope:
  `PROVED-FORMAL`;
- whole-run induction from the recursive certified algorithm, including exact
  bad-endpoint membership in the landing target: `PROVED-FORMAL`;
- linear-rank exponential tail summation and the generated first-bad terminal
  profile: `PROVED-FORMAL`;
- finite two-regime recursive assembly, canonical horizon, and first-bad
  execution theorem: `PROVED-FORMAL`;
- polylogarithmic terminal/switch schedule ordering, eventual distortion
  startup, and asymptotic two-regime shell-clock socket: `PROVED-FORMAL`;
- quantitative terminal/switch tail decay, the complete shellwise
  `O((M+2)^(-kappa))` first-bad profile, and assembly of the canonical shell
  good sets into one natural-density-one set: `PROVED-FORMAL`;
- exact dyadic shell-to-prefix summation, the resulting quantitative
  exceptional count, and its conversion from the explicit base-two scale to
  the manuscript's natural-logarithm normalization: `PROVED-FORMAL`;
- exact entropy-endpoint identity for `A_FP`, the clock identity for `c_*`,
  and existence of a complete rational two-regime parameter package with a
  positive retained exponent for every strict paper parameter triple:
  `PROVED-FORMAL`;
- terminal-witness/clock API, natural-logarithm target conversion, mixed-run
  orbit-ceiling propagation, and the assembled fixed-polylogarithmic theorem:
  `PROVED-FORMAL`;
- referee-facing fixed-polylogarithmic public `Main` theorem:
  `PROVED-FORMAL / PROMOTED`; its direct witness-set `badCount` now matches
  the manuscript literally, with a stronger strict landing inequality.
- support-sensitive arbitrary-target transport on an explicit finite set of
  cumulative times: `PROVED-FORMAL`;
- literal shrinking-barrier re-certification, including rank-dependent
  certification and no use of a bad endpoint as a certified source:
  `PROVED-FORMAL`;
- feasible cumulative-time support of size `O(sqrt(M log M))`:
  `PROVED-FORMAL`;
- half-power terminal-tail loss and the exact entropy endpoint
  `1 / (2 * (1 - H_2(log_3 2)))`: `PROVED-FORMAL`;
- strict parameter package, quantitative shell/prefix profile, literal
  terminal witness, same-witness orbit ceiling, and natural-density-one
  assembly at every `A > 9.9911133419...`: `PROVED-FORMAL / PROMOTED`.

Current shrinking-time-support synchronization snapshot:

```text
f01c074c5732442eceb0e483b086a471f40fc8829156676dfa0fe27216308bef  lean/FirstPassageLinearTransport/Main.lean
9eef36aacff3120a52ae963886b1f58d8fd43937fd9001254871bbfa489fb04f  lean/FirstPassageLinearTransport/TimeSupportTransport.lean
0ea827b5058266e5d8cc2ea9d6dc514dc83b007a8ff0dca0012b3d7fc6674fbf  lean/FirstPassageLinearTransport/ShrinkingSchedules.lean
6a256b83ed132647dc6260569cbf7ce5ad4362f1e0aeead0915087b0be304995  lean/FirstPassageLinearTransport/ShrinkingPolylogProfile.lean
181150a366cc9e0ed0e6fc844befdbcac76006d68efe96a53388c5b3114d5be7  lean/FirstPassageLinearTransport/ShrinkingParameters.lean
5d66163e7734e797168b460fbda5c4e0780e8695f323781c8d865d0051b7a8b2  lean/FirstPassageLinearTransport/ShrinkingNaturalDensityDescent.lean
2530e520615630756944f1d1f6ba9f01f4fbe2f73ca6c8541873d0cec12a8ae7  paper/collatz_first_passage_natural_density.md
84880b296a1d61379a7319967653bc0b874d7eeeb87ef179d727e72ce2f94ef7  paper/collatz_first_passage_natural_density_v3.pdf
cdb8aaffa384f68f84d1ff0dc1e4498234bf97e43d4317c21ea3f2d912b5de17  paper/fig-architecture.svg
8a731b16bceacecc9bf63e90f828d753c720c9842f2c2b13cfdc336a99b86477  paper/make_architecture_figure.py
fa5d2f046b24b812e94a8fb400c411e6742b8a38ac973428a84ed4683a8faeee  lean/FirstPassageLinearTransport/PaperAudit.lean
12229761cf259e9f118420210cfd5676aef0c9d1cf9b0e54ea368e91570abfd5  lean/FirstPassageLinearTransport/PaperDependencyAudit.lean
0a64ce9a5c993b4fda8b0dfa81d612d524479324c82dcc49c439191d1d3313f4  lean/FORMALIZATION.md
5e66cdc19a306386342fd783260c0453b5c182d6db9ca3eabb886b7b2bf3e414  audits/review_time_support_formal_sync_2026_08_08.md
690c0259ee7fae236b02cd7d708e49f79bb10eaad7624ee7af65f73339401863  audits/review_methodological_interface_exposition_2026_08_09.md
5988cbd57c4b44c2e0fa9d7fb477f24d79f2848d460953b95c399fe2503c71b1  audits/review_v3_streamlined_headline_cone_2026_08_09.md
```

The final 2026-08-09 streamline keeps the optimized chain as the sole
headline dependency cone.  It restores the graded fixed-power clock
only as a compact independent companion, deriving its one-step density update
from the retained loss-filtered transport proposition rather than restoring
the former standalone unfiltered-transport section.  It exposes the exact
probabilistic/deterministic interface,
records the Version-1 lineage at `10.5281/zenodo.21851173`, and identifies the
2026 Allikvere and Mazur arbitrary-diverging results as Tao-to-natural-density
bridges.  The headline theorem statements, proofs, constants, and public Lean
declarations are unchanged.  The paper-facing dependency and axiom audits
name the streamlined headline roots together with the isolated graded
companion; see
`audits/review_v3_streamlined_headline_cone_2026_08_09.md`.

The 2026-08-10 referee-flow pass explains the origins and proof status of
`c_*` and `A_FP` at first use, distinguishes the two terminal profiles before
their consumers, and records the comparison qualifications explicitly:
Tao contains the fixed-polylogarithmic target only at the target/logarithmic-
density level; the cited arbitrary-threshold headline statements do not state
the present same-witness ceiling; and no optimality or intrinsic-map status is
claimed for the proof threshold `A_FP`.  These edits change no theorem,
dependency root, or Lean declaration.

Prior fixed-tolerance private-freeze snapshot (historical):

```text
922369796b76f92d9b2bd3d9e276727b321dd99e58117d65987c2b8025c883e7  lean/FirstPassageLinearTransport/Main.lean
5427f88dd207682794c0dbf7b70ddf64010ffa68e4604f3a8e8d7e92c5ae6d2f  lean/FirstPassageLinearTransport/FiniteStartup.lean
f899f326f4c1f2eddcd856d55a897436f4086bdfa01b8c024ff30e7ecf86ff2a  paper/collatz_first_passage_natural_density.md
49c95525cb84ee69a216f142bfbc1d5a1b4d922dfc2a7b0779f9e20a82514f92  paper/collatz_first_passage_natural_density_v3.pdf
968653e5dd407e95a9f874972be80402efa5dc9e09d120756f16a7454a77d3b0  paper/first_passage_v3_print.css
55595c6d8ab9aa95b3bf15ec69393cbc4c5883777365042dfc0c5c3522d100a1  paper/render_first_passage_v3_manuscript.sh
77feb8dc2fba9e2bf177a019fb337e85b2c8bf2af11edf20d83594ca7741d200  audits/review_v3_fixed_polylog_freeze_2026_08_07.md
d71f093503a7cc19d3fffdfc76368c895fc039351b05b27d63a6322dbf9a44ee  paper/collatz_first_passage_natural_density_v2.pdf
```

The later shrinking-time-support promotion changes the theorem endpoint and
supersedes this historical snapshot. Its paper/Lean boundary is recorded in
`audits/review_time_support_formal_sync_2026_08_08.md`.

The paused LC.28 suffix route is not a dependency. Its sole positive resume
target is the centered branch-balance estimate

```text
sum_d sqrt(2^u / |J_(u,d)|)
  * (I_(u,d) / A_(u,d) - 2^(-d)) <= C / u.
```

This is the aggregate collision-weighted defect BB.1/PA.5 recorded in the V3
audit; pointwise balance in every terminal class is not required. The sole
negative resume condition is an inheritable prior-good family with pressure
at least `1 + c`. Finite pressure scans, injectivity alone, primitive
immigration, and arbitrary-input moment estimates do not reopen the route.

## Frozen boundary rule

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

Historical V2.3 synchronized paper/formal snapshot:

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

V2.3.1 synchronized Corollary 1.3 orbit-ceiling snapshot:

```text
8ee564516cace4c061504f4f95817b829ce6f980eb04568a3c1a71b31fc440ee  paper/collatz_first_passage_natural_density.md
d71f093503a7cc19d3fffdfc76368c895fc039351b05b27d63a6322dbf9a44ee  paper/collatz_first_passage_natural_density_v2.pdf
02c35702910adee223c5f3529e341522e4d0262fa089621bc281535aa298f527  paper/first_passage_v2_print.css
762802f5c6885d35c40f227c5cd4c9b2b880f57e07ff7389aaa14bfbc834ddf0  paper/render_first_passage_v2_manuscript.sh
6aa2b661b00e3b581d4ce5fe96972d94c5a65d42c3906b1191fe47ece3c9a571  audits/review_v23_orbit_ceiling_formal_sync_2026_08_06.md
f665bd5fc294c025a5f74fd1f4ee9c39a2d5815dd3d98fcba9964bab710bec86  lean/FirstPassageLinearTransport/Main.lean
3bfc6b8b4801f900912e91569a38a9d524ff0896917f281110b6d7eae9b1ce6e  lean/FirstPassageLinearTransport/OrbitCeiling.lean
ac13d48f617a399d1f395f7edb026111f6241632113512524c2f2b2b8a4dbedd  lean/FirstPassageLinearTransport/QuantitativeNaturalDensityDescent.lean
a3f8c4ae196682a40f43fd5ecfcb539e8485fa2dddb9837c9764c9bb997794f1  lean/FirstPassageLinearTransport/RawNaturalDensityDescent.lean
0c80971eb9f14c88910b6652ffe40df60cadde3570b3bac1e9d77eda1de39f90  lean/FirstPassageLinearTransport/GradedPowerDescent.lean
```

Paper proof-state:

- V3.1 moving-endpoint manuscript audit:
  `ACCEPT / COMMITTED PRIVATE / PUBLIC LEAN PROMOTION PENDING`;
- frozen fixed-exponent manuscript-only mathematical audit: `ACCEPT`;
- literature audit: `PASS WITH BOUNDED PRIORITY SCOPE`;
- formal proof-assistant evidence for the fixed-`A` specialization and existing
  companions: `FULL BUILD PASSED`;
- formal proof-assistant evidence for the V3.1 moving headline:
  `INCOMPLETE / ANALYTIC PRODUCER, TIME SUPPORT, AND CONDITIONAL ASSEMBLY
  FORMALIZED / FIRST-BAD PROFILE ADAPTER OPEN`;
- timed fixed-power Corollary 1.5: `PROVED-ON-PAPER / PROVED-FORMAL / SYNCHRONIZED`;
- fixed-`A` landing part of Corollary 1.2:
  `PROVED-ON-PAPER / PROVED-FORMAL`;
- moving/log-log/triple-log parts of Theorem 1.1 and Corollary 1.2:
  `PROVED-ON-PAPER / ANALYTIC PRODUCER AND TIME SUPPORT PROVED-FORMAL /
  PUBLIC ASSEMBLY OPEN`;
- Theorem 1.3 literal landing/ceiling and every strict exceptional power below
  `1-delta`: `PROVED-ON-PAPER / PROVED-FORMAL`;
- Theorem 1.3 exact exceptional power `1-delta`:
  `PROVED-ON-PAPER / NOT EXPOSED IN PUBLIC LEAN`;
- raw-clock refinement: `PROVED-ON-PAPER / PROVED-FORMAL / SYNCHRONIZED`;
- graded fixed-power clock: `PROVED-ON-PAPER / PROVED-FORMAL / SYNCHRONIZED /
  INDEPENDENT COMPANION`;
- Theorem 1.3 intermediate-orbit ceiling:
  `PROVED-ON-PAPER / PROVED-FORMAL / SYNCHRONIZED`;
- endpoint `delta = 1`: `NOT CLAIMED`;
- global or first-priority claim: `NOT MADE`.

## Formalization triage

**Classification:** `CLOSURE FOR THE FROZEN FIXED-A CHAIN / MOVING ANALYTIC
PRODUCER AND TIME SUPPORT FORMALIZED / PUBLIC V3.1 EXTENSION PENDING`.

Lean closes the frozen fixed-`A` paper dependency chain and now separately
formalizes the sharp-prefactor, moving landing-density producer, moving
feasible-time support, direct first-bad transport, and the exact-rate
conditional `q^(-1/2)` terminal profile. It does not yet close the V3.1 moving
headline: uniform low-stage startup and an eventual `Delta_M` shell-density
and same-witness producer must still discharge the profile hypotheses, and
`MovingEndpointAssembly.lean` remains a conditional consumer.
A successful build of these modules must not be described as formal
verification of the complete stronger theorem.

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
12. `OrbitCeiling.lean`: the blockwise all-prefix envelope, absorption of its
    polynomial startup factor, and the same-witness clock/landing/ceiling
    theorem;
13. `Main.lean`: minimal literal referee-facing API;
14. `SharpEntropyBarrier.lean`, `MovingLowParameters.lean`,
   `MovingLowDensity.lean`: sharp-prefactor and moving target-density producer;
15. `MovingTimeSupport.lean`: literal moving stopped run, certified-shell
   collapse, decreasing low-rank potential, and square-root feasible-time
   support;
16. `MovingFirstBad.lean`, `MovingProfile.lean`: direct moving first-bad
    transport and the conditional support-sensitive terminal-profile socket;
17. `MovingSharpTail.lean`, `MovingSharpProfile.lean`: exact-rate
    `q^(-1/2)` tail summation and the conditional sharp first-bad profile;
18. `MovingEndpointScalars.lean`, `MovingEndpointAssembly.lean`: scalar
   density assembly and conditional moving consumer;
19. `PaperDependencyAudit.lean`, `PaperAudit.lean`,
   `MovingEndpointAudit.lean`: fixed-parameter reachability, public trust, and
   internal moving-producer trust reports.

The exact manuscript map is `lean/FORMALIZATION.md`.  The public timed theorem
is
`FirstPassageLinearTransport.QuantitativeCollatzMain.collatz_first_passage_stretched_log_natural_density_descent`;
its type exposes the iterate witness, landing inequality, and `6.953 log n`
clock literally.
The additional public fixed-power theorem is
`FirstPassageLinearTransport.QuantitativeCollatzMain.collatz_first_passage_fixed_power_natural_density_descent`.
The public quantitative, raw-clock, graded-clock, and all-prefix orbit-ceiling
theorems are the corresponding `collatz_first_passage_*` declarations mapped
in `lean/FORMALIZATION.md`.  In particular,
`collatz_first_passage_stretched_log_descent_with_orbit_ceiling` exposes the
clock, landing, and `orbit j n <= n^(1+beta)` for every `j <= k` using the same
witness `k`.

## Lean acceptance gates

The formalization is complete only when:

1. every paper cut vertex has a named Lean declaration;
2. an unqualified clean `lake build` succeeds for every retained module in
   the independent V3 package; targeted root builds do not replace this gate;
3. the V3 source contains no `sorry`, `admit`, `axiom`, `unsafe` proof
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
11. the manuscript render passes `audits/audit_paper_lean_semantics.py`,
    including its constants, offsets, normalization, status, label, and
    anchor checks.

Current 2026-08-12 maintenance result: the exact-rate sharp tail and its
conditional moving consumer typecheck, and their direct `#print axioms` audit
contains only Lean's standard axioms.  The semantic gate passes 34 literal
contracts and 14 mapped declarations, and the synchronized 25-page PDF render
passes.  The standard Lake target entered an anomalous full Mathlib cache
replay and was stopped without a project error; the uninterrupted
full-package Lake gate remains required before release-candidate status.

## Final Lean audit record

The clean source reconstruction and the subsequent stable-source confirmation
build both passed with Lean `v4.15.0` and the Mathlib revision pinned in
`lean/lake-manifest.json`.  The V3 headline chain and isolated graded
companion are both in the default target.  The build log contains upstream
Mathlib doc-string warnings and non-failing `ring_nf` suggestions.

Direct `PaperDependencyAudit` output:

```text
PAPER_GRAPH_ROOTS                         58
PAPER_KERNEL_PROJECT_DECLARATIONS        832
PAPER_KERNEL_PROJECT_MODULES              66
PAPER_COMBINED_PROJECT_DECLARATIONS      832
PAPER_COMBINED_PROJECT_MODULES            66
PAPER_GRAPH_IMPORTED_MODULES              68
PAPER_SOURCE_REFERENCE_EDGES            7221
MAIN_FILE_THEOREMS                        10
PUBLIC_TERMINAL_ROOTS                     57
RETAINED_PROJECT_THEOREMS                840
RETAINED_SOURCE_THEOREMS                 637
MAIN_REACHABLE_PROJECT_DECLARATIONS      833
MAIN_UNREACHABLE_PROJECT_THEOREMS        205
MAIN_UNREACHABLE_SOURCE_THEOREMS         116
```

The larger source reverse-reachability complement reflects the conservative
package import surface: legacy standalone V2 declarations remain available
beside the V3 theorem family.  It is reported for review and is not counted as
part of the headline dependency chain.  Every manuscript root is listed
positively in the 58-root map above.

Direct `PaperAudit` output for every mapped milestone and all public theorems
contains only Lean's standard axioms `propext`, `Classical.choice`, and
`Quot.sound`.  It contains no project axiom, `sorryAx`, `native_decide`, or
other enlarged trust mechanism.

Direct `MovingEndpointAudit` output for the sharp binomial prefactor, moving
parameter rate, literal landing-density producer, moving time-support theorem,
direct first-bad transport, exact-rate sharp conditional profile, scalar shell
assembly, and conditional moving consumer has the same standard-axiom set and
no enlarged trust mechanism. This trust result does not fill uniform moving
startup or the remaining `Delta_M` shell-density and same-witness producer.

## Ledger

```text
CET V1 tag and commit                         FROZEN
V2 manuscript theorem chain                   V2.3.1 PROVED-PAPER / PROVED-FORMAL / SYNCHRONIZED
V2 reproducible PDF                           V2.3.1 VERIFIED / 17 A4 PAGES / VISUAL PASS
V2 standalone repository                      PRIVATE VERIFIED / MAIN / V2.3.1 SYNCHRONIZED
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
V2 graded-clock formula                        PROVED-ON-PAPER / PROVED-FORMAL / PROMOTED AS V3 COMPANION
V2 raw clock below 10.44 log n                 PROVED-PAPER / PROVED-FORMAL / SYNCHRONIZED
V2 Corollary 1.3 all-prefix orbit ceiling      PROVED-PAPER / PROVED-FORMAL / SYNCHRONIZED
V2 explicit diagonal target                    OPEN / PARKED FOR UNIFORM CONSTANTS
V2 CET-style module and public-API standard    PASS
V2 referee-facing semantic dictionary          PASS / CONCRETE DEFINITIONS
V2 placeholder/forbidden-import scan           PASS
V2 declaration/source dependency audit         PASS / 48 ROOTS / 31 MODULES
V2 reverse-reachability complement             18 RETAINED STANDALONE API THEOREMS
V2 public axiom audit                          PASS / STANDARD LEAN AXIOMS ONLY
V2 final stable-source full build              PASS / 33 MODULES
V2 public release                             NOT TAGGED
```
