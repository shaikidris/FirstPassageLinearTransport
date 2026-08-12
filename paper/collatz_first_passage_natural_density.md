# Polylogarithmic Natural-Density Descent for the Collatz Map

**Idris Ali Shaik**

Independent researcher

**Version:** 3.2 research draft, timeout proof of shell-dependent descent

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
\kappa_*=1-H_2(\log_3 2),
\qquad
A_{\rm FP}=\frac1{2(1-H_2(\log_3 2))}
=9.9911133419\ldots,
\qquad
c_* = \frac2{\log(4/3)}
=6.9521189935\ldots,
\]
where \(H_2\) is binary entropy.  For every fixed
\(A>A_{\rm FP}\), \(c>c_*\), and \(\beta>0\), and every
\(0<\gamma<\kappa_*(A-A_{\rm FP})\), all but
\(O_{A,c,\beta,\gamma}(X/(\log X)^\gamma)\) integers \(n\le X\)
possess a shortcut-Collatz iterate, before \(c\log n\) steps, satisfying
\[
T^k(n)\le C_{\rm tar}(\log n)^A,
\qquad
\max_{0\le j\le k}T^j(n)\le n^{1+\beta}.
\]
More sharply, the fixed exponent may approach the critical value.  For every
fixed \(D>0\), the target can be replaced by
\[
C_{\rm tar}(\log n)^{A_{\rm FP}}
(\log\log n)^{2A_{\rm FP}}(\log\log\log n)^D,
\]
with exceptional count
\(O_{D,c,\beta,\gamma}(X/(\log\log\log X)^\gamma)\) for every
\(0<\gamma<D\kappa_*\).  More generally, the final factor may be replaced,
on a natural-density-one set, by any prescribed function of
\(\log\log n\) tending to infinity.  The pure target
\(C(\log n)^{A_{\rm FP}}\), and the critical secondary scale with a bounded
final multiplier, are not asserted.

For the weaker target \(\exp((\log n)^{1-\delta})\), the same method gives
the sharper exceptional count
\[
O_{\delta,c,\beta}\!\left(
X\exp(-\gamma_{\delta,c,\beta}(\log X)^{1-\delta})
\right)
\]
for every fixed \(0<\delta<1\), \(c>c_*\), and \(\beta>0\); the same witnesses
give every clock constant greater than \(3/\log(4/3)\) for the
unaccelerated Collatz map.

The proof counts the possible parity words exactly for integers in each range
\([2^M,2^{M+1})\).  At large scales, a bound on every parity prefix controls
the orbit; at small scales, the terminal odd-step count controls blocks that
fail to cross their next threshold in time.  The remaining argument is
deterministic.  Because the thresholds decrease, each later failure occurs at
the first crossing of a lower threshold by the original orbit.  The
large-scale prefix bounds restrict
the possible cumulative crossing times to \(O(\sqrt{M\log M})\) values.
Counting only those times replaces a linear loss by a square-root loss and
yields the displayed exponent.  The result is an almost-all statement and
makes no claim for every starting value.

## 1. Introduction and main results

We ask how small a value can be forced along the Collatz orbit of almost every
initial integer in ordinary natural density, while retaining a logarithmic
witnessing time and a bound on the orbit before that witness.

