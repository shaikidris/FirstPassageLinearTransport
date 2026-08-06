# First-Passage Linear Transport for Almost-All Collatz Descent

**Idris Ali Shaik**

Independent researcher

**Version:** 2.3.1 synchronized draft, Corollary 1.3 formally complete

**Content draft:** August 2026

**2020 Mathematics Subject Classification:** Primary 11B83; Secondary 37P99,
60G40

**Keywords:** Collatz map, natural density, first passage, stopping map,
parity vectors, stretched-logarithmic descent

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
For every fixed \(0<\delta<1\), we prove
\[
T_{\min}(n)
\leq
\exp\!\left((\log n)^{1-\delta}\right)
\]
on a set of natural density one.  More quantitatively, for every fixed
\(0<\sigma<1-\delta\), the exceptional count up to \(X\) is at most
\[
5X\exp\!\left(-c_{\delta,\sigma}(\log X)^\sigma\right)
\]
for all sufficiently large \(X\).  The descent is witnessed before
\(6.953\log n\) shortcut steps and before \(10.44\log n\) raw Collatz
steps, and the shortcut orbit up to that witness may be confined below
\(n^{1+\beta}\) for any separately fixed \(\beta>0\).  For every fixed
\(0<\alpha<1\) and \(\varepsilon>0\), a sharper graded clock reaches
\(n^\alpha\) before
\[
\left(\frac{2(1-\alpha)}{\log(4/3)}+\varepsilon\right)\log n
\]
shortcut steps.  The fixed-power exceptional set also satisfies
\(5X\exp(-c_{\alpha,\sigma}(\log X)^\sigma)\) for every fixed
\(0<\sigma<1\).

The proof is elementary once the parity-vector bijection is available.  A
maximal parity barrier supplies a dense set on which every logarithmic shell
enters a lower power scale.  Exact reversal at the first entrance forces all
sources in a tagged landing fiber to have one common odd count.  This gives
linear transport for every target subset of the landing shell.  A totalized
stopped map then iterates the transport through \(O(\log\log n)\) scales.

## 1. Introduction and main results

We work throughout with the shortcut Collatz map \(T\) displayed in the
abstract.  All unqualified logarithms are natural, and \(\log_2\) denotes
the base-two logarithm.  Here \(\mathbb N=\{1,2,3,\ldots\}\).  Put
\[
a_0=\frac{\log_2 3}{2},
\qquad
\rho=\frac{\sqrt3}{2}.
\tag{1.1}
\]

The proof below is organized around the first entrance below a shell-scaled
target.  It does not estimate a fixed-time endpoint distribution: the target
set in the transport theorem is arbitrary, and the stopped map is closed by
an identity branch on a finite startup interval.

This is a standalone V2 argument.  No fixed-time endpoint transport theorem is
a proof dependency of any result below.  A companion formalization accompanies
this version and is not used as manuscript evidence.

### Theorem 1.1 (stretched-logarithmic natural-density descent)

For every fixed \(0<\delta<1\),
\[
T_{\min}(n)
\leq
\exp\!\left((\log n)^{1-\delta}\right)
\tag{1.2}
\]
on a set of natural density one.  The endpoint \(\delta=1\) is not asserted.

### Corollary 1.2 (quantitative exceptional count)

For every fixed \(0<\delta<1\) and every \(0<\sigma<1-\delta\), there are
constants \(c_{\delta,\sigma}>0\) and \(X_{\delta,\sigma}\) such that
\[
\#\left\{1\leq n\leq X:
T_{\min}(n)>
\exp\!\left((\log n)^{1-\delta}\right)
\right\}
\leq
5X\exp\!\left(-c_{\delta,\sigma}(\log X)^\sigma\right)
\tag{1.3}
\]
for every \(X\geq X_{\delta,\sigma}\).

### Corollary 1.3 (time and orbit ceiling)

For every fixed \(0<\delta<1\), the density-one set in Theorem 1.1 may be
chosen so that every sufficiently large retained \(n\) has an integer
\[
0\leq k<6.953\log n
\tag{1.4}
\]
with
\[
T^k(n)
\leq
\exp\!\left((\log n)^{1-\delta}\right).
\tag{1.5}
\]
For every separately fixed \(\beta>0\), the set and witness may also be
chosen so that
\[
\max_{0\leq j\leq k}T^j(n)\leq n^{1+\beta}.
\tag{1.6}
\]

To compare clocks with papers using the raw Collatz map, put
\[
\operatorname{Col}(n)=
\begin{cases}
n/2,&n\equiv0\pmod2,\\
3n+1,&n\equiv1\pmod2.
\end{cases}
\]
For an odd input, one shortcut step is two raw steps; for an even input it is
one.  The shortcut orbit deletes only intermediate values \(3m+1>m\), so
\(T_{\min}(n)=\operatorname{Col}_{\min}(n)\).  The maximal parity barrier
retains enough pointwise odd-count information to sharpen the worst-case
factor two: the witness in Corollary 1.3 also occurs before
\(10.44\log n\) raw steps.

### Corollary 1.4 (timed fixed-power descent)

For every fixed \(\alpha>0\), there is a set \(S_\alpha\) of natural density
one such that every sufficiently large \(n\in S_\alpha\) has an integer
\(k\) satisfying
\[
0\leq k<6.953\log n,
\qquad
T^k(n)\leq n^\alpha.
\]

### Corollary 1.5 (quantitative fixed-power exceptional count)

