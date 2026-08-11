# Allikvere V2: external mathematics and citation audit

**Artifact reviewed:** J. Allikvere, *Almost all Collatz orbits attain almost
bounded values in natural density*, version 2 (2026)  
**Primary record:** <https://doi.org/10.5281/zenodo.21499244>  
**Review date:** 2026-08-07  
**Modes:** `MATH-TEXT + LITERATURE`  
**Reviewer context:** `EXTERNAL-REFEREE`  
**Formal mode:** not applicable; no proof-assistant artifact is supplied  
**Overall result:** `NO CONFIRMED MATHEMATICAL GAP FOUND; CITATION-SAFE ONLY
AS AN UNREFEREED PREPRINT CLAIM`

## 1. Executive verdict

The V2 manuscript is a serious paper-only proof, not a formalized result.  Its
main natural-density conclusion is much stronger than a fixed-polylogarithmic
target: it claims descent below every separately specified function tending to
infinity, together with a single asymptotic clock below (12\log N) raw Collatz
steps.

The argument is **not mathematically self-contained and does not start from
scratch**.  The paper says explicitly that it follows Tao's architecture and
refers to Tao heavily.  It imports Tao's random-affine/Syracuse framework,
valuation approximation, injectivity, renewal/Fourier estimates, sparse-set
counting, and scale bootstrap.  Its genuinely new payload is the conversion of
those ingredients from logarithmic to uniform measure:

1. condition Tao's Fourier and fine-scale mixing laws on the total
   (2)-valuation;
2. count uniform-measure affine fibres by fixed-total compositions;
3. control the sparse first-passage set uniformly in the required
   (3^k)-residue classes;
4. evaluate the remaining incomplete-row profile by a local limit theorem and
   quantitative equidistribution of the orbit ({n\log_2 3});
5. reinsert that scale-independent profile into Tao's bootstrap.

The four load-bearing new transitions were checked in detail below.  I found no
algebraic contradiction, missing normalization, or invalid independence step.
That is meaningful positive evidence, but it is not equivalent to independent
refereeing or formal verification.  The correct citation posture is therefore:

> “Allikvere's 2026 V2 preprint claims ...”

and not:

> “Allikvere proved/established ...”

unless a later refereed version or independent verification becomes available.

## 2. Frozen source record

The official Zenodo V2 package was frozen before review.

| Artifact | SHA-256 |
|---|---|
| PDF, 29 pages | `f4b9915d9e8d71410d6242f646ee7d3158a863d98d1daafc8e5ec74216ed8769` |
| TeX source | `23d9cb265a4fccd4e60827b584f92e7d192ac643fe577657f515a3d54f4ad28a` |
| numerical scripts ZIP | `a497750552ff6aae70a342bacab83885c23eef5fadc3fcac23d8c875d621c657` |
| package README | `fd0cfbfce09a1e7ceb33b0b139f84b01dc13c0ae50360f8faf0db6a1544bf4e4` |

The record identifies the work as V2, deposited 2026-07-22.  The supplied
README says explicitly that the manuscript “has not been independently
refereed.”  The PDF and TeX agree on the headline statements.  The TeX has 63
labels, no duplicate labels, no unresolved internal references, and no missing
bibliography keys.  Critical displayed formulas were also compared against
rendered PDF pages; no text-extraction or rendering corruption was found.

The author's phrase “self-contained” in the package README describes the
single-file build (inlined bibliography and no external figures).  It should
not be read as mathematical self-containment: the manuscript itself says that
it imports Tao heavily.

## 3. Target sanity card

### Literal claim

For every (f:\mathbb N_{>0}\to\mathbb R) with (f(N)\to+\infty),

\[
\frac1x\#\{N\le x:\operatorname{Col}_{\min}(N)<f(N)\}\longrightarrow1.
\]

The quantitative theorem claims absolute constants (C_K,C_0) such that a
fixed target (N_0) is reached by almost every odd start by Syracuse time

\[
K(N)=\frac{\log N}{\log(4/3)}+C_K(\log(N+2))^{0.8},
\]

with exceptional ratio

