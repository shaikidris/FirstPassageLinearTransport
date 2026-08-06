# Post-freeze corollary audit

> **Historical baseline, superseded for Proposals 1--3.**  The full-block
> objection recorded below was correct, but the subsequent paper-first cycle
> supplied a new height-sensitive horizon and closed the graded clock.  The
> raw-clock and quantitative fixed-power proofs also closed.  See
> `graded_clock_paper_proof_2026_08_06.md` and
> `raw_clock_1044_paper_proof_2026_08_06.md`.  The explicit diagonal query in
> Section 4 remains parked.  Formal synchronization of the three new paper
> results is still pending, so the working manuscript is not yet releasable.

## Audit card

- **Mode:** `MATH-TEXT` strengthening audit with a `FORMAL` check for the
  qualitative fixed-power consequence.
- **Reviewer context:** `AUTHOR-AUDIT`.
- **Baseline:** the frozen V2 manuscript and the public timed theorem in
  `FirstPassageLinearTransport.Main`.
- **Target:** determine which of four proposed downstream statements follows
  with its literal constants and quantifiers.
- **Not the target:** empirical clock fitting, silently varying a parameter
  that is fixed in the proved theorem, or deriving a quantitative rate from
  the qualitative `NaturalDensityOne` wrapper.

## Verdict table

| Proposal | Status | Exact conclusion |
|---|---|---|
| Smooth graded clock `c_*(1-alpha)` | `OPEN`, not a free corollary | The existing full-block clock does not supply the claimed smooth coefficient. |
| Raw clock `< 10.44 log n` | `OPEN`, plausible closure target | The numerical margin is favorable, but the raw/shortcut clock identity and deterministic odd-count summation remain to be proved. |
| Fixed-power descent with a rate | `PROVED` from Corollary 1.2 | Valid after correcting the dependency and quantifiers; the qualitative timed form is now `PROVED-FORMAL`. |
| Explicit diagonal target with `2 sqrt(log log n)` | `OPEN`, not derived | Fixed-parameter exceptional constants cannot be evaluated at parameters depending on `X` without a uniform-dependence theorem. |

## 1. Smooth graded clock

The current block theorem bounds a stopped block by the entire current binary
shell depth. After `R` full stopped blocks, its leading clock coefficient is

\[
\frac{1+r+\cdots+r^{R-1}}{\log 2}
=\frac{1-r^R}{(1-r)\log 2}.
\]

Stopping at the first integer `R` with `r^R <= alpha` gives
`1-r^R >= 1-alpha`, in the direction opposite to the claimed upper bound.
The discrepancy is a genuine last-block overshoot, not a removable algebraic
error. It is also visible as `alpha -> 1`: the proposed coefficient tends to
zero, whereas the present first-passage theorem only bounds one nontrivial
block by `log_2 n` steps.

The smooth trade-off may still be true, but it needs a new alpha-sensitive
within-block passage-time theorem or a heterogeneous final block. It must not
be advertised as a consequence of `stageClock_succ` and
`stageOrbit_le_power` alone.

## 2. Raw clock

For a shortcut segment of length `k`, the corresponding raw length should be

\[
k+s_k(n),
\]

because an even shortcut letter costs one raw step and an odd shortcut letter
costs two. The maximal-envelope machinery can potentially bound the excess
odd count deterministically rather than empirically. The intended local
estimate is

\[
s_k(x)\leq \frac{k}{2}+\frac{\eta}{\log 3}\log x
\]

for every block start `x` in the retained envelope and every admissible block
prefix. Summing this with the existing geometric bounds gives the candidate
leading coefficient

\[
C_{\rm raw}(r,\eta)
=\frac{\frac{3}{2\log 2}+\frac{\eta}{\log 3}}{1-r}.
\]

For the explicit parameter selection presently used by
`exists_headlineScalars`, numerical evaluation gives

