# First-Passage Linear Transport

**Project line:** independent V2 manuscript and Lean 4 software  
**Author:** Idris Ali Shaik

This repository contains a new proof architecture for stretched-logarithmic
natural-density descent of the shortcut Collatz map

```text
T(n) = n / 2       if n is even,
T(n) = (3n + 1)/2  if n is odd.
```

The paper-level theorem states that, for every fixed `0 < delta < 1`, a set
of natural density one satisfies

```text
min_k T^k(n) <= exp ((log n)^(1-delta)),
```

with a witness before `6.953 log n` shortcut steps and before `10.44 log n`
raw Collatz steps.  The endpoint `delta = 1` is not claimed.

The synchronized corollaries also provide:

- the exceptional count `5 X exp (-c (log X)^sigma)` for every
  `0 < sigma < 1-delta`;
- the same form for every fixed power target `n^alpha` and every
  `0 < sigma < 1`;
- the smooth graded shortcut clock
  `(2(1-alpha)/log(4/3) + epsilon) log n` for `0 < alpha < 1`.

All four literal public declarations are included in `Main.lean`.

## Release boundary

This project is physically and logically separate from the released
`CET`/CEP V1 repository.  The frozen baseline is tag `v1.0.1`, commit
`16766542edaf1aac67ea1ad474c1193c9c8939c9`.  V2 neither amends that tag nor
imports its capstone theorem chain.

## Contents

- `paper/collatz_first_passage_natural_density.md`: canonical manuscript;
- `paper/collatz_first_passage_natural_density_v2.pdf`: verified render;
- `audits/`: manuscript-only mathematical, literature, content, and desk
  records;
- `audits/review_post_freeze_corollaries_2026_08_06.md`: downstream
  corollary audit and parked explicit-diagonal query;
- `audits/review_v23_formal_sync_2026_08_06.md`: synchronized closure audit
  for the quantitative count, raw clock, and graded clock;
- `lean/`: independent minimal Lean 4 package;
- `proof-state.md`: synchronized paper hashes, status ledger, and formalization
  acceptance gates.

The manuscript proof has passed its manuscript-only adversarial audit.  The
standalone Lean closure now includes the full barrier, transport, pullback,
bootstrap, quantitative shell summation, landing, shortcut/raw/graded clocks,
strict parameter selection, and headline/corollary chain. Its CET-style
verification surface separates the minimal public `Main`, declaration/source
reachability audit, and public axiom audit.
See `lean/FORMALIZATION.md` and `proof-state.md` for the exact theorem map and
build status.
