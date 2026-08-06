# First-Passage V2: manuscript-only content audit

**Audit date:** 2026-08-05  
**Audit scope:** mathematical content only; no typography, bibliography, PDF, or Lean promotion  
**V2 source:** `collatz-working/collatz_first_passage_natural_density.md`  
**Audited source SHA-256:** `1fdb6029d46b26655533fa1ed24c3534928c5754bbb5a3fb6a6e1b3782b15393`  
**Frozen V1/CEP commit:** `9280ffac244f8f5bb9344c3c926d29cf2cd34f76`

## 1. Version boundary

The released endpoint/CEP paper and its software commit are treated as frozen
V1.  This audit does not modify V1 and does not accept any V1 theorem as a
premise.  The first-passage argument is a new V2 paper.  Its future Lean
formalization must live in a separate V2 package with its own `Main.lean`.

The V2 dependency boundary is therefore:

```text
elementary shortcut-Collatz algebra
        |
        +-- parity-vector bijection on a complete dyadic shell
        +-- maximal Boolean-walk estimate
        +-- exact first-passage reversal
        |
        v
arbitrary-target first-passage transport
        |
        v
totalized stopped-map pullback
        |
        v
O(log log n)-scale bootstrap
        |
        v
every fixed delta < 1
```

No fixed-time endpoint theorem, CEP estimate, endpoint-fiber moment, generated
target hypothesis, or prior Lean theorem is used in this graph.

## 2. Headline theorem card

For the shortcut Collatz map

\[
T(n)=\begin{cases}n/2,&2\mid n,\\(3n+1)/2,&2\nmid n,\end{cases}
\]

V2 claims:

1. For every fixed \(0<\delta<1\),
   \[
   T_{\min}(n)\leq\exp((\log n)^{1-\delta})
   \]
   on a natural-density-one set.
2. For every fixed \(0<\sigma<1-\delta\), the exceptional count is
   \[
   O_{\delta,\sigma}\!\left(
   X\exp(-c_{\delta,\sigma}(\log X)^\sigma)
   \right),
   \]
   with the displayed manuscript prefactor \(5\) after constants are fixed.
3. The witness occurs before \(6.953\log n\) shortcut steps.
4. For any separately fixed \(\beta>0\), the orbit through the witness stays
   below \(n^{1+\beta}\) on the chosen density-one set.

The paper does not assert \(\delta=1\), descent for every integer, cycle
nonexistence, or post-witness orbit control.

## 3. Independent reconstruction of the proof

### 3.1 Dense all-prefix barrier

On a complete shell \(I_M=[2^M,2^{M+1})\), the first \(M\) parity bits are
uniform on \(\{0,1\}^M\).  The stopped exponential potential for the centered
walk gives

\[
\Pr\!\left(\max_{k\leq M}|s_k-k/2|>h\right)
\leq2e^{-2h^2/M}.
\]

With \(h=\eta M/(2\log_2 3)\), the exact affine iterate separates into a
multiplicative term and a positive correction.  The barrier gives

\[
\rho^kn^{1-\eta}\leq T^k(n)\leq\rho^kn^{1+\eta},
\qquad k\leq M,
\]

after a fixed startup range.  The additive correction is genuinely absorbed:
its bound is \((2+\sqrt3)2^{\eta M}\), whereas half of the upper allowance is
at least \(2^{(a_0+\eta)M}/2\); the fixed inequality
\(2^{4a_0}=9>2(2+\sqrt3)\) closes the comparison for \(M\geq4\).

Shell summation yields a globally \((K_W,c_W\eta^2)\)-dense set \(W_\eta\).
No pointwise drift assumption outside this retained set is used.

### 3.2 First-passage rigidity and the linear target estimate

For first entrance at time \(h\) into \((0,Y]\), the final step is even, so
the landing lies in \((Y/2,Y]\).  Exact reversal gives

