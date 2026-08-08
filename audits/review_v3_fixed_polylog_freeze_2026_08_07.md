# V3 fixed-polylogarithmic freeze audit

**Date:** 2026-08-07

**Repository line:** private `v3-fixed-polylog` worktree

**Audit classes:** `MATH-TEXT / FORMAL / RENDER / AUTHOR-AUDIT`

**Verdict:** `ACCEPT FOR PRIVATE FREEZE`

**External independent review:** not performed in this cycle

> **Historical boundary.** This audit covers the former fixed-tolerance
> endpoint `1 / (1 - H_2(log_3 2))`. It is superseded for the current
> headline by `review_time_support_formal_sync_2026_08_08.md`, which records
> the shrinking-time-support endpoint. The findings below remain a historical
> audit of the retained comparison chain.

## 1. Input card

The audited headline is the optimized fixed-polylogarithmic first-passage
theorem. For every fixed

```text
A > 1 / (1 - H_2(log_3 2)),
c > 2 / log(4/3),
beta > 0,
```

there are positive constants `C` and `kappa` such that the integers `n <= X`
without a shortcut-Collatz witness `k < c log n` satisfying both

```text
T^k(n) <= C (log n)^A
and
max_{j <= k} T^j(n) <= n^(1+beta)
```

number at most `C X (log X)^(-kappa)` for all sufficiently large `X`.
The endpoint in `A` is not claimed.

The manuscript input is
`paper/collatz_first_passage_natural_density.md`. The public formal root is
`FirstPassageLinearTransport.QuantitativeCollatzMain.collatz_first_passage_fixed_polylogarithmic_natural_density_descent`.

## 2. Mathematical cut-vertex audit

The proof was checked backward from the headline through the following cut
vertices.

1. **Entropy-sharp adjustable barrier.** The exact stopped Boolean-walk
   optimization supplies every strict shell rate below
   `D(1/2 + eta/log_2(3) || 1/2)`. The deterministic affine-correction
   startup remains exponentially below the permitted envelope for every
   fixed barrier fraction below one.
2. **Nested direct first passage.** Strictly decreasing threshold ranks make
   every recursively generated landing the direct first passage of the
   original source below the current threshold. No generated landing law is
   transported.
3. **Rank-scaled first-bad loss.** The first-bad restriction and reverse-loss
   rescaling replace the former quadratic shell loss by `M(L+1)`. The bad
   endpoint itself is never assumed certified.
4. **Two-regime decoupling.** A switch at rank `(log M)^2` separates the
   leading clock parameter from the terminal exceptional-rate parameter.
   The high-rank transition contributes `M/(1-r_hi)` and the low-rank tail is
   `o(M)`.
5. **Endpoint parameter selection.** Letting the low-rank barrier parameter
   approach `1-a_0` yields the nonattained infimum
   `A_FP = 1/(1-H_2(log_3 2))`. Strict inequalities select a positive retained
   exceptional exponent and a clock coefficient below the prescribed `c`.
6. **Literal witness and finite startup.** The assembled shell theorem gives
   the clock, landing, and entire pre-witness orbit ceiling using the same
   `k`. `FiniteStartup.lean` absorbs the finite eventual-witness prefix into
   the constant and replaces `kappa` by `min(kappa,1)>0`. Consequently the
   public `badCount` is literally over the no-witness set.

No confirmed mathematical gap was found in these implications. The Lean
headline uses a strict terminal inequality; this is stronger than the weak
inequality printed in the paper. Lean's `eventually atTop` count is the
filter form of the paper's existence of an `X_0` after which the estimate
holds.

## 3. LC.28 boundary check

The bounded suffix-peeling cycle was read and compared with the retained
frontier ledger. It is a successful structural narrowing, not a dependency
of the headline.

Retained facts include the live/absorbed prefix bundle, the affine strata
`J_(u,d)`, inherited and available masses, the normalized inherited pressure,
and the peeling injection. The only positive resume condition is the centered
generated branch-balance estimate

```text
sum_d sqrt(2^u / |J_(u,d)|)
  * (I_(u,d)/A_(u,d) - 2^(-d)) <= C/u,
```

or a generated coboundary implying it. The negative resume condition is an
all-depth prior-good family with inherited pressure at least `1+c`.
Injectivity alone, unrestricted moments, maximum fibers, deeper finite scans,
primitive immigration before inherited closure, and arbitrary-input operator
estimates do not reopen the branch. LC.28 therefore remains `PAUSED`, and no
LC.28 claim appears in the unconditional paper or Lean dependency chain.

