# First-Passage Linear Transport

**Project line:** public first-passage transport development; Version 4
strengthening under written-proof and formalization review
**Author:** Idris Ali Shaik

**Primary preprint:** [SSRN Paper 7290240](https://papers.ssrn.com/sol3/papers.cfm?abstract_id=7290240),
DOI [10.2139/ssrn.7290240](https://doi.org/10.2139/ssrn.7290240)

**Direct full-text PDF:** [Version 3.2.4](https://shaikidris.github.io/paper/collatz-first-passage.pdf)

**Versioned manuscript archive:** [Zenodo Version 4.0.0](https://doi.org/10.5281/zenodo.22525724)

**Lean 4 software archive:** [Version 4.0.0](https://doi.org/10.5281/zenodo.22525757)

**Palomar registered formalization:**
[PALOMAR-2026-08-26-000005, version 3](https://palomar-registry.org/entry?id=PALOMAR-2026-08-26-000005&version=3)

## Version 4 strengthened release

The active revision is `4.0.0`.  It incorporates a finite ballot estimate
for the complete low-timeout event.  At the written-paper level this changes
the normalized timeout count from
`O(m^(-1/2) 2^(-kappa_* m))` to
`O(m^(-3/2) 2^(-kappa_* m))`.  The resulting theorem package gives:

- the fixed-`A` endpoint exceptional count
  `O(X / (log X)^(kappa_* A - 1/2))` for every fixed `A > A_FP`;
- the critical leading target `(log n)^A_FP U(n)` for any prescribed positive
  `U(n) -> infinity`, without a compulsory secondary logarithmic power;
- corresponding shortcut and raw witnesses at one common landing, with
  centered clocks and both trajectories bounded by `n R(n)` for any
  prescribed positive `R(n) -> infinity`;
- uniform shortcut/raw trajectory tubes and actual first-passage clocks to
  every intervening level on the same good set;
- reciprocal height obstructions showing that the balanced joint
  target-clock-height exceptional orders are sharp (without claiming a
  target-only lower bound);
- a common `n exp(zeta (log n)^(1-delta))` ceiling for the
  stretched-logarithmic companion and an exact prefix-entropy prefactor;
- a graded fixed-power companion with a power-saving exceptional count; and
- an explicit obstruction to replacing the divergent relative-height
  allowance by one fixed multiple of the starting value.

The leading exponent `A_FP = 9.9911133419...` is unchanged, and the pure
critical target `C (log n)^A_FP` is not proved.

**Verification boundary.**  These Version 4 strengthenings have complete
written proofs in the manuscript.  The Version 4 Lean release
kernel-checks the principal ballot, timeout, common-landing, centered-clock,
trajectory-profile, critical-multiplier, reciprocal-obstruction, and
stretched relative-height interfaces.  The full local build and placeholder
scan pass, and the selected-root audit reports only `propext`,
`Classical.choice`, and `Quot.sound`.  The exact prefix-entropy refinement,
the endpoint stretched-logarithmic rate with arbitrary strict clocks, the
graded-power companion, and some secondary/tertiary packaging remain outside
that checked surface.  The canonical Version 4 tag is `lean-v4.0.0`, with
software DOI `10.5281/zenodo.22525757`.  A Version 4 Palomar registration is
still pending.  The exact boundary is recorded in
`lean/FORMALIZATION.md`, `lean/V4_API_AUDIT.md`, and `proof-state.md`.

## Published and formally checked Version 3 baseline

The Version 3 baseline promoted the first-passage architecture from
stretched-logarithmic to moving polylogarithmic natural-density descent for
the shortcut Collatz map

```text
T(n) = n / 2       if n is even,
T(n) = (3n + 1)/2  if n is odd.
```

Put

```text
A_FP = 1 / (2 * (1 - H_2(log_3 2))) = 9.9911133419...,
kappa_* = 1 - H_2(log_3 2).
```

The V3.2 paper-level headline allows a bounded moving exponent `A_M` whenever
the rank buffer

```text
kappa_* ceil(A_M log_2(M+2))
  - (1/2) log_2(M+2) - log_2 log(M+3)
```

diverges to infinity.  For every shortcut clock
`c > 2/log(4/3)` and every `beta > 0`, almost every source in shell `I_M`
then has a witness `k < c log n` with

```text
T^k(n) <= C (log n)^A_M
and max_{j <= k} T^j(n) <= n^(1+beta).
```

This includes every fixed `A > A_FP`, the critical target

```text
(log n)^A_FP (log log n)^(2 A_FP) (log log log n)^D
```

for every fixed `D > 0`, and the same critical base multiplied by an
arbitrarily slowly diverging function of `log log n`.  The pure endpoint with
a bounded final multiplier is not claimed.  At the companion target
`exp ((log n)^(1-delta))`, the shell assembly reaches the endpoint exceptional
power `1-delta`. Every shortcut clock constant above `2/log(4/3)` and every
raw clock constant above `3/log(4/3)` are retained.

The streamlined V3 manuscript retains the endpoint-rate stretched-logarithmic
companion, the raw-clock conversion, the fixed-power exceptional count, and
the graded fixed-power clock.  The graded result is presented as a
compact independent companion: it records the sharp time--descent tradeoff
without entering the optimized fixed-polylogarithmic dependency chain.

The V3.2 manuscript proof is integrated.  It uses high-rank all-prefix
certification and replaces the former moving low all-prefix certificate by a
terminal odd-count timeout tail.  The Lean development compiles the
loss-filtered target transport, direct-passage collapse along decreasing
thresholds,
all-block rank-scaled loss budget, entropy-sharp Boolean barrier, complete
two-regime exceptional profile, literal terminal witness, mixed-run orbit
ceiling, endpoint parameter selection, and the referee-facing fixed-polylog
theorem in `Main.lean` for every fixed `A > A_FP`.  The sharp binomial
prefactor, moving low parameters, rounded barrier, literal moving low-rank
landing-density estimate through the endpoint rate, and uniform moving
`O(sqrt (M log M))` feasible-time support are now formalized in the internal
moving-endpoint modules. Direct moving first-bad transport and the conditional
terminal-profile socket are also formalized.  The sharp conditional socket now
retains the literal `q^(-1/2)` landing prefactor and the unchanged endpoint
rate, giving `(L+1) 2^(-L) + sqrt(L) exp(-b (L-1))`.  The quantitative
moving-stage startup, exact `Delta_M` shell profile, literal same-witness
execution, and public moving-endpoint theorem are now formalized as well.

The frozen formal package verifies the Version 3 moving-endpoint headline by two
low-phase derivations that share the endpoint parameters, scalar asymptotics,
and dyadic assembly.  The V3.2 primary route uses the manuscript's literal
first-timeout event, the sharp timeout density, a decreasing low potential,
direct first-bad transport, and exact halving of the dyadic upper endpoint.
The retained V3.1 alternate uses an all-prefix moving low producer and proves
the same literal shell exceptional profile, logarithmic clock, and
same-witness ceiling in the optional `Alternates/AllPrefix` library. It is
not imported by `Main.lean` or built by the default target. The paper's
sharper fixed-`A` rate range,
its displayed log-log/triple-log/functional specializations, the joint
quantitative predicate and arbitrary clock of Theorem 1.3, the full raw
transfer of Corollary 1.4, and the literal Theorem 5.3 capstone remain
paper-level.  The frozen V2.3.1 theorem family remains available as companion
mathematics.

## Release boundary

This project remains physically and logically separate from the released
`CET`/CEP V1 repository.  The frozen baseline is tag `v1.0.1`, commit
`16766542edaf1aac67ea1ad474c1193c9c8939c9`.  V2 neither amends that tag nor
imports its capstone theorem chain.

The repository is public and must remain public.  Work on this branch does not
by itself authorize a push, release, Zenodo update, Palomar registration, or
journal revision upload.

Before every manuscript render or release candidate, run:

```text
python3 -B audits/audit_paper_lean_semantics.py
```

The V4 render script invokes this gate automatically. It checks the fragile
paper/Lean contracts, mapped declaration presence, theorem-status wording,
and reference resolution. From `lean/`, a release candidate must also pass
the full-package gate:

```text
lake build
```

The default build is intentionally the import-closed canonical `Main` cone
plus its three audits. Its explicit module list makes a clean checkout fail
if a required source dependency is omitted and prevents every module under
the optional `Alternates/AllPrefix` namespace from entering the canonical
artifact. The alternate has its own explicit build gate. A deeper set of
seven moving-profile imports remains visible in the canonical source cone and
is the next recorded packaging cut vertex.

## Contents

- `paper/collatz_first_passage_natural_density.md`: canonical manuscript;
- `paper/collatz_first_passage_natural_density_v4.0.0.pdf`: strengthened
  Version 4 preprint render;
- `paper/render_first_passage_v4_manuscript.sh`: deterministic Version 4
  manuscript render and semantic-boundary gate;
- `paper/collatz_first_passage_natural_density_v2.pdf`: frozen V2 render;
- `paper/collatz_first_passage_natural_density_v3.pdf`: distinct V3 render;
- `paper/fig-architecture.svg`: referee-facing proof-architecture figure;
- `paper/make_architecture_figure.py`: deterministic generator and orbit check
  for the architecture figure;
- `audits/fixed_polylog_promotion_audit_2026_08_07.md`: V3 theorem and
  cut-vertex reconstruction;
- `audits/v4_strengthened_revision_ledger_2026_09_05.md`: review-response,
  N.1--N.11 integration, proof-status, and release-boundary ledger;
- `audits/audit_v4_ballot_strengthening.py`: reproducible finite checks of the
  Version 4 constants, change of measure, ballot counts, actual timeout
  implication, and multiplicative maximal inequality; diagnostic only;
- `audits/review_v31_moving_endpoint_promotion_2026_08_11.md`: V3.1 moving
  endpoint proof, scalar-budget, render, and formal-boundary audit;
- `audits/review_v32_timeout_integrated_replacement_2026_08_12.md`: V3.2
  subtractive timeout proof, endpoint-boundary, route-separation, and render
  audit;
- `audits/paper_lean_semantic_concordance_2026_08_12.md`: literal paper/Lean
  contract concordance and semantic-drift regression gate;
- `audits/review_v32_full_paper_lean_sync_2026_08_12.md`: six-heading
  paper-to-Lean contract, timeout-route negative control, dependency counts,
  trust report, and final PDF inspection;
- `audits/review_referee_lean_surface_and_packaging_2026_08_13.md`:
  referee-facing theorem tiers, exact declaration/import-cone audit, safe
  neutral-module extraction, and the remaining packaging cut vertex;
- `audits/`: manuscript-only mathematical, literature, content, and desk
  records;
- `audits/review_post_freeze_corollaries_2026_08_06.md`: downstream
  corollary audit and parked explicit-diagonal query;
- `audits/review_v23_formal_sync_2026_08_06.md`: synchronized closure audit
  for the quantitative count, raw clock, and graded clock;
- `audits/review_v23_orbit_ceiling_formal_sync_2026_08_06.md`: patch-level
  closure audit for the same-witness intermediate-orbit ceiling;
- `audits/review_v3_streamlined_headline_cone_2026_08_09.md`: optimized
  manuscript-cone, Tao-bridge comparison, formal-map, and render audit;
- `lean/`: independent minimal Lean 4 package;
- `lean/FirstPassageLinearTransport/Alternates/AllPrefix/Audit.lean`: optional
  axiom audit for the retained all-prefix moving realization;
- `lean/FirstPassageLinearTransport/TimeoutEndpointAudit.lean`: axiom audit
  for the primary V3.2 timeout realization and public theorem;
- `proof-state.md`: synchronized paper hashes, status ledger, and formalization
  acceptance gates.

The canonical moving-endpoint theorem has been reconstructed through its
timeout cut vertices.  Its public Lean theorem counts exactly the integers
lacking its displayed witness, matching Theorem 1.1 after the Lean theorem's
harmless strict landing inequality and common-constant strengthening.  The
full-package build, placeholder scan,
declaration-level dependency report, public-root trust audit, manuscript
reference audit, and distinct V3 PDF inspection are recorded separately. See
`lean/FORMALIZATION.md` and `proof-state.md` for the exact boundary.
