#!/usr/bin/env python3
"""Sparse target-averaged Green audit using the timeout low-stage target.

The maximal-barrier stopped target cannot be enumerated in its genuinely
sparse regime.  The proposed timeout replacement makes membership local:
for y in a dyadic landing band, declare y bad when its orbit does not hit
the next lower threshold within its shell rank.

HYPOTHESIS / CONSUMER
  For sources x in I_(q+source_gap), first-passaged to J_q, the timeout-bad
  target does not positively select either landing mass or reverse loss:

      weighted enrichment
        = P_mu(landing bad) / P_uniform(bad)
          * E_mu(loss | bad) / E_mu(loss)

  remains bounded as q grows.  A source-weighted multiblock version is the
  open AVG.JOINT producer.

OBSERVABLE
  Independent deterministic Monte Carlo estimates of the uniform endpoint
  target density and the first-passage landing/loss law.  The two enrichment
  factors and their exact product are printed separately.

FINITE SCOPE
  Sampled, not exhaustive.  Python integers keep every orbit and membership
  decision exact; only the loss sum and reported probabilities are floating
  point.  Sampling uncertainty is printed.  No asymptotic theorem follows.

POSITIVE CONTROL
  A hash target of the same estimated density, independent of the orbit law,
  should have enrichment near one.

NEGATIVE CONTROL
  Selecting the top d fraction of source losses (not an endpoint target) must
  produce visible positive loss enrichment.  It is only a sensitivity check.

KILL SIGNAL
  Stable growth of the generated weighted enrichment with q, beyond sampling
  error, or failure of the independent hash control.

CONTINUE SIGNAL
  Generated and hash enrichments remain O(1), while the aligned-loss control
  is visibly larger and the target density becomes sparse.

STATUS
  EMPIRICAL / sampled finite scope.
"""

from __future__ import annotations

import argparse
import hashlib
import math
import random
from dataclasses import dataclass


def shortcut(n: int) -> int:
    return (3 * n + 1) // 2 if n & 1 else n // 2


def first_passage_loss(n: int, q: int) -> tuple[int, int, float]:
    threshold = 1 << q
    h = 0
    loss = 0.0
    while n > threshold:
        nxt = shortcut(n)
        if n & 1:
            loss += threshold / (2.0 * float(nxt))
        n = nxt
        h += 1
        if h > 10000:
            raise RuntimeError("first-passage horizon exceeded")
    return h, n, loss


def timeout_bad(y: int, landing_q: int, gap: int) -> bool:
    """Whether a landing in J_q times out in its next low block.

    Apart from the separately successful endpoint y = 2^q, a landing in
    J_q = (2^(q-1), 2^q] has parent-shell rank q-1.  A timeout means that
    the orbit has not reached the next threshold through time q-1, not
    through time q.
    """
    if y == 1 << landing_q:
        return False
    rank = landing_q - 1
    if rank <= gap:
        return False
    threshold = 1 << (rank - gap)
    current = y
    for _ in range(rank):
        if current <= threshold:
            return False
        current = shortcut(current)
    return current > threshold


def hash_bad(y: int, probability: float) -> bool:
    if probability <= 0.0:
        return False
    if probability >= 1.0:
        return True
    digest = hashlib.blake2b(str(y).encode("ascii"), digest_size=8).digest()
    value = int.from_bytes(digest, "big") / float(1 << 64)
    return value < probability


@dataclass
class BernoulliEstimate:
    count: int
    total: int

    @property
    def p(self) -> float:
        return self.count / self.total if self.total else math.nan

    @property
    def se(self) -> float:
        if not self.total:
            return math.nan
        return math.sqrt(max(0.0, self.p * (1.0 - self.p) / self.total))


def sample_uniform_target(q: int, gap: int, samples: int, seed: int) -> BernoulliEstimate:
    rng = random.Random(seed)
    lo = 1 << (q - 1)
    bad = 0
    for _ in range(samples):
        y = lo + 1 + rng.getrandbits(q - 1)
        bad += int(timeout_bad(y, q, gap))
    return BernoulliEstimate(bad, samples)