\[
r\approx0.7924943976,
\qquad
\eta\approx6.5736\cdot10^{-6},
\qquad
C_{\rm raw}\approx10.4288681<10.44.
\]

This computation is only a feasibility check. Promotion requires:

1. definitions of the raw map and raw orbit;
2. the exact identity between `k` shortcut steps and `k+s_k(n)` raw steps;
3. the local odd-count estimate from the retained orbit envelope;
4. blockwise additivity and summation over the stopped schedule;
5. an exact, non-decimal proof that `C_raw < 10.44`;
6. control of the `O((log log n)^2)` remainder;
7. a literal public raw-clock theorem and dependency/axiom audit.

Until these are complete, the paper's rigorous raw conversion remains the
worst-case `< 13.906 log n` statement.

## 3. Fixed-power descent with quantitative exceptional rate

The correct paper consequence is stronger than the original suggestion. For
every fixed `alpha > 0` and every fixed `0 < sigma < 1`, there are constants
`c_{alpha,sigma} > 0` and `X_{alpha,sigma}` such that

\[
\#\{1\leq n\leq X:T_{\min}(n)>n^\alpha\}
\leq 5X\exp\!\bigl(-c_{\alpha,\sigma}(\log X)^\sigma\bigr)
\]

for every `X >= X_{alpha,sigma}`.

Proof: choose any fixed `delta` with `0 < delta < 1-sigma`. Then

\[
(\log n)^{1-\delta}=o(\log n),
\]

so `exp((log n)^(1-delta)) <= n^alpha` eventually. The exceptional set for
the larger target `n^alpha` is contained in the exceptional set from
Corollary 1.2, which applies because `sigma < 1-delta`.
The finitely many values before this comparison becomes valid are absorbed by
decreasing the positive constant `c` and increasing the startup threshold.

This rate follows from manuscript Corollary 1.2, not from the qualitative
Lean `Main` theorem. The timed qualitative consequence has been formalized
as

`QuantitativeCollatzMain.collatz_first_passage_fixed_power_natural_density_descent`.

The formal theorem retains the literal `6.953 log n` shortcut clock and uses
the fixed choice `delta=1/2`; it makes no quantitative exceptional-count claim.

## 4. Explicit diagonalization and parked query

Corollary 1.2 quantifies over each **fixed** pair `(delta,sigma)`. Its
constants `c_{delta,sigma}` and `X_{delta,sigma}` may depend arbitrarily on
that pair. Substituting

\[
\sigma=\frac1{\sqrt{\log\log X}},
\qquad
1-\delta=2\sigma
\]

therefore changes the quantifiers and is not licensed by the theorem. The
displayed target

\[
\exp\!\left(\exp(2\sqrt{\log\log n})\right)
\]

is not currently proved.

A non-explicit diagonal density-one set can be constructed by choosing a
sequence of fixed exponents and sufficiently late cutoffs. That gives a
structural quantifier improvement but no prescribed rate such as
`2 sqrt(log log n)`.

**Parked query.** Can the proof be made uniform enough in `delta` and `sigma`
to give explicit upper bounds for `X_{delta,sigma}` and lower bounds for
`c_{delta,sigma}` along a diagonal approaching `delta=1`? Resume the explicit
diagonal claim only after such a parameter-dependence theorem is proved.

## Status change

- `firstPassageLinearTransportFixedPower`: `PROVED-FORMAL` after direct module
  rebuild and public axiom audit; integrated as manuscript Corollary 1.4 in
  the synchronized V2.1 revision.
- quantitative fixed-power exceptional rate: `PROVED` from manuscript
  Corollary 1.2; parked until a matching public Lean declaration is added in
  the same release unit.
- smooth graded clock: `OPEN`.
- raw `< 10.44 log n` clock: `OPEN` with the seven-step closure checklist
  above.
- explicit `2 sqrt(log log n)` diagonal: `OPEN`; current derivation rejected
  for nonuniform parameter substitution.
