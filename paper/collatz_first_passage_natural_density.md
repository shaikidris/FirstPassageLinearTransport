# Fixed-Polylogarithmic Natural-Density Descent for the Collatz Map

**Idris Ali Shaik**

Independent researcher

**Version:** 3.0 research draft, optimized first-passage re-certification

**Content draft:** August 2026

**2020 Mathematics Subject Classification:** Primary 11B83; Secondary 37P99,
60G40

**Keywords:** Collatz map, natural density, first passage, stopping map,
parity vectors, polylogarithmic descent

## Abstract

Let
\[
T(n)=
\begin{cases}
n/2,&n\equiv0\pmod2,\\
(3n+1)/2,&n\equiv1\pmod2,
\end{cases}
\qquad
T_{\min}(n)=\min_{k\geq0}T^k(n).
\]
Put
\[
A_{\rm FP}=\frac1{2(1-H_2(\log_3 2))}
=9.9911133419\ldots,
\qquad
c_* = \frac2{\log(4/3)}
=6.9521189935\ldots,
\]
where \(H_2\) is binary entropy.  For every fixed
\(A>A_{\rm FP}\), \(c>c_*\), and \(\beta>0\), we prove that all but
\(O(X/(\log X)^\kappa)\) integers \(n\le X\) possess a shortcut-Collatz
iterate, before \(c\log n\) steps, satisfying
\[
T^k(n)\le C(\log n)^A,
\qquad
\max_{0\le j\le k}T^j(n)\le n^{1+\beta}.
\]
The constants \(C,\kappa>0\) may depend on the displayed fixed parameters.
The endpoint \(A=A_{\rm FP}\) is not asserted.

At the weaker target
\(\exp((\log n)^{1-\delta})\), the same architecture gives the sharper
exceptional count
\[
O_{\delta,c,\beta}\!\left(
X\exp(-c_{\delta,c,\beta}(\log X)^{1-\delta})
\right)
\]
for every fixed \(0<\delta<1\), \(c>c_*\), and \(\beta>0\).  Companion
consequences retain every raw
clock constant greater than \(3/\log(4/3)\), and the earlier smooth graded
clock reaches \(n^\alpha\) before
\[
\left(\frac{2(1-\alpha)}{\log(4/3)}+\varepsilon\right)\log n
\]
shortcut steps.

The new assembly repeatedly re-certifies first-passage landings rather than
transporting a generated distribution. Strictly nested thresholds identify
every generated landing with a direct first passage from the original shell.
At high ranks the barrier tolerance shrinks like
\(\sqrt{\log M/m}\). The resulting first-passage duration corridors confine
all possible cumulative failure times to
\(O(\sqrt{M\log M})\) integers. Transporting only those time tags replaces
the previous linear horizon loss by a square-root loss. An entropy-sharp
low-rank barrier then gives the displayed exponent, while a separately chosen
high-rank contraction retains the near-optimal clock.
The probabilistic input is confined to exact parity-cube counting; after
certification, the transport and re-certification argument is deterministic.

## 1. Introduction and main results

We work throughout with the shortcut Collatz map \(T\) displayed in the
abstract.  All unqualified logarithms are natural, and \(\log_2\) denotes
the base-two logarithm.  Here \(\mathbb N=\{1,2,3,\ldots\}\).  Put
\[
a_0=\frac{\log_2 3}{2},
\qquad
\rho=\frac{\sqrt3}{2}.
\tag{1.1}\label{eq:1-1}
\]

The proof below is organized around first entrances below nested shell-scaled
targets.  It does not estimate a fixed-time endpoint distribution.  Every
transport estimate is pointwise in the landing target, and every later
certification failure is pulled back directly to the original dyadic shell.

This is a standalone argument.  No fixed-time endpoint transport theorem and
no generated-target equidistribution statement is a proof dependency.  The
separate Lean package now formalizes the optimized chain and its literal
referee-facing fixed-polylogarithmic theorem.  Its full build, dependency and
trust audits, and the manuscript render audit are checked separately; none is
a premise of the paper proof.

