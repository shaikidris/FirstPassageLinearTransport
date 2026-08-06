# First-Passage V2 final manuscript-only mathematical audit

## 1. Input and coverage card

**Mode:** `MATH-TEXT`  
**Reviewer context:** `EXTERNAL-REFEREE` simulation  
**Manuscript:** `collatz_first_passage_natural_density.md`  
**Frozen source SHA-256:**
`533158a16798aed30da8eb425166059071b4ff815b7b837094851e6729253304`  
**Rendered PDF SHA-256:**
`264337560591d285da60bed86a3d42afa7fb38668b84cf73d9e3075dfeddd3bf`  
**Text integrity:** `CLEAN`  
**Equation numbering:** stable, 69 unique tags  
**Access boundary:** manuscript only for the correctness verdict; finite
diagnostics and repository state are reported separately as non-proof evidence

Headline theorem: for the shortcut Collatz map, every fixed
\(0<\delta<1\) has
\[
T_{\min}(n)\leq\exp((\log n)^{1-\delta})
\]
on a natural-density-one set, with a witness before \(6.953\log n\) shortcut
steps.

Sections 1--7, all named results, all 69 numbered displays, the quantitative
corollary, the time constant, and the orbit ceiling were audited.  The
literature-priority and desk modes are separate records.  The not-yet-written
Lean package is outside this audit and is not claimed by the paper.

A global manuscript-only mathematical verdict is epistemically available.

## 2. Dependency graph and cut vertices

```text
parity-vector bijection (Proposition 2.2)
        |
        v
maximal Boolean barrier (Lemma 3.1)
        + exact affine correction (Lemma 3.2)
        v
dense all-prefix set W_eta (Proposition 3.3)
        |
        + first-passage reverse product (Lemma 4.1)
        + odd-count rigidity (Lemma 4.2)
        + tagged-fiber interval count (Lemma 4.3)
        v
arbitrary-target linear transport (Proposition 4.4)
        |
        v
totalized stopped map + dense-set pullback (Theorem 5.1)
        |
        v
D_{j+1}=chi D_j, log(C_j+2)=O(j^2), n_j<=K*n^(r^j)
        |
        v
varying-depth shell assembly
        |
        +-- every fixed delta<1
        +-- quantitative exceptional count
        +-- 6.953 log(n) shortcut clock
        +-- n^(1+beta) path ceiling
```

Cut vertices checked first: Lemma 4.2, Lemma 4.3, Proposition 4.4, Theorem
5.1, recursive closure (6.2)--(6.8), and parameter compatibility (6.14),
(6.18)--(6.24).

There is no imported mathematical result on the headline chain.  The Terras
citation is provenance only; Proposition 2.2 is proved locally.

## 3. Named-result ledger

| Result | Inputs and boundary checks | Evidence status |
|---|---|---|
| Theorem 1.1 | derived from (6.8), (6.15), (6.17), strict parameter interval (6.19) | `REPRODUCED` |
| Corollary 1.2 | \(0<\sigma<1-\delta\), explicit \(\omega\), Lemma 2.1 with \(A=2\) | `REPRODUCED` |
| Corollary 1.3 | strict time margin (6.23), \(O(\log\log n)\) remainder, \(\eta<\beta\) | `REPRODUCED` |
| Lemma 2.1 | early/late shell split, \(\sigma=1\) endpoint, finite startup | `REPRODUCED` |
| Proposition 2.2 | explicit two-branch induction modulo \(2^{k+1}\), \(M=0\) | `REPRODUCED` |
| Proposition 2.3 | induction at even/odd branch, \(k=0\) | `REPRODUCED` |
| Lemma 3.1 | stopped-frontier conservation, \(h=0\), all crossing signs | `REPRODUCED` |
| Lemma 3.2 | exact geometric series and constant \(2+\sqrt3\) | `REPRODUCED` |
| Proposition 3.3 | additive correction, startup shells, uniform shell-series denominator | `REPRODUCED` |
| Lemma 4.1 | final crossing parity, exact reverse factors, \(h<2Y\) | `REPRODUCED` |
| Lemma 4.2 | adjacent odd counts are worst; equality threshold \(h/(2Y)=1/3\) | `REPRODUCED` |
| Lemma 4.3 | interval length, nonempty-fiber upper endpoint, source restriction | `REPRODUCED` |
| Proposition 4.4 | empty/singleton/full targets, positive passage time, \(H|B|\) tags | `REPRODUCED` |
| Theorem 5.1 | floor loss, \(D^{-2}\) absorption, fixed barrier loss, finite totalization, uniform shell sum | `REPRODUCED` |
| Section 6 bootstrap | next-state closure, prefactor growth, shell-varying depth, terminal and clock forks | `REPRODUCED` |