def source_law(
    q: int, source_gap: int, timeout_gap: int, samples: int, seed: int
) -> dict[str, float | int]:
    rng = random.Random(seed)
    m = q + source_gap
    lo = 1 << m
    losses: list[float] = []
    actual_bad: list[bool] = []
    landings: list[int] = []
    max_h = 0
    for _ in range(samples):
        n = lo + rng.getrandbits(m)
        h, y, loss = first_passage_loss(n, q)
        max_h = max(max_h, h)
        losses.append(loss)
        landings.append(y)
        actual_bad.append(timeout_bad(y, q, timeout_gap))

    mean_loss = sum(losses) / samples
    actual_count = sum(actual_bad)
    actual_share = actual_count / samples
    bad_loss = sum(loss for loss, bad in zip(losses, actual_bad) if bad)
    conditional_loss = bad_loss / actual_count if actual_count else math.nan

    return {
        "actual_count": actual_count,
        "actual_share": actual_share,
        "actual_se": math.sqrt(actual_share * (1.0 - actual_share) / samples),
        "mean_loss": mean_loss,
        "conditional_loss": conditional_loss,
        "conditional_loss_enrichment": conditional_loss / mean_loss
        if actual_count and mean_loss
        else math.nan,
        "max_h": max_h,
        "losses": losses,
        "landings": landings,
    }


def parse_args() -> argparse.Namespace:
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("--q", default="24,48,72,96,120")
    p.add_argument("--samples", type=int, default=50000)
    p.add_argument("--density-samples", type=int, default=None)
    p.add_argument("--source-gap", type=int, default=4)
    p.add_argument("--timeout-gap", type=int, default=4)
    p.add_argument("--seed", type=int, default=20260812)
    return p.parse_args()


def main() -> None:
    args = parse_args()
    density_samples = args.density_samples or args.samples
    print("status=EMPIRICAL finite_scope=sampled_large_rank_timeout_target")
    print(
        "q samples density_samples target_density target_se landed_bad_share "
        "landed_se mass_enrichment mean_loss conditional_loss "
        "loss_enrichment weighted_enrichment hash_mass_enrichment "
        "hash_loss_enrichment hash_weighted_enrichment aligned_loss_enrichment max_h"
    )
    for q in (int(x) for x in args.q.split(",") if x):
        target = sample_uniform_target(
            q, args.timeout_gap, density_samples, args.seed + 17 * q
        )
        law = source_law(
            q,
            args.source_gap,
            args.timeout_gap,
            args.samples,
            args.seed + 31 * q,
        )
        d = target.p
        actual_share = float(law["actual_share"])
        mass_enrichment = actual_share / d if d else math.nan
        loss_enrichment = float(law["conditional_loss_enrichment"])
        weighted = mass_enrichment * loss_enrichment

        losses = list(law["losses"])
        landings = list(law["landings"])
        hash_mask = [hash_bad(y, d) for y in landings]
        hash_count = sum(hash_mask)
        hash_share = hash_count / args.samples
        hash_mass = hash_share / d if d else math.nan
        hash_cond_loss = (
            sum(loss for loss, flag in zip(losses, hash_mask) if flag) / hash_count
            if hash_count
            else math.nan
        )
        hash_loss = hash_cond_loss / float(law["mean_loss"]) if hash_count else math.nan

        top_count = max(1, int(round(d * args.samples)))
        top_losses = sorted(losses)[-top_count:]
        aligned_loss = (sum(top_losses) / top_count) / float(law["mean_loss"])

        print(
            f"{q} {args.samples} {density_samples} {d:.12g} {target.se:.4g} "
            f"{actual_share:.12g} {float(law['actual_se']):.4g} "
            f"{mass_enrichment:.8g} {float(law['mean_loss']):.10g} "
            f"{float(law['conditional_loss']):.10g} {loss_enrichment:.8g} "
            f"{weighted:.8g} {hash_mass:.8g} {hash_loss:.8g} "
            f"{(hash_mass * hash_loss):.8g} {aligned_loss:.8g} {law['max_h']}"
        )
    print("audit=PASS")


if __name__ == "__main__":
    main()