We work throughout with the shortcut Collatz map
\[
T(n)=
\begin{cases}
n/2,&n\equiv0\pmod2,\\
(3n+1)/2,&n\equiv1\pmod2.
\end{cases}
\]
One application of \(T\) is one shortcut step, and we write
\(T_{\min}(n)=\min_{k\ge0}T^k(n)\).  All unqualified logarithms are natural,
\(\log_2\) denotes the base-two logarithm, and
\(\mathbb N=\{1,2,3,\ldots\}\).  For \(M\ge0\), let
\[
I_M=[2^M,2^{M+1})\cap\mathbb N
\]
be the \(M\)-th dyadic shell; we call \(M\) its shell rank.  A set
\(S\subseteq\mathbb N\) has natural density one if
\[
\frac{\#(S\cap[1,X])}{X}\longrightarrow1.
\]
Put
\[
a_0=\frac{\log_2 3}{2}.
\tag{1.1}\label{eq:1-1}
\]
Thus \(a_0-1\) is the mean base-two logarithm of the multiplicative main
term under the exact uniform parity coding used below; the affine correction
is treated separately before the first-passage argument begins.

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
The subscript \({\rm FP}\) records that this exponent comes from the
first-passage argument.

### Where the constants come from

The two constants in \eqref{eq:1-2} record the two quantitative costs of the
proof.  First,
\[
1-a_0=\frac{\log_2(4/3)}2,
\qquad
c_*=\frac1{(1-a_0)\log2}.
\]
Thus \(1-a_0\) is the mean base-two logarithmic loss of the multiplicative
main term per shortcut step, and \(c_*\log n\) is the corresponding
mean-drift clock for clearing \(\log_2n\) bits.  This interpretation does not
assert a matching lower bound or optimality theorem.  Second, put
\[
\kappa_*=1-H_2(p_*).
\]
The terminal odd-step count on a shell has an exact binomial law.  Suppose the
iteration stops at a shell rank \(L=L(M)\).  The upper tail at the critical
proportion \(p_*\) has exponential rate \(\kappa_*\log2\) and prefactor of
order \(L^{-1/2}\).  The proof also
sums over \(O(\sqrt{M\log M})\) possible first-passage times and pays a factor
of order \(L\) for the reverse loss.  Together these terms leave the
exponent margin
\[
\kappa_*L-\frac12\log_2M-\log_2\log M.
\]
Its divergence is the endpoint condition in the main theorem.  For
\(L\sim A\log_2M\), the leading power changes sign at
\(A\kappa_*=1/2\), giving \(A_{\rm FP}=1/(2\kappa_*)\).  At equality the
remaining logarithmic margin forces an additional slowly growing factor.
Thus \(A_{\rm FP}\) is a threshold of the present argument rather than an
intrinsic constant of the Collatz map.

The main theorem permits a bounded exponent sequence \((A_M)\), fixed in
advance, with one exponent for each shell \(I_M\).  This single formulation
includes every fixed exponent \(A>A_{\rm FP}\) and also exponents that approach
\(A_{\rm FP}\).  The exact admissibility condition is part of the statement;
its most useful explicit specializations follow immediately afterward.

::: {.theorem-block}

### Theorem 1.1 (shell-dependent polylogarithmic descent) {#thm-moving-polylog}

Let \((A_M)_{M\ge0}\) be a bounded real sequence and put
\[
L_M=\left\lceil A_M\log_2(M+2)\right\rceil,
\qquad
\Delta_M=
\kappa_*L_M-\frac12\log_2(M+2)-\log_2\log(M+3).
\tag{1.3}\label{eq:1-3}
\]
Assume
\[
\Delta_M\longrightarrow+\infty.
\tag{1.4}\label{eq:1-4}
\]
For every fixed \(c>c_*\) and \(\beta>0\), there are constants
\(C_{\rm tar},C_{\rm exc},\varepsilon>0\) and \(M_0\) such that the following
holds.  Let \(\mathcal E_M\) be the set of \(n\in I_M\) for which no integer
\(0\le k<c\log n\) simultaneously satisfies
\[
T^k(n)\le C_{\rm tar}(\log n)^{A_M},
\qquad
\max_{0\le j\le k}T^j(n)\le n^{1+\beta}.
\]
Then, for every \(M\ge M_0\),
\[
\boxed{
\frac{\#\mathcal E_M}{2^M}
\le C_{\rm exc}\left(2^{-\Delta_M}+M^{-\varepsilon}\right).}
\tag{1.5}\label{eq:1-5}
\]
Consequently these simultaneous witnesses exist on a set of natural density
one.

:::

The ceiling in \(L_M\) changes \(\Delta_M\) by only \(O(1)\).  Hence, when
\(A_M\to A_{\rm FP}\), condition \eqref{eq:1-4} is equivalently
\[
\kappa_*(A_M-A_{\rm FP})\log M-\log\log M\longrightarrow+\infty.
\tag{1.6}\label{eq:1-6}
\]

### Corollary 1.2 (explicit descent scales) {#cor-endpoint-profiles}

Fix \(c>c_*\) and \(\beta>0\).  In each of the following statements the
landing has a constant \(C_{\rm tar}>0\), occurs before \(c\log n\) shortcut
steps, and its witness satisfies
\(\max_{j\le k}T^j(n)\le n^{1+\beta}\).

1. For every fixed \(A>A_{\rm FP}\) and every
   \(0<\gamma<\kappa_*(A-A_{\rm FP})\), the target
   \[
   C_{\rm tar}(\log n)^A
   \]
   fails for at most \(O_{A,c,\beta,\gamma}(X/(\log X)^\gamma)\) integers
   \(n\le X\).

2. For every fixed \(B>1/\kappa_*=2A_{\rm FP}\) and every
   \(0<\gamma<B\kappa_*-1\), the target
   \[
   C_{\rm tar}(\log n)^{A_{\rm FP}}(\log\log n)^B
   \]
   fails for at most
   \(O_{B,c,\beta,\gamma}(X/(\log\log X)^\gamma)\) integers \(n\le X\).

3. For every fixed \(D>0\) and every \(0<\gamma<D\kappa_*\), the target
   \[
   C_{\rm tar}(\log n)^{A_{\rm FP}}
   (\log\log n)^{2A_{\rm FP}}(\log\log\log n)^D
   \tag{1.7}\label{eq:1-7}
   \]
   fails for at most
   \(O_{D,c,\beta,\gamma}(X/(\log\log\log X)^\gamma)\) integers \(n\le X\).

More generally, the final factor in \eqref{eq:1-7} may be replaced, on a
natural-density-one set, by \(\Omega(\log\log n)\) for any prescribed
function \(\Omega(x)\to\infty\).  The constants and the retained set may
depend on \(\Omega,c,\beta\).

Every target above is \(o(n)\), so it is a genuine descent for all sufficiently
large \(n\).  The assertions are density-one rather than pointwise.  Neither
the landing constant \(C_{\rm tar}\) nor the onset of the asymptotic comparison
is made effective.

::: {.theorem-block}

### Theorem 1.3 (quantitative stretched-logarithmic descent) {#thm-stretched-log}

For every fixed \(0<\delta<1\), \(c>c_*\), and \(\beta>0\), there are
constants \(C_{\delta,c,\beta},\gamma_{\delta,c,\beta},
X_{\delta,c,\beta}>0\)
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
\exp(-\gamma_{\delta,c,\beta}(\log X)^{1-\delta}).
\tag{1.8}\label{eq:1-8}
\]
The endpoint \(\delta=1\) is not asserted.

:::

### Corollary 1.4 (raw clock) {#cor-raw-clock}

Put
\[
\operatorname{Col}(n)=
\begin{cases}
n/2,&n\equiv0\pmod2,\\
3n+1,&n\equiv1\pmod2.
\end{cases}
\]
For every fixed \(\beta>0\) and
\[
c_{\rm raw}>\frac3{\log(4/3)},
\tag{1.9}\label{eq:1-9}
\]
the conclusions and exceptional-set estimates in
[Theorem 1.1](#thm-moving-polylog),
[Corollary 1.2](#cor-endpoint-profiles), and
[Theorem 1.3](#thm-stretched-log) remain valid for \(\operatorname{Col}\),
with an integer \(\ell<c_{\rm raw}\log n\) and the raw-orbit ceiling
\[
\max_{0\le j\le\ell}\operatorname{Col}^j(n)\le n^{1+\beta}.
\]
Since \(3/\log(4/3)=10.42817849\ldots\), the explicit constant \(10.44\)
remains admissible.

### Corollary 1.5 (fixed powers and the graded clock) {#cor-fixed-power}

For every fixed \(\alpha>0\), the exceptional set for
\(T_{\min}(n)>n^\alpha\) is
\[
O_{\alpha,\sigma}\!\left(
X\exp(-c_{\alpha,\sigma}(\log X)^\sigma)
\right)
\tag{1.10}\label{eq:1-10}
\]
for every fixed \(0<\sigma<1\).

If \(0<\alpha<1\), then for every fixed \(\varepsilon>0\) the same
fixed-power target is also reached on a natural-density-one set before
\[
\left(
\frac{2(1-\alpha)}{\log(4/3)}+\varepsilon
\right)\log n
\tag{1.11}\label{eq:1-11}
\]
shortcut steps.  Thus the clock decreases continuously with the amount of
logarithmic height that remains: for example, the limiting coefficient at
\(\alpha=1/2\) is \(1/\log(4/3)=3.47605949\ldots\), rather than the full
descent coefficient \(c_*\).

### Terminology and recurring notation

We use the following terms consistently.  A *threshold* is a dyadic value
\(2^q\) that the orbit seeks to cross from above.  Its *first passage* is the
first iterate at or below that threshold, and the value reached there is the
*landing*.  Successive landings that start new passages are called
*checkpoints*; together they form a decreasing *threshold chain*.

A *certificate* is a condition on the parity data that guarantees the stated
orbit bounds.  At high shell ranks the certificate controls every parity
prefix and hence every intermediate iterate.  At low ranks the proof instead
uses a *timeout*: failure to cross the next threshold within the allotted
number of steps.  The *switch rank* separates these high and low phases.
*Transport* means counting sources in the original shell whose first-passage
landing lies in a specified target set.

A *witnessing time* is an iterate at which the asserted descent has occurred.
The *same-witness orbit ceiling* bounds every earlier iterate through that
same time; it is not a statement about the remainder of the orbit.  The
global symbols \(T,\operatorname{Col},T_{\min},I_M,a_0,p_*,\kappa_*,
A_{\rm FP}\), and \(c_*\) retain the meanings fixed above.  Symbols used only
inside one proof stage are introduced at the start of the section where they
are needed; in particular, the high- and low-phase parameters are collected
at the beginning of Section 6.

### Proof architecture

The proof has two sharply separated parts and six load-bearing steps.  Its
only probabilistic input is exact counting of parity words on a dyadic shell;
the first-crossing estimates and the assembly of the decreasing threshold
chain are deterministic.

**Exact probabilistic certification.**

1. Every parity word of length \(M\) occurs exactly once on the shell \(I_M\).
2. Counting words with an atypical prefix gives an exponentially small
   exceptional set and bounds the orbit at every time in the block.

**Deterministic Collatz transport and assembly.**

3. First-passage reversal bounds the number of sources for each fixed passage
   time and landing value, while retaining the accumulated effect of the
   additive \(+1\) terms.
4. Along a decreasing threshold chain, every later landing is also a direct
   first passage from the original source shell.
5. Rank-dependent high barriers confine every time at which certification can
   first fail to a common set of size \(O(\sqrt{M\log M})\).
6. Summing only over the feasible passage times and using the critical tail
   for small-shell blocks that do not cross in time give the exact margin
   \(\Delta_M\).  Its positive divergence yields the principal exponent
   \(A_{\rm FP}\).

Steps 3 and 4 are the shared deterministic part of the proof.  Applying them
with one fixed barrier gives the stretched-logarithmic exceptional rate.
Applying them with shrinking large-scale bounds and the small-scale timeout
test gives both the fixed polylogarithmic targets and the shell-dependent
exponent in the headline.

The diagram below shows this division and the flow from one dyadic shell to
successively lower thresholds.

![The proof architecture.  Panel (a) follows an actual shortcut-Collatz orbit
inside the certified high-rank envelope and marks successive threshold
landings; below the switch, the timeout rule replaces low-rank certification.
Panel (b) records
the proved reduction in the number of possible cumulative passage times;
bar lengths are schematic and do not encode the unspecified constant in
Lemmas 6.1 and 6.3.](fig-architecture.svg){#fig-architecture}

### Relation to previous almost-all results

The preceding endpoint-transport preprint [[7]](#ref-endpoint-v1) proves the
range \(0<\delta<0.251245530155874\ldots\) by a fixed-time
endpoint-fiber/Rényi estimate followed by endpoint iteration.  The present
proof is independent of that theorem.  It replaces fixed-time endpoint
transport by high-rank all-prefix certification, first-passage reversal,
direct passage along decreasing thresholds, a small-rank timeout tail, and
aggregation over only the possible passage times.

The main obstruction is not the contraction of one typical block, but the
transport of sparse certification failures through a generated sequence of
landings.  Direct aggregation over every time up to the horizon incurs a
linear loss.  Step 5 above reduces the possible times to
\(O(\sqrt{M\log M})\) possibilities; this linear-to-square-root reduction is
the quantitative pivot of the paper.

The published results of Korec and Tao, the preprint of Inselmann, and the two
recent Tao-to-natural-density bridge manuscripts are compared below only on
the coordinates used in their stated theorems.  Publication status and proof
lineage are recorded in the surrounding prose and references rather than in
the table.

| Work | Density | Target reached for almost all starts | Clock or quantitative feature |
|---|---|---|---|
| Korec [[3]](#ref-korec) | natural | \(n^\theta\), every fixed \(\theta>a_0\) | no clock or quantitative exception used here |
| Inselmann [[2]](#ref-inselmann) | natural | \(n^\varepsilon\), every fixed \(\varepsilon>0\) | \(2\log n/\log(4/3)\) shortcut steps; density convergence |
| Tao [[5]](#ref-tao) | logarithmic | every \(f(n)\to\infty\) | no single global clock in the headline theorem; logarithmic-density estimate |
| Mazur [[4]](#ref-mazur) | natural, bridged from Tao's logarithmic-density framework | every \(f(n)\to\infty\) | \(<436\log n\) unaccelerated steps; fixed-target logarithmic rate |
| Allikvere [[1]](#ref-allikvere) | natural, bridged from Tao's logarithmic-density framework | every \(f(n)\to\infty\) | \(<12\log n\) unaccelerated steps; \(O((\log N_0)^{-1/29}+X^{-1/2000})\) for a fixed target |
| This paper | natural | \((\log n)^{A_{\rm FP}}(\log\log n)^{2A_{\rm FP}}\Omega(\log\log n)\), every \(\Omega\to\infty\); also every fixed \((\log n)^A\), \(A>A_{\rm FP}\) | every shortcut constant \(>c_*\); every unaccelerated constant \(>3/\log(4/3)\); target-dependent quantitative rates and an orbit-height bound through the witnessing time |

[Theorem 1.1](#thm-moving-polylog) additionally bounds every preceding
iterate through the same witnessing time:
\(\max_{j\le k}T^j(n)\le n^{1+\beta}\).  This bound is not part of the
headline statements in [[1]](#ref-allikvere) or [[4]](#ref-mazur); this is a
comparison of stated outputs, not a claim that their proof-internal trajectory
estimates cannot yield related bounds.

The moving polylogarithmic target is smaller than every fixed power and every
fixed stretched-logarithmic target in [Theorem 1.3](#thm-stretched-log), but
it still contains the fixed divergent core
\((\log n)^{A_{\rm FP}}(\log\log n)^{2A_{\rm FP}}\).  It is therefore weaker
than an arbitrary diverging function.  At the target-only level, Tao's theorem
specializes to every target displayed here, albeit in logarithmic rather than
natural density.  Thus the present theorem does not supersede the
arbitrary-threshold conclusions of [[1]](#ref-allikvere) or
[[4]](#ref-mazur).  Conversely, those target statements do not supply the
present natural-density rates, logarithmic clock, or orbit-height bound,
and the clock scale already appears in [[2]](#ref-inselmann).  These axes are
deliberately not collapsed into a single ordering.

Allikvere conditions Tao's Syracuse/Fourier inputs on the total valuation and
supplies a uniform-measure transfer.  Mazur starts from the same
logarithmic-density frontier and adds a quantitative phase-gap and two-adic
lift.  Their shared bridge architecture differs from the exact
Boolean-cube certification and deterministic first-passage transport
separation displayed above.

## 2. Density, parity, and affine iterates

The argument uses three common tools: a shell-to-prefix summation rule, exact
parity coding on each dyadic shell, and an affine formula for the iterate.
This section establishes all three before they are used.

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
More generally, if a nonnegative sequence \(e_M\to0\) satisfies
\[
\#(E\cap I_M)\le e_M2^M
\tag{2.3a}\label{eq:2-3a}
\]
for all sufficiently large \(M\), then \(E\) has natural density zero.

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
contributions proves \eqref{eq:2-3}.

For the final assertion, fix \(\epsilon>0\) and choose \(M_0\) so that
\(e_M\le\epsilon\) for \(M\ge M_0\).  The finitely many earlier shells
contribute \(o(X)\).  If \(2^J\le X<2^{J+1}\), the remaining shells contribute
at most
\[
\epsilon\sum_{M=M_0}^{J}2^M\le2\epsilon X.
\]
Letting \(\epsilon\downarrow0\) proves natural density zero. \(\square\)

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

## 3. A dense set with controlled parity prefixes {#sec-barrier}

The parity bijection identifies a complete dyadic shell with the Boolean
cube.  We now discard the sparse words whose prefixes deviate too far from
their mean and obtain the pathwise orbit envelope needed to guarantee the
first passages used later.

For a parity word of length \(M\), put
\[
Y_k=2s_k-k,
\qquad
H_M=\max_{0\leq k\leq M}\left|s_k-\frac k2\right|
=\frac12\max_{0\leq k\leq M}|Y_k|.
\tag{3.1}\label{eq:3-1}
\]

For \(0<p,q<1\), write
\[
D(p\|q)=p\log\frac pq+(1-p)\log\frac{1-p}{1-q}
\]
for binary relative entropy.  For \(0\le t<1/2\), put
\[
\mathcal I(t)
=D\!\left(\frac12+t\,\middle\|\,\frac12\right)
=\left(\frac12+t\right)\log(1+2t)
+\left(\frac12-t\right)\log(1-2t).
\tag{3.2}\label{eq:3-2}
\]

### Lemma 3.1 (maximal deviation of parity prefixes) {#lem-entropy-barrier}

If \(M\ge1\) and \(0\le h<M/2\), then
\[
2^{-M}\#\{w\in\{0,1\}^M:H_M(w)>h\}
\leq2\exp\!\left(-M\mathcal I(h/M)\right).
\tag{3.3}\label{eq:3-3}
\]
In particular, the right side is at most
\(2\exp(-2h^2/M)\).

Moreover, if \(0<t_0\le t\le t_1<1/2\), then there is a constant
\(C_{t_0,t_1}\) such that, for every \(M\ge1\),
\[
2^{-M}\#\{w:H_M(w)>tM\}
\le C_{t_0,t_1}M^{-1/2}e^{-M\mathcal I(t)}.
\tag{3.3a}\label{eq:3-3a}
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
convexity estimate \(\mathcal I(t)\ge2t^2\), gives the quadratic assertion.

It remains to prove \eqref{eq:3-3a}.  Put
\(a=\lfloor2tM\rfloor+1\).  Reflection, followed by symmetry between the two
boundary signs, gives
\[
\Pr(H_M>tM)
\le4\Pr(Y_M\ge a-1).
\tag{3.3b}\label{eq:3-3b}
\]
This form is insensitive to the parity of \(a\): replacing the terminal
threshold by the next reachable lattice point only decreases the event.  If
\[
k_0=\left\lceil\frac{M+a-1}{2}\right\rceil,
\qquad p_M=\frac{k_0}{M},
\]
then the probability on the right of \eqref{eq:3-3b} is
\(2^{-M}\sum_{k=k_0}^{M}\binom Mk\).  For \(k\ge k_0\), consecutive terms
have ratio
\[
\frac{\binom M{k+1}}{\binom Mk}=\frac{M-k}{k+1}.
\]
Uniformly for \(t_0\le t\le t_1\), this ratio is at most a fixed number
strictly below one once \(M\) exceeds a fixed startup.  The tail is therefore
at most a fixed multiple of its first term.  Uniform Stirling inequalities,
with \(p_M\) confined to a compact subset of \((0,1)\), give
\[
2^{-M}\binom M{k_0}
\le C M^{-1/2}
 \exp\{-M D(p_M\|1/2)\}.
\]
Here \(p_M=1/2+t+O(M^{-1})\), uniformly in the displayed compact interval.
The derivative of \(D(p\|1/2)\) is bounded on a slightly larger compact
interval, so
\[
M D(p_M\|1/2)=M\mathcal I(t)+O(1).
\]
Absorbing this bounded error and the finite startup into
\(C_{t_0,t_1}\) proves \eqref{eq:3-3a}. \(\square\)

Set
\[
\rho:=\frac{\sqrt3}{2}=2^{a_0-1}.
\]
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

### Proposition 3.3 (density of the controlled-prefix set) {#prop-barrier-density}

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
Indeed, before this uniform replacement the slack is
\(\left(1-2^{-(1-\lambda)\eta M}\right)\rho^k n^{1+\eta}\).
Over all \(0\leq k\leq M\) and \(n\in I_M\), its minimum occurs at
\(k=M\) and at the lower shell endpoint \(n=2^M\), which gives
\eqref{eq:3-15}.
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

## 4. First-passage linear transport {#sec-transport}

The barrier identifies a sparse set of bad orbit values.  To count the
original sources that reach such values, we must transport an arbitrary set
of bad landings back to the original shell.  Exact reversal at the first
crossing, together with a bound that retains the reverse-product loss,
provides that bridge.

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

Write the reverse product in \eqref{eq:4-3} as
\(\prod_{j<h}(1-u_j)\), where
\[
u_j(n)=
\begin{cases}
\dfrac1{2T^{j+1}(n)},&T^j(n)\text{ odd},\\[2mm]
0,&T^j(n)\text{ even},
\end{cases}
\qquad
E_Y(n)=Y\sum_{j=0}^{h-1}u_j(n).
\tag{4.5}\label{eq:4-5}
\]
The factor \(Y\) records the additive reverse loss at the target scale:
\(E_Y/Y\) is an additive upper bound for the defect of the reverse product.
It also makes concatenation compatible with changing thresholds.  If a
segment is measured locally at \(Y'\geq Y\), then its contribution after
rescaling to the final threshold \(Y\) is exactly \(Y/Y'\) times its local
contribution to \(E_{Y'}\).  Thus segment losses add after rescaling, which is
the coordinate used below to bound the total loss along a decreasing
threshold chain.
The elementary product inequality gives
\[
1-\frac{E_Y(n)}Y
\le\prod_{j=0}^{h-1}(1-u_j(n))\le1.
\tag{4.6}\label{eq:4-6}
\]

### Lemma 4.2 (fixed-time landing fibers with bounded reverse loss) {#lem-loss-filtered-fibers}

Let \(D\ge0\), and suppose
\[
\frac DY\le\frac13.
\tag{4.7}\label{eq:4-7}
\]
For a fixed pair \((h,y)\), the number of sources \(n\in I_M\) satisfying
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
\tag{4.8}\label{eq:4-8}
\]

#### Proof

Put \(P(n)=\prod_{j<h}(1-u_j(n))\).  By [Lemma 4.1](#lem-first-passage),
if two such sources had odd
counts \(s_1<s_2\), put \(A_i=2^hy/3^{s_i}\).  Then
\(A_1\ge3A_2\), while \eqref{eq:4-3} and \eqref{eq:4-6} give
\[
n_1=A_1P(n_1)
\ge3A_2\left(1-\frac DY\right)
\ge2A_2\ge2n_2.
\]
This is impossible in the half-open shell \(I_M\).  The argument uses
only positive products and introduces no division by a reverse product.
Fix the common odd count and put
\(A=2^hy/3^s\).  All sources lie in
\([(1-D/Y)A,A]\).  Nonemptiness, \eqref{eq:4-7}, and \(n<2^{M+1}\) imply
\(A<(3/2)2^{M+1}\), so this interval has length less than
\[
3D\frac{2^M}{Y}.
\]
This proves \eqref{eq:4-8}. \(\square\)

### Proposition 4.3 (transport of a landing set with bounded reverse loss) {#prop-loss-transport}

Put \(J_Y=(Y/2,Y]\cap\mathbb N\).  Let \(1<Y<2^M\).  Under
\eqref{eq:4-7}, every \(B\subseteq J_Y\) satisfies the
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
\tag{4.9}\label{eq:4-9}
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
\tag{4.10}\label{eq:4-10}
\]
The estimate remains valid after arbitrary source restriction.

#### Proof

Since \(Y<2^M\), every passage time is positive.  Sum
[Lemma 4.2](#lem-loss-filtered-fibers) over the at most \(H|B|\) pairs to
obtain \eqref{eq:4-9}.  The contribution \(H|B|\) is at most
\(H(2^M/Y)|B|\), which gives \eqref{eq:4-10}. \(\square\)

## 5. Threshold chains, direct passage, and reverse loss

This section proves two deterministic facts used by both main arguments.
First, sequential crossings of decreasing thresholds collapse to one direct
first passage from the original shell.  Second, their reverse losses
telescope.  The final theorem applies these facts with one fixed barrier; the
next section retains the same two facts and changes how failure is detected at
small shell ranks.

For example, suppose an orbit first enters below \(2^{30}\), and from that
landing later first enters below \(2^{27}\).  No earlier point of the original
orbit was below \(2^{30}\), hence none was below the smaller threshold
\(2^{27}\); the second landing is therefore the original orbit's first entry
below \(2^{27}\).  The first lemma iterates this elementary observation along
the whole decreasing threshold chain.

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
We call the points \(n_i\) the checkpoints of the chain.
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

### Lemma 5.1 (direct passage along decreasing thresholds) {#lem-nested-passage}

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

The proof uses only that the thresholds decrease strictly and that every
executed block is a genuine first passage to its threshold.  We will use this
generic form in Section 6 for the mixed high-rank/timeout chain; no
certification condition on the low checkpoints is required.

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

### Lemma 5.2 (total reverse loss at a threshold) {#lem-rank-loss}

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

More generally, the same calculation applies to any finite chain of genuine
first-passage blocks for which the threshold ranks are distinct and decreasing,
each block has duration at most its parent rank \(m_j\), and
\(q_j+1>r_*m_j\) for one fixed \(r_*>0\).  Its scaled reverse loss at the
final threshold rank \(q_i\) is then less than \((q_i+2)/r_*\).  This is the
form used for the timeout chain in Proposition 6.4.

Let \(\operatorname{Fail}_{M,L}\) denote the sources whose chain reaches a
certification failure before it reaches rank below \(L\).

### Theorem 5.3 (fixed-barrier failure bound) {#thm-terminal-profile}

Under \eqref{eq:5-1}, for the fixed startup rank \(M_0\) chosen above there
is a constant \(C>0\) such that, for all integers \(M\ge L\ge M_0\),
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

Increase \(M_0\), if necessary, so that
\[
\frac{q+2}{r2^q}\le\frac13
\tag{5.13}\label{eq:5-13}
\]
for every \(q\ge M_0\).  In [Proposition 4.3](#prop-loss-transport), the
available horizon satisfies
\(H\le M/(1-r)+1\ll_r M\), while with \(D=(q+2)/r\) one has
\(1+3D\ll_r q+1\).  Combining \eqref{eq:4-10} with \eqref{eq:5-9}
therefore bounds the proportion of sources whose first failed landing has
rank \(q\) by
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

## 6. Shrinking prefix bounds and compressed passage times

[Theorem 5.3](#thm-terminal-profile) shows what the shared direct-passage and
reverse-loss facts yield with one fixed certificate and a linear time
horizon.  For the stronger shell-dependent exponent, we retain those facts
but
shrink the high-rank barrier and replace low-rank certification by a timeout
tail.  The resulting set of possible cumulative times is much smaller.

The parameters used below fall into four groups.  This table is a roadmap;
the displayed equations following it give the precise definitions and the
order in which the constants are chosen.

| Symbols | Role | Definition or constraint |
|---|---|---|
| \(A_M,L_M,\Delta_M\) | terminal schedule and its remaining exponent margin | fixed in [Theorem 1.1](#thm-moving-polylog); \(L_M\asymp\log M\) and \(\Delta_M\to\infty\) in the main application |
| \(r_{\rm hi}\) | threshold ratio at high ranks | initially \(a_0<r_{\rm hi}<1\); strengthened for the final clock in \eqref{eq:6-18} |
| \(\tau\) | cap on the high-rank tolerance | initially \(0<\tau<r_{\rm hi}-a_0\); also chosen below \(\beta\) and \(a_0\) in \eqref{eq:6-18} |
| \(D_{\rm hi}\) | coefficient of the shrinking high-rank tolerance | chosen large enough in [Proposition 6.4](#prop-rank-buffer) to make high failures polynomially small |
| \(C_{\rm sw},S_M\) | switch coefficient and switch rank | \(S_M=\lceil C_{\rm sw}\log(M+2)\rceil\); \(C_{\rm sw}\) is chosen after \(D_{\rm hi}\) so that \(D_{\rm hi}/\sqrt{C_{\rm sw}}\le\tau\) and \(L_M<S_M\) eventually |
| \(\eta_{M,m}\) | high-rank tolerance at parent rank \(m\) | derived from \(\tau,D_{\rm hi},M,m\) in \eqref{eq:6-3} |
| \(K_0,r_L,q_L\) | bounded-gap low timeout rule | \(K_0>0\) is fixed, \(r_L=1-K_0/(2L)\), and \(q_L(m)=\lfloor r_Lm\rfloor\) |
| \(r_*\) | uniform ratio used only in the reverse-loss estimate | a fixed rational with \(0<r_*<r_{\rm hi}\) and, eventually, \(r_*<r_{L_M}\) |

Thus only \(r_{\rm hi},\tau,D_{\rm hi},C_{\rm sw},K_0\), and \(r_*\)
are choices made inside the argument; the remaining quantities are determined
by those choices and the prescribed terminal schedule.

Choose fixed high-rank data
\[
a_0<r_{\rm hi}<1,
\qquad
0<\tau<r_{\rm hi}-a_0,
\tag{6.1}\label{eq:6-1}
\]
and choose the high switch and tolerance below.
For constants \(D_{\rm hi},C_{\rm sw}>0\), put
\[
S_M=\left\lceil C_{\rm sw}\log(M+2)\right\rceil,
\tag{6.2}\label{eq:6-2}
\]
and, at a high parent rank \(m\ge S_M\), certify with
\[
\eta_{M,m}
=\min\left\{\tau,
D_{\rm hi}\sqrt{\frac{\log(M+2)}m}\right\}.
\tag{6.3}\label{eq:6-3}
\]
The high-rank stage construction at tolerance \(\tau\) remains valid after
lowering its tolerance to \(\eta_{M,m}\); the density of the resulting
rank-dependent certification sets will be estimated separately below.

Fix \(M\), write \(S=S_M\), and start with \(n_0=n\in I_M\),
\(m_0=M\), and elapsed time \(H_0=0\).  If
\(n_0\notin W_{\eta_{M,M}}\), stop with an initial high failure.
Otherwise, while a certified checkpoint \(n_i\in I_{m_i}\) has \(m_i\ge S\),
set
\[
q_i=\lfloor r_{\rm hi}m_i\rfloor,\qquad
h_i=\tau_{2^{q_i}}(n_i),\qquad
n_{i+1}=T^{h_i}(n_i),\qquad
H_{i+1}=H_i+h_i.
\tag{6.4}\label{eq:6-4}
\]
If the landing is the upper endpoint \(2^{q_i}\) and \(q_i\le S\), follow its
deterministic halving orbit to the terminal rank and stop successfully; this
costs at most \(S\) further steps and cannot create a timeout.  If the landing
is \(2^{q_i}\) with \(q_i>S\), stop with a high endpoint failure.  Every
nonendpoint landing lies in the unique shell \(I_{q_i-1}\).  If \(q_i-1<S\),
hand it to the timeout rule defined below; if \(q_i-1\ge S\), test it against
\(W_{\eta_{M,q_i-1}}\).  Its first failed test is a high failure, and a
successful landing becomes the next checkpoint.  As before, a failed landing
is never reused.

### Lemma 6.1 (possible passage times at large ranks) {#lem-time-support}

There is a constant \(K>0\), depending only on the fixed parameters, such
that, for every outer shell \(I_M\) and every threshold rank \(q\) reached by
the high stopped chain, all cumulative first-passage times to its landing band
belong to a finite set \(\mathcal H^{\rm hi}_{M,q}\) satisfying
\[
\#\mathcal H^{\rm hi}_{M,q}
\le K\sqrt{(M+2)\log(M+2)}.
\tag{6.5}\label{eq:6-5}
\]

#### Proof

Write \(g=1-a_0\).  Consider one high certified block from a parent shell
\(I_m\) to threshold \(2^q\), and let \(h\) be its duration and
\(t=\eta_{M,m}\).  The two deterministic orbit envelopes and the
first-passage band give
\[
(1-t)m-q
\le gh
<(1+t)(m+1)-q+1.
\tag{6.6}\label{eq:6-6}
\]
Thus
\[
\left|gh-(m-q)\right|\le tm+t+2.
\tag{6.6a}\label{eq:6-6a}
\]

The next computation shows that all intermediate shell ranks telescope away,
leaving a corridor centered only at the outer rank \(M\) and the final
threshold rank \(q\).

Suppose high blocks \(0,\ldots,j\) have been executed.  Every landing before
the last is certified and lies in
\((2^{q_i-1},2^{q_i}]\).  It cannot equal \(2^{q_i}\): if it did, then at
time \(q_i\) its certification lower bound would be
\[
\rho^{q_i}(2^{q_i})^{1-t}
=2^{(a_0-t)q_i}>1
=T^{q_i}(2^{q_i}),
\]
because every high tolerance satisfies \(t<a_0\).  Hence each certified
landing lies in the unique shell \(I_{q_i-1}\), and therefore
\[
m_{i+1}=q_i-1\qquad(0\le i<j).
\tag{6.6b}\label{eq:6-6b}
\]
This removes the apparent rank branching.  In particular,
\[
\sum_{i=0}^{j}(m_i-q_i)=M-q_j-j.
\tag{6.6c}\label{eq:6-6c}
\]
Summing \eqref{eq:6-6a}, using \eqref{eq:6-6c}, and paying one additional
unit per block to change the center from \(M-q_j-j\) to \(M+1-q_j\), gives
the exact cumulative corridor
\[
\left|gH_{j+1}-\bigl((M+1)-q_j\bigr)\right|
\le
\sum_{i=0}^{j}(t_i m_i+t_i+3).
\tag{6.6d}\label{eq:6-6d}
\]

For every block,
\[
t_i m_i\le D_{\rm hi}\sqrt{m_i\log(M+2)},\qquad t_i\le\tau,
\]
and \eqref{eq:6-6b} gives
\(m_{i+1}\le r_{\rm hi}m_i\).  The resulting geometric square-root sum is
\(O(\sqrt{M\log(M+2)})\), so the right side of \eqref{eq:6-6d} has the
same order.

For fixed \(M\) and \(q_j=q\), the center in \eqref{eq:6-6d} is fixed.
Consequently every feasible integer \(H_{j+1}\) lies in one interval of
length \(O(\sqrt{M\log(M+2)})\); counting its integer points proves
\eqref{eq:6-5}.  No union over intermediate high-rank histories remains.
\(\square\)

The fixed-time, fixed-landing count also has the following restricted-time
form.  If
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
\tag{6.7}\label{eq:6-7}
\]
This is [Proposition 4.3](#prop-loss-transport) summed only over the declared
times.  No interval structure or density hypothesis on \(\mathcal H\)
is used.

### Proposition 6.2 (density of large-rank failures) {#prop-shrinking-high-density}

Assume
\[
\frac{D_{\rm hi}}{\sqrt{C_{\rm sw}}}\le\tau
\qquad\text{and}\qquad
1\le S_M\le M.
\]
Put
\[
c_0=\frac1{2(\log_2 3)^2},
\qquad
C_0=2e^{4c_0}.
\]
For a high threshold rank \(q\), define the complete landing-band target
\[
B^{\rm sh}_{M,S_M,q}
=\{2^q\}\cup
\bigl(I_{q-1}\setminus W_{\eta_{M,q-1}}\bigr).
\]
Then the cap in \eqref{eq:6-3} is inactive at every \(m\ge S_M\), and
\[
\eta_{M,m}^2m=D_{\rm hi}^2\log(M+2).
\tag{6.8a}\label{eq:6-8a}
\]
Moreover,
\[
\frac{\#(I_M\setminus W_{\eta_{M,M}})}{2^M}
\le C_0(M+2)^{-c_0D_{\rm hi}^2},
\tag{6.8b}\label{eq:6-8b}
\]
and, for every \(q\) with \(S_M\le q-1\),
\[
\frac{|B^{\rm sh}_{M,S_M,q}|}{2^q}
\le 2^{-q}+\frac{C_0}{2}(M+2)^{-c_0D_{\rm hi}^2}.
\tag{6.8c}\label{eq:6-8c}
\]

#### Proof

From \(m\ge S_M\ge C_{\rm sw}\log(M+2)\),
\[
D_{\rm hi}\sqrt{\frac{\log(M+2)}m}
\le\frac{D_{\rm hi}}{\sqrt{C_{\rm sw}}}\le\tau.
\]
This proves that the cap is inactive and gives \eqref{eq:6-8a}.

For completeness, the uniform quadratic estimate used here is
\[
\frac{\#(I_m\setminus W_t)}{2^m}
\le C_0e^{-c_0t^2m}
\qquad(0<t\le1).
\tag{6.8d}\label{eq:6-8d}
\]
When \(m\ge4\) and \(tm\ge2\), apply [Lemma 3.1](#lem-entropy-barrier) at
height \(tm/(2\log_2 3)\) and use
\(\mathcal I(u)\ge2u^2\); the correction argument of
[Lemma 3.2](#lem-affine-correction) then gives the required orbit envelope.
Outside this startup regime, \(t^2m\le4\), so the trivial shell bound is
absorbed by \(C_0=2e^{4c_0}\).  Thus \eqref{eq:6-8d} is uniform in \(t\).
Applying it with \(t=\eta_{M,M}\) and using \eqref{eq:6-8a} proves
\eqref{eq:6-8b}.

For \(q\ge1\), the landing band lies in \(I_{q-1}\) apart from its single
upper endpoint \(2^q\).  Apply \eqref{eq:6-8d} in \(I_{q-1}\), divide by
\(2^q\), and use \eqref{eq:6-8a} at \(m=q-1\).  This gives
\eqref{eq:6-8c}. \(\square\)

Consequently the initial high failure and every high-rank landing target
have a common density bound
\[
d_{\rm hi}(M)
\ll (M+2)^{-p_{\rm hi}},
\qquad
p_{\rm hi}
=\min\{C_{\rm sw}\log2,c_0D_{\rm hi}^2\},
\tag{6.9}\label{eq:6-9}
\]
where \(c_0>0\) is the fixed constant in the quadratic prefix-deviation
bound.  The first
term in the minimum pays for the dyadic endpoint boundary at the switch.

### Critical timeout estimate at small shell ranks

The high construction ends when its landing enters below \(S_M\).  At these
smaller shell ranks, the proof no longer controls every parity prefix.  It
replaces that positive all-prefix certificate by a terminal failure test: if
the orbit has not crossed its next threshold by the allowed time, then its
final odd-step count must be unusually large.  That count has the exact
binomial law of [Proposition 2.2](#prop-parity-code), so its tail can be
estimated directly.

Accordingly, declare a low block successful exactly when it reaches its next
threshold before its parent-shell rank expires.

Let \(L=L_M\asymp\log M\), fix \(K_0>0\), and put
\[
r_L=1-\frac{K_0}{2L},
\qquad
q_L(m)=\lfloor r_Lm\rfloor.
\tag{6.10}\label{eq:6-10}
\]
For sufficiently large \(L\), one has \(0<r_L<1\) and
\(q_L(m)<m\) whenever \(m\ge L\).  For \(x\in I_m\), define the low timeout
event without assuming eventual hitting:
\[
\operatorname{To}_{L,m}(x)
\iff
T^j(x)>2^{q_L(m)}
\quad\text{for every }0\le j\le m.
\tag{6.11}\label{eq:6-11}
\]
If this event fails, the least \(0\le h\le m\) with
\(T^h(x)\le2^{q_L(m)}\) is an actual successful first-passage block.

When the high stopped chain above lands in a shell below \(S=S_M\), admit
that landing to the low rule without another all-prefix test.  At a low
checkpoint \(x_i\in I_{m_i}\), stop successfully
if \(m_i<L\).  Otherwise test \(\operatorname{To}_{L,m_i}(x_i)\); stop at its
first occurrence, and if it does not occur execute the least successful
passage just described.  If the new threshold rank is below \(L\), stop
successfully; otherwise continue from the physical landing.  Every successful
low transition has duration at most \(m_i\) and next shell rank at most
\(q_L(m_i)<m_i\).  Thus the low run is total, closes on its own output, and
terminates after at most \(S+1\) stages.  Let
\(\operatorname{Fail}^{\rm to}_{M,L}\) be the union of the unchanged initial
and first high failures with the unique first low timeout.

### Lemma 6.3 (timeout targets and feasible times) {#lem-timeout-low-phase}

Fix \(C>1\).  Uniformly for \(L\le m\le CL\), after one fixed startup,
\[
\boxed{
\frac{\#\{x\in I_m:\operatorname{To}_{L,m}(x)\}}{2^m}
\ll_{C,K_0}m^{-1/2}2^{-\kappa_*m}.}
\tag{6.12}\label{eq:6-12}
\]
Moreover, for every sufficiently large outer rank \(M\) and every possible
first-timeout landing band \(p\), the cumulative times at which that band is
reached lie in a finite set \(\mathcal H^{\rm to}_{M,p}\) satisfying
\[
\#\mathcal H^{\rm to}_{M,p}
\ll\sqrt{(M+2)\log(M+2)}.
\tag{6.13}\label{eq:6-13}
\]

#### Proof

Let \(s=s_m(x)\).  The exact affine iterate \eqref{eq:2-6} gives
\[
T^m(x)<2\cdot3^s+3^s=3^{s+1},
\]
because \(x<2^{m+1}\) and the additive sum is less than \(3^s\).
A timeout has \(T^m(x)>2^{q_L(m)}\), and therefore
\[
s>q_L(m)\log_3 2-1.
\tag{6.14}\label{eq:6-14}
\]
By [Proposition 2.2](#prop-parity-code), \(s_m\) has the exact
\(\operatorname{Bin}(m,1/2)\) counting law on \(I_m\).  In the declared
range, the right side of \eqref{eq:6-14}, divided by \(m\), is
\[
p_*+O_{C,K_0}(L^{-1}).
\]
These thresholds eventually lie in one compact subinterval of \((1/2,1)\).
The ratio of consecutive terms in the upper binomial tail is then bounded
strictly below one, so the tail is at most a fixed multiple of its first
term.  Stirling's inequality and the bounded derivative of
\(D(p\|1/2)\) on that interval give
\[
2^{-m}\sum_{s\ge p m}\binom ms
\ll
m^{-1/2}\exp\{-mD(p\|1/2)\}
\ll m^{-1/2}2^{-\kappa_*m},
\]
because \(D(p_*\|1/2)=\kappa_*\log2\) and \(m/L\le C\).
This proves \eqref{eq:6-12}, including the harmless integer rounding of the
first tail index.

It remains to identify the target set and its possible passage times.
Suppose the first timeout occurs at a low checkpoint \(x_i\).  That checkpoint
is the landing of the preceding successful block; let \(p\) be that block's
threshold rank.  The generic form recorded after
[Lemma 5.1](#lem-nested-passage) collapses the preceding threshold chain,
making
\(H_i\) the direct first-passage time of the original source below \(2^p\), with
\[
x_i\in(2^{p-1},2^p].
\]
The upper endpoint cannot time out, since a power of two crosses every lower
dyadic threshold by repeated halving.  Hence \(x_i\in I_{p-1}\).  Since the
run would already have stopped below rank \(L\), and timeouts occur only below
the switch,
\[
L+1\le p\le S.
\]
Thus the first-timeout target in the landing band is
\[
\mathcal C^{\rm to}_{L,p}
=\{y\in(2^{p-1},2^p)\cap\mathbb N:
      \operatorname{To}_{L,p-1}(y)\},
\qquad
\frac{|\mathcal C^{\rm to}_{L,p}|}{2^p}
\ll p^{-1/2}2^{-\kappa_*p}.
\tag{6.15}\label{eq:6-15}
\]
The last estimate is \eqref{eq:6-12} with \(m=p-1\), after changing only its
fixed constant.

For a fixed high entry threshold, [Lemma 6.1](#lem-time-support) places the
cumulative high entry times in an interval of length
\(O(\sqrt{M\log(M+2)})\).  The possible entry thresholds vary over only
\(O(S)\) ranks, shifting the common center by \(O(S)\).  Low ranks decrease
strictly, there are at most \(S+1\) successful low stages, and each duration
is at most \(S\); hence
\[
\sum_{\text{successful low stages}}h_i\le S(S+1).
\tag{6.16}\label{eq:6-16}
\]
Taking the Minkowski sum enlarges the high interval by \(O(S^2)\).  Since
\(S=O(\log(M+2))\), this is
\(o(\sqrt{M\log M})\), proving \eqref{eq:6-13}. \(\square\)

### Proposition 6.4 (critical shell failure bound) {#prop-rank-buffer}

Let \(L_M\asymp\log M\) be an integer terminal-rank sequence.  For every
fixed \(c>c_*\) and \(\beta>0\), the high parameters and switch constant may
be chosen so that the timeout low chain above has, for some fixed
\(\varepsilon>0\),
\[
\boxed{
\frac{\#\operatorname{Fail}^{\rm to}_{M,L_M}}{2^M}
\ll
\sqrt{M\log M}\,
L_M^{1/2}2^{-\kappa_*L_M}
+M^{-\varepsilon}.}
\tag{6.17}\label{eq:6-17}
\]
Outside this failure set, some iterate before \(c\log n\) lies below
\(2^{L_M}\), and every iterate through the same witness is at most
\(n^{1+\beta}\).

#### Proof

Choose
\[
a_0<r_{\rm hi}<1-\frac1{c\log2},
\qquad
0<\tau<\min\{r_{\rm hi}-a_0,\beta,a_0\}.
\tag{6.18}\label{eq:6-18}
\]
Because \(L_M=O(\log M)\), choose \(C_{\rm sw}\) so that
\(L_M<S_M\) eventually.  Increase \(D_{\rm hi}\) and then
\(C_{\rm sw}\), preserving
\(D_{\rm hi}/\sqrt{C_{\rm sw}}\le\tau\), until the initial and transported
high failures total \(O(M^{-\varepsilon})\) with a fixed positive margin.
Indeed, [Proposition 6.2](#prop-shrinking-high-density), the direct-passage
identity, \eqref{eq:6-5}, and \eqref{eq:6-7} bound their total proportion by
\[
d_{\rm hi}(M)
+O\!\left(\sqrt{M\log M}\,M^2d_{\rm hi}(M)\right),
\]
and the exponent in \(d_{\rm hi}(M)\) may be made arbitrarily large through
the displayed choice of \(D_{\rm hi}\) and \(C_{\rm sw}\).

Choose a fixed rational \(0<r_*<r_{\rm hi}\).  Eventually \(r_*<r_{L_M}\).
Every successful high or low block from parent rank \(m\) to threshold rank
\(q\) then has duration at most \(m\) and \(q+1>r_*m\).  The generic
rank-chain form recorded after [Lemma 5.2](#lem-rank-loss) therefore gives, at
a first-timeout target rank \(p\),
\[
E_{2^p}(n)<\frac{p+2}{r_*}.
\]
After increasing the terminal startup, this loss satisfies the smallness
condition \eqref{eq:4-7}.  Apply the restricted-time form
\eqref{eq:6-7} with target \(\mathcal C^{\rm to}_{L_M,p}\) and time set
\(\mathcal H^{\rm to}_{M,p}\).  Equations \eqref{eq:6-13} and
\eqref{eq:6-15} give
\[
\frac{\#\{\text{first timeout in band }p\}}{2^M}
\ll
\sqrt{M\log M}\,(p+1)p^{-1/2}2^{-\kappa_*p}.
\]
The geometric tail satisfies
\[
\sum_{p=L_M+1}^{S_M}(p+1)p^{-1/2}2^{-\kappa_*p}
\ll L_M^{1/2}2^{-\kappa_*L_M}.
\tag{6.19}\label{eq:6-19}
\]
Combining this with the high contribution proves \eqref{eq:6-17}.

The high-phase clock is at most \(M/(1-r_{\rm hi})+o(M)\), while
\eqref{eq:6-16} makes the low cost \(O((\log M)^2)=o(M)\); a deterministic
switch-endpoint tail costs only another \(O(S_M)\).  The choice
\eqref{eq:6-18} therefore gives total time below
\(cM\log2\le c\log n\).  High blocks use tolerance at most \(\tau<\beta\).
Every low block starts below \(2^{S_M+1}\) and lasts at most its parent rank.
Every state before its final landing is above a threshold greater than one,
so its next iterate satisfies \(T(z)<2z\).  Its whole segment is consequently
at most \(2^{2S_M+1}=M^{O(1)}=n^{o(1)}\).  The same witness therefore retains
the stated ceiling. \(\square\)

For the main theorem, define the exponent margin
\[
\Delta_M=
\kappa_*L_M-\frac12\log_2(M+2)-\log_2\log(M+3).
\tag{6.20}\label{eq:6-20}
\]
If \(L_M\asymp\log M\), then the first term in \eqref{eq:6-17} is
\(O(2^{-\Delta_M})\).  Thus
\[
\boxed{
\frac{\#\operatorname{Fail}^{\rm to}_{M,L_M}}{2^M}
\ll2^{-\Delta_M}+M^{-\varepsilon}.}
\tag{6.21}\label{eq:6-21}
\]

### Proof of [Theorem 1.1](#thm-moving-polylog)

For the bounded sequence \((A_M)\), use the terminal rank in \eqref{eq:1-3}.
Condition \eqref{eq:1-4} implies \(L_M\asymp\log M\): the upper bound follows
from boundedness, and the lower bound follows from the definition of
\(\Delta_M\).  [Proposition 6.4](#prop-rank-buffer) and \eqref{eq:6-21}
therefore give the
shellwise estimate \eqref{eq:1-5}.

The same condition makes \(A_M\) eventually positive.  Since the sequence is
bounded and \(n\in I_M\),
\[
2^{L_M}\le2(M+2)^{A_M}\ll(\log n)^{A_M},
\tag{6.22}\label{eq:6-22}
\]
with a constant uniform in \(M\).  This converts the terminal rank to the
stated landing.  Finally, the right side of \eqref{eq:1-5} tends to zero, so
the qualitative part of [Lemma 2.1](#lem-dyadic-sum) assembles the shell good
sets into one natural-density-one set. \(\square\)

### Proof of [Corollary 1.2](#cor-endpoint-profiles)

For fixed \(A>A_{\rm FP}\), take \(A_M=A\).  Then
\[
2^{-\Delta_M}\ll
M^{-\kappa_*(A-A_{\rm FP})}\log M.
\]
The high exponent in [Proposition 6.4](#prop-rank-buffer) can be chosen larger
than any prescribed
\(\gamma<\kappa_*(A-A_{\rm FP})\).  Splitting the dyadic shell sum at half
the top rank gives the first assertion.

For the second assertion take
\[
L_M=\left\lceil
A_{\rm FP}\log_2(M+2)+B\log_2\log(M+3)
\right\rceil.
\]
Then \(2^{-\Delta_M}\ll(\log M)^{1-B\kappa_*}\).  The same dyadic split
gives every \(\gamma<B\kappa_*-1\).

For the third assertion take
\[
L_M=\left\lceil
A_{\rm FP}\log_2(M+2)
+\frac1{\kappa_*}\log_2\log(M+3)
+D\log_2\log\log(M+4)
\right\rceil.
\tag{6.23}\label{eq:6-23}
\]
Then \(2^{-\Delta_M}\ll(\log\log M)^{-D\kappa_*}\), and the shell split
gives every \(\gamma<D\kappa_*\).  The three displayed targets follow by
exponentiating their terminal ranks and using \(M\asymp\log n\).

For the final functional statement, let \(\Omega(x)\to\infty\).  Choose
numbers \(x_j\uparrow\infty\) so rapidly that
\(\Omega(x)\ge j\) for every \(x\ge x_j\) and
\(\log j/\log x_j\to0\).  The step function equal to \(j\) on
\([x_j,x_{j+1})\) is an eventually nondecreasing subpower minorant
\(\widetilde\Omega\le\Omega\), after a harmless fixed shift of its argument.
Use \eqref{eq:6-23} with the final term replaced by
\(\log_2\widetilde\Omega(\log(M+4))\).  Its exponent margin tends to infinity,
and the resulting smaller target implies the asserted \(\Omega\)-target.
\(\square\)

## 7. Quantitative companions

The two terminal estimates have different quantitative consequences.
[Proposition 6.4](#prop-rank-buffer) gives every strict fixed
polylogarithmic exponent and the shell-dependent exponent in the headline.
The [fixed-barrier failure bound](#thm-terminal-profile) gives the sharper
stretched-logarithmic exceptional rate and the clock consequences recorded
here.

### Proof of [Theorem 1.3](#thm-stretched-log)

We prove the target in \eqref{eq:1-8} by choosing the terminal rank so that
\(2^{L_M}\le\exp((\log n)^{1-\delta})\) on the source shell.

Fix \(0<\delta<1\), put \(\alpha=1-\delta\), and choose a fixed-barrier pair
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
\(\sigma=\alpha\), proves \eqref{eq:1-8}. \(\square\)

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
Thus a fixed-barrier chain has raw time at most
\[
\frac1{1-r}
\left(\frac3{2\log2}+\frac\eta{\log3}\right)\log n+o(\log n).
\tag{7.6}\label{eq:7-6}
\]
For the timeout endpoint, \eqref{eq:7-6} applies to the high phase and the
low phase has \(O(S_M^2)=o(\log n)\) shortcut steps by \eqref{eq:6-16};
those low steps incur at most twice as many raw steps.  As
\(r\downarrow a_0\) and \(\eta\downarrow0\), the coefficient in
\eqref{eq:7-6} tends to
\[
\frac3{\log(4/3)}.
\]
The high parameters in \eqref{eq:6-18} can therefore be chosen to satisfy any fixed
shortcut and raw budgets strictly above their respective limits.  To retain
the literal raw-orbit ceiling in [Corollary 1.4](#cor-raw-clock), run the
argument with an
internal exponent \(0<\beta'<\beta\).  Every additional raw odd image is
\(3m+1=2T(m)\), so
\(2n^{1+\beta'}\le n^{1+\beta}\) eventually.  This proves
[Corollary 1.4](#cor-raw-clock).
\(\square\)

### Fixed-power exceptional count

Fix \(\alpha>0\) and \(0<\sigma<1\).  Choose
\(0<\delta<1-\sigma\).  Then
\[
\exp((\log n)^{1-\delta})\le n^\alpha
\]
eventually, while \(1-\delta>\sigma\).
[Theorem 1.3](#thm-stretched-log) therefore implies
\eqref{eq:1-10}, after decreasing the positive exponential constant and absorbing the
finite startup.

The independent fixed-depth argument for the graded clock
\eqref{eq:1-11} is given in [Appendix A](#app-graded-clock).  It is not an
input to either headline theorem.

## 8. Scope

The argument proves an orbit-minimum statement on a set of natural density
one.  It does not prove descent for every starting value, exclude nontrivial
cycles, or control the orbit after the selected witness.  The endpoint
\(\delta=1\) is a strict parameter limit and is not claimed.  No finite
computation is used as an all-depth premise.  The Collatz conjecture predicts
\(T_{\min}(n)=1\) for every positive starting value; that universal conclusion
is not proved here.

At the polylogarithmic endpoint, the proof requires
\(\Delta_M\to\infty\).  It therefore does not prove the pure target
\(C(\log n)^{A_{\rm FP}}\), nor the critical secondary target with a bounded
tertiary multiplier.  The moving theorem improves the terminal scale while
weakening its displayed exceptional-set rate; these are separate comparison
axes, as recorded in [Corollary 1.2](#cor-endpoint-profiles).

The proofs of Theorems 1.1 and 1.3 use only the optimized first-passage chain:
the parity-vector bijection, large-rank prefix-deviation estimate, small-rank
timeout tail, first-passage reversal, exact reverse-product loss, direct
passage along decreasing thresholds, and the reduced set of possible passage
times.  These proofs use no
fixed-time endpoint-fiber moment,
Fourier estimate, stochastic independence between orbit blocks, mixing
statement, Diophantine reduction, or generated-target equidistribution
hypothesis.  The Boolean walk in
[Lemma 3.1](#lem-entropy-barrier) is exact counting over the parity words
supplied by [Proposition 2.2](#prop-parity-code), not a stochastic model of an
individual Collatz orbit.  The independent graded-clock companion uses only
a fixed finite dense-set pullback and is not on either headline dependency
chain.

## Research and software disclosure

Generative-AI systems were used in proof exploration, adversarial auditing,
finite diagnostics, formalization, and exposition.  The author selected the
theorem and proof architecture, reviewed the resulting artifacts, and accepts
responsibility for the manuscript.  Finite diagnostics are supporting
evidence only and are not premises of any theorem.

The separate Lean package kernel-checks the public theorem chain from
bounded-reverse-loss transport through the natural-density assembly, as well
as the
fixed-depth graded-clock companion.  Its public `Main` theorem includes
[Theorem 1.1](#thm-moving-polylog): for every bounded exponent sequence with
\(\Delta_M\to+\infty\), it exposes the literal shell exceptional ratio,
moving landing, logarithmic clock, and orbit-height bound through the same
witness.  The public
fixed-\(A\) specialization has the strict ranges \(A>A_{\rm FP}\), \(c>c_*\),
and \(\beta>0\), with a positive logarithmic exceptional exponent; its landing
inequality is strict and hence slightly stronger than the manuscript's weak
inequality.  The exact upper range for that fixed-\(A\) exceptional exponent
is paper-level.  For
[Theorem 1.3](#thm-stretched-log), Lean formalizes the literal landing and
ceiling together with every strict exceptional power below \(1-\delta\); the
endpoint power \(1-\delta\) in \eqref{eq:1-8} is paper-level.
For [Corollary 1.4](#cor-raw-clock), the current public raw declaration
formalizes the stretched-logarithmic landing with the \(10.44\log n\) clock.
The moving-polylogarithmic raw specialization, its same-witness raw-orbit
ceiling, and the transferred quantitative rates are presently paper-level.

The package now contains two complete low-rank proof terms for the
shell-dependent theorem.  They share the endpoint parameters, scalar
asymptotics, and dyadic natural-density assembly.  The route mapped to this
V3.2 manuscript mirrors the timeout substitution in
[Lemma 6.3](#lem-timeout-low-phase) and
[Proposition 6.4](#prop-rank-buffer): it kernel-checks the literal timeout
event and endpoint-rate tail, the mixed run and decreasing low potential,
first-timeout transport, exact dyadic-endpoint halving, and the same-witness
clock and ceiling.  The retained comparison route uses the earlier all-prefix
argument at small shell ranks.  The two routes expose identical public
conclusions; the all-prefix route is not a dependency of the written timeout
proof.

The access-controlled
[GitHub repository](https://github.com/shaikidris/FirstPassageLinearTransport)
contains the complete public theorem and both formal derivations on its
current private branch; repository access can be provided to referees on
request.  The
formal package uses Lean `4.15.0` (commit
`11651562caae`) and Mathlib revision
`9837ca9d65d9de6fad1ef4381750ca688774e608`.  From the repository's `lean/`
directory, run:

```text
lake build FirstPassageLinearTransport.TimeoutEndpointAudit \
  FirstPassageLinearTransport.MovingEndpointAudit \
  FirstPassageLinearTransport.PaperDependencyAudit \
  FirstPassageLinearTransport.PaperAudit FirstPassageLinearTransport.Main
```

The theorem dictionary is `lean/FORMALIZATION.md`.  The audit files are
`PaperDependencyAudit.lean` for dependencies, `PaperAudit.lean` for the
public roots, `TimeoutEndpointAudit.lean` for the timeout route, and
`MovingEndpointAudit.lean` for the all-prefix alternate; all four lie in
`lean/FirstPassageLinearTransport/`.  The build,
placeholder scan, dependency report, and all axiom audits pass, with logical
dependencies `propext`, `Classical.choice`, and `Quot.sound`.  These checks
supplement rather than replace the written proof.

## Appendix A. Graded fixed-power clock {#app-graded-clock}

This appendix proves the second assertion of
[Corollary 1.5](#cor-fixed-power).  The argument is a fixed-depth companion
to the headline chain and records a time--descent tradeoff that the stronger
polylogarithmic target alone does not express.

Put \(g=1-a_0\).  Fix \(a_0<r<1\) and \(0<\eta<r-a_0\).  For a certified
source \(x\in I_m\), set \(Y_m=2^{\lfloor rm\rfloor}\), let \(G(x)\) be its
first entrance into \((Y_m/2,Y_m]\), and put
\[
H_m=
\left\lceil
\frac{(1+\eta-r)m+2+\eta}{g}
\right\rceil.
\tag{A.1}\label{eq:a-1}
\]
The strict inequality \(\eta<r-a_0\) gives \(H_m\le m\) eventually.  The
upper half of the all-prefix envelope \eqref{eq:3-8} then gives
\[
T^{H_m}(x)
<2^{-gH_m+(1+\eta)(m+1)}
\le2^{rm-1}
\le Y_m.
\tag{A.2}\label{eq:a-2}
\]
Hence the first passage defining \(G\) occurs by time \(H_m\), and
\[
H_m\le \frac{1+\eta-r}{g}\,m+O_{r,\eta}(1).
\tag{A.3}\label{eq:a-3}
\]

We record why a fixed number of these stages retains natural density one.
After absorbing finitely many startup shells, let
\(\widetilde W_\eta\) denote the certified set and put
\(\mathcal P(S)=\widetilde W_\eta\cap G^{-1}(S)\).
If \(S\) is \((C,D_{\rm dens})\)-dense and \(0<\chi<r\), then
\(\mathcal P(S)\) is \((C',\chi D_{\rm dens})\)-dense for every sufficiently
small fixed \(D_{\rm dens}>0\).
Indeed, for every first passage of length at most \(H_m\), the loss in
\eqref{eq:4-5} satisfies
\(E_{Y_m}\le D_{\rm loss}:=H_m/2\), and
\(H_m/(2Y_m)\le1/3\) eventually.  Apply
[Proposition 4.3](#prop-loss-transport) with \(D=D_{\rm loss}\) and with
\(B=(Y_m/2,Y_m]\setminus S\).  Since
\(|B|\le C Y_m^{1-D_{\rm dens}}\), the
transported part of the shell complement is
\[
\ll C m^2\frac{2^m}{Y_m}Y_m^{1-D_{\rm dens}}
\ll C m^2\,2^{(1-rD_{\rm dens})m}.
\tag{A.4}\label{eq:a-4}
\]
For fixed \(0<\chi<r\), the polynomial factor is absorbed by
\(2^{(r-\chi)D_{\rm dens}m}\), uniformly at cost
\(O_{r,\chi}(D_{\rm dens}^{-2})\).
[Proposition 3.3](#prop-barrier-density) absorbs the certification complement
after \(D_{\rm dens}\) is restricted below a fixed positive threshold.  Dyadic
summation proves the claimed density update.  Iterating it any fixed number
of times therefore still gives a natural-density-one set.

Now fix \(0<\alpha<1\) and \(\varepsilon>0\).  Choose
\(0<\alpha'<\alpha\) with
\(c_*(\alpha-\alpha')<\varepsilon/3\), then choose a fixed \(R\ge1\) and
\(r=(\alpha')^{1/R}>a_0\).  Finally choose \(0<\eta<r-a_0\) so that
\(c_*(1-\alpha')\eta/(1-r)<\varepsilon/3\).
On the resulting \(R\)-fold pullback set, write \(n_0=n\) and
\(n_{i+1}=G(n_i)\).  Finite startup changes only a constant, so
\(n_i\le K_*n^{r^i}\) for a fixed \(K_*\), and consequently
\(n_R\le K_*n^{\alpha'}\le n^\alpha\) eventually.  Summing
\eqref{eq:a-3} gives
\[
\begin{aligned}
k_R
&\le
\frac{1+\eta-r}{g}\,
\frac{1-r^R}{1-r}\log_2n+O_{\alpha,\varepsilon}(1)\\
&=
c_*(1-\alpha')
\left(1+\frac\eta{1-r}\right)\log n
+O_{\alpha,\varepsilon}(1).
\end{aligned}
\tag{A.5}\label{eq:a-5}
\]
The two strict parameter margins leave a final third of the clock slack to
absorb the fixed remainder, proving \eqref{eq:1-11}. \(\square\)

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
