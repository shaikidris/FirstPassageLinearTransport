# Corollary 1.4 synchronized promotion audit

**Audit date:** 2026-08-06
**Manuscript version:** 2.1
**Modes:** `MATH-TEXT`, `FORMAL`
**Reviewer context:** `AUTHOR-AUDIT`
**Scope:** the new timed fixed-power corollary, its proof, formal declaration,
and affected public metadata; the unchanged headline chain retains the V2.0
base audits.

## Frozen inputs

```text
879c28f6998f0fc9afa235cc4181b6b9092463fc38b8bb50f207bd476a280cae  paper/collatz_first_passage_natural_density.md
557c65e961a2df89bd0366001ece025c394c837b859266d7165e876888d301ce  paper/collatz_first_passage_natural_density_v2.pdf
459a0199c62aed3af3d04072334c4b17834eead8b6dcc2249948103e5b432fa5  lean/FirstPassageLinearTransport/Main.lean
79259969a824aa466124f1616af90fd48512ac7808bf83479ee598d1cf8edde5  lean/FirstPassageLinearTransport/PowerDescent.lean
```

Text integrity is `CLEAN`. Equation numbering remains stable because the new
corollary and its two comparison displays introduce no numbered tag. The
rendered PDF has 14 A4 pages. Modified pages 1, 2, 12, and 13 were rendered to
PNG and visually checked; no clipping, overlap, broken formula, or heading
defect was found.

## Literal target and exclusion

Target: for every fixed real `alpha > 0`, there is a natural-density-one set
such that every sufficiently large retained `n` has a natural-number witness
`k` with

```text
k < 6.953 * log n
T^k(n) <= n^alpha.
```

Not promoted: the quantitative exceptional-count bound for the fixed-power
target. It remains a paper-derived consequence of Corollary 1.2 but has no
matching public Lean declaration and therefore is not added to V2.1.

## MATH-TEXT audit

The only new dependency branch is

```text
Corollary 1.3 at delta = 1/2
  -> exp((log n)^(1/2)) landing before 6.953 log n
  -> (log n)^(-1/2) < alpha eventually
  -> (log n)^(1/2) < alpha * log n
  -> exp((log n)^(1/2)) <= n^alpha
  -> Corollary 1.4 with the same witness and clock.
```

For sufficiently large positive integers, `log n > 0` and
`(log n)^(-1/2) -> 0`; hence the displayed multiplication and exponentiation
are valid. The witness and density-one set supplied by Corollary 1.3 with the
fixed choice `delta = 1/2` are unchanged. No uniformity in `alpha` is claimed,
and the strict endpoint `alpha > 0` matches the proof.

**Result:** `REPRODUCED`. The manuscript proof is self-contained and the new
corollary introduces no new load-bearing analytic input.

## FORMAL audit

The manuscript statement maps to

```text
FirstPassageLinearTransport.QuantitativeCollatzMain.
  collatz_first_passage_fixed_power_natural_density_descent
```

Field-by-field comparison:

| Field | Manuscript | Lean | Result |
|---|---|---|---|
| Parameter | every fixed real `alpha > 0` | `{alpha : ℝ}` with `0 < alpha` | exact |
| Density | natural-density-one set | `NaturalDensityOne S` | exact |
| Startup | every sufficiently large retained `n` | `∀ᶠ n in atTop, n ∈ S -> ...` | exact |
| Dynamics | shortcut iterate `T^k(n)` | `(orbit k n : ℝ)` | exact by package definitions |
| Witness | integer `k >= 0` | `k : ℕ` | exact |
| Clock | `k < 6.953 log n` | `(k : ℝ) < (6953/1000) * Real.log n` | exact |
| Landing | `T^k(n) <= n^alpha` | `(orbit k n : ℝ) <= (n : ℝ)^alpha` | exact |

The implementation uses the same fixed choice `delta = 1/2` and formalizes
the eventual comparison in `eventuallyStretchedHalfLePower`. A full
`lake build` succeeded. The public axiom audit reports only `propext`,
`Classical.choice`, and `Quot.sound`, with no project axiom, `sorryAx`,
`native_decide`, or other enlarged trust mechanism.

**Result:** `INDEPENDENTLY VERIFIED` as a kernel-checked consequence of the
formalized timed theorem, with a literal paper-to-Lean statement match.

## Promotion decision

`ACCEPT` for the bounded V2.1 synchronization change. Corollary 1.4, its
paper proof, the public Lean declaration, theorem map, audit roots, disclosure,
PDF, and proof-state are one release unit. The quantitative fixed-power rate,
smooth graded clock, improved raw clock, and explicit diagonal target remain
outside this promotion.