The exact finite diagnostic independently verifies the reverse-product,
odd-count, fiber, and coalescence statements through \(M=22\) at one target
schedule, with additional target exponents checked through \(M=18\).  That is
`INDEPENDENTLY VERIFIED (FINITE SCOPE ONLY)` and is not used to upgrade the
all-depth evidence label.

## 4. Numbered-display ledger

Every tag below was read at its definition and every later application was
checked against its hypotheses.

| Displays | Local role | Manuscript-only status |
|---|---|---|
| (1.1) | constants \(a_0,\rho\) | `YES` |
| (1.2)--(1.6) | public theorem and corollaries | `YES` |
| (2.1)--(2.3) | dense-set definition and varying-shell summation | `YES` |
| (2.4)--(2.6) | parity bits, bijection, affine iterate | `YES` |
| (3.1)--(3.2) | maximal walk and tail estimate | `YES` |
| (3.3)--(3.5) | affine correction decomposition | `YES` |
| (3.6)--(3.9) | retained set and global density | `YES` |
| (4.1)--(4.4) | first passage, band, reverse product | `YES` |
| (4.5)--(4.7) | tagged fiber and pointwise bounds | `YES` |
| (4.8) | arbitrary-target transport | `YES` |
| (5.1)--(5.3) | scale parameters and guaranteed hit | `YES` |
| (5.4)--(5.8) | finite totalization and pullback definition | `YES` |
| (5.9)--(5.16) | exponent transport and global shell proof | `YES` |
| (6.1)--(6.4) | recursive density parameters | `YES` |
| (6.5)--(6.8) | closed orbit recursion | `YES` |
| (6.9)--(6.15) | varying-depth density assembly | `YES` |
| (6.16)--(6.19) | terminal scale and compatibility ratio | `YES` |
| (6.20)--(6.21) | time and path ceiling | `YES` |
| (6.22)--(6.24) | exact 6.953 margin and \(\delta<1\) limit | `YES` |

No display is `EXTERNAL` or `NEEDS-SENTENCE` in the frozen version.

## 5. Cut-vertex reconstruction

### 5.1 Tagged-fiber rigidity

For fixed \((h,y,s)\), reversal places every source in
\([(1-h/(2Y))A,A]\), where \(A=2^hy/3^s\).  If two sources have odd counts
that differ by at least one, their main scales differ by at least three.
Since the correction factor is at least \(2/3\), their ratio is at least two,
contradicting membership in one half-open dyadic shell.  This proves the
single-odd-count assertion without a residue-distribution premise.

Nonemptiness of the fiber and the shell upper bound give
\(A<2^{M+1}/(1-h/(2Y))\).  Counting integers in the interval gives exactly
the manuscript's (4.6); the hypotheses of (4.7) absorb the additive one.

### 5.2 Arbitrary-target transport

First passage forces every landing into \((Y/2,Y]\), and \(Y<2^M\) excludes
time zero.  There are at most \(H|B|\) time/landing tags, so summing the
pointwise bound gives (4.8).  Because restriction can only decrease a tagged
fiber, the statement is uniform over every source subset.

### 5.3 Pullback interface

For \(B=S^c\cap(Y_M/2,Y_M]\), density gives
\(|B|\leq CY_M^{1-D}\).  Substitution into (4.8) produces
\(CM^2 2^M Y_M^{-D}\).  The floor costs at most two and, for fixed
\(\chi<r\),
\[
(M+1)^2e^{-(r-\chi)D M\log2}\ll D^{-2}.
\]
The barrier complement is absorbed because \(\chi D\leq D_\eta\), and the
finite identity branch is absorbed by the fixed prefactor.  The shell ratio
is uniformly separated from one for \(D\leq D_c\), closing the global
\((C,D)\mapsto(K(C+1)D^{-2},\chi D)\) interface.

### 5.4 Recursive closure

The totalized map is identity below the startup threshold and is first passage
on every large retained state.  Hence every output in the recursive sets again
satisfies the exact input contract; no unproved reset or fresh-randomness
assumption occurs.  Iteration gives the three scalar recurrences printed in
(6.4) and (6.7).

With \(R_M=\lceil\omega\log(M+4)\rceil\), density needs
\(\omega\log(1/\chi)<1\) and terminal descent needs
\(\delta<\omega\log(1/r)\).  Their strict compatibility is (6.19).  The two
independent interior limits \(r\downarrow a_0\) and \(\chi\uparrow a_0\)
yield every fixed \(\delta<1\) without asserting equality.

## 6. Constant and scale ledger

