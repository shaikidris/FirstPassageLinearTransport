# First-Passage Linear Transport

Lean 4 formalization accompanying the manuscript
*Polylogarithmic Descent for Almost All Collatz Orbits in Natural Density* by
Idris Ali Shaik.

- SSRN preprint:
  [Paper 7290240](https://papers.ssrn.com/sol3/papers.cfm?abstract_id=7290240),
  DOI <https://doi.org/10.2139/ssrn.7290240>
- Direct full-text PDF:
  [Version 3.2.3](https://shaikidris.github.io/paper/collatz-first-passage.pdf)
- Versioned manuscript archive: <https://doi.org/10.5281/zenodo.21984038> (v3.2.3)
- Manuscript source: [`paper/collatz_first_passage_natural_density.md`](paper/collatz_first_passage_natural_density.md)
- Software archive: <https://doi.org/10.5281/zenodo.21930432>
- Frozen release: `lean-v3.2.0`

The development formalizes the principal first-timeout and first-passage
theorem chain for the shortcut Collatz map. Its public API includes moving-
endpoint and fixed-exponent polylogarithmic natural-density theorems,
quantitative exceptional-set bounds, logarithmic witnessing clocks, and an
orbit-height bound through the same witness. It also retains stretched-
logarithmic, raw-clock, fixed-power, and graded-clock companion results.

The formalization is supplementary: the manuscript proof is self-contained.
These are almost-all results. They do not prove the pointwise Collatz
conjecture or exclude exceptional cycles or divergent trajectories.

## Reproduce the checked build

The package is pinned to Lean `v4.15.0` and Mathlib commit
`9837ca9d65d9de6fad1ef4381750ca688774e608`.

```bash
cd lean
lake build
```

The default target compiles the canonical `Main` dependency cone and three
audit roots. The public declarations are in
[`lean/FirstPassageLinearTransport/Main.lean`](lean/FirstPassageLinearTransport/Main.lean).
The theorem map and audit commands are in
[`lean/FORMALIZATION.md`](lean/FORMALIZATION.md).

Retained alternate and legacy implementations are isolated in separate,
non-default Lake libraries; they are not imported by `Main`.

## License

The Lean software is licensed under Apache License 2.0; see
[`LICENSE`](LICENSE). The manuscript is available through the linked SSRN
preprint page and is distributed under CC BY 4.0 through the versioned Zenodo
archive.
