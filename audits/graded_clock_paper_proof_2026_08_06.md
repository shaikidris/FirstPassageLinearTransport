# Smooth graded-clock paper proof

## Audit card

- **Mode:** `MATH-TEXT` closure proof.
- **Status:** `PROVED-ON-PAPER / PROVED-FORMAL`; synchronized in V2.3.
- **Target:** for fixed `0 < alpha < 1` and `epsilon > 0`, obtain a
  natural-density-one set on which an iterate reaches `n^alpha` before
  `(cStar * (1 - alpha) + epsilon) * log n` shortcut steps, where
  `cStar = 2 / log (4 / 3)`.
- **Rejected shortcut:** stopping the existing full-block schedule at the
  first `R` with `r^R <= alpha`.  That incurs a genuine last-block
  overshoot.
- **New input:** use the already-proved all-prefix orbit envelope to shorten
  the certified horizon of the existing stopped map in proportion to the
  logarithmic height removed.

## 1. Short-horizon one-stage lemma

Put

\[
g=1-a_0>0,
\qquad
c_*=\frac1{g\log2}=\frac2{\log(4/3)}.
\]

Fix

\[
a_0<r<1,
\qquad
0<\eta<r-a_0,
\]

and retain the shell target

\[
Y_M=2^{\lfloor rM\rfloor}.
\]

Define the shortened horizon

\[
H_M=
\left\lceil
\frac{(1+\eta-r)M+2+\eta}{g}
\right\rceil.
\tag{GC.1}
\]

Because `eta < r - a0`,

\[
\frac{1+\eta-r}{g}<1.
\]

Consequently, after increasing the fixed startup shell, one has

\[
1\le H_M\le M.
\tag{GC.2}
\]

If `n` lies in the maximal-barrier set in the shell
`I_M=[2^M,2^(M+1))`, the all-prefix upper envelope gives, for every
`h <= M`,

\[
T^h(n)\le 2^{-gh}n^{1+\eta}.
\tag{GC.3}
\]

Using `n < 2^(M+1)` and (GC.1),

\[
\begin{aligned}
T^{H_M}(n)
&<2^{-gH_M+(1+\eta)(M+1)}\\
&\le 2^{rM-1}\\
&\le 2^{\lfloor rM\rfloor}=Y_M.
\end{aligned}
\tag{GC.4}
\]

The second inequality is exactly

\[
gH_M\ge(1+\eta-r)M+2+\eta,
\]

and the third uses `floor(rM) >= rM - 1`.  Thus the first-passage time
to `Y_M` is at most `H_M`, not merely at most `M`.

The ceiling gives the explicit clock bound

\[
H_M
\le
\theta M+C_\eta,
\qquad
\theta=\frac{1+\eta-r}{g},
\qquad
C_\eta=\frac{2+\eta}{g}+1.
\tag{GC.5}
\]

## 2. The density pullback is unchanged

Proposition 4.4 is stated for every horizon `H`.  Insert `H=H_M`.
By (GC.2),

\[
\frac{H_M}{2Y_M}\le\frac{M}{2Y_M}\le\frac13
\]

on all sufficiently large shells.  Its transported-source bound becomes

\[
\frac52 H_M^2\frac{2^M}{Y_M}|B|
\le
\frac52 M^2\frac{2^M}{Y_M}|B|.
\]

This is no larger than the term already used in Theorem 5.1.  The stopped
map itself is unchanged: it is still the first entrance below `Y_M`; only
its proved upper time bound improves from `M` to `H_M`.  Therefore the
entire dense-set pullback proof, including the exponent update
`D -> chi D`, remains valid with the shortened certified horizon.  No new
distributional, moment, or independence estimate is inserted.

## 3. Fixed finite bootstrap to a prescribed power

Fix

\[
0<\alpha<1,
\qquad
\varepsilon>0.
\]

Choose `alphaPrime` with