| Quantity | Exact reconstruction | Margin/status |
|---|---|---|
| \(a_0\) | \(\log_2(3)/2\) | fixed, \(<1\) |
| affine correction | \(1/[2(1-\sqrt3/2)]=2+\sqrt3\) | exact |
| startup domination | \(2^{4a_0}=9>2(2+\sqrt3)\) | strict |
| odd-count rigidity | \(3(1-h/(2Y))\geq2\) | valid at boundary \(h/(2Y)=1/3\) |
| fiber constant | \(1+(3/2)H2^M/Y\leq(5/2)H2^M/Y\) | uses \(H\geq1,Y<2^M\) |
| shortcut clock limit | \(1/((1-a_0)\log2)=2/\log(4/3)\) | exact |
| decimal guard | \(2/\log(4/3)<1029/148<6.953\) | rigorously strict |
| raw conversion | at most two raw steps per shortcut step | \(<13.906\log n\) |

Polynomial factors are one-stage costs and are explicitly propagated into
\(\log C_R=O(R^2)\).  No hidden constant depends on the shell index after
\(r,\chi,\eta,\delta,\sigma,\beta\) are fixed in the order stated.

## 7. Quantifier audit

- Theorem 1.1: for each fixed \(\delta\), the density-one set and startup may
  depend on \(\delta\).
- Corollary 1.2: \(c_{\delta,\sigma}\) and \(X_{\delta,\sigma}\) may depend on
  the fixed pair \((\delta,\sigma)\).
- Corollary 1.3: for separately fixed \(\beta\), the set may also depend on
  \(\beta\).
- Theorem 5.1: \(K_{\rm FP},D_c\) depend only on fixed \(r,\eta,\chi\), not on
  \(C,D,S,M\).
- The endpoint \(\delta=1\) is never substituted or claimed.
- The orbit ceiling ends at the selected witness and is not a global-orbit
  assertion.

## 8. Anti-circularity and finite-to-infinite bridges

No generated-target distribution is assumed: Proposition 4.4 is universal in
the landing subset.  No finite experiment enters the proof.  No old endpoint
theorem enters the density recursion.  No stage is iterated before its output
is returned to the closed set by (6.2) and (6.6).  The shell-varying set is
converted to a global natural-density statement by the proved Lemma 2.1.

## 9. Findings

Confirmed errors in the frozen manuscript: none.

Confirmed gaps in the frozen manuscript: none.

Plausible unresolved mathematical concerns on the headline chain: none.

Repairs made before the frozen hash:

1. expanded the parity-bijection induction;
2. displayed the stopped-frontier conservation in Lemma 3.1;
3. made cumulative block times explicit for the orbit ceiling;
4. corrected a math-delimiter typo found by PDF inspection.

## 10. Deferrals and self-containedness

A competent referee can verify the headline theorem from the manuscript alone:
`YES`.

There is no appeal to a routine computation, script, Lean declaration, omitted
appendix, or external analytic theorem.  Literature citations supply context
only.  Formal verification is explicitly described as work in progress.

## 11. Free baseline and nonfree content

The parity bijection plus one fixed shell gives familiar fixed-power
natural-density descent.  That does not freely imply a stretched-logarithmic
target, because the target changes after each block and its preimage can be an
arbitrary dense set.  The nonfree content is therefore typed as:

- `INTERFACE`: pointwise first-passage transport for every landing target;
- `QUANTIFIER`: closure under recursively generated dense targets;
- `TARGET SCALE`: every fixed stretched-log exponent \(\delta<1\);
- `RATE`: stretched-exponential-in-log exceptional count for that target.

The time constant itself lies on the scale already present in the literature
and is not presented as globally novel.

## 12. Not checked and conflicting evidence

- Formal fidelity: `NOT CHECKED`; the V2 Lean package does not yet exist.
- Global priority of Proposition 4.4: `NOT CHECKED`; see the separate
  literature audit.
- Independent peer review of the 2026 comparison preprints: `NOT CHECKED` and
  irrelevant to the internal correctness proof.
- Conflicting mathematical evidence: none located.

## 13. Likely referee question not answered by the paper

Is the exact arbitrary-target tagged-fiber estimate of Proposition 4.4 new in
the stopping-time literature, or is it an unrecognized specialization of an
existing first-passage argument?  This affects positioning, not correctness;
the manuscript deliberately makes no priority claim for it.

## 14. Protocol-integrity self-audit

The verdict below follows the dependency, display, quantifier, constant,
self-containedness, anti-circularity, and bridge audits.  It does not use the
Lean build, finite diagnostics, author identity, or problem plausibility as
proof.  Literature and desk conclusions are kept in separate artifacts.

## 15. Mathematical verdict

`ACCEPT` for manuscript-only mathematical correctness.

All headline cut vertices were reproduced from the frozen manuscript, no
unresolved headline concern remains, and the paper's scope and strict endpoint
are stated accurately.

