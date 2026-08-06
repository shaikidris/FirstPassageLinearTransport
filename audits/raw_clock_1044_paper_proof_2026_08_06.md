# Raw-clock `10.44 log n` paper proof

## Audit card

- **Mode:** `MATH-TEXT` closure proof.
- **Status:** `PROVED-ON-PAPER / PROVED-FORMAL`; synchronized in V2.3.
- **Target:** replace the current worst-case conversion
  `13.906 log n` by a literal raw Collatz clock below `10.44 log n` for
  every fixed stretched-log exponent `0 < delta < 1`.
- **New content:** exact raw/shortcut clock identity plus deterministic
  blockwise odd-count control from the already-proved maximal barrier.
- **Not used:** empirical parity frequency, an independence assumption, or
  an average over retained sources.

## 1. Exact raw/shortcut identity

Let

\[
\operatorname{Col}(m)=
\begin{cases}
m/2,&m\equiv0\pmod2,\\
3m+1,&m\equiv1\pmod2,
\end{cases}
\]

and let `s_k(n)` be the number of odd entries among
`n,T(n),...,T^(k-1)(n)`.  Then

\[
\boxed{
\operatorname{Col}^{\,k+s_k(n)}(n)=T^k(n).
}
\tag{RC.1}
\]

Proof is by induction on `k`.  At an even shortcut state, one shortcut
letter is one raw step and the odd count does not increase.  At an odd
shortcut state, one shortcut letter is the two-step raw segment

\[
m\longmapsto3m+1\longmapsto(3m+1)/2,
\]

and the odd count increases by one.  This also proves exact additivity under
concatenation:

\[
s_{k+\ell}(n)=s_k(n)+s_\ell(T^k(n)).
\tag{RC.2}
\]

## 2. Deterministic odd-count excess on one stopped block

Let `x` be a nonstartup retained block source in the shell `I_M`, and let
`ell(x) <= M` be its stopped shortcut length.  Membership in the maximal
barrier set gives, at every prefix `h <= M`,

\[
\left|s_h(x)-\frac h2\right|
\le
\frac{\eta M}{\log_2 3}.
\tag{RC.3}
\]

In particular,

\[
s_{\ell(x)}(x)
\le
\frac{\ell(x)}2+
\frac{\eta M}{\log_2 3}.
\tag{RC.4}
\]

Since `M <= log_2 x`, change of base yields

\[
\frac{\eta M}{\log_2 3}
\le
\frac{\eta}{\log3}\log x.
\tag{RC.5}
\]

On the finite startup identity branch, `ell(x)=0` and the same required
upper estimate is trivial.

## 3. Sum over the stopped bootstrap

For a retained source, write

\[
n_0=n,
\qquad
n_{i+1}=G(n_i),
\qquad
\ell_i=\ell(n_i),
\qquad
0\le i<R.
\]

The raw time reaching `n_R` is, by (RC.1)--(RC.2),

\[
K_R^{\rm raw}
=\sum_{i=0}^{R-1}
\bigl(\ell_i+s_{\ell_i}(n_i)\bigr).
\tag{RC.6}
\]

Equations (RC.4)--(RC.5) imply

\[
K_R^{\rm raw}
\le
\frac32\sum_{i=0}^{R-1}\ell_i
+\frac{\eta}{\log3}
\sum_{i=0}^{R-1}\log n_i.
\tag{RC.7}
\]

The existing bootstrap estimates are

\[
\sum_{i=0}^{R-1}\ell_i
\le
\frac{\log n}{(1-r)\log2}+O(R),
\tag{RC.8}
\]

and

\[
n_i\le K_*n^{r^i}.
\]

Therefore

\[
\sum_{i=0}^{R-1}\log n_i
\le
\frac{\log n}{1-r}+O(R).
\tag{RC.9}
\]

Combining (RC.7)--(RC.9),

\[
K_R^{\rm raw}
\le
C_{\rm raw}(r,\eta)\log n+O(R),
\tag{RC.10}
\]