## 4. Formal verification record

The following command completed successfully with Lean 4.15.0 and the pinned
Mathlib manifest:

```text
lake build
```

The targeted audit build also passed:

```text
lake build FirstPassageLinearTransport.V3CutVertexAudit \
  FirstPassageLinearTransport.PaperDependencyAudit \
  FirstPassageLinearTransport.PaperAudit
```

The public headline reports only Mathlib's standard logical dependencies:

```text
propext, Classical.choice, Quot.sound
```

The source scan found no `sorry`, `admit`, project `axiom`, `TODO`, `FIXME`,
or placeholder marker in the package. The declaration audit reports:

```text
PAPER_GRAPH_ROOTS                         55
PAPER_KERNEL_PROJECT_DECLARATIONS        784
PAPER_KERNEL_PROJECT_MODULES              53
PAPER_COMBINED_PROJECT_DECLARATIONS      786
PAPER_COMBINED_PROJECT_MODULES            53
PAPER_GRAPH_IMPORTED_MODULES              54
PAPER_SOURCE_REFERENCE_EDGES            5335
MAIN_FILE_THEOREMS                        10
PUBLIC_TERMINAL_ROOTS                     56
RETAINED_PROJECT_THEOREMS                706
RETAINED_SOURCE_THEOREMS                 535
MAIN_REACHABLE_PROJECT_DECLARATIONS      787
MAIN_UNREACHABLE_PROJECT_THEOREMS        102
MAIN_UNREACHABLE_SOURCE_THEOREMS          35
```

The unreachable retained declarations are companion or alternative API
lemmas; the audit lists them explicitly. All four theorems in the new
`FiniteStartup` module are reachable from the public headline.

## 5. Manuscript and reference audit

The manuscript theorem, parameter selection, terminal target, clock, orbit
ceiling, and direct exceptional set were compared with the public theorem
type. Internal HTML targets have no missing or duplicate identifiers. Every
`\eqref` target has a corresponding equation label, with no duplicate
equation labels. The rendered PDF text contains no unresolved reference,
label, undefined-value, or error marker.

The literature search was not rerun in this cycle. The bounded-priority
literature record from the V2 line remains the only literature-status input;
the V3 manuscript makes no global first or best claim.

## 6. Render audit

The distinct V3 PDF was regenerated with the versioned render script. It is
an 18-page A4 PDF. The complete page set had already been visually inspected;
the final page changed by the literal formalization disclosure and was
re-inspected after the final render. It is legible, has no overflow, and keeps
the complete references on page 18. The frozen V2 PDF was not regenerated and
its hash is unchanged.

After the theorem freeze, the manuscript received one non-semantic
clarification: an unnumbered remark after Theorem 1.1 defines the eventual
crossover at which the fixed-polylogarithmic upper bound becomes a genuine
descent, states explicitly that the existential constants and crossover are
not effective, and gives one clearly labelled illustrative scale. No theorem,
proof, parameter range, or Lean declaration changed. The V3 PDF was regenerated
and rechecked; it remains an 18-page A4 document, the remark fits on page 2,
and the references remain complete on page 18.

## 7. Frozen hashes

```text
922369796b76f92d9b2bd3d9e276727b321dd99e58117d65987c2b8025c883e7  lean/FirstPassageLinearTransport/Main.lean
5427f88dd207682794c0dbf7b70ddf64010ffa68e4604f3a8e8d7e92c5ae6d2f  lean/FirstPassageLinearTransport/FiniteStartup.lean
f899f326f4c1f2eddcd856d55a897436f4086bdfa01b8c024ff30e7ecf86ff2a  paper/collatz_first_passage_natural_density.md
49c95525cb84ee69a216f142bfbc1d5a1b4d922dfc2a7b0779f9e20a82514f92  paper/collatz_first_passage_natural_density_v3.pdf
d71f093503a7cc19d3fffdfc76368c895fc039351b05b27d63a6322dbf9a44ee  paper/collatz_first_passage_natural_density_v2.pdf
```

## 8. Final decision

The optimized fixed-polylogarithmic theorem is synchronized across the paper,
public Lean API, dependency map, and rendered V3 artifact. The unconditional
result is independent of the paused LC.28 checkpoint-congestion frontier.
The worktree is ready for the author's private commit-and-push decision. No
commit, push, release, visibility change, or public publication is performed
by this audit.