For every fixed \(\alpha>0\) and every fixed \(0<\sigma<1\), there are
constants \(c_{\alpha,\sigma}>0\) and \(X_{\alpha,\sigma}\) such that
\[
\#\{1\leq n\leq X:T_{\min}(n)>n^\alpha\}
\leq
5X\exp\!\left(-c_{\alpha,\sigma}(\log X)^\sigma\right)
\tag{1.7}
\]
for every \(X\geq X_{\alpha,\sigma}\).

### Corollary 1.6 (smooth graded shortcut clock)

For every fixed \(0<\alpha<1\) and every fixed \(\varepsilon>0\), there is
a set \(S_{\alpha,\varepsilon}\) of natural density one such that every
sufficiently large \(n\in S_{\alpha,\varepsilon}\) has an integer \(k\)
with
\[
0\leq k<
\left(
\frac{2(1-\alpha)}{\log(4/3)}+\varepsilon
\right)\log n,
\qquad
T^k(n)\leq n^\alpha.
\tag{1.8}
\]

### Relation to previous almost-all results

The theorem should be read along several independent axes: density notion,
target scale, clock, and exceptional rate.  The closest comparisons are:

| Result | Status | Density | Target reached for almost all starts | Clock retained in the stated result | Quantitative exception |
|---|---|---|---|---|---|
| Korec [3] | published | natural | \(n^\theta\), every fixed \(\theta>a_0\) | not part of the cited theorem | not used here |
| Inselmann [2] | preprint | natural | \(n^\varepsilon\), every fixed \(\varepsilon>0\) | \(2\log n/\log(4/3)\) shortcut steps | density convergence |
| Tao [5] | published | logarithmic | every \(f(n)\to\infty\) | no single global clock in the headline theorem | logarithmic-density estimate |
| Mazur [4] | manuscript with a pinned formal artifact | natural | every \(f(n)\to\infty\) | \(<436\log n\) raw steps | fixed-target logarithmic rate |
| Allikvere [1] | preprint | natural | every \(f(n)\to\infty\) | \(<12\log n\) raw steps | \(O((\log N_0)^{-1/29}+X^{-1/2000})\) for a fixed target |
| This paper | standalone V2 | natural | \(\exp((\log n)^{1-\delta})\), every fixed \(0<\delta<1\) | \(<6.953\log n\) shortcut steps and \(<10.44\log n\) raw steps; graded shortcut clock (1.8) for fixed powers | \(5X\exp(-c(\log X)^\sigma)\), every fixed \(0<\sigma<1-\delta\); every fixed \(0<\sigma<1\) for fixed powers |

Thus the present target is smaller than every fixed power target, and hence
gives a stronger descent conclusion on that axis, but it is weaker than an
arbitrary diverging function.  In particular, this paper does not
claim to supersede the arbitrary-threshold conclusions of [1] or [4], and its
shortcut clock is on the scale already identified in [2].  Its distinct
contribution is a short, self-contained route to stretched-logarithmic
natural-density descent, a stretched-exponential-in-log exceptional rate for
that target, and a pointwise first-passage transport estimate valid for every
landing subset.  The last statement removes any need to prove that a target
generated by earlier blocks resembles a fresh random set.

The proof has four load-bearing steps.

1. The parity-vector bijection turns a complete dyadic shell into the
   uniform Boolean cube.
2. A maximal Boolean-walk estimate gives a power-dense all-prefix set.
3. First-passage reversal gives a pointwise tagged-fiber bound and hence
   linear transport for arbitrary targets.
4. A totalized stopped-map pullback iterates this transport without assuming
   that a generated target resembles a fresh random set.

## 2. Density, parity, and affine iterates

For \(S\subseteq\mathbb N\), put
\[
B_S(X)=\#\{1\leq n\leq X:n\notin S\}.
\]
We call \(S\) **\((C,D)\)-dense** if
\[
B_S(X)\leq C X^{1-D}
\qquad(X\geq1),
\tag{2.1}
\]
where \(C>0\) and \(0<D\leq1\).  Every such set has natural density one.

We use the following varying-rate shell summation.

### Lemma 2.1 (varying-rate dyadic summation)