\[
O\big((\log N_0)^{-1/29}+x^{-1/2000}\big).
\]

The raw Collatz conversion gives

\[
\left(\frac3{\log(4/3)}+\frac1{\log2}+o(1)\right)\log N
=11.87\ldots\log N<12\log N.
\]

### Calibration cases

- (f(N)=N) is much weaker than the advertised theorem and is consistent with
  classical density results.
- A fixed constant (f(N)=C) is **not** covered, because (f) must diverge.
- Arbitrarily slow divergence, for example an iterated logarithm, is covered
  separately for each fixed (f).  This is the decisive quantifier.
- The clock is claimed to be independent of (f), but the exceptional set and
  eventual threshold may depend on (f).

### Capacity check

No elementary counterexample or normalization contradiction appears.  The
scale-free first-passage profile needed by the bootstrap is possible only if
the (sqrt n)-wide local-limit window cancels its (n^{-1/2}) mass and the
remaining floor phase averages to a constant.  The manuscript identifies and
computes exactly this mechanism rather than assuming it.

## 4. Dependency graph and cut vertices

```text
Tao valuation approximation + affine coding
            |
            v
sum-conditioned Fourier decay (Theorem 3.1)
            |
            v
sum-conditioned fine-scale mixing (Theorem 4.1)
            |
            v
coarse product formula (Corollary 4.5)
            |
            v
uniform first-passage fibre computation
   |             |                 |
   |             |                 +-- window-replacement discrepancy
   |             +-- flatness of E' modulo 3^k
   +-- LCLT + Kronecker phase average
            |
            v
uniform first-passage stabilization (Theorem 6.1)
            |
            v
Tao scale bootstrap -> natural density -> timed/raw clock
```

The review treated the following as cut vertices:

