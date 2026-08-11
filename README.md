# First-Passage Linear Transport

**Project line:** private V3.1 moving-endpoint promotion worktree
**Author:** Idris Ali Shaik

This branch promotes the first-passage architecture from stretched-logarithmic
to moving polylogarithmic natural-density descent for the shortcut Collatz map

```text
T(n) = n / 2       if n is even,
T(n) = (3n + 1)/2  if n is odd.
```

Put

```text
A_FP = 1 / (2 * (1 - H_2(log_3 2))) = 9.9911133419...,
kappa_* = 1 - H_2(log_3 2).
```

The V3.1 paper-level headline allows a bounded moving exponent `A_M` whenever
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

The V3.1 manuscript proof is integrated. The Lean development compiles the
loss-filtered target transport, nested direct first-passage collapse,
all-block rank-scaled loss budget, entropy-sharp Boolean barrier, complete
two-regime exceptional profile, literal terminal witness, mixed-run orbit
ceiling, endpoint parameter selection, and the referee-facing fixed-polylog
theorem in `Main.lean` for every fixed `A > A_FP`.  The sharp binomial
prefactor, moving low parameters, rounded barrier, and literal moving
low-rank landing-density estimate through the endpoint rate are now
formalized in the internal moving-endpoint modules, but are not yet connected
to a public Lean theorem.  The formal package therefore
verifies the fixed-exponent landing, clock, ceiling, and a positive
logarithmic exceptional exponent, not the full V3.1 moving headline or the
paper's exact endpoint ranges for the exceptional exponent. The frozen
V2.3.1 theorem family remains available as companion mathematics.

## Release boundary

This project remains physically and logically separate from the released
`CET`/CEP V1 repository.  The frozen baseline is tag `v1.0.1`, commit
`16766542edaf1aac67ea1ad474c1193c9c8939c9`.  V2 neither amends that tag nor
imports its capstone theorem chain.

The repository must remain private. No release, visibility change, or push to
a public repository is authorized by work on this branch.

## Contents

- `paper/collatz_first_passage_natural_density.md`: canonical manuscript;
- `paper/collatz_first_passage_natural_density_v2.pdf`: frozen V2 render;
- `paper/collatz_first_passage_natural_density_v3.pdf`: distinct V3 render;
- `paper/fig-architecture.svg`: referee-facing proof-architecture figure;
- `paper/make_architecture_figure.py`: deterministic generator and orbit check
  for the architecture figure;
- `audits/fixed_polylog_promotion_audit_2026_08_07.md`: V3 theorem and
  cut-vertex reconstruction;
- `audits/review_v31_moving_endpoint_promotion_2026_08_11.md`: V3.1 moving
  endpoint proof, scalar-budget, render, and formal-boundary audit;
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
- `proof-state.md`: synchronized paper hashes, status ledger, and formalization
  acceptance gates.

The fixed-exponent V3 manuscript proof and public formal chain have been
reconstructed through all five cut vertices. The public Lean theorem counts exactly the
integers lacking its displayed witness, matching the manuscript after the
Lean theorem's harmless strict landing inequality.  The V3.1 paper extension
adds the sharp maximal-walk prefactor and moving rank buffer above that frozen
formal boundary.  The full-package build, placeholder scan,
declaration-level dependency report, public-root trust audit, manuscript
reference audit, and distinct V3 PDF inspection are recorded separately. See
`lean/FORMALIZATION.md` and `proof-state.md` for the exact boundary.