Let \(0<\sigma\leq1\), \(A,\gamma>0\), and suppose that, for all
sufficiently large \(M\),
\[
\#\bigl(E\cap[2^M,2^{M+1})\bigr)
\leq A e^{-\gamma(M+4)^\sigma}2^M.
\tag{2.2}
\]
Then there are \(\gamma'>0\) and \(X_0\) such that
\[
\#(E\cap[1,X])
\leq(2A+1)X e^{-\gamma'(\log X)^\sigma}
\qquad(X\geq X_0).
\tag{2.3}
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
contributions proves (2.3). \(\square\)

For \(n\geq1\), define
\[
p_i(n)=\mathbf1_{\{T^i(n)\ \mathrm{odd}\}},
\qquad
s_k(n)=\sum_{i=0}^{k-1}p_i(n).
\tag{2.4}
\]

The exact parity coding below is classical in the stopping-time literature;
see, for example, Terras [6].  Its short proof is included because no external
result is needed by the argument.

### Proposition 2.2 (parity-vector bijection)

For every \(M\geq0\),
\[
n\bmod2^M
\longmapsto
(p_0(n),\ldots,p_{M-1}(n))
\tag{2.5}
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

### Proposition 2.3 (exact affine iterate)

For every \(n\geq1\) and \(k\geq0\),
\[
T^k(n)
=
\frac{3^{s_k(n)}}{2^k}n
+
\sum_{i=0}^{k-1}
\frac{p_i(n)3^{s_k(n)-s_{i+1}(n)}}{2^{k-i}}.
\tag{2.6}
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
\tag{3.1}
\]

### Lemma 3.1 (maximal Boolean-walk bound)

For \(M\geq1\) and \(h\geq0\),
\[
2^{-M}\#\{w\in\{0,1\}^M:H_M(w)>h\}
\leq2\exp\!\left(-\frac{2h^2}{M}\right).
\tag{3.2}
\]

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
shows that replacing any unexpanded node by its two children preserves the
total potential.  Take the frontier to consist of the first-crossing prefixes
together with all depth-\(M\) words that never cross.  Starting from the root,
its frontier sum is therefore \((\cosh\theta)^M\).  Each crossing node
contributes at least \(2^{-|u|}\cosh(2\theta h)\), so
\[
\Pr(H_M>h)
\leq\frac{(\cosh\theta)^M}{\cosh(2\theta h)}
\leq2\exp\!\left(\frac{M\theta^2}{2}-2\theta h\right).
\]
Here \(\cosh x\leq e^{x^2/2}\) and
\(\cosh x\geq e^{|x|}/2\).  Taking \(\theta=2h/M\) proves (3.2); the
case \(h=0\) is immediate. \(\square\)

Define
\[
r_k(n)=
\sum_{i=0}^{k-1}
\frac{p_i(n)}{3^{s_{i+1}(n)}2^{k-i}},
\qquad
d_k=s_k-\frac k2.
\tag{3.3}
\]
By Proposition 2.3,
\[
T^k(n)
=\rho^k n3^{d_k}
+(r_k(n)3^{k/2})3^{d_k}.
\tag{3.4}
\]

### Lemma 3.2 (uniform affine correction)

If \(H_M\leq h\), then for every \(1\leq k\leq M\),
\[
r_k(n)3^{k/2}
\leq
(2+\sqrt3)\left(1-\rho^k\right)3^h
<(2+\sqrt3)3^h.
\tag{3.5}
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
which is (3.5). \(\square\)

For \(0<\eta\leq1\), let \(W_\eta\) be the set of integers \(n\) such
that
\[
\rho^k n^{1-\eta}
\leq T^k(n)\leq
\rho^k n^{1+\eta}
\qquad
(0\leq k\leq\lfloor\log_2n\rfloor).
\tag{3.6}
\]

### Proposition 3.3 (density of the maximal-barrier set)

There are absolute constants \(K_W,c_W>0\) such that \(W_\eta\) is
\((K_W,c_W\eta^2)\)-dense for every \(0<\eta\leq1\).

#### Proof

Put \(L_3=\log_2 3\) and, on the shell
\(I_M=[2^M,2^{M+1})\cap\mathbb N\), choose
\[
h=\frac{\eta M}{2L_3}.
\]
Proposition 2.2 and Lemma 3.1 give
\[
\frac{\#\{n\in I_M:H_M(n)>h\}}{2^M}
\leq
2\exp\!\left(-\frac{\eta^2M}{2L_3^2}\right).
\tag{3.7}
\]
Assume \(H_M\leq h\), \(M\geq4\), and \(\eta M\geq2\).  Then
\[
3^h=2^{\eta M/2},
\qquad
n^\eta\geq2^{\eta M},
\qquad
2^{\eta M/2}\leq\frac12n^\eta.
\tag{3.8}
\]
Since \(|d_k|\leq h\), the multiplicative term in (3.4) lies between
\(\rho^k n^{1-\eta}\) and
\(\frac12\rho^k n^{1+\eta}\): indeed, (3.8) and \(n\geq2^M\) give
\[
3^{-h}=2^{-\eta M/2}\geq n^{-\eta},
\qquad
3^h=2^{\eta M/2}\leq\frac12n^\eta.
\]
By Lemma 3.2, the additive term is at most
\[
(2+\sqrt3)3^{2h}=(2+\sqrt3)2^{\eta M}.
\]
For \(k\leq M\) and \(n\geq2^M\),
\[
\frac12\rho^k n^{1+\eta}
\geq\frac12\rho^M2^{(1+\eta)M}
=\frac12 2^{(a_0+\eta)M}.
\]
Because \(2^{4a_0}=9>2(2+\sqrt3)\), this dominates the additive term
when \(M\geq4\).  Thus (3.6) holds through time \(M\).

If \(M<4\) or \(\eta M<2\), use the trivial shell bound.  Consequently
there are absolute \(K_{\rm sh},c_0>0\), with \(c_0<\log2\), such that
\[
\frac{\#(W_\eta^c\cap I_M)}{2^M}
\leq K_{\rm sh}e^{-c_0\eta^2M}
\tag{3.9}
\]
for every \(M\).  Summing the geometric shell series proves (2.1) with
\[
D=c_W\eta^2,
\qquad
c_W=\frac{c_0}{\log2},
\]
and a constant \(K_W\) uniform in \(0<\eta\leq1\), because
\(2e^{-c_0\eta^2}-1\geq2e^{-c_0}-1>0\). \(\square\)

## 4. First-passage linear transport

For real \(Y>1\), define
\[
\tau_Y(n)=\min\{h\geq0:T^h(n)\leq Y\}
\tag{4.1}
\]
when the set is nonempty.

### Lemma 4.1 (first-passage band and reverse product)

Let \(1<Y<2^M\), let \(n\in I_M\), and suppose
\(\tau_Y(n)=h\geq1\).  Write \(x_j=T^j(n)\), \(y=x_h\), and let \(s\)
be the number of odd values among \(x_0,\ldots,x_{h-1}\).  Then
\[
\frac Y2<y\leq Y
\tag{4.2}
\]
and
\[
n=
\frac{2^hy}{3^s}
\prod_{\substack{0\leq j<h\\x_j\ \mathrm{odd}}}
\left(1-\frac1{2x_{j+1}}\right).
\tag{4.3}
\]
Consequently, whenever \(h<2Y\),
\[
\left(1-\frac h{2Y}\right)\frac{2^hy}{3^s}
\leq n\leq\frac{2^hy}{3^s}.
\tag{4.4}
\]

#### Proof

The final crossing cannot be odd: otherwise
\(x_h=(3x_{h-1}+1)/2>x_{h-1}>Y\).  Hence \(x_{h-1}=2y\), proving
(4.2).  Reversing an even step gives \(x_j=2x_{j+1}\), while reversing an
odd step gives
\[
x_j=\frac{2x_{j+1}-1}{3}
=\frac23x_{j+1}\left(1-\frac1{2x_{j+1}}\right).
\]
Multiplication proves (4.3).  Every odd factor occurs before the final
crossing, so its following state is greater than \(Y\).  Therefore
\(\prod_i(1-u_i)\geq1-\sum_i u_i\) gives a lower product bound
\(1-s/(2Y)\geq1-h/(2Y)\); the upper bound is one. \(\square\)

For a tagged landing cell put
\[
F_{M,Y}(h,y)
=\#\{n\in I_M:\tau_Y(n)=h,\ T^h(n)=y\}.
\tag{4.5}
\]

### Lemma 4.2 (odd-count rigidity)

If \(h/(2Y)\leq1/3\), every source in a nonempty tagged fiber \((h,y)\)
has the same odd count.

#### Proof

If two sources had odd counts \(s_1<s_2\), put
\(A_i=2^hy/3^{s_i}\).  Then \(A_1\geq3A_2\), and (4.4) would give
\[
\frac{n_1}{n_2}
\geq3\left(1-\frac h{2Y}\right)\geq2.
\]
This is impossible for two integers in the half-open shell \(I_M\), whose
ratio is strictly smaller than two. \(\square\)

### Lemma 4.3 (tagged-fiber bound)

If \(h/(2Y)\leq1/3\), then
\[
F_{M,Y}(h,y)
\leq1+\frac{2h2^M}{2Y-h}.
\tag{4.6}
\]
In particular, if \(1\leq h\leq H\) and \(H/(2Y)\leq1/3\), then
\[
F_{M,Y}(h,y)
\leq\frac52H\frac{2^M}{Y}.
\tag{4.7}
\]
The estimates remain valid after arbitrary source restriction.

#### Proof

Lemma 4.2 fixes one odd count \(s\).  Put
\(A=2^hy/3^s\) and \(\varepsilon=h/(2Y)\).  By (4.4), every source lies
in \([(1-\varepsilon)A,A]\).  Nonemptiness and \(n<2^{M+1}\) give
\[
A<\frac{2^{M+1}}{1-\varepsilon}.
\]
The interval contains at most \(1+\varepsilon A\) integers, proving (4.6).
Under the second hypotheses, the nonconstant term is at most
\((3/2)H2^M/Y\), while \(1\leq H2^M/Y\), proving (4.7). \(\square\)

Put \(J_Y=(Y/2,Y]\cap\mathbb N\).

### Proposition 4.4 (arbitrary-target linear transport)

Let \(1<Y<2^M\), \(H\geq1\), and \(H/(2Y)\leq1/3\).  Every
\(B\subseteq J_Y\) satisfies
\[
\#\{n\in I_M:\tau_Y(n)\leq H,
\ T^{\tau_Y(n)}(n)\in B\}
\leq\frac52H^2\frac{2^M}{Y}|B|.
\tag{4.8}
\]
The same inequality holds after arbitrary source restriction.

#### Proof

Every landing belongs to \(J_Y\) by (4.2).  Since \(Y<2^M\), the passage
time is positive.  Sum (4.7) over the at most \(H|B|\) tagged cells
\((h,y)\). \(\square\)

## 5. A closed stopped map and its pullback

Fix
\[
a_0<r<1,
\qquad
0<\eta<r-a_0,
\tag{5.1}
\]
and put \(Y_M=2^{\lfloor rM\rfloor}\).  Choose \(M_0\) so large that,
for all \(M\geq M_0\),
\[
1<Y_M<2^M,
\qquad
\frac{M}{2Y_M}\leq\frac13,
\qquad
(a_0+\eta)M+1+\eta\leq\lfloor rM\rfloor.
\tag{5.2}
\]
If \(n\in W_\eta\cap I_M\), then (3.6) gives
\[
T^M(n)
\leq\rho^Mn^{1+\eta}
<2^{(a_0+\eta)M+1+\eta}
\leq Y_M.
\tag{5.3}
\]
Thus \(\tau_{Y_M}(n)\leq M\).

Put
\[
N_0=2^{M_0},
\qquad
\widetilde W_\eta=W_\eta\cup[1,N_0).
\tag{5.4}
\]
Define a total map \(G=G_{r,\eta}:\mathbb N\to\mathbb N\) and a block
length \(\ell:\mathbb N\to\mathbb N\) by
\[
(G(n),\ell(n))=
\begin{cases}
(T^{\tau_{Y_M}(n)}(n),\tau_{Y_M}(n)),
 &n\in W_\eta\cap I_M,\ M\geq M_0,\\
(n,0),&\text{otherwise}.
\end{cases}
\tag{5.5}
\]
Every \(G(n)\) is the actual iterate \(T^{\ell(n)}(n)\).  On
\(\widetilde W_\eta\),
\[
0\leq\ell(n)\leq\lfloor\log_2n\rfloor,
\qquad
G(n)\leq K_0n^r,
\qquad
K_0=N_0^{1-r}.
\tag{5.6}
\]
During every nontrivial block,
\[
T^j(n)\leq n^{1+\eta}
\qquad(0\leq j\leq\ell(n)).
\tag{5.7}
\]

For \(S\subseteq\mathbb N\), define
\[
\operatorname{FPPull}_{r,\eta}(S)
=\widetilde W_\eta\cap G^{-1}(S).
\tag{5.8}
\]

### Theorem 5.1 (first-passage dense-set pullback)

Fix \(r,\eta\) as above and \(0<\chi<r\).  There are constants
\(K_{\rm FP},D_c>0\), depending only on these fixed parameters, such that,
whenever \(0<D\leq D_c\), the pullback (5.8) sends every
\((C,D)\)-dense set to a
\[
\bigl(K_{\rm FP}(C+1)D^{-2},\chi D\bigr)\text{-dense set}.
\tag{5.9}
\]

#### Proof

By Proposition 3.3, \(\widetilde W_\eta\) is
\((C_\eta,D_\eta)\)-dense for fixed positive constants.  Choose
\[
D_c\leq\min\left\{1,\frac{D_\eta}{\chi}\right\},
\qquad
\chi D_c<1.
\tag{5.10}
\]
Let \(S\) be \((C,D)\)-dense, take \(M\geq M_0\), and put \(Y=Y_M\).
A source in \(I_M\) outside (5.8) either lies outside \(W_\eta\), or lies
in \(W_\eta\) and lands in \(B_M=S^c\cap J_Y\).  Since
\[
|B_M|\leq\#(S^c\cap[1,Y])\leq CY^{1-D},
\tag{5.11}
\]
Proposition 4.4 with \(H=M\) gives
\[
\#\{n\in W_\eta\cap I_M:G(n)\notin S\}
\leq\frac52CM^2 2^M Y^{-D}.
\tag{5.12}
\]
The floor costs only
\[
Y^{-D}=2^{-D\lfloor rM\rfloor}
\leq2\,2^{-rDM}.
\tag{5.13}
\]
Put \(q=(r-\chi)\log2>0\).  For \(0<D\leq1\),
\[
(M+1)^2e^{-qDM}
\leq D^{-2}(DM+1)^2e^{-qDM}
\leq C_qD^{-2},
\tag{5.14}
\]
where \(C_q=\sup_{x\geq0}(x+1)^2e^{-qx}<\infty\).  Hence (5.12) is at
most
\[
K_1(C+1)D^{-2}2^{(1-\chi D)M}.
\tag{5.15}
\]
The other bad sources satisfy
\[
\#(W_\eta^c\cap I_M)
\leq C_\eta2^{(M+1)(1-D_\eta)}
\leq K_2(C+1)D^{-2}2^{(1-\chi D)M}
\tag{5.16}
\]
by (5.10).  Increase the fixed constant to absorb the finitely many shells
below \(M_0\).  Summing the geometric shell series proves (5.9).  The
summation constant is uniform for \(0<D\leq D_c\): if
\(a_D=2^{1-\chi D}\), then
\[
\sum_{M=0}^{J}a_D^M
\leq\frac{a_D}{a_D-1}a_D^J,
\qquad
\frac{a_D}{a_D-1}
\leq
\frac{2}{2^{1-\chi D_c}-1}.
\]
Taking \(2^J\leq X<2^{J+1}\) now gives the defining global bound (2.1)
with exponent \(\chi D\). \(\square\)

### Lemma 5.2 (height-sensitive first-passage clock)

Put
\[
g=1-a_0>0.
\]
For the parameters in (5.1), define
\[
H_M=
\left\lceil
\frac{(1+\eta-r)M+2+\eta}{g}
\right\rceil.
\tag{5.17}
\]
After increasing the fixed startup shell if necessary,
\[
1\leq H_M\leq M,
\qquad
\tau_{Y_M}(n)\leq H_M
\quad(n\in W_\eta\cap I_M),
\tag{5.18}
\]
and
\[
H_M\leq
\frac{1+\eta-r}{g}M+\frac{2+\eta}{g}+1.
\tag{5.19}
\]
The stopped map and the dense-set pullback theorem are unchanged when this
shorter certified horizon replaces the coarse bound \(M\).

#### Proof

The strict condition \(\eta<r-a_0\) gives
\[
\frac{1+\eta-r}{g}<1,
\]
so (5.17) is between (1) and (M) on all sufficiently large shells.
The all-prefix envelope (3.6), the identity
\(\rho^h=2^{-gh}\), and \(n<2^{M+1}\) give
\[
T^{H_M}(n)
<2^{-gH_M+(1+\eta)(M+1)}
\leq2^{rM-1}
\leq2^{\lfloor rM\rfloor}=Y_M.
\tag{5.20}
\]
The middle inequality is precisely the ceiling inequality in (5.17); the
last uses \(\lfloor rM\rfloor\geq rM-1\).  This proves (5.18), and the
elementary upper bound for a ceiling proves (5.19).

Finally, Proposition 4.4 is already uniform in the horizon.  Since
\(H_M\leq M\), both
\[
\frac{H_M}{2Y_M}\leq\frac13
\quad\text{and}\quad
\frac52H_M^2\frac{2^M}{Y_M}|B|
\leq
\frac52M^2\frac{2^M}{Y_M}|B|
\tag{5.21}
\]
follow from the estimates used in Theorem 5.1.  Thus no density exponent or
pullback constant worsens. \(\square\)

## 6. Bootstrap and proof of the main theorem

Fix
\[
a_0<r<1,
\qquad
0<\eta<r-a_0,
\qquad
0<\chi<a_0.
\tag{6.1}
\]
Decrease the density exponent of \(\widetilde W_\eta\), if necessary, so
that it is \((C_0,D_0)\)-dense with \(0<D_0\leq D_c\).  Define
\[
\mathcal S_0=\widetilde W_\eta,
\qquad
\mathcal S_{j+1}
=\operatorname{FPPull}_{r,\eta}(\mathcal S_j).
\tag{6.2}
\]
Theorem 5.1 gives
\[
D_{j+1}=\chi D_j,
\qquad
C_{j+1}\leq K_{\rm FP}(C_j+1)D_j^{-2}.
\tag{6.3}
\]
Consequently
\[
D_j=D_0\chi^j,
\qquad
\log(C_j+2)=O(j^2).
\tag{6.4}
\]
For the second assertion, choose a fixed
\(A\geq\max\{1,K_{\rm FP}+2\}\).  Since \(D_j\leq1\),
\[
C_{j+1}+2\leq A(C_j+2)D_j^{-2}.
\]
Taking logarithms and summing
\(2\log(D_j^{-1})=2\log(D_0^{-1})+2j\log(1/\chi)\) proves (6.4).

If \(n\in\mathcal S_R\), put
\[
n_0=n,
\qquad
n_{i+1}=G(n_i)
\quad(0\leq i<R).
\tag{6.5}
\]
Induction in (6.2) gives
\[
n_i\in\mathcal S_{R-i}\subseteq\widetilde W_\eta
\qquad(0\leq i\leq R).
\tag{6.6}
\]
Thus (5.6) applies at every nonterminal stage, and a second induction gives
\[
n_i
\leq K_0^{1+r+\cdots+r^{i-1}}n^{r^i}
\leq K_*n^{r^i},
\qquad
K_*=K_0^{1/(1-r)}.
\tag{6.7}
\]
Every block is an actual Collatz segment, including the zero-step identity
branch.  Therefore
\[
n_R=T^{k_R}(n),
\qquad
k_R=\sum_{i=0}^{R-1}\ell(n_i).
\tag{6.8}
\]

For the outer shell \(I_M\), choose
\[
R_M=\lceil\omega\log(M+4)\rceil
\tag{6.9}
\]
with fixed \(\omega>0\), and define a varying-shell set \(\mathscr H\) by
\[
\mathscr H\cap I_M=\mathcal S_{R_M}\cap I_M.
\tag{6.10}
\]
Since \(R_M\leq\omega\log(M+4)+1\), (6.4) gives
\[
D_{R_M}
\geq D_0\chi(M+4)^{-\omega\log(1/\chi)},
\qquad
\log(C_{R_M}+2)=O((\log M)^2).
\tag{6.11}
\]
The exceptional proportion in \(I_M\) is at most
\[
2C_{R_M}\exp(-D_{R_M}M\log2).
\tag{6.12}
\]
Put \(\gamma=\omega\log(1/\chi)\).  Equations (6.11)--(6.12) show that
the logarithm of this proportion is at most
\[
O((\log M)^2)-cM^{1-\gamma}.
\tag{6.13}
\]
It tends to \(-\infty\) whenever
\[
\omega\log(1/\chi)<1.
\tag{6.14}
\]
After decreasing \(c\) and increasing the starting shell, the exceptional
proportion is at most
\[
2\exp\!\left(-c(M+4)^{1-\gamma}\right).
\tag{6.15}
\]
Lemma 2.1 proves that \(\mathscr H\) has natural density one and supplies the
global exceptional count.

On \(\mathscr H\cap I_M\), (6.7) and
\(R_M\geq\omega\log(M+4)\) give
\[
\log n_{R_M}
\leq
\log K_*+(M+1)\log2\,(M+4)^{-\omega\log(1/r)}.
\tag{6.16}
\]
Hence
\[
n_{R_M}
\leq\exp\!\left((\log n)^{1-\delta}\right)
\tag{6.17}
\]
for all sufficiently large \(M\), provided
\[
\delta<\omega\log(1/r).
\tag{6.18}
\]
Conditions (6.14) and (6.18) admit a common \(\omega\) exactly when
\[
\delta<\frac{\log(1/r)}{\log(1/\chi)}.
\tag{6.19}
\]

The time and intervening orbit are also controlled.  From (5.6) and (6.7),
\[
\ell(n_i)
\leq\log_2n_i
\leq r^i\log_2n+\log_2K_*.
\]
Summing the geometric progression and using
\(\log K_*=\log K_0/(1-r)\) gives
\[
k_R
\leq
\frac{\log n}{(1-r)\log2}
+\frac{R\log K_0}{(1-r)\log2}.
\tag{6.20}
\]

The same schedule admits a sharper raw Collatz clock.  Let \(s_h(x)\) be
the number of odd shortcut states among
\(x,T(x),\ldots,T^{h-1}(x)\).  Direct induction gives the exact identity
\[
\operatorname{Col}^{\,h+s_h(x)}(x)=T^h(x):
\]
an even shortcut letter costs one raw step, while an odd shortcut letter is
the two-step raw segment
\(x\mapsto3x+1\mapsto(3x+1)/2\).  Odd counts are additive under
concatenation.  For a nonstartup retained block beginning at
\(n_i\in I_{M_i}\), the maximal barrier gives
\[
s_{\ell(n_i)}(n_i)
\leq
\frac{\ell(n_i)}2+
\frac{\eta M_i}{\log_2 3}
\leq
\frac{\ell(n_i)}2+
\frac{\eta}{\log3}\log n_i.
\]
The startup identity branch contributes zero.  Hence the raw time
\(k_R^{\rm raw}\) corresponding to (6.8) satisfies
\[
\begin{aligned}
k_R^{\rm raw}
&\leq
\frac32\sum_{i<R}\ell(n_i)
+\frac{\eta}{\log3}\sum_{i<R}\log n_i\\
&\leq
\frac1{1-r}
\left(\frac3{2\log2}+\frac\eta{\log3}\right)\log n
+O(R).
\end{aligned}
\tag{6.20r}
\]
Here (6.7) gives
\(\sum_{i<R}\log n_i\leq(1-r)^{-1}\log n+O(R)\).
For the schedule (6.9), the remainder in (6.20r) is
\(O(\log\log n)=o(\log n)\).

If \(t_i=\sum_{m<i}\ell(n_m)\) and
\(t_i\leq j\leq t_{i+1}\), equations (5.7) and (6.7) give
\[
T^j(n)
\leq K_*^{1+\eta}n^{1+\eta}.
\tag{6.21}
\]

### Proof of Theorem 1.1 and Corollaries 1.2--1.6

For \(x=1/7\), the positive-term series for
\(\log((1+x)/(1-x))\) gives
\[
\log\frac43
>2\left(\frac17+\frac1{3\cdot7^3}\right)
=\frac{296}{1029}.
\]
Consequently
\[
\frac1{(1-a_0)\log2}
=\frac2{\log(4/3)}
<\frac{1029}{148}
<\frac{6953}{1000}.
\tag{6.22}
\]
The same rational lower bound also gives the strict raw-clock margin
\[
\log\frac43>\frac{296}{1029}>\frac{25}{87},
\qquad
\frac3{\log(4/3)}<\frac{261}{25}=10.44,
\tag{6.22r}
\]
because \(296\cdot87-25\cdot1029=27>0\).
Thus the strict interval
\[
a_0<r<1-\frac1{6.953\log2}
\tag{6.23}
\]
is nonempty.  As \(r\downarrow a_0\) in this interval and
\(\chi\uparrow a_0\) through strict choices below \(a_0\),
\[
\frac{\log(1/r)}{\log(1/\chi)}\longrightarrow1.
\tag{6.24}
\]
Given \(0<\delta<1\), choose fixed \(r,\chi\) so that (6.19) and (6.23)
hold, and choose \(0<\eta<r-a_0\).  Equations (6.8), (6.15), and (6.17)
prove Theorem 1.1.

For Corollary 1.2, fix \(0<\sigma<1-\delta\).  Since
\(\delta/(1-\sigma)<1\), choose the same strict parameters with
\[
q:=\frac{\log(1/r)}{\log(1/\chi)},
\qquad
\frac{\delta}{1-\sigma}<q.
\]
Choose
\[
\delta<\theta<q(1-\sigma),
\qquad
\omega=\frac{\theta}{\log(1/r)}.
\]
Then the descent exponent is \(\theta>\delta\), while the density-loss
exponent is \(\theta/q<1-\sigma\).  Thus (6.14), (6.18), and (6.15) hold
with shell exponent \(\sigma\), with the strict margin required by the
stretched-exponential domination.
Lemma 2.1 with \(A=2\) gives the prefactor \(5\) in (1.3).

For Corollary 1.3, (6.20), (6.23), and
\(R_M=O(\log M)=O(\log\log n)\) give
\[
k_{R_M}<6.953\log n
\]
for every sufficiently large retained \(n\).  Given \(\beta>0\), choose
\(\eta<\min\{r-a_0,\beta\}\).  The fixed factor in (6.21) is at most
\(n^{\beta-\eta}\) for all sufficiently large \(n\), proving (1.6).
For the raw clock, the leading coefficient in (6.20r) tends to
\(3/\log(4/3)\) as \(r\downarrow a_0\) and \(\eta\downarrow0\).
Equations (6.22r), (6.24), and the strict condition \(\delta<1\) therefore
allow the same parameters to be chosen so that
\[
\delta<\frac{\log(1/r)}{\log(1/\chi)},
\qquad
\frac1{1-r}
\left(\frac3{2\log2}+\frac\eta{\log3}\right)
<\frac{261}{25}.
\]
The strict margin absorbs the \(o(\log n)\) term in (6.20r), proving the
stated \(10.44\log n\) raw clock.

For Corollary 1.4, apply Corollary 1.3 with \(\delta=1/2\).  If
\(\alpha>0\), then \((\log n)^{-1/2}<\alpha\) for all sufficiently large
\(n\).  Multiplication by the positive quantity \(\log n\) gives
\[
(\log n)^{1/2}<\alpha\log n.
\]
After exponentiating,
\[
\exp\!\left((\log n)^{1/2}\right)
\leq \exp(\alpha\log n)=n^\alpha.
\]
Thus the same witness supplied by Corollary 1.3 satisfies the fixed-power
landing inequality without changing the \(6.953\log n\) clock.

For Corollary 1.5, fix \(\alpha>0\) and \(0<\sigma<1\), and choose a fixed
\(\delta\) with
\[
0<\delta<1-\sigma.
\]
Then
\[
(\log n)^{1-\delta}=o(\log n),
\]
so
\[
\exp\!\left((\log n)^{1-\delta}\right)\leq n^\alpha
\]
for every sufficiently large \(n\).  Thus, apart from finitely many initial
values, the exceptional set in (1.7) is contained in the exceptional set in
(1.3).  Apply Corollary 1.2.  Decreasing its positive constant and increasing
the startup threshold absorb the finite initial contribution while retaining
the prefactor \(5\): explicitly, replace its constant \(c_0\) by
\(c_0/2\); then
\[
5X\left(e^{-(c_0/2)(\log X)^\sigma}
-e^{-c_0(\log X)^\sigma}\right)\longrightarrow\infty,
\]
so it eventually dominates the fixed initial count.  This proves (1.7).

For Corollary 1.6, put
\[
c_*=\frac1{(1-a_0)\log2}=\frac2{\log(4/3)}.
\]
Fix \(0<\alpha<1\) and \(\varepsilon>0\).  Choose
\(0<\alpha'<\alpha\) with
\[
c_*(\alpha-\alpha')<\frac\varepsilon3.
\]
Choose a fixed integer \(R\geq1\) so large that
\[
r=(\alpha')^{1/R}>a_0;
\]
then \(0<r<1\) and \(r^R=\alpha'\).  Finally choose
\(0<\eta<r-a_0\) so small that
\[
c_*(1-\alpha')\frac\eta{1-r}<\frac\varepsilon3.
\tag{6.25}
\]
Apply the fixed-depth version of (6.2) with this \(R\).  Repeated use of
Theorem 5.1 shows that \(\mathcal S_R\) is power-dense, hence has natural
density one.  Lemma 5.2 and (6.7) give, with a fixed horizon constant
\(C_h=(2+\eta)/(1-a_0)+1\),
\[
\begin{aligned}
k_R
&\leq
\frac{1+\eta-r}{1-a_0}
\sum_{i=0}^{R-1}\log_2n_i+C_hR\\
&\leq
\frac{1+\eta-r}{(1-a_0)\log2}
\frac{1-r^R}{1-r}\log n+O_{\alpha,\varepsilon}(1)\\
&=
c_*(1-\alpha')
\left(1+\frac\eta{1-r}\right)\log n
+O_{\alpha,\varepsilon}(1).
\end{aligned}
\tag{6.26}
\]
The choices of \(\alpha'\) and \(\eta\) leave at least
\(\varepsilon/3\) to absorb the fixed remainder, and hence give the clock
in (1.8) for all sufficiently large \(n\).  At the terminal stage, (6.7)
gives
\[
n_R\leq K_*n^{r^R}=K_*n^{\alpha'}\leq n^\alpha
\]
eventually, since \(\alpha'<\alpha\).  This proves Corollary 1.6.
\(\square\)

## 7. Scope

The argument proves an orbit-minimum statement on a set of natural density
one.  It does not prove descent for every starting value, exclude nontrivial
cycles, or control the orbit after the selected witness.  The endpoint
\(\delta=1\) is a strict parameter limit and is not claimed.  No finite
computation is used as an all-depth premise.

The proof consumes only the parity-vector bijection, the maximal-barrier
estimate, the first-passage reversal identity, and the resulting stopped-map
pullback.  In particular, no fixed-time endpoint-fiber moment or generated
target equidistribution hypothesis is used.

## Research and software disclosure

Generative-AI systems were used in proof exploration, adversarial auditing,
finite diagnostics, formalization, and exposition.  The author selected the
theorem and proof architecture, reviewed the resulting artifacts, and accepts
responsibility for the manuscript.  The finite diagnostic is supporting
evidence only and is not a premise of any theorem.  The separate V2 Lean
package formalizes the timed natural-density theorem, the quantitative
exceptional counts in Corollaries 1.2 and 1.5, both clock refinements and the
same-witness intermediate-orbit ceiling in Corollary 1.3, and the graded clock
in Corollary 1.6.  The manuscript proof remains self-contained and does not
use the formal artifact as evidence.  Its public `Main` module records the
piecewise shortcut and raw Collatz maps, their literal iterates, the
missing-count definition of natural density one, and the two descent
predicates in a semantic dictionary; these are concrete definitions rather
than abstract hypotheses of the formal theorems.

## References

[1] J. Allikvere, *Almost all Collatz orbits attain almost bounded values in
natural density*, version 2, preprint (2026),
[doi:10.5281/zenodo.21499244](https://doi.org/10.5281/zenodo.21499244).

[2] M. Inselmann, *An approximation of the Collatz map and a lower bound for
the average total stopping time*, arXiv:2402.03276v3 (2024),
[doi:10.48550/arXiv.2402.03276](https://doi.org/10.48550/arXiv.2402.03276).

[3] I. Korec, *A density estimate for the \(3x+1\) problem*, Math. Slovaca
44 (1994), no. 1, 85--89,
[DML-CZ record](https://dml.cz/handle/10338.dmlcz/133225).

[4] L. Mazur, *Natural-density almost-bounded Collatz orbits in logarithmic
time*, version 2, manuscript with companion formal artifact (21 July 2026),
[ProofAtlas PDF](https://www.proofatlas.ai/papers/natural-density-log-time-collatz/Mazur_Natural_Density_Collatz_Orbits_in_Logarithmic_Time_v2.pdf).

[5] T. Tao, *Almost all orbits of the Collatz map attain almost bounded
values*, Forum Math. Pi **10** (2022), e12,
[doi:10.1017/fmp.2022.8](https://doi.org/10.1017/fmp.2022.8).

[6] R. Terras, *A stopping time problem on the positive integers*, Acta
Arith. **30** (1976), 241--252.