\[
n=\frac{2^hy}{3^s}
\prod_{x_j\ {m odd}}
\left(1-\frac1{2x_{j+1}}\right).
\]

All following states in odd factors exceed \(Y\).  Hence

\[
\left(1-\frac h{2Y}\right)\frac{2^hy}{3^s}
\leq n\leq\frac{2^hy}{3^s}.
\]

If \(h/(2Y)\leq1/3\), two different odd counts would force two shell sources
to have ratio at least two.  Thus one tagged fiber \((h,y)\) has one odd
count and is contained in one short real interval.  Counting integers in that
interval gives

\[
F_{M,Y}(h,y)
\leq1+\frac{2h2^M}{2Y-h}
\leq\frac52H\frac{2^M}{Y}.
\]

Summing over at most \(H|B|\) tags proves, for every target
\(B\subseteq(Y/2,Y]\),

\[
\#\{n\in I_M:\tau_Y(n)\leq H,\ T^{\tau_Y(n)}(n)\in B\}
\leq\frac52H^2\frac{2^M}{Y}|B|.
\]

This is the architectural break from V1: target power one is pointwise and
does not require a distributional statement about \(B\).

### 3.3 Closed stopped map

Choose \(a_0<r<1\), \(0<\eta<r-a_0\), and
\(Y_M=2^{\lfloor rM\rfloor}\).  On \(W_\eta\cap I_M\), the upper barrier at
time \(M\) is below \(Y_M\) for every sufficiently large \(M\), so first
passage occurs by time \(M\).

The stopped map is totalized by the identity outside the large retained
branch.  Adjoining the finite startup interval to \(W_\eta\) makes the
recursive interface closed.  On that closed set,

\[
G(n)\leq K_0n^r,
\qquad
\ell(n)\leq\lfloor\log_2n\rfloor.
\]

This totalization is not cosmetic: it prevents the recursion from silently
assuming that every later state remains above the startup threshold.

### 3.4 Arbitrary dense-target pullback

If \(S\) is \((C,D)\)-dense, its bad landing set in \((Y_M/2,Y_M]\) has
size at most \(CY_M^{1-D}\).  The linear target estimate gives shell loss

\[
\ll CM^2 2^M Y_M^{-D}.
\]

For any fixed \(0<\chi<r\), polynomial absorption yields

\[
M^2 2^{-rDM}\ll_{r,\chi}D^{-2}2^{-\chi DM}.
\]

The fixed loss from \(W_\eta^c\) is absorbed after choosing
\(D_c\leq D_\eta/\chi\).  The shell geometric-series constant is uniform for
\(0<D\leq D_c\).  Consequently

\[
(C,D)\longmapsto
\bigl(K_{\rm FP}(C+1)D^{-2},\chi D\bigr).
\]

This step was reconstructed without importing the old endpoint pullback.

### 3.5 Bootstrap and parameter feasibility

After \(R\) pullbacks,

\[
D_R=D_0\chi^R,
\qquad
\log(C_R+2)=O(R^2),
\qquad
n_R\leq K_*n^{r^R}.
\]

For \(R_M=\lceil\omega\log(M+4)\rceil\), density requires

\[
\omega\log(1/\chi)<1,
\]

while the terminal threshold requires

\[
\delta<\omega\log(1/r).
\]

The two strict inequalities are compatible precisely when

\[
\delta<\frac{\log(1/r)}{\log(1/\chi)}.
\]

Taking \(r\downarrow a_0\) and \(\chi\uparrow a_0\) through independent
strict choices gives every fixed \(\delta<1\).  No limiting parameter is
inserted into a theorem at equality.

### 3.6 Quantitative density, time, and orbit ceiling

Choosing
\(\omega=(1-\sigma)/\log(1/\chi)\) gives shell decay
\(e^{-cM^\sigma}\) whenever
\(\delta/(1-\sigma)<\log(1/r)/\log(1/\chi)\).  The varying-rate shell lemma
then gives the global exceptional count with prefactor \(5\).