**Relation to Version 1.**  The preceding preprint [[7]](#ref-endpoint-v1)
proved stretched-logarithmic descent only for
\(0<\delta<0.251245530155874\ldots\), using a fixed-time
endpoint-fiber/Rényi transport theorem followed by endpoint iteration.  The
present paper does not import that theorem.  It replaces the earlier
architecture by all-prefix certification, first-passage reversal, direct
nested re-certification, and support-sensitive aggregation of feasible
cumulative times.  This yields both the fixed-polylogarithmic headline and the
full strict range \(0<\delta<1\) in the quantitative companion theorem.  The
main text is therefore organized along this new dependency chain: separate
results are retained only when they feed [Theorem 1.1](#thm-fixed-polylog),
[Theorem 1.2](#thm-stretched-log), or their stated corollaries.

**Probabilistic/deterministic interface.**  The parity-vector bijection makes
the uniform Boolean law exact on every complete dyadic shell.  The entropy
estimate is used only to show that an explicit all-prefix barrier fails on a
sparse set; it is not a random-walk model for an individual Collatz orbit.
From first-passage reversal onward, the transport side is deterministic: it
uses the exact affine iterate, the reverse-product identity, tagged-fiber
bounds, nested direct re-certification, and the compressed support of feasible
cumulative times.  No mixing theorem, Diophantine reduction, stochastic
independence between orbit blocks, or generated-landing equidistribution is
assumed.

Define binary entropy by
\[
H_2(p)=-p\log_2p-(1-p)\log_2(1-p),
\]
and put
\[
p_*=\log_3 2,
\qquad
A_{\rm FP}=\frac1{2(1-H_2(p_*))},
\qquad
c_*=\frac2{\log(4/3)}.
\tag{1.2}\label{eq:1-2}
\]

::: {.theorem-block}

### Theorem 1.1 (optimized fixed-polylogarithmic descent) {#thm-fixed-polylog}

For every fixed
\[
A>A_{\rm FP},
\qquad
c>c_*,
\qquad
\beta>0,
\tag{1.3}\label{eq:1-3}
\]
there are constants \(C,\kappa,X_0>0\) with the following property.  For
every \(X\ge X_0\), let \(\mathcal E_{A,c,\beta,C}(X)\) be the set of integers
\(1\le n\le X\) for which no integer \(0\le k<c\log n\) simultaneously
satisfies
\[
T^k(n)\le C(\log n)^A,
\qquad
\max_{0\le j\le k}T^j(n)\le n^{1+\beta}.
\]
Then
\[
\#\mathcal E_{A,c,\beta,C}(X)
\le C\frac{X}{(\log X)^\kappa}.
\tag{1.4}\label{eq:1-4}
\]
In particular, \(T_{\min}(n)\le C(\log n)^A\) on a set of natural density
one.  The endpoint \(A=A_{\rm FP}\) is not asserted.

:::

### Remark (asymptotic crossover)

The conclusion is asymptotic.  For fixed \(C,A>0\), let
\(N_{\rm cross}(C,A)\) be the least \(N\) such that
\(C(\log n)^A<n\) for every \(n\ge N\); it exists because
\((\log n)^A=o(n)\).  The landing is a genuine descent only beyond this
crossover, and the prefix estimate begins only at \(X_0\).  None of
\(C\), \(X_0\), or \(N_{\rm cross}\) is made effective.  For scale only,
\(A=10\) and \(C=7\) give \(N_{\rm cross}\approx4.93\times10^{16}\); these
values are illustrative and are not supplied by the theorem.

::: {.theorem-block}

### Theorem 1.2 (endpoint-rate stretched-logarithmic descent) {#thm-stretched-log}

For every fixed \(0<\delta<1\), \(c>c_*\), and \(\beta>0\), there are
constants \(C_{\delta,c,\beta},c_{\delta,c,\beta},X_{\delta,c,\beta}>0\)
with the following property.  For every \(X\ge X_{\delta,c,\beta}\), let
\(\mathcal E_{\delta,c,\beta}(X)\) be the set of integers
\(1\le n\le X\) for which no integer \(0\le k<c\log n\) simultaneously
satisfies
\[
T^k(n)\le\exp((\log n)^{1-\delta}),
\qquad
\max_{0\le j\le k}T^j(n)\le n^{1+\beta}.
\]
Then
\[
\#\mathcal E_{\delta,c,\beta}(X)
\le
C_{\delta,c,\beta}X
\exp(-c_{\delta,c,\beta}(\log X)^{1-\delta}).
\tag{1.5}\label{eq:1-5}
\]
The endpoint \(\delta=1\) is not asserted.

:::

### Corollary 1.3 (raw clock) {#cor-raw-clock}

Put
\[
\operatorname{Col}(n)=
\begin{cases}
n/2,&n\equiv0\pmod2,\\
3n+1,&n\equiv1\pmod2.
\end{cases}
\]
For every fixed \(A>A_{\rm FP}\), \(\beta>0\), and
\[
c_{\rm raw}>\frac3{\log(4/3)},
\tag{1.6}\label{eq:1-6}
\]
there are constants \(C,\kappa,X_0>0\) such that all but
\(C X/(\log X)^\kappa\) integers \(n\le X\), for \(X\ge X_0\), possess an
integer \(\ell<c_{\rm raw}\log n\) for which
\[
\operatorname{Col}^{\ell}(n)\le C(\log n)^A,
\qquad
\max_{0\le j\le\ell}\operatorname{Col}^j(n)\le n^{1+\beta}.
\]
The analogous statement with the target in
[Theorem 1.2](#thm-stretched-log) and its exceptional
rate also holds.  Since \(3/\log(4/3)=10.42817849\ldots\), the explicit
constant \(10.44\) remains admissible.

### Corollary 1.4 (fixed powers and the smooth graded clock) {#cor-fixed-power}

For every fixed \(\alpha>0\), the exceptional set for
\(T_{\min}(n)>n^\alpha\) is
\[
O_{\alpha,\sigma}\!\left(
X\exp(-c_{\alpha,\sigma}(\log X)^\sigma)
\right)
\tag{1.7}\label{eq:1-7}
\]
for every fixed \(0<\sigma<1\).  If \(0<\alpha<1\), then for every fixed
\(\varepsilon>0\) the same fixed-power target is reached on a
natural-density-one set before
\[
\left(
\frac{2(1-\alpha)}{\log(4/3)}+\varepsilon
\right)\log n
\tag{1.8}\label{eq:1-8}
\]
shortcut steps.

### Relation to previous almost-all results

The theorem should be read along several independent axes: density notion,
target scale, clock, and exceptional rate.  The closest comparisons are:

| Result | Status | Density | Target reached for almost all starts | Clock retained in the stated result | Quantitative exception |
|---|---|---|---|---|---|
| Korec [[3]](#ref-korec) | published | natural | \(n^\theta\), every fixed \(\theta>a_0\) | not part of the cited theorem | not used here |
| Inselmann [[2]](#ref-inselmann) | preprint | natural | \(n^\varepsilon\), every fixed \(\varepsilon>0\) | \(2\log n/\log(4/3)\) shortcut steps | density convergence |
| Tao [[5]](#ref-tao) | published | logarithmic | every \(f(n)\to\infty\) | no single global clock in the headline theorem | logarithmic-density estimate |
| Mazur [[4]](#ref-mazur) | manuscript with a pinned formal artifact | natural | every \(f(n)\to\infty\) | \(<436\log n\) raw steps | fixed-target logarithmic rate |
| Allikvere [[1]](#ref-allikvere) | preprint | natural | every \(f(n)\to\infty\) | \(<12\log n\) raw steps | \(O((\log N_0)^{-1/29}+X^{-1/2000})\) for a fixed target |
| This paper | standalone optimized first-passage argument | natural | \(C(\log n)^A\), every fixed \(A>A_{\rm FP}\); also \(\exp((\log n)^{1-\delta})\) with a stronger rate | every shortcut constant \(>c_*\); every raw constant \(>3/\log(4/3)\); graded clock \eqref{eq:1-8} for fixed powers | \(O(X/(\log X)^\kappa)\) at the polylog target; \(O(Xe^{-c(\log X)^{1-\delta}})\) at the stretched-log target |

The fixed-polylogarithmic target is smaller than every fixed power and every
fixed stretched-logarithmic target of the form in
[Theorem 1.2](#thm-stretched-log).  It remains
weaker than an arbitrary diverging function.  Thus the present theorem does
not supersede the arbitrary-threshold conclusions of [[1]](#ref-allikvere)
or [[4]](#ref-mazur), and the clock scale already appears in
[[2]](#ref-inselmann).  The comparison is deliberately
coordinatewise: target scale, density notion, exceptional rate, and clock are
not collapsed into one ordering.

The proof has two sharply separated parts and six load-bearing steps.

**Exact probabilistic certification.**

1. The parity-vector bijection turns a complete dyadic shell into the
   uniform Boolean cube.
2. An adjustable maximal Boolean barrier gives an entropy-sharp shell
   exceptional rate and a certified all-prefix orbit envelope.

**Deterministic Collatz transport and assembly.**

3. First-passage reversal gives a loss-filtered tagged-fiber bound for
   every target subset of a landing shell.
4. Strictly decreasing threshold ranks identify each recursively generated
   landing with a direct first passage from the original source shell.
5. Rank-dependent high barriers confine every cumulative first-bad time to a
   common support of size \(O(\sqrt{M\log M})\).
6. Support-sensitive transport and a high/low parameter choice separate the
   leading clock from the low-rank entropy rate and yield \(A_{\rm FP}\).

## 2. Density, parity, and affine iterates

For \(S\subseteq\mathbb N\), put
\[
B_S(X)=\#\{1\leq n\leq X:n\notin S\}.
\]
We call \(S\) **\((C,D)\)-dense** if
\[
B_S(X)\leq C X^{1-D}
\qquad(X\geq1),
\tag{2.1}\label{eq:2-1}
\]
where \(C>0\) and \(0<D\leq1\).  Every such set has natural density one.

We use the following varying-rate shell summation.

### Lemma 2.1 (varying-rate dyadic summation) {#lem-dyadic-sum}

Let \(0<\sigma\leq1\), \(A,\gamma>0\), and suppose that, for all
sufficiently large \(M\),
\[
\#\bigl(E\cap[2^M,2^{M+1})\bigr)
\leq A e^{-\gamma(M+4)^\sigma}2^M.
\tag{2.2}\label{eq:2-2}
\]
Then there are \(\gamma'>0\) and \(X_0\) such that
\[
\#(E\cap[1,X])
\leq(2A+1)X e^{-\gamma'(\log X)^\sigma}
\qquad(X\geq X_0).
\tag{2.3}\label{eq:2-3}
\]

#### Proof

Let \(2^J\leq X<2^{J+1}\).  The shells below \(J/2\) contain fewer than
\(X^{1/2}\) integers.  On the remaining shells,
\[
M+4\geq\frac{\log X}{4\log2}.
\]
Thus their total contribution is at most
\[
2AX\exp\!\left(
-\frac{\gamma}{(4\log2)^\sigma}(\log X)^\sigma
\right).
\]
Choose
\[
\gamma'=\min\left\{
\frac{\gamma}{(4\log2)^\sigma},\frac12
\right\}.
\]
For all sufficiently large \(X\), one has
\(X^{1/2}\leq X e^{-\gamma'(\log X)^\sigma}\).  Adding the early and late
contributions proves \eqref{eq:2-3}. \(\square\)

For \(n\geq1\), define
\[
p_i(n)=\mathbf1_{\{T^i(n)\ \mathrm{odd}\}},
\qquad
s_k(n)=\sum_{i=0}^{k-1}p_i(n).
\tag{2.4}\label{eq:2-4}
\]

The exact parity coding below is classical in the stopping-time literature;
see, for example, Terras [[6]](#ref-terras).  Its short proof is included
because no external
result is needed by the argument.

### Proposition 2.2 (parity-vector bijection) {#prop-parity-code}

For every \(M\geq0\),
\[
n\bmod2^M
\longmapsto
(p_0(n),\ldots,p_{M-1}(n))
\tag{2.5}\label{eq:2-5}
\]
is a bijection from \(\mathbb Z/2^M\mathbb Z\) to \(\{0,1\}^M\).

#### Proof

The relation
\[
n\equiv n'\pmod{2^{k+1}}
\quad\Longrightarrow\quad
T(n)\equiv T(n')\pmod{2^k}
\]
shows inductively that the first \(M\) parity bits depend only on
\(n\bmod2^M\).  For the converse, induct on the word length.  Suppose the
first bit is \(e\), and use the induction hypothesis to recover the residue
\(m=T(n)\bmod2^k\) from the remaining \(k\) bits.  If \(e=0\), the unique
compatible residue is
\[
n\equiv2m\pmod{2^{k+1}}.
\]
If \(e=1\), it is
\[
n\equiv(2m-1)3^{-1}\pmod{2^{k+1}},
\]
where \(3\) is a unit modulo \(2^{k+1}\).  The first residue is even, the
second is odd, and in either case applying \(T\) recovers \(m\bmod2^k\).
Thus every word has exactly one preimage residue. \(\square\)

### Proposition 2.3 (exact affine iterate) {#prop-affine-iterate}

For every \(n\geq1\) and \(k\geq0\),
\[
T^k(n)
=
\frac{3^{s_k(n)}}{2^k}n
+
\sum_{i=0}^{k-1}
\frac{p_i(n)3^{s_k(n)-s_{i+1}(n)}}{2^{k-i}}.
\tag{2.6}\label{eq:2-6}
\]

#### Proof

The assertion is trivial at \(k=0\).  Passing from \(k\) to \(k+1\), an
even letter divides every existing term by two.  An odd letter multiplies
every existing term by \(3/2\) and adds \(1/2\).  This is exactly the
displayed update. \(\square\)

## 3. A dense maximal-barrier set

For a parity word of length \(M\), put
\[
Y_k=2s_k-k,
\qquad
H_M=\max_{0\leq k\leq M}\left|s_k-\frac k2\right|
=\frac12\max_{0\leq k\leq M}|Y_k|.
\tag{3.1}\label{eq:3-1}
\]

For \(0\le t<1/2\), put
\[
\mathcal I(t)
=D\!\left(\frac12+t\,\middle\|\,\frac12\right)
=\left(\frac12+t\right)\log(1+2t)
+\left(\frac12-t\right)\log(1-2t).
\tag{3.2}\label{eq:3-2}
\]

### Lemma 3.1 (entropy-sharp maximal Boolean-walk bound) {#lem-entropy-barrier}

If \(M\ge1\) and \(0\le h<M/2\), then
\[
2^{-M}\#\{w\in\{0,1\}^M:H_M(w)>h\}
\leq2\exp\!\left(-M\mathcal I(h/M)\right).
\tag{3.3}\label{eq:3-3}
\]
In particular, the right side is at most
\(2\exp(-2h^2/M)\).

#### Proof

Fix \(\theta>0\) and stop the Boolean tree at the first prefix \(u\) with
\(|Y(u)|>2h\).  For a frontier node of depth \(k\), set
\[
\Phi_\theta(u)
=2^{-k}\cosh(\theta Y(u))(\cosh\theta)^{M-k}.
\]
The identity
\[
\cosh(\theta(y-1))+\cosh(\theta(y+1))
=2\cosh(\theta y)\cosh\theta
\]
shows that replacing an unexpanded node by its two children preserves the
total potential.  The frontier formed by first-crossing prefixes and
noncrossing depth-\(M\) words therefore has total
\((\cosh\theta)^M\).  Each crossing prefix contributes at least
\(2^{-|u|}\cosh(2\theta h)\), whence
\[
\Pr(H_M>h)
\le2\exp(M\log\cosh\theta-2\theta h).
\tag{3.4}\label{eq:3-4}
\]
Take \(u=2h/M\) and \(\theta=\operatorname{arctanh}u\).  The elementary
Legendre identity
\[
u\theta-\log\cosh\theta
=D\!\left(\frac{1+u}{2}\,\middle\|\,\frac12\right)
=\mathcal I(h/M)
\]
proves \eqref{eq:3-3}.  Pinsker's inequality in this binary case, or the direct
convexity estimate \(\mathcal I(t)\ge2t^2\), gives the final assertion.
\(\square\)

Define
\[
r_k(n)=
\sum_{i=0}^{k-1}
\frac{p_i(n)}{3^{s_{i+1}(n)}2^{k-i}},
\qquad
d_k=s_k-\frac k2.
\tag{3.5}\label{eq:3-5}
\]
By [Proposition 2.3](#prop-affine-iterate),
\[
T^k(n)
=\rho^k n3^{d_k}
+(r_k(n)3^{k/2})3^{d_k}.
\tag{3.6}\label{eq:3-6}
\]

### Lemma 3.2 (uniform affine correction) {#lem-affine-correction}

If \(H_M\leq h\), then for every \(1\leq k\leq M\),
\[
r_k(n)3^{k/2}
\leq
(2+\sqrt3)\left(1-\rho^k\right)3^h
<(2+\sqrt3)3^h.
\tag{3.7}\label{eq:3-7}
\]

#### Proof

For \(0\leq i<k\), the barrier gives
\(s_{i+1}\geq(i+1)/2-h\).  Hence
\[
r_k3^{k/2}
\leq
3^h\sum_{i=0}^{k-1}\frac{3^{(k-i-1)/2}}{2^{k-i}}
=\frac{3^h}{2}\sum_{j=0}^{k-1}\rho^j,
\]
which is \eqref{eq:3-7}. \(\square\)

For \(0<\eta\leq1\), let \(W_\eta\) be the set of integers \(n\) such
that
\[
\rho^k n^{1-\eta}
\leq T^k(n)\leq
\rho^k n^{1+\eta}
\qquad
(0\leq k\leq\lfloor\log_2n\rfloor).
\tag{3.8}\label{eq:3-8}
\]

Define
\[
b_{\rm ent}(\eta)
=\mathcal I\!\left(\frac{\eta}{\log_2 3}\right).
\tag{3.9}\label{eq:3-9}
\]

### Proposition 3.3 (entropy-sharp density of the maximal-barrier set) {#prop-barrier-density}

Let \(0<\eta<1-a_0\).  For every fixed
\(0<c<b_{\rm ent}(\eta)\), there is \(K_{\eta,c}>0\) such that
\[
\frac{\#(W_\eta^c\cap I_M)}{2^M}
\le K_{\eta,c}e^{-cM}
\qquad(M\ge0).
\tag{3.10}\label{eq:3-10}
\]
Consequently \(W_\eta\) is
\((K'_{\eta,c},c/\log2)\)-dense after increasing the fixed constant.

#### Proof

Put \(L_3=\log_2 3\).  Since \(c<b_{\rm ent}(\eta)\), choose a fixed
\(0<\lambda<1\) with
\[
c<\mathcal I\!\left(\frac{\lambda\eta}{L_3}\right).
\tag{3.11}\label{eq:3-11}
\]
On \(I_M\), take
\[
h=\frac{\lambda\eta M}{L_3}.
\tag{3.12}\label{eq:3-12}
\]
Assume \(H_M\le h\).  Since \(3^h=2^{\lambda\eta M}\le n^\eta\),
the multiplicative term in \eqref{eq:3-6} is at least
\(\rho^kn^{1-\eta}\) and at most
\[
2^{-(1-\lambda)\eta M}\rho^kn^{1+\eta}.
\tag{3.13}\label{eq:3-13}
\]
[Lemma 3.2](#lem-affine-correction) bounds the additive term by
\[
(2+\sqrt3)3^{2h}
=(2+\sqrt3)2^{2\lambda\eta M}.
\tag{3.14}\label{eq:3-14}
\]
The unused part of the upper envelope is at least
\[
\left(1-2^{-(1-\lambda)\eta M}\right)
\rho^M2^{(1+\eta)M}.
\tag{3.15}\label{eq:3-15}
\]
Its binary exponent exceeds that of \eqref{eq:3-14}, because
\[
a_0+\eta-2\lambda\eta
\ge a_0-\eta>0.
\tag{3.16}\label{eq:3-16}
\]
Thus \eqref{eq:3-8} holds for every \(k\le M\) once \(M\) is sufficiently large.

[Proposition 2.2](#prop-parity-code) and
[Lemma 3.1](#lem-entropy-barrier) now give
\[
\frac{\#(W_\eta^c\cap I_M)}{2^M}
\le
2\exp\!\left[-M\mathcal I\!\left(
\frac{\lambda\eta}{L_3}\right)\right]
\le2e^{-cM}
\]
on all sufficiently large shells.  Enlarge \(K_{\eta,c}\) to absorb the
finite startup.  Summing the resulting geometric shell series proves the
global density assertion. \(\square\)

## 4. First-passage linear transport

For real \(Y>1\), define
\[
\tau_Y(n)=\min\{h\geq0:T^h(n)\leq Y\}
\tag{4.1}\label{eq:4-1}
\]
when the set is nonempty.

### Lemma 4.1 (first-passage band and reverse product) {#lem-first-passage}

Let \(1<Y<2^M\), let \(n\in I_M\), and suppose
\(\tau_Y(n)=h\geq1\).  Write \(x_j=T^j(n)\), \(y=x_h\), and let \(s\)
be the number of odd values among \(x_0,\ldots,x_{h-1}\).  Then
\[
\frac Y2<y\leq Y
\tag{4.2}\label{eq:4-2}
\]
and
\[
n=
\frac{2^hy}{3^s}
\prod_{\substack{0\leq j<h\\x_j\ \mathrm{odd}}}
\left(1-\frac1{2x_{j+1}}\right).
\tag{4.3}\label{eq:4-3}
\]
Consequently, whenever \(h<2Y\),
\[
\left(1-\frac h{2Y}\right)\frac{2^hy}{3^s}
\leq n\leq\frac{2^hy}{3^s}.
\tag{4.4}\label{eq:4-4}
\]

#### Proof

The final crossing cannot be odd: otherwise
\(x_h=(3x_{h-1}+1)/2>x_{h-1}>Y\).  Hence \(x_{h-1}=2y\), proving
\eqref{eq:4-2}.  Reversing an even step gives \(x_j=2x_{j+1}\), while reversing an
odd step gives
\[
x_j=\frac{2x_{j+1}-1}{3}
=\frac23x_{j+1}\left(1-\frac1{2x_{j+1}}\right).
\]
Multiplication proves \eqref{eq:4-3}.  Every odd factor occurs before the final
crossing, so its following state is greater than \(Y\).  Therefore
\(\prod_i(1-u_i)\geq1-\sum_i u_i\) gives a lower product bound
\(1-s/(2Y)\geq1-h/(2Y)\); the upper bound is one. \(\square\)

For a tagged landing cell put
\[
F_{M,Y}(h,y)
=\#\{n\in I_M:\tau_Y(n)=h,\ T^h(n)=y\}.
\tag{4.5}\label{eq:4-5}
\]

### Lemma 4.2 (odd-count rigidity) {#lem-odd-rigidity}

If \(h/(2Y)\leq1/3\), every source in a nonempty tagged fiber \((h,y)\)
has the same odd count.

#### Proof

If two sources had odd counts \(s_1<s_2\), put
\(A_i=2^hy/3^{s_i}\).  Then \(A_1\geq3A_2\), and \eqref{eq:4-4} would give
\[
\frac{n_1}{n_2}
\geq3\left(1-\frac h{2Y}\right)\geq2.
\]
This is impossible for two integers in the half-open shell \(I_M\), whose
ratio is strictly smaller than two. \(\square\)

### Lemma 4.3 (tagged-fiber bound) {#lem-tagged-fiber}

If \(h/(2Y)\leq1/3\), then
\[
F_{M,Y}(h,y)
\leq1+\frac{2h2^M}{2Y-h}.
\tag{4.6}\label{eq:4-6}
\]
In particular, if \(1\leq h\leq H\) and \(H/(2Y)\leq1/3\), then
\[
F_{M,Y}(h,y)
\leq\frac52H\frac{2^M}{Y}.
\tag{4.7}\label{eq:4-7}
\]
The estimates remain valid after arbitrary source restriction.

#### Proof

[Lemma 4.2](#lem-odd-rigidity) fixes one odd count \(s\).  Put
\(A=2^hy/3^s\) and \(\varepsilon=h/(2Y)\).  By \eqref{eq:4-4}, every source lies
in \([(1-\varepsilon)A,A]\).  Nonemptiness and \(n<2^{M+1}\) give
\[
A<\frac{2^{M+1}}{1-\varepsilon}.
\]
The interval contains at most \(1+\varepsilon A\) integers, proving \eqref{eq:4-6}.
Under the second hypotheses, the nonconstant term is at most
\((3/2)H2^M/Y\), while \(1\leq H2^M/Y\), proving \eqref{eq:4-7}. \(\square\)

Put \(J_Y=(Y/2,Y]\cap\mathbb N\).

### Proposition 4.4 (arbitrary-target linear transport) {#prop-target-transport}

Let \(1<Y<2^M\), \(H\geq1\), and \(H/(2Y)\leq1/3\).  Every
\(B\subseteq J_Y\) satisfies
\[
\#\{n\in I_M:\tau_Y(n)\leq H,
\ T^{\tau_Y(n)}(n)\in B\}
\leq\frac52H^2\frac{2^M}{Y}|B|.
\tag{4.8}\label{eq:4-8}
\]
The same inequality holds after arbitrary source restriction.

#### Proof

Every landing belongs to \(J_Y\) by \eqref{eq:4-2}.  Since \(Y<2^M\), the passage
time is positive.  Sum \eqref{eq:4-7} over the at most \(H|B|\) tagged cells
\((h,y)\). \(\square\)

For the optimized assembly, write the reverse product in \eqref{eq:4-3} as
\(\prod_{j<h}(1-u_j)\), where
\[
u_j(n)=
\begin{cases}
\dfrac1{2T^{j+1}(n)},&T^j(n)\text{ odd},\\[2mm]
0,&T^j(n)\text{ even},
\end{cases}
\qquad
E_Y(n)=Y\sum_{j=0}^{h-1}u_j(n).
\tag{4.9}\label{eq:4-9}
\]
The elementary product inequality gives
\[
1-\frac{E_Y(n)}Y
\le\prod_{j=0}^{h-1}(1-u_j(n))\le1.
\tag{4.10}\label{eq:4-10}
\]

### Lemma 4.5 (loss-filtered tagged fibers) {#lem-loss-filtered-fibers}

Let \(D\ge0\), and suppose
\[
\frac DY\le\frac13.
\tag{4.11}\label{eq:4-11}
\]
For a fixed tag \((h,y)\), the number of sources \(n\in I_M\) satisfying
\[
\tau_Y(n)=h,
\qquad
T^h(n)=y,
\qquad
E_Y(n)\le D
\]
is at most
\[
1+3D\frac{2^M}{Y}.
\tag{4.12}\label{eq:4-12}
\]

#### Proof

Put \(P(n)=\prod_{j<h}(1-u_j(n))\).  If two such sources had odd
counts \(s_1<s_2\), put \(A_i=2^hy/3^{s_i}\).  Then
\(A_1\ge3A_2\), while \eqref{eq:4-3} and \eqref{eq:4-10} give
\[
n_1=A_1P(n_1)
\ge3A_2\left(1-\frac DY\right)
\ge2A_2\ge2n_2.
\]
This is impossible in the half-open shell \(I_M\).  The argument uses
only positive products and introduces no division by a reverse product.
Fix the common odd count and put
\(A=2^hy/3^s\).  All sources lie in
\([(1-D/Y)A,A]\).  Nonemptiness, \eqref{eq:4-11}, and \(n<2^{M+1}\) imply
\(A<(3/2)2^{M+1}\), so this interval has length less than
\[
3D\frac{2^M}{Y}.
\]
This proves \eqref{eq:4-12}. \(\square\)

### Proposition 4.6 (loss-filtered target transport) {#prop-loss-transport}

Let \(1<Y<2^M\).  Under \eqref{eq:4-11}, every \(B\subseteq J_Y\) satisfies the
exact bound
\[
\#\left\{n\in I_M:
\begin{array}{l}
\tau_Y(n)\le H,\quad
T^{\tau_Y(n)}(n)\in B,\\
E_Y(n)\le D
\end{array}
\right\}
\le
H\left(1+3D\frac{2^M}{Y}\right)|B|.
\tag{4.13}\label{eq:4-13}
\]
Consequently,
\[
\#\left\{n\in I_M:
\begin{array}{l}
\tau_Y(n)\le H,\quad
T^{\tau_Y(n)}(n)\in B,\\
E_Y(n)\le D
\end{array}
\right\}
\le
H(1+3D)\frac{2^M}{Y}|B|.
\tag{4.14}\label{eq:4-14}
\]
The estimate remains valid after arbitrary source restriction.

#### Proof

Since \(Y<2^M\), every passage time is positive.  Sum \eqref{eq:4-12} over the at
most \(H|B|\) tags to obtain \eqref{eq:4-13}.  The contribution \(H|B|\) is at most
\(H(2^M/Y)|B|\), which gives \eqref{eq:4-14}. \(\square\)

## 5. Nested first-passage re-certification

Fix
\[
a_0<r<1,
\qquad
0<\eta<r-a_0,
\qquad
0<c_\eta<b_{\rm ent}(\eta).
\tag{5.1}\label{eq:5-1}
\]
Increase a fixed startup rank \(M_0=M_0(r,\eta,c_\eta)\) whenever needed
below.  If \(x\in W_\eta\cap I_m\), put \(q=\lfloor rm\rfloor\).  For
all \(m\ge M_0\),
\[
T^m(x)\le\rho^mx^{1+\eta}
<2^{(a_0+\eta)m+1+\eta}
\le2^q.
\tag{5.2}\label{eq:5-2}
\]
Thus \(\tau_{2^q}(x)\le m\), and \eqref{eq:3-8} bounds the whole block by
\(x^{1+\eta}\).

Fix integers \(M\ge L\ge M_0\), and start with \(n_0=n\in I_M\).  Put
\[
m_i=\lfloor\log_2n_i\rfloor,
\qquad
t_0=0.
\]
If \(m_i<L\), stop successfully.  If \(m_i\ge L\) but
\(n_i\notin W_\eta\), stop with a certification failure.  Otherwise define
\[
q_i=\lfloor rm_i\rfloor,
\quad
h_i=\tau_{2^{q_i}}(n_i),
\quad
n_{i+1}=T^{h_i}(n_i),
\quad
t_{i+1}=t_i+h_i.
\tag{5.3}\label{eq:5-3}
\]
The first-passage band gives
\[
2^{q_i-1}<n_{i+1}\le2^{q_i},
\qquad
m_{i+1}\in\{q_i-1,q_i\}.
\tag{5.4}\label{eq:5-4}
\]
Since \(q_i\le m_i-1\),
\[
m_{i+1}\le q_i\le rm_i,
\qquad
q_{i+1}\le q_i-1
\tag{5.5}\label{eq:5-5}
\]
whenever the next block is executed.  Consequently
\[
t_i\le\sum_{j<i}m_j
\le M\sum_{j<i}r^j
<\frac{M}{1-r}.
\tag{5.6}\label{eq:5-6}
\]

### Lemma 5.1 (nested direct first passage) {#lem-nested-passage}

For every executed block \(i\),
\[
t_{i+1}=\tau_{2^{q_i}}(n_0),
\qquad
n_{i+1}=T^{\tau_{2^{q_i}}(n_0)}(n_0).
\tag{5.7}\label{eq:5-7}
\]

#### Proof

The assertion is the definition when \(i=0\).  Inductively, every state
before \(t_i\) exceeds the preceding threshold and hence the strictly
smaller \(2^{q_i}\).  At time \(t_i\), one has
\(n_i\ge2^{m_i}>2^{q_i}\).  The local block stays above \(2^{q_i}\)
until its endpoint.  Thus \(t_i+h_i\) is exactly the first crossing of the
new threshold by the original orbit. \(\square\)

For \(q\ge1\), put
\[
J_q=(2^{q-1},2^q]\cap\mathbb N,
\qquad
B_q=W_\eta^c\cap J_q.
\tag{5.8}\label{eq:5-8}
\]
The interval \(J_q\) lies in \(I_{q-1}\) apart from its upper endpoint.
[Proposition 3.3](#prop-barrier-density) therefore gives
\[
\frac{|B_q|}{2^q}
\le C_{\eta,c_\eta}(e^{-c_\eta q}+2^{-q}).
\tag{5.9}\label{eq:5-9}
\]

### Lemma 5.2 (rank-scaled reverse loss) {#lem-rank-loss}

If blocks \(0,\ldots,i\) are executed before the first certification
failure, then the direct first passage in \eqref{eq:5-7} satisfies
\[
E_{2^{q_i}}(n)<\frac{q_i+2}{r}.
\tag{5.10}\label{eq:5-10}
\]

#### Proof

In block \(j\), every state following an odd step is strictly larger than
\(2^{q_j}\); the final crossing is even.  Therefore each reverse-loss
increment is less than \(2^{-q_j-1}\).  Since the block has at most
\(m_j\) steps, rescaling all blocks to the final threshold gives
\[
E_{2^{q_i}}(n)
<\frac12\sum_{j\le i}m_j2^{q_i-q_j}.
\]
Now \(m_j<(q_j+1)/r\), and the distinct integer thresholds \(q_j\) are
all at least \(q_i\).  Hence
\[
E_{2^{q_i}}(n)
<\frac1{2r}\sum_{d\ge0}(q_i+d+1)2^{-d}
=\frac{q_i+2}{r}.
\]
\(\square\)

Let \(\operatorname{Fail}_{M,L}\) denote the sources whose chain reaches a
certification failure before it reaches rank below \(L\).

### Theorem 5.3 (optimized terminal profile) {#thm-terminal-profile}

Under \eqref{eq:5-1}, there is a fixed startup rank and a constant \(C>0\) such
that, for all \(M\ge L\) above that startup,
\[
\boxed{
\frac{\#\operatorname{Fail}_{M,L}}{2^M}
\le C\left[
e^{-c_\eta M}
+M(L+1)(e^{-c_\eta L}+2^{-L})
\right].}
\tag{5.11}\label{eq:5-11}
\]
Every source outside this set has an integer \(k<M/(1-r)\) such that
\[
T^k(n)<2^L,
\qquad
\max_{0\le j\le k}T^j(n)\le n^{1+\eta}.
\tag{5.12}\label{eq:5-12}
\]

#### Proof

An initial failure has proportion \(O(e^{-c_\eta M})\).  Otherwise let the
first failed certification be a generated landing in \(B_q\).  Every earlier
block and the block producing that landing are certified, so
[Lemma 5.2](#lem-rank-loss) applies; the bad landing itself is not assumed
certified.  [Lemma 5.1](#lem-nested-passage) makes it
a direct first passage from \(I_M\), at time at most \(M/(1-r)+1\).

Increase the startup rank until
\[
\frac{q+2}{r2^q}\le\frac13
\tag{5.13}\label{eq:5-13}
\]
for every \(q\ge L\).  [Proposition 4.6](#prop-loss-transport), with
\(D=(q+2)/r\), bounds the proportion of sources whose first failed landing
has rank \(q\) by
\[
C M(q+1)(e^{-c_\eta q}+2^{-q}).
\tag{5.14}\label{eq:5-14}
\]
The two elementary tail estimates
\[
\sum_{q\ge L}(q+1)e^{-c_\eta q}
\ll(L+1)e^{-c_\eta L},
\qquad
\sum_{q\ge L}(q+1)2^{-q}
\ll(L+1)2^{-L}
\]
prove \eqref{eq:5-11}.

Outside the failure set, integer ranks strictly decrease until a state of
rank below \(L\) is reached.  Equations \eqref{eq:5-2}, \eqref{eq:5-6}, and the monotonic
decrease of block endpoints prove \eqref{eq:5-12}. \(\square\)

## 6. Shrinking barriers and compressed time support

The loss in [Theorem 5.3](#thm-terminal-profile) comes from summing over all
times up to a linear horizon.  The actual certified blocks occupy a much
smaller time support once the high-rank barrier width is allowed to shrink
with the current rank.

Choose fixed high-rank data
\[
a_0<r_{\rm hi}<1,
\qquad
0<\tau<r_{\rm hi}-a_0,
\tag{6.1}\label{eq:6-1}
\]
and fixed low-rank data
\[
a_0<r_{\rm lo}<1,
\qquad
0<\eta_{\rm lo}<r_{\rm lo}-a_0.
\tag{6.2}\label{eq:6-2}
\]
For constants \(D,C_{\rm sw}>0\), put
\[
S_M=\left\lceil C_{\rm sw}\log(M+2)\right\rceil,
\tag{6.3}\label{eq:6-3}
\]
and, at a high parent rank \(m\ge S_M\), certify with
\[
\eta_{M,m}
=\min\left\{\tau,
D\sqrt{\frac{\log(M+2)}m}\right\}.
\tag{6.4}\label{eq:6-4}
\]
Below the switch use the fixed tolerance \(\eta_{\rm lo}\).  Every smaller
tolerance reuses the fixed high-rank certification theorem at tolerance
\(\tau\), so no rank-dependent startup assumption is introduced.

The nested first-passage proof remains unchanged.  With
\(r_*=\min\{r_{\rm hi},r_{\rm lo}\}\), every first-bad landing at threshold
rank \(q\) is a direct first passage from the original shell and satisfies
\[
E_{2^q}(n)<\frac{q+2}{r_*}.
\tag{6.5}\label{eq:6-5}
\]

### Lemma 6.1 (duration corridor and feasible-time support) {#lem-time-support}

There is a constant \(K>0\), depending only on the fixed parameters, such
that for every outer shell \(I_M\) and every possible first-bad rank \(q\),
all cumulative first-passage times belong to a finite set
\(\mathcal H_{M,q}\) satisfying
\[
\#\mathcal H_{M,q}
\le K\sqrt{(M+2)\log(M+2)}.
\tag{6.6}\label{eq:6-6}
\]

#### Proof

Consider one certified block from a parent shell \(I_m\) to threshold
\(2^q\), and let \(h\) be its duration and \(t\) its active tolerance.
The two deterministic orbit envelopes and the first-passage band give
\[
(1-t)m-q
\le(1-a_0)h
<(1+t)(m+1)-q+1.
\tag{6.7}\label{eq:6-7}
\]
The width before division by \(1-a_0\) is exactly \(2tm+t+2\).
During the high phase, \(tm\le D\sqrt{m\log(M+2)}+\tau\), and the parent
ranks decrease geometrically with ratio at most \(r_{\rm hi}\).  Hence the
sum of high-phase widths is
\(O(\sqrt{M\log(M+2)})\).  The low phase begins below
\(S_M+1=O(\log M)\); summing its fixed-tolerance widths contributes only
\(O(S_M)\).  Adding the integer rounding errors gives one interval of at
most the size in \eqref{eq:6-6} containing every feasible cumulative time.
\(\square\)

The tagged-fiber proof also has the following support-sensitive form.  If
\(\mathcal H\) is any finite set of positive times, \(B\subseteq[1,Y]\),
and the scaled reverse loss is at most \(D_q\), then
\[
\#\left\{n\in I_M:
\begin{array}{l}
\text{the first passage below }Y\text{ occurs at some }h\in\mathcal H,\\
T^h(n)\in B,\ E_Y(n)\le D_q
\end{array}\right\}
\le
\#\mathcal H\left(1+3D_q\frac{2^M}{Y}\right)\#B.
\tag{6.8}\label{eq:6-8}
\]
This is [Proposition 4.6](#prop-loss-transport) summed only over the declared
time tags.  No interval structure or density hypothesis on \(\mathcal H\)
is used.

Above the switch, choose \(C_{\rm sw}\) large enough that the cap in
\eqref{eq:6-4} is inactive.  The quadratic maximal-barrier estimate then has
exponent
\(\eta_{M,m}^2m=D^2\log(M+2)\).  Consequently the initial high failure and
every high-rank landing target have a common density bound
\[
d_{\rm hi}(M)
\ll (M+2)^{-p_{\rm hi}},
\qquad
p_{\rm hi}
=\min\{C_{\rm sw}\log2,c_0D^2\},
\tag{6.9}\label{eq:6-9}
\]
where \(c_0>0\) is the fixed quadratic maximal-barrier constant.  The first
term in the minimum pays for the dyadic endpoint boundary at the switch.

### Theorem 6.2 (support-sensitive terminal profile) {#thm-two-regime-profile}

Let \(b_{\rm lo}<b_{\rm ent}(\eta_{\rm lo})\) and let
\(0<c_2<\log2\).  For all sufficiently large \(M\) and
\(1\le L<S_M<M\),
\[
\boxed{
\frac{\#\operatorname{Fail}^{\rm sh}_{M,L}}{2^M}
\ll
d_{\rm hi}(M)
+\sqrt{M\log(M+2)}
\left(
M^2d_{\rm hi}(M)
+e^{-b_{\rm lo}L}+e^{-c_2L}
\right).}
\tag{6.10}\label{eq:6-10}
\]
Outside this failure set, some iterate before
\[
\frac{M}{1-r_{\rm hi}}+\frac{S_M+1}{1-r_{\rm lo}}
\]
lies below \(2^L\).  If \(\tau<\beta\), every iterate through the same
witness is at most \(n^{1+\beta}\), once \(M\) is sufficiently large.

#### Proof

Partition by the unique first failed certification rank.  Equations
\eqref{eq:6-5}, \eqref{eq:6-6}, and \eqref{eq:6-8} give, after division by
\(2^M\), the time-support factor times \((q+1)\) times the density of the
rank-\(q\) bad landing target.  Summing the high ranks contributes
\(O(\sqrt{M\log M}\,M^2d_{\rm hi}(M))\).  The strict exponents
\(b_{\rm lo}<b_{\rm ent}(\eta_{\rm lo})\) and \(c_2<\log2\) absorb the
linear rank factor in the low geometric tails and give the final two terms
in \eqref{eq:6-10}.  The initial failure contributes \(d_{\rm hi}(M)\).

The block ranks decrease geometrically, which gives the displayed clock.
High blocks use tolerance at most \(\tau\).  Every low block begins below
\(2^{S_M+1}=(M+2)^{O(1)}=n^{o(1)}\), so its fixed-tolerance envelope is also
below \(n^{1+\beta}\) eventually. \(\square\)

### Proof of [Theorem 1.1](#thm-fixed-polylog)

As \(\eta\uparrow1-a_0\),
\[
\frac12+\frac{\eta}{\log_2 3}
\uparrow\log_3 2=p_*.
\]
Continuity of relative entropy gives
\[
\sup_{\eta<1-a_0}b_{\rm ent}(\eta)
=D(p_*\|1/2)
=(1-H_2(p_*))\log2.
\tag{6.11}\label{eq:6-11}
\]

Fix the strict parameters in \eqref{eq:1-3}.  Choose
\[
a_0<r_{\rm hi}<1-\frac1{c\log2},
\qquad
0<\tau<\min\{r_{\rm hi}-a_0,\beta,a_0\}.
\tag{6.12}\label{eq:6-12}
\]
Because \(A>A_{\rm FP}\), equation \eqref{eq:6-11} permits fixed
\(\eta_{\rm lo},b_{\rm lo},c_2\) with
\[
0<b_{\rm lo}<b_{\rm ent}(\eta_{\rm lo}),
\qquad
0<c_2<\log2,
\qquad
\frac12<\frac{A\min\{b_{\rm lo},c_2\}}{\log2}.
\tag{6.13}\label{eq:6-13}
\]
Choose \(a_0+\eta_{\rm lo}<r_{\rm lo}<1\).  Next choose \(D\) and then
\(C_{\rm sw}\) so large that
\(D/\sqrt{C_{\rm sw}}\le\tau\),
\(C_{\rm sw}>A/\log2\), and \(p_{\rm hi}\) in \eqref{eq:6-9} exceeds every
fixed polynomial cost needed below.

Set
\[
L_M=\left\lceil A\log_2(M+2)\right\rceil.
\tag{6.14}\label{eq:6-14}
\]
Then \(L_M<S_M\) eventually.  From \eqref{eq:6-10}, every fixed
\[
0<\kappa<
\min\left\{
p_{\rm hi}-\frac52,
\frac{A\min\{b_{\rm lo},c_2\}}{\log2}-\frac12
\right\}
\tag{6.15}\label{eq:6-15}
\]
is admissible after a small strict decrease to absorb powers of
\(\log(M+2)\).  The choices above make this interval nonempty.  Moreover,
\[
2^{L_M}\le2(M+2)^A\ll_A(\log n)^A
\qquad(n\in I_M),
\tag{6.16}\label{eq:6-16}
\]
and
\[
\frac{M}{1-r_{\rm hi}}+O(\log M)
<cM\log2
\le c\log n
\tag{6.17}\label{eq:6-17}
\]
eventually.

For \(2^J\le X<2^{J+1}\), shells below \(J/2\) contain \(O(X^{1/2})\)
integers, while on the remaining shells \(M^{-\kappa}\ll J^{-\kappa}\).
Their dyadic sizes sum to \(O(X)\), proving \eqref{eq:1-4}.  Finally,
\eqref{eq:6-11} shows that the infimum of the strict exponents is exactly
\(1/(2(1-H_2(p_*)))\); the endpoint is not claimed. \(\square\)

## 7. Quantitative companions

### Proof of [Theorem 1.2](#thm-stretched-log)

Fix \(0<\delta<1\), put \(\alpha=1-\delta\), and choose a one-regime pair
\((r,\eta)\) satisfying \eqref{eq:5-1}, with
\[
r<1-\frac1{c\log2},
\qquad
\eta<\beta.
\tag{7.1}\label{eq:7-1}
\]
Take
\[
L_M=\left\lfloor\frac{(M\log2)^\alpha}{\log2}\right\rfloor.
\tag{7.2}\label{eq:7-2}
\]
The factor \(M(L_M+1)\) in \eqref{eq:5-11} is absorbed by the exponential tail, so
\[
\#\operatorname{Fail}_{M,L_M}
\le C2^M e^{-c'M^\alpha}.
\tag{7.3}\label{eq:7-3}
\]
For \(n\in I_M\),
\[
2^{L_M}\le\exp((M\log2)^\alpha)
\le\exp((\log n)^\alpha).
\]
The clock and path ceiling follow from \eqref{eq:5-12} and \eqref{eq:7-1}.
[Lemma 2.1](#lem-dyadic-sum), with
\(\sigma=\alpha\), proves \eqref{eq:1-5}. \(\square\)

### Raw-clock conversion

Let \(s_h(x)\) count the odd states among
\(x,T(x),\ldots,T^{h-1}(x)\).  Direct induction gives
\[
\operatorname{Col}^{h+s_h(x)}(x)=T^h(x).
\tag{7.4}\label{eq:7-4}
\]
If \(x\in W_\eta\) and \(h\le\lfloor\log_2x\rfloor\), the positive main
term in the affine iterate and the upper envelope in \eqref{eq:3-8} give
\[
s_h(x)\le\frac h2+\frac{\eta\log x}{\log3}.
\tag{7.5}\label{eq:7-5}
\]
Thus a one-regime chain has raw time at most
\[
\frac1{1-r}
\left(\frac3{2\log2}+\frac\eta{\log3}\right)\log n+o(\log n).
\tag{7.6}\label{eq:7-6}
\]
For the two-regime chain, \eqref{eq:7-6} applies to the high phase; the entire low
phase has \(O(S_M)=o(\log n)\) shortcut steps and at most twice as many raw
steps.  As \(r\downarrow a_0\) and \(\eta\downarrow0\), the coefficient in
\eqref{eq:7-6} tends to
\[
\frac3{\log(4/3)}.
\]
The high parameters in \eqref{eq:6-12} can therefore be chosen to satisfy any fixed
shortcut and raw budgets strictly above their respective limits.  To retain
the literal raw-orbit ceiling in [Corollary 1.3](#cor-raw-clock), run the
argument with an
internal exponent \(0<\beta'<\beta\).  Every additional raw odd image is
\(3m+1=2T(m)\), so
\(2n^{1+\beta'}\le n^{1+\beta}\) eventually.  This proves
[Corollary 1.3](#cor-raw-clock).
\(\square\)

### Fixed-power exceptional count

Fix \(\alpha>0\) and \(0<\sigma<1\).  Choose
\(0<\delta<1-\sigma\).  Then
\[
\exp((\log n)^{1-\delta})\le n^\alpha
\]
eventually, while \(1-\delta>\sigma\).
[Theorem 1.2](#thm-stretched-log) therefore implies
\eqref{eq:1-7}, after decreasing the positive exponential constant and absorbing the
finite startup.

## 8. Companion graded fixed-power clock {#sec-graded-clock}

For completeness, we retain the fixed-depth stopped-map pullback that gives
the sharper graded clock.  This companion is not a dependency of Theorems
1.1 or 1.2.

Fix \(r,\eta\) as in \eqref{eq:5-1}, put \(Y_M=2^{\lfloor rM\rfloor}\), enlarge
\(W_\eta\) on a finite startup interval, and let \(G(n)\) be the first
passage below \(Y_M\) on the certified part and the identity otherwise.
For \(S\subseteq\mathbb N\), set
\[
\operatorname{FPPull}_{r,\eta}(S)
=\widetilde W_\eta\cap G^{-1}(S).
\tag{8.1}\label{eq:8-1}
\]

### Proposition 8.1 (dense-set pullback) {#prop-dense-pullback}

For every fixed \(0<\chi<r\), there are \(K_{\rm FP},D_c>0\) such that,
whenever \(0<D\le D_c\), \eqref{eq:8-1} sends every \((C,D)\)-dense set to a
\[
\bigl(K_{\rm FP}(C+1)D^{-2},\chi D\bigr)\text{-dense set}.
\tag{8.2}\label{eq:8-2}
\]

#### Proof

For a source shell \(I_M\), the bad landing target has cardinality at most
\(CY_M^{1-D}\).  [Proposition 4.4](#prop-target-transport) gives at most
\(O(CM^22^MY_M^{-D})\) such sources.  Since
\[
Y_M^{-D}\le2\,2^{-rDM}
\]
and
\[
(M+1)^2e^{-(r-\chi)D M\log2}\ll_{r,\chi}D^{-2},
\]
this is
\(O((C+1)D^{-2}2^{(1-\chi D)M})\).
[Proposition 3.3](#prop-barrier-density) controls the
certification complement at a fixed positive exponent; choose \(D_c\) so
that this exponent is at least \(\chi D_c\).  Finite startup and geometric
shell summation give \eqref{eq:8-2}. \(\square\)

Put \(g=1-a_0\).  The envelope also gives the height-sensitive block bound
\[
\tau_{Y_M}(n)
\le
\left\lceil\frac{(1+\eta-r)M+2+\eta}{g}\right\rceil
\tag{8.3}\label{eq:8-3}
\]
for every sufficiently large certified source in \(I_M\).  Indeed,
\(\rho^h=2^{-gh}\), and the displayed ceiling makes
\(\rho^h n^{1+\eta}\le2^{\lfloor rM\rfloor}\).

Fix \(0<\alpha<1\) and \(\varepsilon>0\).  Choose
\(0<\alpha'<\alpha\) with
\[
c_*(\alpha-\alpha')<\frac\varepsilon3,
\]
then choose a fixed \(R\) and
\[
r=(\alpha')^{1/R}>a_0,
\qquad
r^R=\alpha'.
\]
Finally choose \(0<\eta<r-a_0\) so that
\[
c_*(1-\alpha')\frac\eta{1-r}<\frac\varepsilon3.
\tag{8.4}\label{eq:8-4}
\]
Repeated use of [Proposition 8.1](#prop-dense-pullback) at this fixed depth
produces a power-dense,
hence natural-density-one, set on which all \(R\) blocks are certified.  If
\(n_i\) are the block endpoints, then
\[
n_i\le K_*n^{r^i}
\tag{8.5}\label{eq:8-5}
\]
for a fixed \(K_*\).  Summing \eqref{eq:8-3} gives
\[
\begin{aligned}
k_R
&\le
\frac{1+\eta-r}{(1-a_0)\log2}
\frac{1-r^R}{1-r}\log n+O_{\alpha,\varepsilon}(1)\\
&=c_*(1-\alpha')
\left(1+\frac\eta{1-r}\right)\log n
+O_{\alpha,\varepsilon}(1).
\end{aligned}
\tag{8.6}\label{eq:8-6}
\]
The choices leave a strict margin for the fixed remainder.  Also
\(n_R\le K_*n^{\alpha'}\le n^\alpha\) eventually.  This proves the graded
clock in \eqref{eq:1-8}. \(\square\)

## 9. Scope

The argument proves an orbit-minimum statement on a set of natural density
one.  It does not prove descent for every starting value, exclude nontrivial
cycles, or control the orbit after the selected witness.  The endpoint
\(\delta=1\) is a strict parameter limit and is not claimed.  No finite
computation is used as an all-depth premise.

The headline proof consumes only the parity-vector bijection, the
maximal-barrier estimate, the first-passage reversal identity, the exact
reverse-product loss, nested direct re-certification, and the compressed
feasible-time support. The
dense-set pullback in [Section 8](#sec-graded-clock) is used only for the
companion graded clock.
In particular, no fixed-time endpoint-fiber moment, mixing statement,
Diophantine reduction, or generated-target equidistribution hypothesis is
used.  The Boolean walk in [Lemma 3.1](#lem-entropy-barrier) is only exact
counting over the parity words supplied by
[Proposition 2.2](#prop-parity-code), not a stochastic model of an individual
Collatz orbit.

## Research and software disclosure

Generative-AI systems were used in proof exploration, adversarial auditing,
finite diagnostics, formalization, and exposition.  The author selected the
theorem and proof architecture, reviewed the resulting artifacts, and accepts
responsibility for the manuscript.  Finite diagnostics are supporting
evidence only and are not premises of any theorem.

The separate Lean package formalizes the structural chain used above,
including support-sensitive loss-filtered transport, shrinking-barrier
re-certification, the square-root feasible-time support, the resulting
terminal profile, strict endpoint-parameter selection, the literal terminal
witness, and its same-witness orbit ceiling. Its public `Main` theorem has
the same strict ranges \(A>A_{\rm FP}\), \(c>c_*\), and \(\beta>0\) as
[Theorem 1.1](#thm-fixed-polylog), and its `badCount` is taken directly over
the integers lacking that displayed witness; no auxiliary good-set
quantifier remains in the public statement.  The Lean landing inequality is
strict, and therefore slightly stronger than the manuscript's weak landing
inequality.  The full package build, declaration-level
dependency report,
placeholder scan, and public-root axiom audit pass; the reported logical
dependencies are `propext`, `Classical.choice`, and `Quot.sound`.  These
artifacts are additional verification evidence, not manuscript premises.

## References

<span id="ref-allikvere">[1]</span> J. Allikvere, *Almost all Collatz orbits attain almost bounded values in
natural density*, version 2, preprint (2026),
[doi:10.5281/zenodo.21499244](https://doi.org/10.5281/zenodo.21499244).

<span id="ref-inselmann">[2]</span> M. Inselmann, *An approximation of the Collatz map and a lower bound for
the average total stopping time*, arXiv:2402.03276v3 (2024),
[doi:10.48550/arXiv.2402.03276](https://doi.org/10.48550/arXiv.2402.03276).

<span id="ref-korec">[3]</span> I. Korec, *A density estimate for the \(3x+1\) problem*, Math. Slovaca
44 (1994), no. 1, 85--89,
[DML-CZ record](https://dml.cz/handle/10338.dmlcz/133225).

<span id="ref-mazur">[4]</span> L. Mazur, *Natural-density almost-bounded Collatz orbits in logarithmic
time*, version 2, manuscript with companion formal artifact (21 July 2026),
[ProofAtlas PDF](https://www.proofatlas.ai/papers/natural-density-log-time-collatz/Mazur_Natural_Density_Collatz_Orbits_in_Logarithmic_Time_v2.pdf).

<span id="ref-tao">[5]</span> T. Tao, *Almost all orbits of the Collatz map attain almost bounded
values*, Forum Math. Pi **10** (2022), e12,
[doi:10.1017/fmp.2022.8](https://doi.org/10.1017/fmp.2022.8).

<span id="ref-terras">[6]</span> R. Terras, *A stopping time problem on the positive integers*, Acta
Arith. **30** (1976), 241--252.

<span id="ref-endpoint-v1">[7]</span> I. A. Shaik, *Quantitative Collatz Descent to
Stretched-Logarithmic Scale in Natural Density, with a Lean 4 Formalization*,
version 2.0.2, preprint (2026),
[doi:10.5281/zenodo.21851173](https://doi.org/10.5281/zenodo.21851173).