1. conditioning Tao's Fourier/mixing bounds on a fixed total valuation;
2. the residue-class flatness lemma for the thin generated set (E');
3. the incomplete-row/local-limit/Kronecker evaluation of (D_y(M));
4. normalization and all-scale reassembly.

No final verdict was formed before all four were checked.

## 5. Detailed proof audit

### 5.1 Negative-binomial local limit input

The exact law

\[
\Pr(s_n=s)=\binom{s-1}{n-1}2^{-s}
\]

and the moderate-deviation local limit expansion used in Lemma 2.2 have the
correct center (2n), variance (2n), Gaussian exponent
(-(s-2n)^2/(4n)), and polynomial lower bound throughout the stated
(O(\sqrt{n\log n})) window.

**Evidence:** `REPRODUCED`.

### 5.2 Sum-conditioned Fourier decay

The conditioning event (s_n=s) is measurable with respect to the pair-sum
sigma algebra used in Tao's decoupling.  Tao's pointwise nonnegative majorant
therefore survives conditioning.  Dividing by
(\Pr(s_n=s)\ge n^{-O(1)}) costs only a polynomial factor, while Tao's
Proposition 7.3 supplies arbitrarily high polynomial decay.  Thus the
superpolynomial estimate survives uniformly in the moderate window.

This is not a new independent Fourier proof; it is a correct positivity and
conditioning transfer of Tao's v7 estimate.

**Evidence:** `REPRODUCED CONDITIONAL ON TAO'S PUBLISHED/ARXIV INPUT`.

### 5.3 Conditional fine-scale mixing

The bottom/top split is exact after fixing the lower-block total.  Given the
global total, the upper block has a fixed-total composition law, so Theorem
3.1 applies to its Fourier factor.  The likelihood ratio between the upper
block total and the global total is only polynomial in the central window.
The lower factor is handled by Plancherel and Tao's injectivity Corollary 6.3.

The manuscript then removes the near-top scale restriction by an exact mixture
identity and a geometric chain of scales.  Finally, the Radon--Nikodym
derivative of the first (m) coordinates under total-sum conditioning is
expanded with the same LCLT; its expectation gives the stated
(O((m\log n/n)^{1/2})) coarse-scale stability.

No false independence step was found: the dependence created by the total sum
is retained in the conditional top law and in the explicit likelihood ratio.

**Evidence:** `REPRODUCED CONDITIONAL ON TAO'S FOURIER/INJECTIVITY INPUTS`.

### 5.4 Initial uniform source and first-passage concentration

An interval of length (L) is uniform modulo (2^{n'}) up to discrepancy one
per class, giving total variation (O(2^{n'}/L)).  Under (4^{n'}\le y), this
is (O(2^{-n'})), matching Tao's valuation-approximation hypothesis.  The
choice (n'=3n_0) has the advertised room.

The paper correctly notices that Tao's top-trimmed first-passage interval is
wrong for uniform measure: almost all uniform mass lies near the top of the
multiplicative interval.  The replacement interval extends the top edge, and
the two-sided drift estimate puts the uniform first-passage time inside it
except for the stated small errors.

**Evidence:** `REPRODUCED`.

### 5.5 Exact uniform fibre count and row incompleteness

For a valuation tuple of total (s), the affine equation pins the source to
one odd integer.  Uniform measure therefore gives the same mass to every
admissible tuple, unlike Tao's logarithmic (2^{-s})-weighting.  The source is
inside the interval exactly when (s) lies in a tuple- and endpoint-dependent
window.  The manuscript keeps this row-incompleteness explicitly and does not
silently replace partial rows by complete ones.

Grouping fixed-total tuples is legitimate because the geometric product law
conditioned on its sum is uniform over compositions.

**Evidence:** `REPRODUCED`.

### 5.6 Flatness of the thin first-passage set (E')

This is one of the paper's most important genuinely new lemmas.

For a fixed valuation prefix (\vec b) of total (B), exact affine coding
makes the prefix condition one odd residue class modulo (2^{B+1}).  On that
class, every relevant iterate is increasing affine in (M), so the
first-passage and range conditions cut an interval.  Adding
(M\equiv X\pmod{3^k}) uses the Chinese remainder theorem, because the two
moduli are coprime, and costs (O(1)) discrepancy per prefix.

The count of contributing prefixes is bounded by a composition count
(4^{m_0}e^{O((\log x)^{0.7})}\log x=x^{2\cdot10^{-5}+o(1)}), which is absorbed
by the displayed (O(x^{10^{-4}})) error.  This error is uniform in the
interval and in (k), exactly what the later sparse-incidence sum needs.

The proof does not assume that the thin set is uniformly distributed; it
derives the required discrepancy from its dyadic affine-prefix structure.

**Evidence:** `REPRODUCED`; this remains a high-priority candidate for a second
specialist audit because all later target-weighted error sums consume it.

### 5.7 Window replacement

Replacing (M-F) by (M) can only change membership when a source endpoint is
straddled.  Since (0<F\le3^{n'}), the discrepancy localizes to intervals of
length (3^{n'}).  The flatness lemma converts their (E')-population into a
uniform main term plus a small error.

At the top endpoint, two distinct indices in the Gaussian bulk would force

\[
\|q\log_2 3\|\ll x^{-0.98}
\]

for (q\le(\log x)^{1/2+o(1)}), contradicting the effective irrationality
measure.  Hence at most one bulk index contributes.  Its local-limit mass is
(O((\log x)^{-1/2+o(1)})).  The lower endpoint has an additional fixed power
of (x), and the remaining indices are Chernoff tails.  Tao's reciprocal-mass
bound then completes the sum over (M).

The phase separation is applied before summing absolute values, so the
argument does not conceal a divergent interval-length factor.

**Evidence:** `REPRODUCED`.

### 5.8 Evaluation of the incomplete-row kernel (D_y(M))

The identity

\[
3^{-n'}\binom{s-1}{n'-1}
=2^{s-n'\log_2 3}\Pr(s_{n'}=s)
\]

is exact.  The hockey-stick sum produces the upper-edge weight without a
missing (\sqrt{n'}) factor.  The saddle is

\[
n'_* = \frac{\log(y^\alpha/M)}{\log(4/3)},
\]

and the LCLT normalization cancels the width of its Gaussian window.  The
remaining factor (2^{-\{n'\log_2 3+u\}}) is averaged by a weighted
Kronecker-orbit lemma.

The paper explicitly catches the possible correlation between phase and
Gaussian weight: it replaces the integer-valued weight by a smooth
phase-free envelope and bounds the replacement in (\ell^1) before applying
equidistribution.  The resulting constant is

\[
\kappa
=\frac{2\int_0^1 2^{-\theta}\,d\theta}{2-\log_2 3}
=\frac1{\log(4/3)}.
\]

The constant and absence of a residual square-root factor were independently
recomputed numerically; see Section 8.

**Evidence:** `REPRODUCED`.

### 5.9 Normalization and scale bootstrap

After substituting the (D_y(M)) asymptotic, every dependence on the source
scale (y\in\{x^\alpha,x^{\alpha^2}\}) disappears into the same positive
measure

\[
Q(E)=\frac1Z\sum_{M\in E'(E)}\frac{p_{m_1}(M)}M.
\]

Taking the full target normalizes (Z).  The convention for infinite passage
adds only an event already controlled by the separate finite-passage bound.
The total-variation comparison between the two scales then follows.

The final monotonicity ladder is Tao's measure-agnostic bootstrap with uniform
sources.  Its errors form a convergent geometric series in the logarithmic
scale.  The passage from multiplicative intervals to the prefix ([1,x]) is
particularly simple for uniform measure because the discarded lower segment
has power-small mass.  Replacing a nonmonotone (f) by its tail infimum
correctly handles the arbitrary-diverging-function quantifier.

**Evidence:** `REPRODUCED CONDITIONAL ON TAO'S BOOTSTRAP INPUT`.

### 5.10 Timed theorem and raw clock

The timed target set is propagated through the same ladder using the two-sided
first-passage estimates.  The elementary telescope

\[
\operatorname{Col}^{k+s_k}(M)=\operatorname{Syr}^k(M),\qquad
s_k\le2k+\log_2 M
\]

follows by multiplying (2^{\nu_2(3n+1)}\operatorname{Syr}(n)\le4n).
Consequently raw time is at most (3k+\log_2N), yielding the displayed
(11.87\ldots\log N) constant.

**Evidence:** `REPRODUCED`.

## 6. Audit of imported Tao dependencies

Allikvere's proof depends materially on Tao; those citations are not merely
historical.  The checked imports include:

| Tao input | Role in Allikvere |
|---|---|
| Proposition 1.9 | valuation-vector approximation from uniform residue data |
| Lemma 2.1 | exact affine/parity coding and prefix residue classes |
| Section 3 / Theorem 3.1 implication | all-scale bootstrap |
| Proposition 5.2 and Lemma 5.3 | first-passage architecture and reciprocal sparse-set bounds |
| Corollary 6.3 | injectivity in the bottom Fourier factor |
| Proposition 7.3 | superpolynomial white-set/renewal decay |

Tao's current arXiv source is V7 (2026-07-16).  A direct V6-to-V7 source diff
confirmed corrections inside the first-passage and Proposition 7.3 proof,
and a substantive correction to Lemma 7.9.  Allikvere's V2 formulas use the
corrected V7 forms at the places audited.  This also means a referee should
read Allikvere against Tao V7, not an older local copy.

**Dependency verdict:** the Allikvere manuscript is a standalone *paper
artifact*, but not a standalone *proof architecture*.

## 7. Literature and priority findings

1. The Zenodo record and PDF support the title, author, V2 date, main theorem,
   quantitative rate, and raw clock quoted in the present V3 comparison table.
2. The work is an unrefereed preprint.  It supplies source and ancillary
   numerics, but no Lean/Coq/Isabelle artifact and no independent proof
   certificate.
3. The V2 note added acknowledges independent concurrent work on the
   natural-density upgrade but does not name it.  Priority among 2026
   manuscripts should therefore not be inferred from this paper alone.
4. The introduction's phrase “the strongest almost-all result to date is due
   to Tao” is historically natural for the paper's starting point but is too
   broad in a V2 deposited amid concurrent natural-density manuscripts.  This
   is a priority-wording issue, not a defect in the proof.

**Literature verdict:** `PASS WITH BOUNDED PRIORITY SCOPE`.

## 8. Numerical reproduction

The numerical files state that they are sanity checks and that no proof
depends on them.  They were run only as falsification tests.

### Commands

```text
python3 -B numerics/check1_fourier_decay.py 100000
python3 -B numerics/check2_dym_constant.py
python3 -B numerics/check3_first_passage.py 20000
```

### Results

- The (D_y(M)) constant test gave
  (D2^{-u}/\kappa\in[0.9982,1.0023]) for (u=40,60,80,120,160), and a
  fractional-(u) spread of (0.6239\%).
- The first-passage Monte Carlo gave cross-scale total-variation values
  (0.0568) (uniform) and (0.0535) (logarithmic), while the split-sample
  noise values were (0.0666) to (0.0796).  At this reduced sample count the
  advertised signal is below the noise floor, so this is consistency evidence,
  not confirmation of Theorem 6.1.
- The Fourier diagnostic shows small central conditional coefficients at
  (n=8,\dots,12), but large far-left coefficients near the deterministic
  all-ones corner.  This is compatible with the theorem's asymptotic central
  window and does not test its uniform constants.

### Minor source defect

`check2_dym_constant.py` says “Computes exactly,” but it uses floating-point
`lgamma`, truncates the outer sum at `nmax=3000`, and discards terms below a
floating threshold.  The computation is accurate as a numerical check but is
not exact arithmetic.  This has no proof impact because the manuscript makes
the scripts ancillary.

## 9. Findings ledger

| ID | Evidence | Severity | Finding | Consequence |
|---|---|---:|---|---|
| A1 | `REPRODUCED` | — | Main fixed-total fibre and LCLT/Kronecker normalization is internally coherent | no gap found |
| A2 | `REPRODUCED CONDITIONAL ON TAO` | — | Conditional Fourier and mixing transfers preserve dependence correctly | no invalid independence step found |
| A3 | `REPRODUCED` | — | Sparse-set residue flatness supplies the actual population needed by the mixing error | no hidden ambient-interval loss found |
| A4 | `NOT FORMALLY VERIFIED` | major evidentiary caveat | no proof-assistant artifact or independent referee report | cite as a claim, not established literature |
| A5 | `CONFIRMED` | minor | paper artifact is build-standalone but proof is Tao-dependent | avoid describing method as from scratch |
| A6 | `CONFIRMED` | minor | “strongest to date” wording is priority-sensitive amid concurrent work | do not repeat that priority claim |
| A7 | `CONFIRMED` | minor/source only | “computes exactly” numerical docstring is inaccurate | no theorem impact |

## 10. Citation recommendation for the V3 manuscript

The current bibliography entry is accurate.  The comparison table is also
factually faithful to the V2 theorem statements because it labels the work a
preprint.  For maximum referee safety, narrative references should use this
form:

> Allikvere's unrefereed V2 preprint claims natural-density descent below every
> diverging target, with a fixed-target quantitative estimate and a raw clock
> below (12\log N); its paper-only argument extends Tao's first-passage
> architecture and has no formal proof artifact.

Avoid:

- “Allikvere proved ...” without the preprint qualifier;
- “independently verified” or “formally verified”;
- “standalone proof from scratch”;
- priority language such as “first” or “strongest.”

The numerical constants in the present comparison table can remain, but they
should be understood as *claims of the cited V2 preprint*.  The present V3
paper does not use Allikvere's result as a proof premise.

## 11. Final decision

```text
MATHEMATICAL TEXT: NO CONFIRMED GAP FOUND AFTER CUT-VERTEX AUDIT
FORMAL VERIFICATION: NONE SUPPLIED
INDEPENDENT REFEREE STATUS: NONE REPORTED
LITERATURE/CITATION: SAFE AS AN UNREFEREED PREPRINT CLAIM
THEOREM-INPUT STATUS FOR THIS PROJECT: COMPARISON ONLY; DO NOT IMPORT
```

The strongest honest conclusion from this review is not “the theorem is
certified.”  It is: **the proof architecture is coherent at the audited cut
vertices, the headline is accurately reported, and no specific mathematical
error was found; nevertheless the result remains a recent, unrefereed,
paper-only claim that depends heavily on Tao V7.**