The total block length satisfies

\[
k_R\leq
\frac{\log n}{(1-r)\log2}
+O_{r,\eta}(R).
\]

The exact positive-term logarithm estimate proves

\[
\frac{1}{(1-a_0)\log2}
=\frac2{\log(4/3)}<6.953.
\]

Thus \(r>a_0\) may still be chosen with a strict leading time coefficient
below \(6.953\).  The blockwise upper envelope and
\(\eta<\beta\) give the stated \(n^{1+\beta}\) ceiling after the fixed factor
is absorbed for sufficiently large \(n\).

## 4. Anti-circularity audit

| Potential circularity | Result |
|---|---|
| Use the desired density theorem to justify the parity model | Absent; the parity bijection is exact on each complete shell. |
| Assume a generated target is random/equidistributed | Absent; Proposition 4.4 holds for every target subset. |
| Use a fixed-time endpoint moment to prove first-passage transport | Absent; the proof is a pointwise reverse-product interval count. |
| Invoke the old endpoint bootstrap | Absent; V2 re-proves the pullback recurrence and shell assembly. |
| Treat finite diagnostics as an all-depth proof | Absent; diagnostics are explicitly supporting evidence only. |
| Set \(r=\chi=a_0\) or assert \(\delta=1\) | Absent; all parameters and the theorem endpoint remain strict. |
| Ignore later states falling below the startup scale | Absent; the stopped map uses an explicit zero-step identity branch. |

## 5. Finite-to-infinite gate

The all-depth proof is symbolic.  The exact diagnostic
`audit_first_passage_linear_transport.py` checks only finite shells and is not
cited as a premise.

Regression evidence recorded during this audit:

- exact reverse-product inequalities;
- first-passage landing band;
- odd-count rigidity in every tagged cell;
- exact pointwise and uniform fiber bounds;
- synchronous first-coalescence identity at target exponent \(0.80\), through
  \(M=22\);
- additional target exponents \(0.60,0.75,0.82,0.90\), through \(M=18\).

All runs passed.  The observed maximum fibers were well below the proved
uniform upper bound.  This supports implementation correctness but does not
strengthen the theorem.

## 6. Confirmed repairs made during audit

1. The parity-vector bijection proof was expanded into an explicit induction
   with the two inverse branches modulo \(2^{k+1}\).
2. The global orbit-ceiling line now uses explicit cumulative block times,
   avoiding an ambiguous local/global iterate index.
3. The V2/V1 dependency boundary was written into the manuscript.
4. Two notation defects were corrected: \(S\subseteq\mathbb N\) and
   `\min` in the shell-summation lemma.

None of these repairs changed the headline theorem or a numerical exponent.

## 7. Content verdict

```text
Parity-vector shell model:                 PROVED ON PAPER
Maximal-barrier density:                    PROVED ON PAPER
First-passage reverse product:              PROVED ON PAPER
Odd-count rigidity:                         PROVED ON PAPER
Tagged-fiber pointwise bound:               PROVED ON PAPER
Arbitrary-target linear transport:          PROVED ON PAPER
Finite totalization / recursive closure:     PROVED ON PAPER
Dense-set pullback with exponent chi*D:      PROVED ON PAPER
Bootstrap for every fixed delta < 1:         PROVED ON PAPER
Quantitative exceptional count:              PROVED ON PAPER
6.953 log(n) witness bound:                  PROVED ON PAPER
n^(1+beta) orbit ceiling:                    PROVED ON PAPER
Finite regression:                           PASS (EVIDENCE ONLY)
Presentation and bibliography:               DEFERRED
V2 Lean package and Main.lean:                NOT YET STARTED
```

**Manuscript-content decision:** `ACCEPT AS V2 PROOF CANDIDATE`.

No unresolved mathematical dependency on V1/CEP was found.  Promotion to a
released theorem should wait for the separately versioned V2 Lean package and
the later presentation/reference pass requested by the author.

