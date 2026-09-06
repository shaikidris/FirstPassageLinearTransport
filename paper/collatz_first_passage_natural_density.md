# Polylogarithmic Descent for Almost All Collatz Orbits in Natural Density

**Idris Ali Shaik**

Independent researcher, Dubai, United Arab Emirates

**Email:** shaikidris@apache.org

**ORCID:** [0009-0009-9699-9712](https://orcid.org/0009-0009-9699-9712)

**Version:** 4.0.0 - preprint

**Date:** 6 September 2026

**Preprint DOI:**
[10.5281/zenodo.22525724](https://doi.org/10.5281/zenodo.22525724)

**Lean 4 software DOI:**
[10.5281/zenodo.22525757](https://doi.org/10.5281/zenodo.22525757)

**Palomar registry (preceding manuscript):**
[PALOMAR-2026-08-26-000005, version 3](https://palomar-registry.org/entry?id=PALOMAR-2026-08-26-000005&version=3)

**2020 Mathematics Subject Classification:** Primary 11B83; Secondary 37P99,
60G40

**Keywords:** Collatz map, almost all Collatz orbits, natural density, first
passage, stopping map, parity vectors, polylogarithmic descent

## Abstract

We prove that, in ordinary natural density, almost every positive integer has
shortcut and raw Collatz iterates reaching the same polylogarithmic-scale value
within logarithmically many steps, while both preceding trajectories remain
within an arbitrarily slowly diverging factor of the starting value.

Let \(T\) be the shortcut Collatz map, which sends an even integer to \(n/2\)
and an odd integer to \((3n+1)/2\), and let \(\operatorname{Col}\) denote the
unaccelerated map.  Put
\[
A_{\rm FP}=9.9911133419\ldots,
\qquad
\kappa_*=(2A_{\rm FP})^{-1},
\qquad
c_*=\frac2{\log(4/3)}=6.9521189935\ldots.
\]
For any prescribed positive functions \(U(n),R(n)\to\infty\), a set of
positive integers of natural density one has corresponding shortcut and raw
witnesses \(k,\ell\) with a common landing
\[
T^k(n)=\operatorname{Col}^{\ell}(n)
< (\log n)^{A_{\rm FP}}U(n).
\]
Both trajectories through these witnesses are bounded by \(nR(n)\), and
\[
k=c_*\log n+O(\sqrt{\log n\,\log\log n}),
\qquad
\ell=\tfrac32c_*\log n+O(\sqrt{\log n\,\log\log n}).
\]
On the same good set, these centered laws hold uniformly through the selected
trajectories and therefore give the actual first-passage time to every
intermediate level between the landing and the source.
For every fixed \(A>A_{\rm FP}\), the complete target--clock--height
conclusion has exceptional count
\(O(X/(\log X)^{\kappa_*A-1/2})\).  The upper-bound endpoint
\(\kappa_*A-1/2\) is attained for this joint conclusion; with the balanced
height ceiling, the same order is forced from below by the height condition.
At the method threshold, every prescribed divergent multiplier \(U(n)\)
suffices; the pure target \(C(\log n)^{A_{\rm FP}}\) remains unproved.
The constant \(A_{\rm FP}\) is a threshold of the present method rather than
an intrinsic constant of the map.

The main obstacle is that density estimates for one descent block cannot be
iterated as if the landing values were uniformly distributed.  We combine
exact parity-word counting with deterministic first-passage transport along
decreasing thresholds.  A timeout constrains every parity prefix; a finite
ballot estimate therefore improves its normalized word count to
\(O(m^{-3/2}2^{-\kappa_*m})\).  Together with an
\(O(\sqrt{M\log M})\) corridor for cumulative passage times, this removes the
secondary logarithmic loss from the critical leading exponent.  A
stretched-logarithmic companion has stretched-exponential exceptional decay
and a common relative-height allowance of the same stretched-logarithmic
order.  All conclusions are almost-all statements, not a proof of the
pointwise Collatz conjecture.

## 1. Introduction and main results

We ask how small a value can be forced along the Collatz orbit of almost every
initial integer in ordinary natural density, while retaining a logarithmic
witnessing time and a bound on the orbit before that witness.

For classical background and broad surveys of the \(3x+1\) problem, see
Crandall [[1]](#ref-crandall), Lagarias [[7]](#ref-lagarias), and Wirsching
[[13]](#ref-wirsching).

We work throughout with the shortcut Collatz map
\[
T(n)=
\begin{cases}
n/2,&n\equiv0\pmod2,\\
(3n+1)/2,&n\equiv1\pmod2.
\end{cases}
\]
and the unaccelerated map
\[
\operatorname{Col}(n)=
\begin{cases}
n/2,&n\equiv0\pmod2,\\
3n+1,&n\equiv1\pmod2.
\end{cases}
\]
One application of \(T\) is one shortcut step; one application of
\(\operatorname{Col}\) is one raw step.  We write
\(T_{\min}(n)=\min_{k\ge0}T^k(n)\).  All unqualified logarithms are natural,
\(\log_2\) denotes the base-two logarithm, and
\(\mathbb N=\{1,2,3,\ldots\}\).  For \(M\ge0\), let
\[
I_M=[2^M,2^{M+1})\cap\mathbb N
\]
be the \(M\)-th dyadic shell; we call \(M\) its shell rank.  A set
\(S\subseteq\mathbb N\) has natural density one if
\[
\frac{\#\{1\le n\le X:n\notin S\}}{X}\longrightarrow0,
\]
or, equivalently, if \(\#(S\cap[1,X])/X\to1\).

All assertions involving iterated logarithms are understood for sufficiently
large positive integers; changing the finite initial segment only changes a
fixed exceptional constant.  We use \(k\), or \(h\) for a local block, for
shortcut time, \(\ell\) for raw time, and \(s_h\) for the number of odd
shortcut states among the first \(h\) shortcut steps.

The nearest clocked natural-density baseline is Inselmann
[[3]](#ref-inselmann).  His Theorem 1.3 gives a graded clock for descent to
fixed powers, while his Theorem 1.1 supplies a horizon-wide two-sided
trajectory envelope.  The distinct point here is the simultaneous package of
a smaller polylogarithmic terminal scale, explicit exceptional-set rates,
centered shortcut and raw witnessing times, and a common-witness relative
orbit ceiling.  The fixed-power companion in Appendix A is an independent
derivation from the present first-passage transport, not a claim that the
graded clock itself is new.

### Main result at a glance

For any prescribed positive functions \(U(n),R(n)\to\infty\), almost every
positive integer has corresponding shortcut and raw witnesses reaching one
value below \((\log n)^{A_{\rm FP}}U(n)\), with clocks centered at
\(c_*\log n\) and \(3c_*\log n/2\), and with both trajectories bounded by
\(nR(n)\).  For each fixed \(A>A_{\rm FP}\), this becomes an explicit
\(O_A(X/(\log X)^q)\) joint exceptional count with
\(q=\kappa_*A-1/2\), target \((\log n)^A\), and common ceiling
\(n(\log n)^q\).  The trajectory estimate also identifies the actual first
passage to every intermediate level.  These are almost-all conclusions; they
do not settle the pointwise conjecture or control the orbit after the selected
witness.  The constant \(A_{\rm FP}=9.9911133419\ldots\) is a threshold of
this method, not a proposed optimal exponent for the map.

Why is the result not obtained by simply repeating a one-block density
estimate?  After a first descent, the landing values are generated by the
orbit and need not be uniformly distributed in their new shell.  Moreover, a
union bound over every possible passage time loses a factor linear in the
original shell rank.  The proof uses decreasing thresholds so that every
later failure is again a first-passage event of the original orbit, and then
shows that only \(O(\sqrt{M\log M})\) cumulative passage times can occur.
This transport step is the quantitative pivot of the paper.

The shell-dependent master theorem is stated below as
[Theorem 1.1](#thm-moving-polylog).  Its fixed-target and critical
specializations are collected in
[Corollary 1.2](#cor-endpoint-profiles).

### Where the constants come from {#where-the-constants-come-from}

\[
a_0=\frac{\log_2 3}{2}.
\tag{1.1}\label{eq:1-1}
\]
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
assert a matching lower bound or optimality theorem.  Drift heuristics and
related stochastic models are classical; see Kontorovich--Lagarias
[[4]](#ref-kontorovich-lagarias) and Lagarias--Weiss
[[8]](#ref-lagarias-weiss).  The estimates below nevertheless come from exact
parity-word counting, not from a stochastic model of an individual orbit.
Second, put
\[
\kappa_*=1-H_2(p_*).
\]
The terminal odd-step count on a shell has an exact binomial law, but a
timeout supplies more information than its endpoint: every parity prefix has
remained above a fixed logarithmic barrier.  After tilting to the critical
odd-step proportion \(p_*\), a finite ballot estimate gives a normalized
timeout count of order \(L^{-3/2}2^{-\kappa_*L}\).  The proof also sums over
\(O(\sqrt{M\log M})\) possible cumulative first-passage times and pays a
factor of order \(L\) for the reverse loss.  Together these terms leave the
exponent margin
\[
\kappa_*L-\frac12\log_2M.
\]
Its divergence is the endpoint condition in the revised main theorem.  For
\(L\sim A\log_2M\), the leading power changes sign at
\(A\kappa_*=1/2\), giving \(A_{\rm FP}=1/(2\kappa_*)\).  At equality an
arbitrarily slowly diverging multiplier suffices, but a bounded multiplier is
not obtained.  Thus \(A_{\rm FP}\) is a threshold of the present argument
rather than an intrinsic constant of the Collatz map.

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
\kappa_*L_M-\frac12\log_2(M+2).
\tag{1.3}\label{eq:1-3}
\]
Assume
\[
\Delta_M\longrightarrow+\infty.
\tag{1.4}\label{eq:1-4}
\]
For every fixed \(N>0\), there are constants
\(C_{\rm exc},K>0\) and an integer \(M_0\ge1\) such that the
following holds.  These constants may depend on the bounded sequence
\((A_M)\) and on \(N\), but are independent of \(M\).  Let
\(\mathcal E_M\) be the set of \(n\in I_M\) for which there are no integers
\(k,\ell\ge0\) and common landing \(y\) satisfying all of the landing,
clock, height, and trajectory-tube conditions below:
\[
T^k(n)=\operatorname{Col}^{\ell}(n)=y
<(\log n)^{A_M},
\]
\[
|k-c_*\log n|+\left|\ell-\frac32c_*\log n\right|
\le K\sqrt{\log n\,\log\log n},
\]
\[
\max_{0\le j\le k}T^j(n)\le n(M+2)^N,
\qquad
\max_{0\le i\le\ell}\operatorname{Col}^i(n)\le n(M+2)^N.
\]
Writing \(d=\tfrac12\log(4/3)=c_*^{-1}\) and letting \(s_j(n)\) count
the odd states among the first \(j\) shortcut steps, the same witnesses may
be required to satisfy
\[
\sup_{0\le j\le k}
\left|\log T^j(n)-\log n+dj\right|
+
\sup_{0\le j\le k}\left|s_j(n)-\frac j2\right|
\le K\sqrt{\log n\,\log\log n},
\]
\[
\sup_{0\le i\le\ell}
\left|\log\operatorname{Col}^i(n)-\log n+\frac{2d}{3}i\right|
\le K\sqrt{\log n\,\log\log n}.
\]
Consequently, for every real \(z\) with \(y\le z\le n\), the actual first
passage times
\[
\tau_z(n)=\min\{j:T^j(n)\le z\},
\qquad
\widehat\tau_z(n)=\min\{i:\operatorname{Col}^i(n)\le z\}
\]
reach the same state and obey, uniformly in \(z\),
\[
\left|\tau_z(n)-c_*\log(n/z)\right|
+
\left|\widehat\tau_z(n)-\frac32c_*\log(n/z)\right|
\le K\sqrt{\log n\,\log\log n},
\]
after changing \(K\) once.
Then, for every \(M\ge M_0\),
\[
\boxed{
\frac{\#\mathcal E_M}{2^M}
\le C_{\rm exc}\left(2^{-\Delta_M}+(M+2)^{-N}\right).}
\tag{1.5}\label{eq:1-5}
\]
Consequently these simultaneous witnesses exist on a set of natural density
one.  In particular, every prescribed fixed shortcut budget \(c>c_*\), raw
budget \(\widehat c>3/\log(4/3)\), and ceiling exponent \(\beta>0\) hold
eventually on the same set.

:::

**Target normalization.**  The proof uses the normalized terminal rank
\[
L'_M=\left\lfloor A_M\log_2(M\log2)\right\rfloor,
\]
which, for bounded \((A_M)\), differs from the displayed rank and margin by
only \(O(1)\), while \(2^{L'_M}\le(\log n)^{A_M}\) throughout \(I_M\).
Thus the landing constant is one; only fixed constants and startup change,
not the exponent or exceptional rate.

The ceiling in \(L_M\) changes \(\Delta_M\) by only \(O(1)\).  Hence, when
\(A_M\to A_{\rm FP}\), condition \eqref{eq:1-4} is equivalently
\[
\kappa_*(A_M-A_{\rm FP})\log M\longrightarrow+\infty.
\tag{1.6}\label{eq:1-6}
\]

### Corollary 1.2 (explicit descent scales) {#cor-endpoint-profiles}

Each numbered statement below supplies corresponding shortcut and raw times
with the centered bounds in Theorem 1.1 and a common landing strictly below
the displayed target.  Both trajectories through those times are bounded by
the displayed common ceiling.

1. For every fixed \(A>A_{\rm FP}\), put
   \(q=\kappa_*A-1/2>0\).  The target
   \[
   (\log n)^A
   \]
   fails for at most \(O_A(X/(\log X)^q)\) integers \(n\le X\), where
   ``fails'' means failure of the simultaneous target, centered-clock, and
   common-height requirements, with common ceiling \(n(\log n)^q\).

2. For every fixed \(B>0\), the target
   \[
   (\log n)^{A_{\rm FP}}(\log\log n)^B
   \]
   fails for at most
   \(O_B(X/(\log\log X)^{B\kappa_*})\) integers \(n\le X\), where
   ``fails'' has the same simultaneous meaning and the common ceiling is
   \(n(\log\log n)^{B\kappa_*}\).

3. For every fixed \(D>0\), the target
   \[
   (\log n)^{A_{\rm FP}}(\log\log\log n)^D
   \tag{1.7}\label{eq:1-7}
   \]
   fails for at most
   \(O_D(X/(\log\log\log X)^{D\kappa_*})\) integers \(n\le X\), again in
   the simultaneous sense, with common ceiling
   \(n(\log\log\log n)^{D\kappa_*}\).

4. More generally, let \(U,R:\mathbb N\to(0,\infty)\) be any prescribed
   functions with \(U(n),R(n)\to\infty\).  On a set of natural density one,
   the common landing satisfies
   \[
   T^k(n)=\operatorname{Col}^{\ell}(n)
   <(\log n)^{A_{\rm FP}}U(n),
   \]
   and the two corresponding trajectories are bounded by \(nR(n)\).  No
   monotonicity of \(U\) or \(R\) is required.  The density-one set may
   depend on the prescribed functions \(U\) and \(R\); the first-passage
   estimates are uniform in the intermediate level on that same set.

The first three targets are \(o(n)\), hence give genuine descent for all
sufficiently large \(n\).  In item 4 the proof clips \(U\) to a divergent
subpolynomial shell minorant, so the constructed landing is still below \(n\)
eventually even if the displayed prescribed target is larger.  The assertions
are density-one rather than pointwise, and the onset of the asymptotic
comparison is not made effective.  The upper-bound rate exponents above
include their endpoints; no smaller-exponent qualification is required.

For each of the first three profiles, if the exceptional event means failure
of the complete simultaneous target--clock--height conclusion with its
displayed ceiling, the stated upper bound is sharp in order: the corresponding
count is also bounded below by a positive constant times the displayed
function.  This lower bound is forced by the height ceiling; it is not a
target-only lower bound and does not prove that \(A_{\rm FP}\) is optimal.
The uniform first-passage conclusions in Theorem 1.1 apply on these same good
sets to every level between the common landing and \(n\).

The target and height exponents may also be prescribed independently.  For
fixed \(A>A_{\rm FP}\), \(q=\kappa_*A-1/2\), and any fixed \(b>0\), the
target \((\log n)^A\), centered clocks, and common ceiling
\(n(\log n)^b\) fail jointly for at most
\[
O_{A,b}\!\left(
\frac{X}{(\log X)^{\min\{q,b\}}}\right)
\]
integers up to \(X\).  Item 1 is the balanced choice \(b=q\), not a
necessary coupling between terminal scale and height allowance.

The next theorem is a separate fixed-barrier companion.  It retains strict
clock inequalities rather than the centered trajectory profile, but the same
finite multiplicative-maximum argument gives a much smaller common height
allowance than a fixed power of \(n\).

::: {.theorem-block}

### Theorem 1.3 (quantitative stretched-logarithmic descent) {#thm-stretched-log}

For every fixed \(0<\delta<1\), shortcut budget \(c_T>c_*\), raw budget
\(c_{\rm raw}>3/\log(4/3)\), and \(\zeta>0\), there are constants
\(C,\gamma,X_0>0\) with the following property.  For every \(X\ge X_0\),
let \(\mathcal E_{\delta,c_T,c_{\rm raw},\zeta}(X)\) be the set of integers
\(1\le n\le X\) for which there are no corresponding integers
\(0\le k<c_T\log n\), \(0\le\ell<c_{\rm raw}\log n\), and common landing
\(y\) satisfying
\[
T^k(n)=\operatorname{Col}^{\ell}(n)=y
\le\exp((\log n)^{1-\delta})
\]
and
\[
\max_{0\le j\le k}T^j(n),\quad
\max_{0\le i\le\ell}\operatorname{Col}^i(n)
\le n\exp(\zeta(\log n)^{1-\delta}).
\]
Then
\[
\#\mathcal E_{\delta,c_T,c_{\rm raw},\zeta}(X)
\le
CX\exp(-\gamma(\log X)^{1-\delta}).
\tag{1.8}\label{eq:1-8}
\]
The constants may depend on all four fixed parameters; in particular,
\(\gamma\) may depend on \(\zeta\).
The endpoint \(\delta=1\) is not asserted.

:::

### Corollary 1.4 (raw-clock constant and ceiling projection) {#cor-raw-clock}

Theorem 1.1 and Corollary 1.2 already give a raw witness centered at
\(3\log n/\log(4/3)\) for the same landing as the shortcut witness.  For the
stretched-logarithmic conclusion, Theorem 1.3 now supplies the raw witness and
common ceiling directly.  Since
\[
\frac3{\log(4/3)}=10.42817849\ldots,
\tag{1.9}\label{eq:1-9}
\]
the explicit constant \(10.44\) remains admissible.  Moreover, for every
fixed \(\beta>0\), the common ceiling in Theorem 1.3 is eventually smaller
than \(n^{1+\beta}\), so the preceding fixed-power ceiling statement remains
an immediate projection.

Thus [Corollary 1.4](#cor-raw-clock) records the numerical raw-clock
projection of the corresponding-witness statement in Theorem 1.3.

### Corollary 1.5 (fixed powers and the independent graded-clock companion) {#cor-fixed-power}

For every fixed \(\alpha>0\), there is \(d_\alpha>0\) such that the
exceptional set for \(T_{\min}(n)>n^\alpha\) has size
\[
O_\alpha(X^{1-d_\alpha}).
\tag{1.10}\label{eq:1-10}
\]
For \(\alpha\ge1\) this exceptional set is empty.

If \(0<\alpha<1\), then for every fixed
\(\varepsilon_T,\varepsilon_{\rm raw},\beta>0\), there is \(d>0\) such that,
apart from \(O(X^{1-d})\) integers \(n\le X\), corresponding shortcut and
raw times reach the same value
\[
T^k(n)=\operatorname{Col}^{\ell}(n)\le n^\alpha,
\]
both trajectories through those witnesses are at most \(n^{1+\beta}\), and
\[
k<
\left(
\frac{2(1-\alpha)}{\log(4/3)}+\varepsilon_T
\right)\log n,
\qquad
\ell<
\left(
\frac{3(1-\alpha)}{\log(4/3)}+\varepsilon_{\rm raw}
\right)\log n.
\tag{1.11}\label{eq:1-11}
\]
Thus both clock coefficients decrease continuously with the amount of
logarithmic height that remains.  For example, at \(\alpha=1/2\) the
shortcut coefficient tends to
\(1/\log(4/3)=3.47605949\ldots\), rather than the full-descent coefficient
\(c_*\).

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
indices \(k\) and \(h\) count shortcut steps unless stated otherwise.  A
raw-map time is denoted by \(\ell\) and counts applications of
\(\operatorname{Col}\).  In the raw-clock conversion, \(s_h\) counts the odd
states among the first \(h\) shortcut steps; each such state adds one raw
step, so \(\ell=h+s_h\).

A *startup* is a fixed lower bound on the shell rank, allowed to depend on
the fixed parameters, beyond which the stated estimate applies.  Increasing
the startup changes only a finite initial set.

The global symbols \(T,\operatorname{Col},T_{\min},I_M,a_0,p_*,\kappa_*,
A_{\rm FP}\), and \(c_*\) retain the meanings fixed above.  Symbols used only
inside one proof stage are introduced at the start of the section where they
are needed; in particular, the high- and low-phase parameters are collected
at the beginning of Section 6.

### Proof architecture

At a high level, the proof does three things: it certifies typical paths for
one block, pulls later failures back to the original source shell, and sums
only over passage times that can actually occur.  The six steps below record
the precise dependency structure.  The only probabilistic input is exact
counting of parity words on a dyadic shell; the first-crossing estimates and
the assembly of the decreasing threshold chain are deterministic.

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

The time-support bound is stated and proved in
[Lemma 6.1](#lem-time-support).  [Proposition 6.4](#prop-rank-buffer)
assembles the critical shell estimate, and \eqref{eq:6-20}--\eqref{eq:6-21}
convert it to the margin \(\Delta_M\) explained in the
[opening constant discussion](#where-the-constants-come-from).

Steps 3 and 4 are the shared deterministic part of the proof.  Applying them
with one fixed barrier gives the stretched-logarithmic exceptional rate.
Applying them with shrinking large-scale bounds and the small-scale timeout
test gives both the fixed polylogarithmic targets and the shell-dependent
exponent in the headline.

Four declarations associated with the preceding public manuscript are
registered in the
[Palomar Registry as PALOMAR-2026-08-26-000005, version 3](https://palomar-registry.org/entry?id=PALOMAR-2026-08-26-000005&version=3).
That record does not verify the strengthened statements introduced in this
revision.  The precise declaration-level coverage and verification boundary
are recorded in the
[research and software disclosure](#research-and-software-disclosure).

Figure 1 shows this division and the flow from one dyadic shell to
successively lower thresholds.

![Figure 1. The proof architecture.  Panel (a) follows an actual shortcut-Collatz orbit
inside the certified high-rank envelope and marks successive threshold
landings; below the switch, the timeout rule replaces low-rank certification.
Panel (b) records
the proved reduction in the number of possible cumulative passage times;
bar lengths are schematic and do not encode the unspecified constant in
Lemmas 6.1 and 6.3.](fig-architecture.svg)

### Relation to previous almost-all results

Terras [[11]](#ref-terras) and Everett [[2]](#ref-everett) proved the classical
first-descent statement for almost every starting value; Terras's follow-up
[[12]](#ref-terras-density) addressed the associated density question.

The earlier endpoint-transport preprint [[9]](#ref-endpoint-v1) proves stretched-logarithmic
descent in the range \(0<\delta<0.251245530155874\ldots\) by fixed-total
endpoint fibers, a Rényi estimate, and endpoint-only iteration.  The present
proof is logically independent of that theorem.  Its proof architecture and
principal conclusions are substantially different: high-rank all-prefix
certification, first-passage reversal along decreasing thresholds, and a
small-rank timeout tail yield fixed polylogarithmic targets above the explicit
critical exponent, a moving critical endpoint, and a same-witness orbit
ceiling.  Theorem 1.3 also gives an independent stretched-logarithmic companion
for every \(0<\delta<1\), extending the parameter range obtained in [[9]](#ref-endpoint-v1).

The main obstruction is not the contraction of one typical block, but the
transport of sparse certification failures through a generated sequence of
landings.  Direct aggregation over every time up to the horizon incurs a
linear loss.  The proof instead organizes long multi-landing passages in
natural density without that linear time-union loss.  Step 5 above reduces the
possible times to \(O(\sqrt{M\log M})\) possibilities; this
linear-to-square-root reduction is the quantitative pivot of the paper.

The published results of Korec and Tao, the preprint of Inselmann, and the
publicly archived, unrefereed Tao-to-natural-density bridge manuscripts of
Allikvere [[14]](#ref-allikvere) and Mazur [[15]](#ref-mazur) are compared
below only on the coordinates used in their stated public versions.
Submission status is not inferred from public circulation.  The numerical
entries below are taken from the specifically dated versions in
[[14]](#ref-allikvere)--[[15]](#ref-mazur).

| Work | Density | Target reached for almost all starts | Clock or quantitative feature |
|---|---|---|---|
| Korec [[5]](#ref-korec) | natural | \(n^\theta\), every fixed \(\theta>a_0\) | no clock or quantitative exception used here |
| Inselmann [[3]](#ref-inselmann) | natural | \(n^\varepsilon\), every fixed \(\varepsilon>0\) | \(2\log n/\log(4/3)\) shortcut steps; density convergence |
| Tao [[10]](#ref-tao) | logarithmic | every \(f(n)\to\infty\) | no single global clock in the headline theorem; logarithmic-density estimate |
| Mazur [[15]](#ref-mazur) | natural, bridged from Tao's logarithmic-density framework | every \(f(n)\to\infty\) | version 2 states \(<436\log n\) unaccelerated steps and a fixed-target logarithmic rate |
| Allikvere [[14]](#ref-allikvere) | natural, bridged from Tao's logarithmic-density framework | every \(f(n)\to\infty\) | version 2 states \(<12\log n\) unaccelerated steps and \(O((\log N_0)^{-1/29}+X^{-1/2000})\) for a fixed target |
| This paper | natural | \((\log n)^{A_{\rm FP}}U(n)\) for every prescribed \(U(n)\to\infty\); fixed-\(A\) endpoint rates in [Corollary 1.2](#cor-endpoint-profiles) | uniform actual first-passage clocks; sharp balanced joint rates; both orbit heights bounded by \(nR(n)\) for every prescribed \(R(n)\to\infty\) |

[Corollary 1.2(4)](#cor-endpoint-profiles) additionally supplies corresponding
shortcut and raw witnesses and bounds both preceding trajectories by
\(nR(n)\) for an arbitrary prescribed divergent relative allowance.  This is
a comparison of stated outputs, not a claim that the other proofs contain no
related internal trajectory estimates.  In particular, Inselmann's Theorem
1.1 already supplies a horizon-wide trajectory envelope at the fixed-power
scale.

The moving target of [Theorem 1.1](#thm-moving-polylog) includes the critical
specialization \((\log n)^{A_{\rm FP}}U(n)\) for every prescribed divergent
multiplier \(U\).  It is smaller than every fixed power when a subpolynomial
minorant is used, and smaller than every fixed stretched-logarithmic target in
[Theorem 1.3](#thm-stretched-log), but it still contains the fixed positive
power \((\log n)^{A_{\rm FP}}\).  It is therefore weaker than an arbitrary
diverging absolute target.  At the target-only level, Tao's theorem
specializes to every target displayed here, albeit in logarithmic rather than
natural density.  Thus the present theorem does not supersede the
arbitrary-threshold conclusions reported in those manuscripts.
Conversely, the stated Tao, Allikvere, and Mazur terminal-threshold results do
not include the present same-witness orbit-height ceiling.  Inselmann does
supply a trajectory envelope at the fixed-power scale, as well as the
underlying logarithmic clock scale.  The target class, density, rate, clock,
and path-height axes are deliberately not collapsed into a single ordering.

Complementary inverse-tree work obtains lower bounds for the number of
integers whose orbits reach \(1\) by means of difference inequalities; see
Krasikov--Lagarias [[6]](#ref-krasikov-lagarias).  That direction is distinct
from the forward first-passage transport used here.

Allikvere conditions Tao's Syracuse/Fourier inputs on the total valuation and
supplies a uniform-measure transfer.  Mazur starts from the same
logarithmic-density frontier and adds a quantitative phase-gap and two-adic
lift.  Their shared bridge architecture differs from the exact
Boolean-cube certification and deterministic first-passage transport
separation displayed above.

## 2. Density, parity, and affine iterates

The argument uses three common tools: a shell-to-prefix summation rule, exact
parity coding on each dyadic shell, and an affine formula for the iterate.
This section establishes all three before they are used.  Lemma 2.1 converts
shell exceptional estimates into global natural-density bounds.
Proposition 2.2 makes parity words exactly uniform on a complete shell,
supplying the counting law used in Sections 3 and 6.  Proposition 2.3
separates each iterate into its multiplicative term and affine correction,
which is the orbit-envelope input for Section 3.

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
**Quantitative form.**
Then there are \(\gamma'>0\) and \(X_0\) such that
\[
\#(E\cap[1,X])
\leq(2A+1)X e^{-\gamma'(\log X)^\sigma}
\qquad(X\geq X_0).
\tag{2.3}\label{eq:2-3}
\]

**Qualitative form.**  More generally, if a nonnegative sequence
\(e_M\to0\) satisfies
\[
\#(E\cap I_M)\le e_M2^M
\tag{2.3a}\label{eq:2-3a}
\]
for all sufficiently large \(M\), then \(E\) has natural density zero.

#### Proof

Let \(2^J\leq X<2^{J+1}\).  The shells with
\(M<\lfloor J/2\rfloor\) contain fewer than \(X^{1/2}\) integers.  On the
remaining shells,
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
see, for example, Terras [[11]](#ref-terras).  Its short proof is included
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

Consequently, as \(n\) ranges over the complete shell \(I_M\), its length-
\(M\) parity word is exactly uniform on \(\{0,1\}^M\).

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

## 3. A dense set with controlled parity prefixes

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
Indeed, applying the two-sided Stirling bounds to \(M!\), \(k_0!\), and
\((M-k_0)!\) produces the displayed entropy exponent and a prefactor
\(O((Mp_M(1-p_M))^{-1/2})\); compactness makes this \(O(M^{-1/2})\)
uniformly.
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

Let \(0<\eta<1-a_0\).  There is \(K_\eta>0\) such that
\[
\frac{\#(W_\eta^c\cap I_M)}{2^M}
\le K_\eta(M+1)^{-1/2}e^{-b_{\rm ent}(\eta)M}
\qquad(M\ge0).
\tag{3.10}\label{eq:3-10}
\]
Consequently, for every fixed \(0<c<b_{\rm ent}(\eta)\), the set
\(W_\eta\) is \((K'_{\eta,c},c/\log2)\)-dense after increasing the fixed
constant.

#### Proof

Put \(L_3=\log_2 3\), \(b=b_{\rm ent}(\eta)\), and, on \(I_M\), take the
constant-slack barrier
\[
h_M=\frac{\eta M-1}{L_3},
\qquad
3^{h_M}=2^{\eta M-1}.
\tag{3.11}\label{eq:3-11}
\]
For sufficiently large \(M\), this barrier is positive and lies below
\(M/2\).  Assume \(H_M\le h_M\).  Since \(n\ge2^M\), one has
\(3^{h_M}=2^{\eta M-1}<n^\eta\), so the multiplicative term in
\eqref{eq:3-6} is at least
\(\rho^kn^{1-\eta}\) and at most one half of the upper envelope:
\[
\rho^kn3^{d_k}
\le\frac12\rho^kn^{1+\eta}.
\tag{3.12}\label{eq:3-12}
\]
[Lemma 3.2](#lem-affine-correction) bounds the additive term in
\eqref{eq:3-6} by
\[
(2+\sqrt3)3^{2h_M}
=\frac{2+\sqrt3}{4}\,2^{2\eta M}.
\tag{3.13}\label{eq:3-13}
\]
The unused half of the upper envelope is uniformly at least
\[
\frac12\rho^M2^{(1+\eta)M}
=\frac12\,2^{(a_0+\eta)M}.
\tag{3.14}\label{eq:3-14}
\]
Because \(\eta<1-a_0<a_0\), its exponent \(a_0+\eta\) is larger than
\(2\eta\).  Thus \eqref{eq:3-14} absorbs \eqref{eq:3-13} after one fixed
startup, and
\[
H_M\le h_M\quad\Longrightarrow\quad n\in W_\eta.
\tag{3.15}\label{eq:3-15}
\]

Apply the fixed-slope estimate \eqref{eq:3-3a} with
\[
t_M=\frac{h_M}{M}
=\frac{\eta}{L_3}-\frac1{ML_3}.
\tag{3.16}\label{eq:3-16}
\]
These slopes eventually lie in a fixed compact subinterval of \((0,1/2)\).
Smoothness of \(\mathcal I\) there gives
\(M\mathcal I(t_M)=Mb+O_\eta(1)\).  The parity bijection in
[Proposition 2.2](#prop-parity-code), \eqref{eq:3-3a}, and
\eqref{eq:3-15} now prove \eqref{eq:3-10}, after enlarging \(K_\eta\) for
the finite startup.

For every \(c<b\), the factor
\((M+1)^{-1/2}e^{-bM}\) is \(O_{\eta,c}(e^{-cM})\).
Summing the resulting geometric shell series proves the stated global density
consequence. \(\square\)

## 4. First-passage linear transport

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
\(A<(3/2)2^{M+1}\), so this interval has length at most
\[
3D\frac{2^M}{Y}.
\]
Any additional congruence or residue restriction can only reduce the number
of integer sources in this interval; no full-lattice occupancy is assumed.
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
telescope.  [Theorem 1.3](#thm-stretched-log) applies these facts through the
fixed-barrier route; the next section retains the same two facts and changes
how failure is detected at small shell ranks.

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
increment is less than \(2^{-q_j-1}\).  Loss incurred in block \(j\) is
initially measured relative to its own threshold \(2^{q_j}\).  Expressing it
in units of the final threshold \(2^{q_i}\) multiplies that loss by
\(2^{q_i-q_j}\).  Since the block has at most \(m_j\) steps, summing these
rescaled contributions gives
\[
E_{2^{q_i}}(n)
<\frac12\sum_{j\le i}m_j2^{q_i-q_j}.
\]
Now \(m_j<(q_j+1)/r\), and the distinct integer thresholds \(q_j\) are
all at least \(q_i\).  Thus, for each \(d=q_j-q_i\ge0\), there is at most
one block at rank \(q_i+d\).  The worst case occupies every such rank, and
the identities
\[
\sum_{d\ge0}2^{-d}=2,
\qquad
\sum_{d\ge0}d2^{-d}=2
\]
give
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

Under \eqref{eq:5-1}, there are an integer
\(M_0=M_0(r,\eta,c_\eta)\ge1\) and a constant \(C>0\) such that, for all
integers \(M\ge L\ge M_0\),
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

### Proposition 5.4 (relative height for the fixed-barrier chain) {#prop-fixed-barrier-height}

Assume in addition to \eqref{eq:5-1} that
\[
r(1+\eta)<1.
\tag{5.15}\label{eq:5-15}
\]
For every real \(R\ge4\), enlarge \(\operatorname{Fail}_{M,L}\) by the
sources whose first \(M\) multiplicative parity prefixes exceed \(R/4\).
Denote the enlarged set by
\(\operatorname{Fail}^{\rm ht}_{M,L,R}\).  It has shell proportion
\[
\ll_{r,\eta,c_\eta}
e^{-c_\eta M}
+M(L+1)(e^{-c_\eta L}+2^{-L})
+R^{-1}.
\tag{5.16}\label{eq:5-16}
\]
Every source outside it has the landing and shortcut clock in
[Theorem 5.3](#thm-terminal-profile), and, with
\(\ell=k+s_k(n)\),
\[
T^k(n)=\operatorname{Col}^{\ell}(n)<2^L,
\qquad
\max_{j\le k}T^j(n),\quad
\max_{i\le\ell}\operatorname{Col}^i(n)\le nR.
\tag{5.17}\label{eq:5-17}
\]

#### Proof

For the first \(M\) parity prefixes of \(n\), put
\(F_j=3^{s_j}/2^j\).  By
[Lemma B.4](#lem-multiplier-maximum) and the exact shell parity law, the
additional exception has proportion at most \(4/R\).

Outside the original failure set, let the first block cross
\(Y=2^{\lfloor rM\rfloor}\).  Before the crossing, all relevant shortcut
states are larger than this level.  The exact recurrence gives
\[
T^j(n)=nF_j
\prod_{\substack{0\le i<j\\T^i(n)\ {\rm odd}}}
\left(1+\frac1{3T^i(n)}\right),
\]
and the logarithm of the product is at most
\(M/(3Y)\).  After a fixed startup this product is at most two.  Therefore
\(\max F_j\le R/4\) bounds every shortcut state in the first block by
\(nR/2\), and every inserted raw odd state, which is twice the following
shortcut state, by \(nR\).

The first checkpoint is at most \(2^{\lfloor rM\rfloor}\le n^r\).
Every later block is certified, so \eqref{eq:3-8} and
\eqref{eq:5-15} bound all of its shortcut states by
\((n^r)^{1+\eta}\le n\) and its raw states by \(2n\le nR\).
The shortcut/raw correspondence gives the same landing at
\(\ell=k+s_k(n)\).  Adding the maximum exception to \eqref{eq:5-11}
proves \eqref{eq:5-16}--\eqref{eq:5-17}. \(\square\)

## 6. Shrinking prefix bounds and compressed passage times

[Theorem 5.3](#thm-terminal-profile) shows what the shared direct-passage and
reverse-loss facts yield with one fixed certificate and a linear time
horizon.  It reduces the remaining problem to three costs: the number of
possible passage times, the reverse loss at the landing scale, and the density
of failed landings.  We now improve the first and third costs.  Shrinking
prefix bounds compress the passage-time sum, while the low-rank timeout
condition permits a ballot estimate.  The reverse-loss mechanism is unchanged.

The parameters used below fall into four groups.  This table is a roadmap;
the displayed equations following it give the precise definitions and the
order in which the constants are chosen.

| Symbols | Role | Definition or constraint |
|---|---|---|
| \(A_M,L_M,\Delta_M\) | terminal schedule and its remaining exponent margin | fixed in [Theorem 1.1](#thm-moving-polylog); \(L_M\asymp\log M\) and \(\Delta_M\to\infty\) in the main application |
| \(r_{\rm hi}\) | threshold ratio at high ranks | fixed in \((a_0,1)\), and denoted by \(r\) in the final parameter choice \eqref{eq:6-18} |
| \(\tau\) | cap on the high-rank tolerance | initially \(0<\tau<r_{\rm hi}-a_0\); \eqref{eq:6-18} also imposes \(r_{\rm hi}(1+\tau)<1\) for the relative-height estimate |
| \(D_{\rm hi}\) | coefficient of the shrinking high-rank tolerance | chosen large enough in [Proposition 6.4](#prop-rank-buffer) to make high failures polynomially small |
| \(C_{\rm sw},S_M\) | switch coefficient and switch rank | \(S_M=\lceil C_{\rm sw}\log(M+2)\rceil\); \(C_{\rm sw}\) is chosen after \(D_{\rm hi}\) so that \(D_{\rm hi}/\sqrt{C_{\rm sw}}\le\tau\) and \(L_M<S_M\) eventually |
| \(\eta_{M,m}\) | high-rank tolerance at parent rank \(m\) | derived from \(\tau,D_{\rm hi},M,m\) in \eqref{eq:6-3} |
| \(K_0,r_L,q_L\) | bounded-gap low timeout rule | \(K_0>0\) is fixed, \(r_L=1-K_0/(2L)\), and \(q_L(m)=\lfloor r_Lm\rfloor\) |
| \(r_*\) | uniform ratio used only in the reverse-loss estimate | a fixed rational with \(0<r_*<r_{\rm hi}\) and, eventually, \(r_*<r_{L_M}\) |

Thus only \(r_{\rm hi},\tau,D_{\rm hi},C_{\rm sw},K_0\), and \(r_*\)
are choices made inside the argument; the remaining quantities are determined
by those choices and the prescribed terminal schedule.

**High-rank stopped chain and compressed passage times.**  Choose fixed
high-rank data
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
deterministic halving orbit until its shell rank is below \(L_M\), and stop
successfully; this
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

Write \(g=1-a_0\).  The point is not that the number of high-rank histories is
small.  For one block from rank \(m\) to threshold rank \(q\), the duration is
centered at \((m-q)/g\), with an error of order
\(\sqrt{m\log(M+2)}\).  Every continuing landing lies in the shell
\(I_{q-1}\), so the next parent rank is exactly \(q-1\).  Consequently the
centers telescope along any history to a quantity depending only on the outer
rank \(M\) and final rank \(q\), while geometric rank decay keeps the
accumulated error within \(O(\sqrt{M\log(M+2)})\).  Thus all cumulative times
for fixed \(M,q\) lie in one corridor of that width.

Consider one high certified block from a parent shell
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

The next computation makes this telescoping explicit.

Suppose high blocks \(0,\ldots,j\) have been executed.  Every landing before
the last is a continuing checkpoint in \((2^{q_i-1},2^{q_i}]\).  By the
stopping rule in \eqref{eq:6-4}, a landing equal to \(2^{q_i}\) terminates the
chain: it is followed by deterministic halving when \(q_i\le S\), and is a
high endpoint failure when \(q_i>S\).  Thus no continuing checkpoint is an
upper endpoint.  Each lies in the unique shell \(I_{q_i-1}\), and therefore
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
No optimality is claimed for this support bound or for its logarithmic factor.
\(\square\)

The fixed-time, fixed-landing count also has the following restricted-time
form.  If \(\mathcal H\) is any finite set of positive times,
\(B\subseteq J_Y\), and \(D_q\ge0\) satisfies \(D_q/Y\le1/3\), then
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
\left[
\bigl(I_{q-1}\cap J_{2^q}\bigr)
\setminus W_{\eta_{M,q-1}}
\right].
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
height
\[
h=\frac{tm}{2\log_2 3},
\qquad 3^h=2^{tm/2}.
\]
Here \(h<m/2\), since \(t\le1<\log_2 3\), so the height is in the range of
[Lemma 3.1](#lem-entropy-barrier).
If \(H_m\le h\), then \(|d_k|\le h\) for every \(k\le m\).  Since
\(n\ge2^m\),
\[
3^{-h}=2^{-tm/2}\ge n^{-t},
\qquad
3^h=2^{tm/2}\le2^{-tm/2}n^t.
\]
Thus the multiplicative term in \eqref{eq:3-6} lies above
\(\rho^kn^{1-t}\) and below
\(2^{-tm/2}\rho^kn^{1+t}\).  The unused upper-envelope slack is at least
\[
\left(1-2^{-tm/2}\right)\rho^m2^{(1+t)m}
\ge\frac12\,2^{(a_0+t)m}.
\]
Meanwhile [Lemma 3.2](#lem-affine-correction) and \(d_k\le h\) bound the
additive term in \eqref{eq:3-6} by
\[
(2+\sqrt3)3^{2h}=(2+\sqrt3)2^{tm}.
\]
For \(m\ge4\), this is at most the displayed slack because
\(2^{a_0m}/2\ge2^{4a_0}/2=9/2>2+\sqrt3\).  Hence
\(H_m\le h\) implies \(x\in W_t\), or equivalently
\(I_m\setminus W_t\subseteq\{x\in I_m:H_m(x)>h\}\).  By
[Proposition 2.2](#prop-parity-code), [Lemma 3.1](#lem-entropy-barrier), and
\(\mathcal I(u)\ge2u^2\), the complementary proportion is at most
\[
2\exp\!\left(-\frac{t^2m}{2(\log_2 3)^2}\right)
=2e^{-c_0t^2m}.
\]
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
smaller shell ranks, the proof no longer imposes the positive high-rank
certificate.  A timeout nevertheless contains path information of its own:
every prefix of the actual parity word has kept the orbit above the next
threshold.  The exact multiplicative recurrence converts this into survival
above a fixed logarithmic barrier.  The finite ballot estimate proved in
[Appendix B](#app-finite-ballot) then gains a factor \(m^{-1}\) over the
terminal-only binomial bound.

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
\ll_{C,K_0}m^{-3/2}2^{-\kappa_*m}.}
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

Write \(x_j=T^j(x)\), let \(b_i\) be the parity of \(x_i\), and put
\[
s_j=\sum_{i<j}b_i,
\qquad
Z_j=s_j\log3-j\log2.
\]
Iteration of the shortcut recurrence gives the exact product
\[
x_j=x\,e^{Z_j}
\prod_{\substack{0\le i<j\\x_i\ {\rm odd}}}
\left(1+\frac1{3x_i}\right).
\tag{6.14}\label{eq:6-14}
\]
On a timeout every \(x_i>Y:=2^{q_L(m)}\).  The logarithm of the product in
\eqref{eq:6-14} is therefore between zero and \(m/(3Y)\).  Since
\(x<2^{m+1}\) and \(x_j>2^{q_L(m)}\), every prefix satisfies
\[
Z_j>-(m+1-q_L(m))\log2-\frac{m}{3Y}.
\tag{6.14a}\label{eq:6-14a}
\]
Integer rounding gives
\[
m-q_L(m)
=\left\lceil\frac{K_0m}{2L}\right\rceil
\le\frac{CK_0}{2}+1.
\]
Also \(q_L(m)\ge m-CK_0/2-1\), so \(m/(3Y)\le1\) uniformly after one
startup.  Thus every timeout word satisfies \(Z_j>-B\) for every
\(0\le j\le m\), with the fixed choice
\[
B=\left(\frac{CK_0}{2}+2\right)\log2+1.
\]
[Lemma B.3](#lem-fair-word-barrier), followed by the exact parity-word
bijection of [Proposition 2.2](#prop-parity-code), now proves
\eqref{eq:6-12}.  This uses the actual affine orbit and does not replace it by
a random model.

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
\ll p^{-3/2}2^{-\kappa_*p}.
\tag{6.15}\label{eq:6-15}
\]
The last estimate is \eqref{eq:6-12} with \(m=p-1\), after changing only its
fixed constant and absorbing the harmless factor between \(2^{p-1}\) and
\(2^p\).

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

### Proposition 6.4 (strengthened critical shell theorem) {#prop-rank-buffer}

Fix constants \(0<c_-\le c_+<\infty\), \(K_0>0\), and \(N>0\).  Let
\(L_M\) be an integer terminal-rank sequence satisfying, eventually,
\[
c_-\log(M+2)\le L_M\le c_+\log(M+2),
\]
and let \(R_M\ge4\) be any prescribed real sequence.  The high parameters
and switch constant may be chosen so that there are fixed constants \(C,K\)
and a fixed startup for which
\[
\boxed{
\frac{\#\operatorname{Fail}^{\rm str}_{M,L_M,R_M}}{2^M}
\le C\left[
\sqrt{\frac{(M+2)\log(M+2)}{L_M+1}}\,2^{-\kappa_*L_M}
+(M+2)^{-N}+R_M^{-1}
\right].}
\tag{6.17}\label{eq:6-17}
\]
Outside this failure set, every \(n\in I_M\) has corresponding shortcut and
raw times \(k,\ell\) and one common landing \(y\) such that
\[
T^k(n)=\operatorname{Col}^{\ell}(n)=y<2^{L_M},
\tag{6.17a}\label{eq:6-17a}
\]
\[
|k-c_*\log n|+
\left|\ell-\frac32c_*\log n\right|
\le K\sqrt{\log n\,\log\log n},
\tag{6.17b}\label{eq:6-17b}
\]
and
\[
\max_{j\le k}T^j(n)\le nR_M,
\qquad
\max_{i\le\ell}\operatorname{Col}^i(n)\le nR_M.
\tag{6.17c}\label{eq:6-17c}
\]
The constants \(C,K\) depend only on the fixed data and not on the detailed
sequences \(L_M,R_M\); the startup also includes the point from which the
displayed bounds on \(L_M\) hold.  The failure set
\(\operatorname{Fail}^{\rm str}\) is the union of the previous
initial, high-landing, and first-timeout failures with the initial
multiplicative-maximum exception used for \eqref{eq:6-17c}.

#### Proof

**High failures.**

Choose a fixed \(r\in(a_0,1)\) and
\[
a_0<r<1,
\qquad
0<\tau<\min\{r-a_0,(1-r)/r,a_0,1\}.
\tag{6.18}\label{eq:6-18}
\]
Thus \(r(1+\tau)<1\).  Use \(r_{\rm hi}=r\), choose \(D_{\rm hi}\) so that
\(c_0D_{\rm hi}^2>N+5\), and then choose \(C_{\rm sw}\) large enough that
\[
C_{\rm sw}\log2>N+5,
\qquad
C_{\rm sw}\ge D_{\rm hi}^2/\tau^2,
\qquad
rC_{\rm sw}>2c_+.
\tag{6.18a}\label{eq:6-18a}
\]
With \(S_M=\lceil C_{\rm sw}\log(M+2)\rceil\), one has
\(L_M<S_M<M\) eventually.  The final high threshold entering below the
switch is still at least \(L_M+1\), since its parent rank is at least \(S_M\)
and its threshold rank is at least \(rS_M-1\).  The initial and transported
high failures then total \(O((M+2)^{-N})\).
Indeed, [Proposition 6.2](#prop-shrinking-high-density), the direct-passage
identity, \eqref{eq:6-5}, and \eqref{eq:6-7} bound their total proportion by
\[
d_{\rm hi}(M)
+O\!\left(\sqrt{M\log M}\,M^2d_{\rm hi}(M)\right),
\]
where the transported contribution is estimated as follows.  For a high target
rank \(q\), let \(B_q\) be its bad landing target.  Every producing block has
duration at most its parent rank \(m\) and \(q+1>r_{\rm hi}m\), so the generic
rank-scaled-loss statement after [Lemma 5.2](#lem-rank-loss) gives
\(E_{2^q}(n)<D_q:=(q+2)/r_{\rm hi}\).  Increase the fixed startup so that
\(D_q/2^q=(q+2)/(r_{\rm hi}2^q)\le1/3\) for every high target rank.  Thus
\eqref{eq:6-7} applies.  Since \(|B_q|\le2^qd_{\rm hi}(M)\), it gives, after
division by \(2^M\), a band proportion
\(\ll\sqrt{M\log M}(2^{q-M}+D_q)d_{\rm hi}(M)
\ll\sqrt{M\log M}\,M d_{\rm hi}(M)\).  Summing over at most \(M+1\)
possible ranks proves the displayed total.
The exponent in \(d_{\rm hi}(M)\) exceeds \(N+5\) by
\eqref{eq:6-18a}, so the polynomial transport factors are absorbed with
room to spare.

**Low timeouts.**  Fix \(r_*=1/2<r_{\rm hi}\), which is permitted because
\(r_{\rm hi}>a_0>1/2\).  Eventually
\(r_*<r_{L_M}\).
Every successful high or low block from parent rank \(m\) to threshold rank
\(q\) then has duration at most \(m\) and \(q+1>r_*m\).  The generic
rank-chain form recorded after [Lemma 5.2](#lem-rank-loss) therefore gives, at
a first-timeout target rank \(p\),
\[
E_{2^p}(n)<\frac{p+2}{r_*}.
\]
Since \(L_M\asymp\log M\) and
\(S_M=C_{\rm sw}\log(M+2)+O(1)\), a fixed \(C>1\), depending only on the
fixed bounds \(c_-\) and \(C_{\rm sw}\), satisfies
\(p-1\le S_M-1\le CL_M\) eventually; for example, any
\[
C>\max\left\{1,\frac{2C_{\rm sw}}{c_-}\right\}
\]
works after increasing the fixed startup.  Thus
[Lemma 6.3](#lem-timeout-low-phase) applies uniformly to every timeout band
\(L_M+1\le p\le S_M\).
After increasing the terminal startup, this loss satisfies the smallness
condition \eqref{eq:4-7}.  Apply the restricted-time form
\eqref{eq:6-7} with target \(\mathcal C^{\rm to}_{L_M,p}\) and time set
\(\mathcal H^{\rm to}_{M,p}\).  Equations \eqref{eq:6-13} and
\eqref{eq:6-15} give
\[
\frac{\#\{\text{first timeout in band }p\}}{2^M}
\ll
\sqrt{M\log M}\,(p+1)p^{-3/2}2^{-\kappa_*p}.
\]
The geometric tail satisfies
\[
\sum_{p=L_M+1}^{S_M}(p+1)p^{-3/2}2^{-\kappa_*p}
\ll L_M^{-1/2}2^{-\kappa_*L_M}.
\tag{6.19}\label{eq:6-19}
\]
This proves the first term of \eqref{eq:6-17}; the high failures supply its
second term.

**Shortcut and raw clocks.**  Let \(H\) be the cumulative time at the last
high landing,
whose threshold rank \(q_{\rm ent}\) is \(O(S_M)\).  Equation
\eqref{eq:6-6d} and the geometric decay of the high parent ranks give
\[
\left|gH-\bigl((M+1)-q_{\rm ent}\bigr)\right|
\ll\sqrt{M\log(M+2)}.
\]
The remaining low part costs at most \(S_M(S_M+1)\), and an endpoint-halving
tail costs at most \(S_M\).  Both are absorbed by the same error.  Since
\(\log n=M\log2+O(1)\), the resulting shortcut witness satisfies
\[
k=c_*\log n+O(\sqrt{\log n\,\log\log n}).
\tag{6.19a}\label{eq:6-19a}
\]

Let \(q_f\) be the final threshold rank.  The low rule and the endpoint-
halving alternative give
\[
L_M-K_0/2-1\le q_f\le L_M.
\tag{6.19b}\label{eq:6-19b}
\]
Indeed, if the final block is low, its parent rank is at least \(L_M\), so
\(q_f=\lfloor r_{L_M}m\rfloor\ge L_M-K_0/2-1\).  A threshold rank above
\(L_M\) cannot terminate the run, whereas a nonendpoint landing at threshold
rank \(L_M\) already has shell rank \(L_M-1\); in the endpoint-halving case,
\(q_f=L_M-1\).  This accounts for every successful terminal case.
Treating every endpoint-halving step as a one-step first passage, the complete
successful chain is the direct first passage of the original source to its
last threshold.  If \(s\) is the number of odd shortcut steps, the exact
reverse product of Section 4 gives
\[
n=\frac{2^k y}{3^s}P,
\qquad
1-\frac{q_f+2}{r_*2^{q_f}}\le P\le1.
\tag{6.19c}\label{eq:6-19c}
\]
Hence \(\log P=O(L_M2^{-L_M})\), while \(0\le\log y\le L_M\log2\).
Taking logarithms and using \eqref{eq:6-19a} yields
\[
s-\frac{k}{2}
=\frac{gk\log2-\log n+\log y+\log P}{\log3}
=O(\sqrt{\log n\,\log\log n}).
\]
Since \(\operatorname{Col}^{k+s}(n)=T^k(n)=y\), this proves the centered raw
clock in \eqref{eq:6-17b}.

**Relative height.**  It remains to establish the common relative-height
bound.  For the first
\(M\) parity prefixes of the original source, put
\(F_j=3^{s_j}/2^j\).  [Lemma B.4](#lem-multiplier-maximum) and the exact shell
parity law show that, outside a set of proportion at most \(4/R_M\),
\[
\max_{0\le j\le M}F_j\le R_M/4.
\tag{6.19d}\label{eq:6-19d}
\]
During the first high block, the multiplicative correction in
\eqref{eq:6-14} is at most
\(\exp(M/2^{\lfloor rM\rfloor+1})\le2\) after one startup.  Thus every
shortcut state there is at most \(nR_M/2\), and every intervening raw odd
state is at most twice the following shortcut state.  Every later high block
starts below \(2^{\lfloor rM\rfloor}\), so its prefix envelope and
\(r(1+\tau)<1\) keep its shortcut states below \(n\) and its raw states below
\(2n\).  Low blocks and endpoint halving remain below
\(2^{2S_M+2}=M^{O(1)}<n\) eventually.  Since \(R_M\ge4\), these estimates
prove \eqref{eq:6-17c}.  Adding the initial maximum exception contributes
  the final term \(R_M^{-1}\) in \eqref{eq:6-17}.  \(\square\)

### Proposition 6.5 (uniform trajectory tubes and actual first passages) {#prop-first-passage-profile}

Put
\[
d=\frac12\log(4/3)=c_*^{-1},
\qquad
e_n=\sqrt{\log n\,\log\log n}.
\]
On the successful set of [Proposition 6.4](#prop-rank-buffer), with its
constructed witnesses \(k,\ell\) and landing \(y\), there is a fixed
\(K>0\) such that
\[
\sup_{0\le j\le k}
\left|\log T^j(n)-\log n+dj\right|\le Ke_n,
\qquad
\sup_{0\le j\le k}
\left|s_j(n)-\frac j2\right|\le Ke_n,
\tag{6.19e}\label{eq:6-19e}
\]
and
\[
\sup_{0\le i\le\ell}
\left|\log\operatorname{Col}^i(n)-\log n+\frac{2d}{3}i\right|
\le Ke_n.
\tag{6.19f}\label{eq:6-19f}
\]
No additional exceptional event is required.

For every real \(z\) with \(y\le z\le n\), define
\[
\tau_z(n)=\min\{j:T^j(n)\le z\},
\qquad
\widehat\tau_z(n)=\min\{i:\operatorname{Col}^i(n)\le z\}.
\]
Uniformly over all such \(z\),
\[
\left|\tau_z(n)-c_*\log(n/z)\right|
+
\left|\widehat\tau_z(n)-\frac32c_*\log(n/z)\right|
\le Ke_n.
\tag{6.19g}\label{eq:6-19g}
\]
The two passages reach the same state, and their preceding trajectories
inherit the height bounds in Proposition 6.4.

#### Proof

For a high block starting at checkpoint \(n_i\in I_{m_i}\), certification
gives, at every local time \(0\le u\le h_i\),
\[
\left|\log T^u(n_i)-\log n_i+du\right|
\le\eta_{M,m_i}\log n_i.
\]
Telescope at the actual checkpoint values.  Since the high parent ranks
decrease geometrically and
\[
\eta_{M,m_i}m_i
\le D_{\rm hi}\sqrt{m_i\log(M+2)},
\]
the accumulated error, including the local error inside the current block, is
\[
\ll\sum_i\sqrt{m_i\log(M+2)}
\ll\sqrt{M\log(M+2)}.
\tag{6.19h}\label{eq:6-19h}
\]
The remaining low part and endpoint-halving tail contain
\(O(S_M^2)=O((\log M)^2)\) shortcut steps.  Since
\(x/2\le T(x)\le2x\), extending the logarithmic tube across that tail costs
only \(O((\log M)^2)=o(\sqrt{M\log M})\).  This proves the first estimate in
\eqref{eq:6-19e}.

For every prefix of the selected trajectory, the exact forward product is
\[
\log T^j(n)
=\log n+s_j\log3-j\log2+A_j,
\qquad
A_j=\sum_{\substack{0\le i<j\\T^i(n)\ {\rm odd}}}
\log\left(1+\frac1{3T^i(n)}\right).
\]
The corrections \(A_j\) are nonnegative and increasing.  For the complete
successful chain, \eqref{eq:6-19c} is the same identity in reverse, so
\(A_k=-\log P=O(L_M2^{-L_M})\).  Hence \(0\le A_j\le A_k\) for
\(j\le k\).  Rearranging the preceding display and using the shortcut tube
gives the parity estimate in \eqref{eq:6-19e}.

At the corresponding raw times \(i_j=j+s_j\), one has
\(\operatorname{Col}^{i_j}(n)=T^j(n)\) and
\(i_j=3j/2+O(e_n)\).  Equations \eqref{eq:6-19e} therefore give
\eqref{eq:6-19f} at every corresponding time.  An extra raw odd image is
twice the following shortcut state and lies one raw step before it; this
changes the logarithmic error by only a fixed constant.  Thus
\eqref{eq:6-19f} holds at every raw time through \(\ell\).

Finally, if \(z<n\), a first shortcut crossing of \(z\) must be an even
halving: an odd shortcut step sends a positive state \(x\) to
\((3x+1)/2>x\), so it cannot create a new downward crossing.  The landing
therefore lies in \((z/2,z]\).  Substituting this landing into
\eqref{eq:6-19e} proves the first formula in \eqref{eq:6-19g}.  A raw odd
image is larger than the preceding shortcut state and cannot create a new
downward crossing.  Therefore the first raw crossing reaches the same state;
\eqref{eq:6-19f} gives the second formula.  The case \(z=n\) has time zero.
\(\square\)

For the main theorem, define the exponent margin
\[
\Delta_M=
\kappa_*L_M-\frac12\log_2(M+2).
\tag{6.20}\label{eq:6-20}
\]
If \(L_M\asymp\log M\), then the first term in \eqref{eq:6-17} is
\(O(2^{-\Delta_M})\).  Thus
\[
\boxed{
\frac{\#\operatorname{Fail}^{\rm str}_{M,L_M,(M+2)^N}}{2^M}
\ll2^{-\Delta_M}+(M+2)^{-N}.}
\tag{6.21}\label{eq:6-21}
\]

### Proof of [Theorem 1.1](#thm-moving-polylog)

Condition \eqref{eq:1-4} makes \(A_M\) eventually positive and implies
\(L_M\asymp\log M\): the upper bound follows from boundedness, and the lower
bound follows from the definition of \(\Delta_M\).  Use the normalized
terminal rank
\[
L'_M=\left\lfloor A_M\log_2(M\log2)\right\rfloor.
\tag{6.22}\label{eq:6-22}
\]
For bounded \((A_M)\), one has \(L'_M-L_M=O(1)\).  Hence
\[
\Delta'_M=\kappa_*L'_M-\frac12\log_2(M+2)
=\Delta_M+O(1)\longrightarrow+\infty,
\]
and \(L'_M\asymp\log M\).  Apply
[Proposition 6.4](#prop-rank-buffer) with this terminal rank and
\(R_M=(M+2)^N\), and then apply
[Proposition 6.5](#prop-first-passage-profile) on the same successful set.
Equations \eqref{eq:6-21} and \(\Delta'_M=\Delta_M+O(1)\) give
\eqref{eq:1-5}, while the two propositions give the centered clocks, the
common shortcut and raw height bounds, the uniform tubes, and the actual
first-passage profile.

For \(n\in I_M\), \(\log n\ge M\log2\), so
\[
2^{L'_M}\le(M\log2)^{A_M}\le(\log n)^{A_M}.
\]
This proves the normalized landing claim.  Finally, the right side of
\eqref{eq:1-5} tends to zero, so the qualitative part of
[Lemma 2.1](#lem-dyadic-sum) assembles the shell good sets into one
natural-density-one set. \(\square\)

### Proof of [Corollary 1.2](#cor-endpoint-profiles)

For the three quantitative profiles, put \(t_M=M\log2\) and use the
terminal ranks
\[
\begin{split}
L_M^{(1)}&=\lfloor A\log_2t_M\rfloor,\\
L_M^{(2)}&=\lfloor A_{\rm FP}\log_2t_M+B\log_2\log t_M\rfloor,\\
L_M^{(3)}&=\lfloor A_{\rm FP}\log_2t_M
             +D\log_2\log\log t_M\rfloor.
\end{split}
\tag{6.23}\label{eq:6-23}
\]
They satisfy the hypotheses of [Proposition 6.4](#prop-rank-buffer), and
\(2^{L_M^{(i)}}\) is at most the corresponding target throughout \(I_M\).
The first term of \eqref{eq:6-17} is, respectively,
\[
O(M^{-q}),
\qquad
O((\log M)^{-B\kappa_*}),
\qquad
O((\log\log M)^{-D\kappa_*}),
\]
where \(q=\kappa_*A-1/2\).  Choose, respectively,
\[
R_M=t_M^q,
\qquad
R_M=(\log t_M)^{B\kappa_*},
\qquad
R_M=(\log\log t_M)^{D\kappa_*},
\]
and choose the high-error exponent \(N>q\) in the first case and any fixed
\(N>0\) in the other two.  The three terms in \eqref{eq:6-17} then have the
displayed orders.

For the global counts, let \(J=\lfloor\log_2X\rfloor\).  The shells with
\(M<\lfloor J/2\rfloor\) contain fewer than \(X^{1/2}\) integers.  On the
remaining shells each displayed rate is bounded by a fixed multiple of its
value at \(J\).  Summing the shell sizes, including the possibly partial top
shell by the full-shell estimate, proves items 1--3 with their endpoint
exponents.

For item 4, define the shell minima
\[
u_M=\min_{n\in I_M}U(n),
\qquad
r_M=\min_{n\in I_M}R(n).
\]
Both tend to infinity.  Put
\[
w_M=\min\{u_M,\log(M+2)\},
\qquad
L_M=\left\lfloor
A_{\rm FP}\log_2(M\log2)+\log_2w_M
\right\rfloor,
\qquad
R_M=\min\{r_M,M+2\}.
\tag{6.23a}\label{eq:6-23a}
\]
After one startup, \(L_M\asymp\log M\), \(R_M\ge4\), and the shell-failure
proportion is
\[
O\!\left(w_M^{-\kappa_*}+(M+2)^{-1}+R_M^{-1}\right)=o(1).
\]
The definitions of the minima make the target and height comparisons
pointwise throughout the shell.  The qualitative part of
[Lemma 2.1](#lem-dyadic-sum) therefore proves natural density one.  The
clipping \(w_M\le\log(M+2)\) also shows that the constructed landing is
below a fixed polylogarithmic-logarithmic scale and hence below \(n\)
eventually, even when the prescribed \(U\) itself grows rapidly.  \(\square\)

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

Fix \(0<\delta<1\) and put \(\alpha=1-\delta\).  Since the two prescribed
clock budgets are strict, choose a fixed-barrier pair \((r,\eta)\) satisfying
\eqref{eq:5-1} and
\[
r(1+\eta)<1,
\qquad
\frac1{(1-r)\log2}<c_T,
\qquad
\frac1{1-r}\left(\frac3{2\log2}+\frac{\eta}{\log3}\right)
<c_{\rm raw}.
\tag{7.1}\label{eq:7-1}
\]
Such a choice exists by taking \(r\downarrow a_0\) and
\(\eta\downarrow0\).
Take
\[
L_M=\left\lfloor\frac{(M\log2)^\alpha}{\log2}\right\rfloor.
\tag{7.2}\label{eq:7-2}
\]
In [Proposition 5.4](#prop-fixed-barrier-height), set
\[
R_M=\exp(\zeta(M\log2)^\alpha).
\]
The polynomial factor \(M(L_M+1)\) is absorbed by the exponential tails in
\eqref{eq:5-16}, and \(R_M^{-1}\) has the same stretched-exponential form.
Thus, for some \(c'>0\) that may depend on \(\zeta\),
\[
\#\operatorname{Fail}^{\rm ht}_{M,L_M,R_M}
\le C2^M e^{-c'M^\alpha}.
\tag{7.3}\label{eq:7-3}
\]
For \(n\in I_M\),
\[
2^{L_M}\le\exp((M\log2)^\alpha)
\le\exp((\log n)^\alpha).
\]
Also \(R_M\le\exp(\zeta(\log n)^\alpha)\), so \eqref{eq:5-17} gives
the common ceiling in Theorem 1.3.

**Raw-clock calculation.**  For completeness, the raw clock uses the same
landing.  Direct induction gives
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
As \(r\downarrow a_0\) and \(\eta\downarrow0\), the coefficient in
\eqref{eq:7-6} tends to \(3/\log(4/3)\); the choice \eqref{eq:7-1}
therefore gives \(\ell<c_{\rm raw}\log n\) eventually, while
\eqref{eq:5-6} gives \(k<c_T\log n\).  The shortcut/raw correspondence and
[Proposition 5.4](#prop-fixed-barrier-height) ensure that these two times
reach the same landing and obey the same ceiling.
[Lemma 2.1](#lem-dyadic-sum), with \(\sigma=\alpha\), now proves
\eqref{eq:1-8}. \(\square\)

### Fixed-power exceptional count

If \(\alpha\ge1\), then \(T_{\min}(n)\le n\le n^\alpha\), so the exceptional
set in \eqref{eq:1-10} is empty.  For \(0<\alpha<1\), apply the stronger
fixed-depth construction in [Appendix A](#app-graded-clock) with any fixed
positive clock slacks and height exponent, and then forget the clock and
height conclusions.  Its density pullback gives an exponent \(d>0\), proving
\eqref{eq:1-10}.

The independent fixed-depth proof of the graded clock \eqref{eq:1-11} is
given in [Appendix A](#app-graded-clock).  It is not an input to either
headline theorem.

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
\(C(\log n)^{A_{\rm FP}}\) for a fixed constant \(C>0\).  It does prove every
target \((\log n)^{A_{\rm FP}}U(n)\) with a prescribed positive multiplier
\(U(n)\to\infty\), as stated in
[Corollary 1.2(4)](#cor-endpoint-profiles).  The target scale and its
exceptional-set rate are separate comparison axes; the quantitative profiles
in Corollary 1.2 record this tradeoff.

Theorem 1.1 uses the parity-vector bijection, large-rank prefix-deviation
estimate, small-rank timeout tail, first-passage reversal, exact
reverse-product loss, direct passage along decreasing thresholds, and the
reduced set of possible passage times.  Theorem 1.3 instead uses the
fixed-barrier failure bound of Theorem 5.3 after the shared first-passage and
reverse-loss lemmas; it does not use the small-rank timeout substitution.
Neither proof uses a
fixed-time endpoint-fiber moment,
Fourier estimate, stochastic independence between orbit blocks, mixing
statement, Diophantine reduction, or generated-target equidistribution
hypothesis.  The Boolean walk in
[Lemma 3.1](#lem-entropy-barrier) is exact counting over the parity words
supplied by [Proposition 2.2](#prop-parity-code), not a stochastic model of an
individual Collatz orbit.  The independent graded-clock companion uses only
a fixed finite dense-set pullback and is not on either headline dependency
chain.

The divergent relative-height allowance in Corollary 1.2(4) cannot in
general be replaced by a fixed constant, even without a clock restriction.
[Proposition 8.1](#prop-fixed-ceiling-obstruction) gives a quantitative
reciprocal obstruction, and
[Proposition 8.2](#prop-moving-ceiling-obstruction) records its shellwise
form.

### Proposition 8.1 (reciprocal fixed-ceiling obstruction) {#prop-fixed-ceiling-obstruction}

Let \(C\ge1\) be fixed, and let \(f:\mathbb N\to(0,\infty)\) satisfy
\(f(n)=o(n)\).  Let \(E(f,C)\) be the set of integers for which there is no
\(k\ge0\) satisfying both
\[
T^k(n)\le f(n),
\qquad
\max_{0\le j\le k}T^j(n)\le Cn
\tag{8.1}\label{eq:8-1}
\]
Then
\[
\underline d(E(f,C))\ge\frac{2}{3C}.
\tag{8.2}\label{eq:8-2}
\]
Here \(\underline d\) denotes lower natural density.
The same lower bound holds if a raw or joint ceiling is required.

#### Proof

Fix \(h\ge1\).  For all sufficiently large \(n\),
\[
f(n)<2^{-h}n\le T^j(n)
\qquad(0\le j\le h),
\]
so no target witness can occur in the first \(h\) shortcut steps.  If the
first \(h\) parity letters lie in \(A_h(C)\) from
[Lemma B.5](#lem-multiplier-reciprocal), then the positive affine formula
gives an actual state
\[
T^j(n)\ge nF_j>Cn
\]
before any possible target witness.  Every later witness therefore violates
the ceiling.

The parity-vector bijection identifies \(A_h(C)\) with a union of residue
classes modulo \(2^h\) of density \(2^{-h}\#A_h(C)\).  Apart from finitely
many integers this union is contained in \(E(f,C)\).  Apply \eqref{eq:b-8}
and let \(h\to\infty\) to obtain \eqref{eq:8-2}.  Every shortcut state is
also a raw state, proving the raw and joint assertions. \(\square\)

### Proposition 8.2 (moving shell ceilings) {#prop-moving-ceiling-obstruction}

For \(f:\mathbb N\to(0,\infty)\), put
\[
f_M^+=\max_{n\in I_M}f(n).
\]
Let \((R_M)\) be a real sequence and suppose
\[
\log\max\{1,f_M^+\}=o(M),
\qquad
R_M\ge1,
\qquad
\log R_M=o(M).
\tag{8.3}\label{eq:8-3}
\]
Let \(E_M\subseteq I_M\) consist of the sources admitting no witness with
target \(f(n)\) and shortcut ceiling \(nR_M\).  Then
\[
\frac{\#E_M}{2^M}
\ge\frac{2}{3R_M}\left(1-O(M^{-1})\right).
\tag{8.4}\label{eq:8-4}
\]

#### Proof

Take \(h=\lfloor M/2\rfloor\), and let \(\varepsilon_0\) be the constant
from [Lemma B.5](#lem-multiplier-reciprocal).  The hypotheses imply, eventually,
\[
f_M^+<2^{M-h},
\qquad
\log R_M\le\varepsilon_0h\log3.
\]
For \(n\in I_M\) and \(j\le h\),
\(T^j(n)\ge2^{-h}n\ge2^{M-h}>f(n)\), so no target witness occurs in
this prefix.  The length-\(h\) parity words are exactly uniform on \(I_M\).
Every word in \(A_h(R_M)\) therefore prevents a target-and-height witness,
as in Proposition 8.1.  Equation \eqref{eq:b-8} proves
\eqref{eq:8-4}. \(\square\)

The same argument applies to a nonconstant relative ceiling by using its
maximum on each shell.  The two uniform shell conditions in \eqref{eq:8-3}
are essential; pointwise subexponential growth alone is not substituted for
them.

### Corollary 8.3 (sharp balanced joint exceptional orders) {#cor-joint-rate-sharpness}

For each of the first three profiles in
[Corollary 1.2](#cor-endpoint-profiles), let the exceptional event mean
failure of the entire simultaneous target--clock--height conclusion with its
displayed common ceiling.  Then, respectively,
\[
\#E_A(X)
=\Theta_A\!\left(\frac{X}{(\log X)^q}\right),
\qquad q=\kappa_*A-\frac12,
\tag{8.5}\label{eq:8-5}
\]
\[
\#E_B(X)
=\Theta_B\!\left(
\frac{X}{(\log\log X)^{B\kappa_*}}\right),
\tag{8.6}\label{eq:8-6}
\]
and
\[
\#E_D(X)
=\Theta_D\!\left(
\frac{X}{(\log\log\log X)^{D\kappa_*}}\right).
\tag{8.7}\label{eq:8-7}
\]

#### Proof

The upper bounds are Corollary 1.2.  For the lower bounds, use
Proposition 8.2 with the corresponding target and relative-height profile.
All three targets satisfy the first uniform shell condition in
\eqref{eq:8-3}; the three ceiling profiles satisfy the second.  Their maxima
and minima on adjacent dyadic shells are asymptotically equivalent.  Thus
\eqref{eq:8-4} gives the matching lower order on every sufficiently large
complete shell.  For arbitrary large \(X\), retain the last complete shell
below \(X\); it contains a fixed positive proportion of \([1,X]\), and its
slowly varying ceiling is comparable with the displayed function at \(X\).
This proves \eqref{eq:8-5}--\eqref{eq:8-7}. \(\square\)

These lower bounds are forced by the height condition.  They do not estimate
target-only failure and do not establish optimality of \(A_{\rm FP}\), the
timeout mechanism, or the terminal scale.
[Corollary 8.3](#cor-joint-rate-sharpness) therefore concerns the balanced
joint conclusions only.

## 9. Method ceiling and future directions

The endpoint in this paper is set by the first term of \eqref{eq:6-17}.
To separate the leading power from logarithmic factors, suppose a future
replacement for the feasible-time summation contributed
\(M^{\theta+o(1)}\) in place of the present \(M^{1/2+o(1)}\), while retaining
the same timeout tail and reverse-loss estimate.  The scalar budget would then
require
\[
\kappa_*L_M>\theta\log_2M+o(\log M).
\]
For \(L_M\sim A\log_2M\), its corresponding method threshold would be
\(A>\theta/\kappa_*\).  This is only a conditional calculation: the paper
proves \(\theta=1/2\), not any smaller value.

[Lemma 6.1](#lem-time-support) already replaces a union over high-rank
histories by one interval of feasible times.  One possible route to further
improvement is to control the aggregate over that corridor more sharply.  A
stronger corridor bound or a stronger local estimate could also change the
scalar budget; neither is established here.  Two other possible mechanisms
are a signed or target-weighted estimate for the actual first-passage landings
before taking an absolute upper bound, or a restart-closed renewal estimate
for the mass surviving a low-rank timeout.  Neither estimate is proved here.

The improved timeout estimate leaves the aggregate factor
\[
F(M)L_M^{-1/2}2^{-\kappa_*L_M},
\]
where the present passage-time argument has
\(F(M)\ll\sqrt{M\log M}\).  There are two distinct possible improvements.
At the pure critical rank
\[
L_M=A_{\rm FP}\log_2M+O(1),
\]
the aggregate is of order \(F(M)/\sqrt{M\log M}\).  Thus a future bound
\[
F(M)=o(\sqrt{M\log M})
\]
would suffice for the pure-critical density-one conclusion, provided the
other estimates remained uniform and vanishing.  In particular,
\(F(M)=O(\sqrt M)\) would leave a factor \((\log M)^{-1/2}\).

Lowering the leading polylogarithmic exponent requires more: an effective
time factor \(F(M)=M^{\theta+o(1)}\) with \(\theta<1/2\) would move the
method threshold to \(\theta/\kappa_*\).  These are conditional budget
calculations, not proved transport improvements.  Merely narrowing a marginal
time distribution does not control the actual generated bad landing set.
Extending the chain to ranks much smaller than \(\log M\) would also require
new uniform control of the switch-to-terminal ratio and timeout constants.
The present results establish neither the pure critical target nor a smaller
leading exponent.

A fixed terminal rank would require a different survivor-killing estimate
whose exceptional mass decays with the outer rank \(M\), for a fixed clock
strictly above \(c_*\).  If such an estimate reached a fixed interval
\([1,C]\), and the finitely many integers in that interval were verified to
reach \(1\), it would imply convergence to \(1\) on a set of natural density
one.  That substantially stronger conclusion is outside the present theorem.

## Research and software disclosure {#research-and-software-disclosure}

OpenAI Codex 5.6 (https://openai.com/codex; accessed July--September 2026)
materially assisted with proof exploration, Lean formalization,
compiler-guided diagnostics, drafting, and audit construction under
author-supplied mathematical and release protocols.  Anthropic Claude, xAI
Grok, and Alibaba Qwen (accessed through their public interfaces in
August--September 2026; exact transient model revisions were not retained)
were used for limited exposition and review suggestions.  The author
independently assessed every suggestion, selected the architecture, checked
the mathematics and references, made all release decisions, and accepts
responsibility for all content.  No AI system is an author.  Finite
diagnostics are not premises of any theorem.

The Version 4 Lean package and the separately registered Palomar package have
different verified scopes, listed below.  The Version 4 package locally
kernel-checks the principal strengthened theorem chain; Palomar version 3
still covers four declarations associated with the preceding public
manuscript, version 3.2.4.  The canonical Version 4 library builds without
`sorry`, `admit`, a project axiom, or a missing module, and its public-root
audits report only Lean's standard logical axioms.  The exact correspondence
is recorded in `lean/FORMALIZATION.md`.

The present revision adds a new finite ballot estimate, the improved
\(m^{-3/2}\) timeout bound, the exact endpoint rates, arbitrary divergent
target and relative-height multipliers, centered shortcut and raw clocks, and
the strengthened graded-power companion.  It also derives uniform trajectory
tubes and actual first-passage clocks, reciprocal height obstructions and
sharp balanced joint exceptional orders, a stretched-logarithmic
relative-height ceiling, and the exact prefix-entropy prefactor.  The Version 4
formalization kernel-checks the principal ballot,
timeout, moving-endpoint, arbitrary-multiplier, common-landing, centered-clock,
trajectory-profile, and reciprocal-obstruction interfaces.  Its full build
has no `sorry`, `admit`, or project axiom, and its new-root audit reports only
Lean's standard logical axioms.  The exact prefix-entropy refinement, the
endpoint stretched-logarithmic rate with arbitrary strict clocks, the
graded-power companion, and some secondary and tertiary profile wrappers
remain outside that checked surface.  The Version 4 software artifact is cited
below.  Its four selected declarations have not yet been independently
replayed and registered as a new Palomar version.

| Artifact | Scope of artifact | Boundary relevant to this revision |
|---|---|---|
| Lean release `lean-v4.0.0`, Lean 4.15 | principal ballot, timeout, moving-endpoint, arbitrary-multiplier, common-landing, centered-clock, trajectory-profile, and reciprocal-obstruction interfaces | exact prefix-entropy refinement, endpoint stretched-logarithmic rate with arbitrary strict clocks, graded-power companion, and secondary/tertiary wrappers remain outside the checked surface |
| Palomar version 3, Lean 4.33 | four named declarations: moving endpoint, the full previously admissible strict fixed-\(A\) rate range, a fixed-clock stretched same-witness projection, and strict-subendpoint stretched exceptional counts | adds a fixed-\(A\) wrapper not present in the frozen release, but does not contain the version 4 results |
| This version 4 manuscript | self-contained written proofs in Sections 6--8 and Appendices A--B | some companion interfaces remain paper-only, and a Version 4 Palomar replay remains to be completed |

The
[GitHub repository](https://github.com/shaikidris/FirstPassageLinearTransport)
contains the exported theorem.  The audited Version 4 Lean source is frozen at
tag `lean-v4.0.0`.  A matching archive is available in the
[Zenodo software record](https://doi.org/10.5281/zenodo.22525757).  The formal
package uses Lean `4.15.0` (commit
`11651562caae`) and Mathlib revision
`9837ca9d65d9de6fad1ef4381750ca688774e608`.  From the repository's `lean/`
directory, run:

```text
lake build
```

Four declarations from the preceding manuscript version are also registered in the
[Palomar Registry as PALOMAR-2026-08-26-000005, version 3](https://palomar-registry.org/entry?id=PALOMAR-2026-08-26-000005&version=3).
That record preserves commit
`68d0ab1f258fa9a584d9ca3f3822d5f56461b8ed` of the separate
`FirstPassageLinearTransport-Palomar` repository.  The Palomar package ports
the frozen dependency cone to Lean `4.33.0` and adds the literal
paper-strength fixed-exponent wrapper described in its source-provenance
record; that wrapper was not part of the `lean-v3.2.0` release.
The permanent record identifies the exact Challenge and Solution statements,
preserves the submitted source commit, and records successful Comparator and
NanoDa verification with only `propext`, `Quot.sound`, and
`Classical.choice` permitted.  Palomar registration is supplementary
machine-verification evidence for those selected formal declarations; it is
not journal peer review and does not certify the stronger claims first stated
in this revision.

The theorem dictionary is `lean/FORMALIZATION.md`.  The audit files are
`PaperDependencyAudit.lean` for dependencies, `PaperAudit.lean` for the
public roots, and `TimeoutEndpointAudit.lean` for the timeout route. The
canonical build, placeholder scan, dependency report, and all axiom audits
pass, with logical dependencies `propext`, `Classical.choice`, and
`Quot.sound`.  The default build includes the named canonical audit roots.
These checks supplement rather than replace the written proof.

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

Now fix \(0<\alpha<1\) and
\(\varepsilon_T,\varepsilon_{\rm raw},\beta>0\).  Choose
\(0<\alpha'<\alpha\) sufficiently close that
\[
c_*(\alpha-\alpha')<\varepsilon_T/3,
\qquad
\frac32c_*(\alpha-\alpha')<\varepsilon_{\rm raw}/3.
\tag{A.5}\label{eq:a-5}
\]
Choose a fixed integer \(J\ge1\) such that
\(r=(\alpha')^{1/J}>a_0\), and fix \(0<\chi<r\).  Finally choose \(\eta>0\)
so small that \(\eta<r-a_0\), \(\eta<\beta/2\), and, with
\[
e=c_*(1-\alpha')\frac{\eta}{1-r},
\]
one has
\[
e<\min\left\{\frac{\varepsilon_T}{3},
\frac{\varepsilon_{\rm raw}}{3(1+p_*)}\right\}.
\tag{A.6}\label{eq:a-6}
\]

To retain a quantitative exceptional count, start from \(\mathbb N\), choose
one sufficiently small \(D_0>0\), and apply the density update above exactly
\(J\) times.  All intermediate density exponents remain in its permitted
range.  The resulting good set has complement
\[
O(X^{1-d}),
\qquad d=\chi^JD_0>0,
\tag{A.7}\label{eq:a-7}
\]
after decreasing \(D_0\), if necessary, so that \(d<1\).

On this set write \(n_0=n\) and \(n_{i+1}=G(n_i)\).  Finite startup changes
only a constant, so \(n_i\le K_*n^{r^i}\) for a fixed \(K_*\), and hence
\(n_J\le K_*n^{\alpha'}\le n^\alpha\) eventually.  Summing
\eqref{eq:a-3} gives
\[
\begin{aligned}
k
&\le
\frac{1+\eta-r}{g}\,
\frac{1-r^J}{1-r}\log_2n+O(1)\\
&=
\left[c_*(1-\alpha')+e\right]\log n+O(1).
\end{aligned}
\tag{A.8}\label{eq:a-8}
\]
The choices in \eqref{eq:a-5}--\eqref{eq:a-6} leave room for the fixed
remainder and prove the shortcut inequality in \eqref{eq:1-11}.

For the corresponding raw clock, let \(s\) be the number of odd shortcut
steps up to this same landing \(y=n_J\).  The direct-passage identity and
reverse product from Sections 4--5 give
\[
n=\frac{2^ky}{3^s}P,
\qquad 0<P\le1.
\]
Because \(y\le K_*n^{\alpha'}\),
\[
s\log3
=k\log2+\log y+\log P-\log n
\le k\log2-(1-\alpha')\log n+O(1).
\]
Thus, for \(\ell=k+s\),
\[
\ell
\le(1+p_*)k-\frac{1-\alpha'}{\log3}\log n+O(1).
\tag{A.9}\label{eq:a-9}
\]
The identity
\[
(1+p_*)c_*-\frac1{\log3}=\frac32c_*
\]
and \eqref{eq:a-8} now give
\[
\ell\le
\left[\frac32c_*(1-\alpha')+(1+p_*)e\right]\log n+O(1).
\tag{A.10}\label{eq:a-10}
\]
Equations \eqref{eq:a-5}--\eqref{eq:a-6} absorb the remainder and prove the
raw inequality in \eqref{eq:1-11}.

Finally, all block starts decrease, and the controlled-prefix envelope bounds
every shortcut state by \(n^{1+\eta}\).  Each intervening raw odd state is at
most twice the following shortcut state.  Since \(\eta<\beta/2\), both
trajectories are eventually bounded by \(n^{1+\beta}\).  The landing, both
clocks, the two ceilings, and the power-saving exceptional count all arise
from the same fixed-depth pullback set. \(\square\)

The graded clock has prior support in Inselmann's Theorem 1.3, while his
Theorem 1.1 supplies a trajectory envelope.  The argument here records the
quantitative joint consequence of the present finite-pullback construction;
it is not asserted as a new fixed-power frontier.

## Appendix B. Finite ballot estimates {#app-finite-ballot}

This appendix proves the finite-word estimate used in
[Lemma 6.3](#lem-timeout-low-phase).  Probability notation below denotes an
exact finite product weighting of words.  It is not an independence
assumption about consecutive Collatz descent blocks.

### Lemma B.1 (centered finite survival) {#lem-centered-survival}

Let \(X_1,\ldots,X_n\) be independent copies of a random variable on a finite
weighted alphabet such that
\[
\mathbb EX_1=0,
\qquad |X_1|\le1,
\qquad \mathbb EX_1^2=v>0.
\]
Put \(S_0=0\) and \(S_j=\sum_{i=1}^jX_i\).  For every \(h\ge0\) and
integer \(n\ge1\),
\[
\begin{split}
\mathbb P\{S_j\ge-h\text{ for }0\le j\le n\}
&\le\frac{h+1}{\sqrt n+h+1}
+\frac{(h+1)(\sqrt n+1)}{vn}\\
&\le\left(1+\frac2v\right)\frac{h+1}{\sqrt n}.
\end{split}
\tag{B.1}\label{eq:b-1}
\]

#### Proof

Set \(H=\sqrt n\), and let \(\tau\) be the smaller of \(n\) and the first
index at which \(S_j<-h\) or \(S_j\ge H\).  If no such index occurs, put
\(\tau=n\).  The stopped value has the finite expansion
\[
Y=S_\tau=\sum_{j=1}^n\mathbf1_{\{\tau\ge j\}}X_j.
\]
The indicator in the \(j\)-th summand is determined by the first \(j-1\)
letters.  Independence and centering therefore give \(\mathbb EY=0\).
Conditioning on the letters before the later increment makes every cross term
in \(\mathbb EY^2\) vanish, while the diagonal terms give
\[
\mathbb EY^2
=v\sum_{j=1}^n\mathbb P(\tau\ge j)
=v\mathbb E\tau.
\tag{B.2}\label{eq:b-2}
\]
Bounded overshoot gives \(-h-1\le Y\le H+1\).  Hence
\[
0\le\mathbb E[(Y+h+1)(H+1-Y)]
=(h+1)(H+1)-v\mathbb E\tau,
\]
so \(\mathbb E\tau\le(h+1)(H+1)/v\).  If \(U=\{Y\ge H\}\), then
\(Y\ge-h-1\) off \(U\), and \(\mathbb EY=0\) gives
\[
\mathbb P(U)\le\frac{h+1}{H+h+1}.
\]
A path surviving above \(-h\) through time \(n\) either stops at the upper
boundary or has \(\tau=n\).  Markov's inequality for \(\tau\) therefore gives
\[
\mathbb P(\text{survival})
\le\mathbb P(U)+\mathbb P(\tau=n)
\le\frac{h+1}{H+h+1}+\frac{\mathbb E\tau}{n},
\]
which proves \eqref{eq:b-1}. \(\square\)

### Lemma B.2 (uniform binomial atom) {#lem-binomial-atom}

For fixed \(p\in(0,1)\), there is \(C_p<\infty\) such that, for every
integer \(n\ge1\),
\[
\sup_{k\in\mathbb Z}\binom nkp^k(1-p)^{n-k}\le C_pn^{-1/2},
\tag{B.3}\label{eq:b-3}
\]
where masses outside \(0\le k\le n\) are zero.

#### Proof

The ratio of consecutive positive masses is
\[
\frac{n-k}{k+1}\frac p{1-p}.
\]
Thus a mode may be chosen as \(k_0=\lfloor(n+1)p\rfloor\), with
\(|k_0-np|\le1\).  For all sufficiently large \(n\), \(u=k_0/n\) remains in
a fixed compact subinterval of \((0,1)\).  The elementary factorial Stirling
bounds give
\[
\binom n{k_0}p^{k_0}(1-p)^{n-k_0}
\le\frac{C}{\sqrt{nu(1-u)}}e^{-nD(u\Vert p)}
\le C_pn^{-1/2},
\]
because \(D(u\Vert p)\ge0\).  Enlarge \(C_p\) for the finitely many smaller
values of \(n\).  Every other atom is no larger than a mode. \(\square\)

### Lemma B.3 (fair-word mass above a fixed barrier) {#lem-fair-word-barrier}

For a binary word \(b_0,\ldots,b_{m-1}\), put
\[
s_j=\sum_{i<j}b_i,
\qquad
Z_j=s_j\log3-j\log2.
\]
For every fixed \(B>0\), there is \(C_B<\infty\) such that, for every
integer \(m\ge1\),
\[
2^{-m}\#\{b:Z_j>-B\text{ for every }0\le j\le m\}
\le C_Bm^{-3/2}2^{-\kappa_*m}.
\tag{B.4}\label{eq:b-4}
\]
The constant may be chosen uniformly for \(B\) in a bounded positive
interval.

#### Proof

Give a letter \(1\) weight \(p_*\) and a letter \(0\) weight \(1-p_*\), and
write \(\mathbb P_*\) for the resulting finite product law.  The increments
of \(Z\) then have mean zero, absolute value less than one, and variance
\[
v=p_*(1-p_*)(\log3)^2=\log2\log(3/2)>0.
\]
The negated increments have the same properties.  Put
\[
\lambda=\frac{\log(p_*/(1-p_*))}{\log3}>0.
\]
For every individual word, direct simplification gives
\[
\frac{2^{-m}}{p_*^{s_m}(1-p_*)^{m-s_m}}
=2^{-\kappa_*m}e^{-\lambda Z_m}.
\tag{B.5}\label{eq:b-5}
\]

For \(m\ge8\), split the word into a first block of length
\(a=\lfloor m/4\rfloor\), a middle block of length \(b=m-2a\), and a last
block of length \(a\).  Let \(W\) be the event on the left of
\eqref{eq:b-4}, and partition its terminal values into
\[
Z_m+B\in[q,q+1),
\qquad q=0,1,2,\ldots.
\]
On \(W\), the first block stays above \(-B\).  On \(W\) in bin \(q\), the
reversed, negated last block has partial sums
\[
Z_{m-j}-Z_m>-(q+1),
\qquad 0\le j\le a.
\]
These two necessary outer-block events depend on disjoint letters.  Applying
[Lemma B.1](#lem-centered-survival) to each bounds their product probability
by
\[
\frac{C(B+1)(q+2)}a.
\]
After the two outer blocks are fixed, the terminal-bin condition asks that
the middle-block sum lie in an interval of length one.  That sum is
\(K\log3-b\log2\), where \(K\) has the
\(\operatorname{Bin}(b,p_*)\) law.  Its lattice spacing is
\(\log3>1\), so the interval contains at most one atom.
[Lemma B.2](#lem-binomial-atom) bounds the conditional probability by
\(Cb^{-1/2}\), uniformly in the outer blocks.  Since \(a\ge m/8\) and
\(b\ge m/2\),
\[
\mathbb P_*(W,\ Z_m+B\in[q,q+1))
\le C(B+1)(q+2)m^{-3/2}.
\tag{B.6}\label{eq:b-6}
\]
The power \(m^{-3/2}\) has three square-root sources: survival of the first
outer block, survival of the reversed-negated last outer block, and the
single middle-block binomial atom.
Only the two disjoint outer-block events have been multiplied here; no
independence of the full survival and terminal events is asserted.

On bin \(q\),
\(e^{-\lambda Z_m}\le e^{\lambda B}e^{-\lambda q}\).  Summing
\eqref{eq:b-6} with the weights in \eqref{eq:b-5} yields
\[
2^{-m}\#W
\le C(B+1)e^{\lambda B}
\left(\sum_{q\ge0}(q+2)e^{-\lambda q}\right)
m^{-3/2}2^{-\kappa_*m}.
\]
The series converges, and the finitely many \(m<8\) are absorbed into the
constant.  The same expression is bounded uniformly when \(B\) ranges over
a bounded positive interval. \(\square\)

This is a ballot-type estimate.  General ballot estimates for finite-variance
walks are classical; see Addario-Berry and Reed
[[16]](#ref-addario-berry-reed).  Their theorem is not a premise here: the
finite argument above supplies the precise estimate used in Section 6.

### Lemma B.4 (finite multiplicative maximum) {#lem-multiplier-maximum}

For fair binary words of length \(M\), put
\(F_j=3^{s_j}/2^j\).  For every \(u>0\),
\[
2^{-M}\#\{b:\max_{0\le j\le M}F_j>u\}\le u^{-1}.
\tag{B.7}\label{eq:b-7}
\]

#### Proof

Given a prefix, the next multiplicative factor is \(1/2\) or \(3/2\), whose
fair average is one.  Stop at the first index for which \(F_j>u\), or at
\(M\) if there is none; if \(u<1\), stop at zero.  Repeatedly replacing each
pair of children by its parent in this finite word tree shows that the stopped
terminal value has mean one.  It is nonnegative everywhere and exceeds \(u\)
on the crossing event.  Hence
\(1\ge u\,\mathbb P(\text{crossing})\), proving \eqref{eq:b-7}. \(\square\)

### Lemma B.5 (reciprocal finite multiplicative maximum) {#lem-multiplier-reciprocal}

For \(u\ge1\), let
\[
A_h(u)=\left\{\max_{0\le j\le h}F_j>u\right\},
\qquad
\varepsilon_0=\frac{3/4-p_*}{2}>0,
\qquad
K_{\max}=\frac{3}{16\varepsilon_0^2}.
\]
If \(\log u\le\varepsilon_0h\log3\), then
\[
\frac{2}{3u}\left(1-\frac{K_{\max}}h\right)
\le2^{-h}\#A_h(u)\le\frac1u.
\tag{B.8}\label{eq:b-8}
\]
For small \(h\), a negative lower bound is understood as vacuous.

#### Proof

Stop each fair word at its first crossing of \(u\), or at \(h\) if it
does not cross.  The finite-tree identity used in Lemma B.4 gives
\(\mathbb EF_\sigma=1\).  At a crossing, the previous value is at most
\(u\), and only an upward multiplier can cross, so
\(u<F_\sigma\le3u/2\).  Consequently
\[
1\le\frac32u\,\mathbb P_{1/2}(A_h(u))
+\mathbb E_{1/2}[F_h;A_h(u)^c].
\tag{B.9}\label{eq:b-9}
\]
For each individual word there is the exact change of finite word weights
\[
2^{-h}F_h
=\left(\frac34\right)^{s_h}
 \left(\frac14\right)^{h-s_h}.
\tag{B.10}\label{eq:b-10}
\]
Therefore the final term in \eqref{eq:b-9} equals
\(\mathbb P_{3/4}(A_h(u)^c)\), and is at most
\(\mathbb P_{3/4}(F_h\le u)\).

Under the latter finite product weighting, \(s_h\) has mean \(3h/4\) and
variance \(3h/16\).  The identity
\(\log F_h=s_h\log3-h\log2\), the definition
\(p_*=\log_3 2\), and the hypothesis on \(u\) imply
\[
F_h\le u
\quad\Longrightarrow\quad
s_h\le p_*h+\frac{\log u}{\log3}
\le\left(\frac34-\varepsilon_0\right)h.
\]
Chebyshev's inequality bounds this probability by \(K_{\max}/h\).
Substitution in \eqref{eq:b-9} proves the lower bound; Lemma B.4 gives the
upper bound. \(\square\)

## References

<span id="ref-crandall">[1]</span> R. E. Crandall, *On the "3x+1" problem*, Math.
Comp. **32** (1978), no. 144, 1281--1292,
[doi:10.1090/S0025-5718-1978-0480321-3](https://doi.org/10.1090/S0025-5718-1978-0480321-3).

<span id="ref-everett">[2]</span> C. J. Everett, *Iteration of the number-theoretic
function \(f(2n)=n\), \(f(2n+1)=3n+2\)*, Adv. Math. **25** (1977), no. 1,
42--45,
[doi:10.1016/0001-8708(77)90087-1](https://doi.org/10.1016/0001-8708(77)90087-1).

<span id="ref-inselmann">[3]</span> M. Inselmann, *An approximation of the Collatz
map and a lower bound for the average total stopping time*, arXiv:2402.03276v3
(2024),
[doi:10.48550/arXiv.2402.03276](https://doi.org/10.48550/arXiv.2402.03276).

<span id="ref-kontorovich-lagarias">[4]</span> A. V. Kontorovich and J. C.
Lagarias, *Stochastic models for the \(3x+1\) and \(5x+1\) problems and related
problems*, in *The Ultimate Challenge: The \(3x+1\) Problem* (J. C. Lagarias,
ed.), American Mathematical Society, Providence, RI, 2010, pp. 131--188.

<span id="ref-korec">[5]</span> I. Korec, *A density estimate for the \(3x+1\)
problem*, Math. Slovaca 44 (1994), no. 1, 85--89,
[DML-CZ record](https://dml.cz/handle/10338.dmlcz/133225).

<span id="ref-krasikov-lagarias">[6]</span> I. Krasikov and J. C. Lagarias,
*Bounds for the \(3x+1\) problem using difference inequalities*, Acta Arith.
**109** (2003), 237--258,
[doi:10.4064/aa109-3-4](https://doi.org/10.4064/aa109-3-4).

<span id="ref-lagarias">[7]</span> J. C. Lagarias, *The \(3x+1\) problem and its
generalizations*, Amer. Math. Monthly **92** (1985), no. 1, 3--23,
[doi:10.2307/2322189](https://doi.org/10.2307/2322189).

<span id="ref-lagarias-weiss">[8]</span> J. C. Lagarias and A. Weiss, *The
\(3x+1\) problem: two stochastic models*, Ann. Appl. Probab. **2** (1992),
no. 1, 229--261,
[doi:10.1214/aoap/1177005779](https://doi.org/10.1214/aoap/1177005779).

<span id="ref-endpoint-v1">[9]</span> I. A. Shaik, *Quantitative Collatz Descent to
Stretched-Logarithmic Scale in Natural Density, with a Lean 4 Formalization*,
version 2.0.2, preprint (2026),
[doi:10.5281/zenodo.21851173](https://doi.org/10.5281/zenodo.21851173).

<span id="ref-tao">[10]</span> T. Tao, *Almost all orbits of the Collatz map
attain almost bounded values*, Forum Math. Pi **10** (2022), e12,
[doi:10.1017/fmp.2022.8](https://doi.org/10.1017/fmp.2022.8).

<span id="ref-terras">[11]</span> R. Terras, *A stopping time problem on the
positive integers*, Acta Arith. **30** (1976), 241--252.

<span id="ref-terras-density">[12]</span> R. Terras, *On the existence of a
density*, Acta Arith. **35** (1979), 101--102,
[doi:10.4064/aa-35-1-101-102](https://doi.org/10.4064/aa-35-1-101-102).

<span id="ref-wirsching">[13]</span> G. J. Wirsching, *The Dynamical System
Generated by the \(3n+1\) Function*, Lecture Notes in Mathematics, vol. 1681,
Springer-Verlag, Berlin, 1998,
[doi:10.1007/BFb0095985](https://doi.org/10.1007/BFb0095985).

<span id="ref-allikvere">[14]</span> J. Allikvere, *Almost all Collatz orbits
attain almost bounded values in natural density*, version 2, preprint
(22 July 2026),
[doi:10.5281/zenodo.21499244](https://doi.org/10.5281/zenodo.21499244).

<span id="ref-mazur">[15]</span> L. Mazur, *Natural-density almost-bounded
Collatz orbits in logarithmic time*, version 2, preprint (21 July 2026),
[public manuscript](https://www.proofatlas.ai/papers/natural-density-log-time-collatz/Mazur_Natural_Density_Collatz_Orbits_in_Logarithmic_Time_v2.pdf).

<span id="ref-addario-berry-reed">[16]</span> L. Addario-Berry and B. A. Reed,
*Ballot theorems for random walks with finite variance*, arXiv:0802.2491v2
(2008),
[doi:10.48550/arXiv.0802.2491](https://doi.org/10.48550/arXiv.0802.2491).