where

\[
\boxed{
C_{\rm raw}(r,\eta)
=
\frac1{1-r}
\left(
\frac3{2\log2}+\frac\eta{\log3}
\right).
}
\tag{RC.11}
\]

For the stretched-log schedule, `R=O(log log n)`, so the remainder in
(RC.10) is `o(log n)`.

## 4. Exact strict margin below `10.44`

At the limiting admissible parameters,

\[
\lim_{r\downarrow a_0,\ \eta\downarrow0}
C_{\rm raw}(r,\eta)
=
\frac3{\log(4/3)}.
\tag{RC.12}
\]

The manuscript already proves, from two positive terms of the logarithm
series,

\[
\log\frac43>\frac{296}{1029}.
\tag{RC.13}
\]

Moreover,

\[
\frac{296}{1029}>\frac{25}{87},
\]

because

\[
296\cdot87-25\cdot1029=27>0.
\]

Hence

\[
\frac3{\log(4/3)}
<
\frac3{25/87}
=
\frac{261}{25}
=10.44.
\tag{RC.14}
\]

This is an exact rational guard, not a floating-point comparison.

## 5. Compatibility with every `delta < 1`

Fix `0 < delta < 1`.  The endpoint proof already uses

\[
\frac{\log(1/r)}{\log(1/\chi)}\longrightarrow1
\]

as `r` decreases to `a0` from above and `chi` increases to `a0` from
below.  By the strict inequalities `delta < 1` and (RC.14), choose `r` and
`chi` sufficiently close to `a0` so that simultaneously

\[
\delta<\frac{\log(1/r)}{\log(1/\chi)}
\]

and

\[
\frac1{1-r}\frac3{2\log2}<\frac{261}{25}.
\]

Then choose

\[
0<\eta<r-a_0
\]

small enough that the full expression (RC.11) still satisfies

\[
C_{\rm raw}(r,\eta)<\frac{261}{25}.
\tag{RC.15}
\]

All parameters are fixed before the retained density-one set is formed.
Since the error in (RC.10) is `o(log n)`, the strict margin in (RC.15)
absorbs it for every sufficiently large retained `n`.

The formal proof records the exact pointwise inequality with coefficient
`eta / log 3`; this corrects the spurious factor `1/2` in the initial
paper-only audit.  The correction does not change the limiting coefficient
or the strict `10.44` conclusion because `eta` is chosen arbitrarily small.

## 6. Exact theorem statement

For every fixed `0 < delta < 1`, there is a set `S_delta` of natural
density one such that every sufficiently large `n` in `S_delta` has a raw
Collatz time `j` satisfying

\[
0\le j<10.44\log n
\]

and

\[
\operatorname{Col}^j(n)
\le
\exp\!\left((\log n)^{1-\delta}\right).
\tag{RC.16}
\]

The same parameter choice may retain the separately fixed **shortcut-orbit**
ceiling from Corollary 1.3.  No raw intermediate-value ceiling is asserted
here; an odd raw step inserts the additional value `3m+1`.

## 7. Anti-circularity and boundary checks

1. The proof never replaces retained parities by independent fair bits.
2. The odd-count estimate is pointwise at every prefix of every retained
   block.
3. Raw time is an exact integer identity, not an asymptotic conversion.
4. The leading `3/2` factor and the excess term are both present.
5. The strict rational margin pays the full `o(log n)` remainder.
6. The choice of `r, chi, eta` remains compatible with every fixed
   `delta < 1`; no endpoint parameter is substituted after the set is built.

## Verdict

`ACCEPT-ON-PAPER`.  The previous `13.906` conversion discarded all parity
information.  The already-proved maximal barrier supplies exactly the
pointwise information needed to replace the factor `2` by `3/2` plus a
vanishing parameter loss, with a rigorous strict margin below `10.44`.
Manuscript promotion and Lean formalization remain required gates.
