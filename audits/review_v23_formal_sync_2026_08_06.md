# V2.3 strengthened-corollary formal synchronization audit

**Audit date:** 2026-08-06
**Modes:** `MATH-TEXT`, `FORMAL`, `RELEASE-CHECK`
**Reviewer context:** `AUTHOR-AUDIT`
**Decision:** `ACCEPT-SYNCHRONIZED`

## Scope

This audit closes the three additions that were paper-only in V2.2:

1. the smooth graded shortcut clock for fixed powers;
2. the raw Collatz clock below `10.44 log n`;
3. the quantitative fixed-power exceptional count.

It also promotes the quantitative stretched-logarithmic exceptional count,
which is the formal input to item 3.  The stronger logarithmic-density
extension remains parked and is not imported or claimed.

## Mathematical corrections found during formalization

Two paper-only formulas required correction before synchronization.

First, the pointwise orbit envelope gives

\[
s_k(n)-\frac{k}{2}
\leq \frac{\eta\log n}{\log 3},
\]

not the same expression with an extra factor `1/2`.  Accordingly the raw
leading coefficient is

\[
\frac{1}{1-r}
\left(\frac{3}{2\log 2}+\frac{\eta}{\log 3}\right).
\]

Its limit as `r` decreases to `a0` and `eta` decreases to zero remains
`3 / log(4/3)`, so the exact rational guard below `261/25 = 10.44` is
unchanged.

Second, the quantitative parameter proof cannot put `omega` on the boundary
where the density exponent equals `1-sigma`.  The synchronized proof chooses

\[
q=\frac{\log(1/r)}{\log(1/\chi)},\qquad
\delta<\theta<q(1-\sigma),\qquad
\omega=\frac{\theta}{\log(1/r)}.
\]

This gives strict descent margin `theta > delta` and strict density margin
`theta/q < 1-sigma`, exactly matching the all-depth shell estimate.

## Formal theorem map

| Manuscript result | Public Lean declaration | Literal match |
|---|---|---|
| Corollary 1.2 | `QuantitativeCollatzMain.collatz_first_passage_quantitative_stretched_exceptional_count` | `0 < sigma < 1-delta`, prefactor `5`, eventual natural-log count |
| Corollary 1.3 raw clock | `QuantitativeCollatzMain.collatz_first_passage_raw_stretched_log_natural_density_descent` | raw iterate witness before `(261/25) log n` at the same target |
| Corollary 1.5 | `QuantitativeCollatzMain.collatz_first_passage_quantitative_fixed_power_exceptional_count` | `alpha > 0`, every `0 < sigma < 1`, prefactor `5` |
| Corollary 1.6 | `QuantitativeCollatzMain.collatz_first_passage_graded_power_natural_density_descent` | `0 < alpha < 1`, `epsilon > 0`, exact graded coefficient |

The quantitative proof certifies the target predicate shell by shell before
dyadic summation.  Consequently arbitrary finite startup shells are already
paid by the leading `1` in the generic prefactor `1 + 2A`; no unformalized
finite-error absorption is hidden in the public theorem.

## Dependency and trust gates

The combined declaration/source audit passed with:

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

The 19-theorem reverse complement consists of retained elementary/support
API, including the standalone exact raw-constant lemma.  None is an optional
research branch or an imported V1 theorem.

`PaperAudit.lean` reports only Lean's standard `propext`,
`Classical.choice`, and `Quot.sound` for every mapped cut vertex and all
public theorems.  It reports no project axiom, `sorryAx`, `native_decide`, or
other enlarged trust mechanism.

## Anti-circularity and scope

- The quantitative count uses the proved shell bootstrap ratio and a generic
  dyadic summation theorem; it does not infer an all-depth rate from natural
  density alone.
- The raw clock uses a pointwise odd-count inequality, not empirical parity
  frequency or independence.
- The graded clock shortens the already-certified first-passage horizon; it
  does not assume the desired graded conclusion.
- No V1/CEP theorem module is imported.
- No fixed-time moment, generated-target equidistribution, or logarithmic-
  density claim is introduced.

## Verdict

The V2.3 paper statements, public Lean declarations, dependency map, and
axiom surface agree.  The three strengthened corollaries are accepted as
paper-proved and formally proved.  The full 32-module default `lake build`
passed.  The deterministic render produced a tagged, unencrypted, 17-page A4
PDF; pages 1--2 and 12--17 were visually inspected after the final notation
change with no clipping, overlap, or malformed formula.  The configured
personal GitHub destination was checked and remains `PRIVATE`.  Any
subsequent commit or push of this synchronized batch must preserve that
visibility and must not use the enterprise account.

```text
b6af06e6cc29987e9e9a2752dfd70144daadacab9e6c159e0b10cf2d0a4a6e12  paper/collatz_first_passage_natural_density.md
caf185be4e621e596edab5150ad6af455fc5f935849ce4d5f40a34efeff2c66a  paper/collatz_first_passage_natural_density_v2.pdf
49cb1e3017b3a59956535b09af5654b65cc4b5245bf272d426171816195d4b10  lean/FirstPassageLinearTransport/Main.lean
```
