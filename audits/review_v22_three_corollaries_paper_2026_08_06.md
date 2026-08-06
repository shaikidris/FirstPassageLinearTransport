# V2.3 three-strengthening synchronization audit

## Audit card

- **Mode:** `MATH-TEXT`, backward from the three literal conclusions.
- **Reviewer context:** `AUTHOR-AUDIT` with anti-circularity and render gates.
- **Scope:** paper and formal proofs for the smooth graded shortcut clock, the
  `10.44 log n` raw clock, and the quantitative fixed-power exceptional
  count.
- **Formal status:** all three results now have matching public Lean
  declarations; combined dependency/axiom and clean-build gates remain part
  of the final V2.3 synchronization record.

## Historical V2.2 paper-first artifacts

These hashes identify the pre-formal V2.2 paper snapshot audited in this
record.  The authoritative synchronized V2.3 hashes are recorded in
`review_v23_formal_sync_2026_08_06.md` and `proof-state.md`.

```text
2695606c82dce40a0c2bc4b9adf5ff27afbc0269d3a5e13cab6647c4717fe660  paper/collatz_first_passage_natural_density.md
c1fdb41f5833aa121c449997b94f3a8a35c305097484099467327baf8396413b  paper/collatz_first_passage_natural_density_v2.pdf
b76df4d925dd847eeb6552445a580ebe5dc5d56eab70f385cb9d2f0abd0c1f1a  audits/graded_clock_paper_proof_2026_08_06.md
8469b6646ef774485840e804e9710e3b18b1db5d4ad996f781c953cc08ea66f3  audits/raw_clock_1044_paper_proof_2026_08_06.md
```

## 1. Smooth graded clock

Literal target:

\[
k<\left(\frac{2(1-\alpha)}{\log(4/3)}+\varepsilon\right)\log n,
\qquad
T^k(n)\le n^\alpha
\]

for fixed `0 < alpha < 1`, `epsilon > 0`, on a natural-density-one set.

| Gate | Evidence | Verdict |
|---|---|---|
| New input is genuinely stronger than the rejected full-block argument | Lemma 5.2 proves `tau_Y <= H_M` from the all-prefix envelope | `PASS` |
| Horizon lies in the range of the envelope and transport theorem | `eta < r-a0` gives `H_M <= M` eventually | `PASS` |
| Floor and shell-upper constants are paid | numerator contains `2+eta`; equation (5.20) lands at `2^(rM-1) <= 2^floor(rM)` | `PASS` |
| Density pullback survives | Proposition 4.4 is uniform in `H`; `H_M <= M` only reduces its `H^2` term | `PASS` |
| No last-block overshoot | choose `alphaPrime < alpha`, fixed `R`, and `r = alphaPrime^(1/R)` | `PASS` |
| Landing constant is paid | `K_* n^alphaPrime <= n^alpha` eventually | `PASS` |
| Clock losses are paid | `alpha-alphaPrime`, `eta/(1-r)`, and the fixed remainder each receive explicit thirds of `epsilon` | `PASS` |
| Quantifiers are fixed before density construction | `alphaPrime`, `R`, `r`, and `eta` depend only on fixed `alpha,epsilon` | `PASS` |

The decisive exact calculation is

\[
\frac{1+\eta-r}{(1-a_0)\log2}
\frac{1-r^R}{1-r}
=
\frac{2(1-\alpha')}{\log(4/3)}
\left(1+\frac\eta{1-r}\right).
\]

Status: `PROVED-ON-PAPER / PROVED-FORMAL`.

## 2. Raw clock below `10.44 log n`

Literal target: the stretched-log landing from Corollary 1.3 occurs at a raw
Collatz time `j < 10.44 log n`.

| Gate | Evidence | Verdict |
|---|---|---|
| Raw/shortcut relationship is exact | `Col^(k+s_k(n))(n)=T^k(n)` by parity induction | `PASS` |
| Block concatenation is exact | odd counts add after shifting the shortcut source | `PASS` |
| Bias control is pointwise | maximal barrier gives `s_h-h/2 <= eta log n/log 3` for every prefix | `PASS` |
| Startup is covered | totalized branch has zero shortcut and raw length | `PASS` |
| Schedule remainder is subleading | existing clock and size sums give `O(R)=O(log log n)=o(log n)` | `PASS` |
| Strict decimal is certified rationally | `log(4/3)>296/1029>25/87`, hence `3/log(4/3)<261/25` | `PASS` |
| Endpoint parameter compatibility | raw coefficient and transport exponent are simultaneous open conditions at `(r,eta,chi)=(a0,0,a0)` | `PASS` |

The exact leading coefficient retained in the manuscript is

\[
C_{\rm raw}(r,\eta)
=\frac1{1-r}
\left(\frac3{2\log2}+\frac\eta{\log3}\right),
\]

with limit `3/log(4/3)`, strictly below `10.44`.

Status: `PROVED-ON-PAPER / PROVED-FORMAL`.

## 3. Quantitative fixed-power exceptional count

Literal target: for fixed `alpha > 0` and `0 < sigma < 1`,

\[
\#\{n\le X:T_{\min}(n)>n^\alpha\}
\le 5X\exp(-c_{\alpha,\sigma}(\log X)^\sigma)
\]

eventually.

| Gate | Evidence | Verdict |
|---|---|---|
| Legal parameter choice | choose fixed `0 < delta < 1-sigma` | `PASS` |
| Target comparison | `(log n)^(1-delta)=o(log n)` gives the stretched-log target below `n^alpha` eventually | `PASS` |
| Exceptional-set inclusion has the right direction | failure to reach the larger target `n^alpha` implies failure to reach the smaller stretched-log target | `PASS` |
| Finite initial count is paid without changing prefactor 5 | replace `c0` by `c0/2`; the gap between the two stretched-exponential bounds tends to infinity | `PASS` |
| No qualitative-density substitution | proof consumes quantitative Corollary 1.2 directly | `PASS` |

Status: `PROVED-ON-PAPER / PROVED-FORMAL`.

## 4. Render and presentation gate

- PDF render: `PASS`, 17 pages, A4, tagged, unencrypted.
- Modified pages visually inspected: title/abstract, result statements and
  comparison table, Lemma 5.2, raw-clock calculation, all three corollary
  proofs, disclosure, and references.
- One source control-character defect in equation (5.19) was found by the
  first visual pass, repaired, rerendered, and reinspected.
- Final result: no clipped text, broken equation, overlap, or unresolved math
  error in the inspected working PDF.

## 5. Anti-circularity ledger

- No theorem uses the claimed graded clock to prove its own short horizon.
- No theorem replaces generated targets by random or equidistributed sets.
- No empirical odd-frequency estimate enters the raw clock.
- No fixed-parameter exceptional theorem is evaluated at an `X`-dependent
  parameter.
- Formal completion is claimed only after literal public theorem, axiom,
  dependency, and full-build checks.

## Verdict

`ACCEPT-SYNCHRONIZED` for all three additions, subject to the final recorded
combined build and render gates.  The stronger logarithmic-density extension
remains parked and is not part of this acceptance.