\[
0<\alpha'<\alpha,
\qquad
c_*(\alpha-\alpha')<\frac\varepsilon3.
\tag{GC.6}
\]

Choose an integer `R >= 1` so large that

\[
r=(\alpha')^{1/R}>a_0.
\tag{GC.7}
\]

Then `0 < r < 1` and `r^R=alphaPrime`.  Finally choose `eta` so that

\[
0<\eta<r-a_0,
\qquad
c_*(1-\alpha')\frac\eta{1-r}<\frac\varepsilon3.
\tag{GC.8}
\]

All parameters and `R` are fixed independently of `n`.  Iterate the
shortened stopped-map pullback exactly `R` times.  A finite iteration of
the power-density recurrence remains power-dense, hence supplies a set of
natural density one.

Let

\[
n_0=n,
\qquad
n_{i+1}=G(n_i),
\qquad
0\le i<R.
\]

The existing stage-size induction applies without change:

\[
n_i\le K_*n^{r^i}
\tag{GC.9}
\]

for a fixed `K_* >= 1`.  At the terminal stage,

\[
n_R\le K_*n^{r^R}=K_*n^{\alpha'}\le n^\alpha
\tag{GC.10}
\]

for all sufficiently large `n`, because `alphaPrime < alpha`.

## 4. Telescoping clock

Let `ell(n_i)` be the shortened first-passage time.  Equations (GC.5)
and (GC.9) give

\[
\begin{aligned}
k_R
&=\sum_{i=0}^{R-1}\ell(n_i)\\
&\le
\theta\sum_{i=0}^{R-1}\log_2 n_i+C_\eta R\\
&\le
\theta\frac{1-r^R}{1-r}\log_2 n+O_{\alpha,\varepsilon}(1).
\end{aligned}
\tag{GC.11}
\]

Since

\[
\frac\theta{\log2}\frac{1-r^R}{1-r}
=
c_*(1-\alpha')
\left(1+\frac\eta{1-r}\right),
\tag{GC.12}
\]

(GC.6)--(GC.8) imply that the leading coefficient in (GC.11) is
strictly smaller than

\[
c_*(1-\alpha)+\frac{2\varepsilon}{3}.
\]

The fixed additive term in (GC.11) is smaller than
`(epsilon / 3) * log n` for all sufficiently large `n`.  Hence

\[
k_R<\bigl(c_*(1-\alpha)+\varepsilon\bigr)\log n.
\tag{GC.13}
\]

Combining (GC.10) and (GC.13) proves the target theorem.

## 5. Exact theorem statement

For every fixed `0 < alpha < 1` and every fixed `epsilon > 0`, there is
a set `S_{alpha,epsilon}` of natural density one such that every
sufficiently large `n` in that set has an integer `k` satisfying

\[
0\le k<
\left(
\frac{2(1-\alpha)}{\log(4/3)}+\varepsilon
\right)\log n,
\qquad
T^k(n)\le n^\alpha.
\tag{GC.14}
\]

## 6. Anti-circularity and boundary checks

1. **No full-block overshoot.**  The improvement comes from (GC.4), an
   independently proved shorter terminal time, not from reversing the
   inequality `1-r^R >= 1-alpha`.
2. **No fresh-randomness premise.**  Proposition 4.4 remains pointwise in
   the target subset.
3. **No varying parameter in a fixed theorem.**  `alphaPrime`, `R`, `r`,
   and `eta` are fixed before the density-one set is constructed.
4. **Landing constant is paid.**  The strict gap
   `alphaPrime < alpha` absorbs `K_*`; it is not silently dropped.
5. **The `alpha -> 1` test passes.**  The leading clock tends to zero,
   because the shortened horizon is proportional to logarithmic height
   removed.
6. **The `alpha -> 0` test is consistent.**  The leading coefficient tends
   to `cStar`, recovering the existing `2 / log(4/3)` endpoint scale.
7. **Finite startup is harmless.**  All newly imposed horizon inequalities
   are eventual fixed-parameter inequalities and are absorbed into the
   totalized identity branch.

## Verdict

`ACCEPT-ON-PAPER`.  The earlier obstruction applied only to the old
full-shell horizon.  The all-prefix envelope plus the already general
first-passage transport proposition supplies the missing alpha-sensitive
horizon.  Manuscript promotion and Lean formalization remain separate
required gates.
