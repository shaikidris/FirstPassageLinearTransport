#!/usr/bin/env python3
"""Deterministic paper/Lean semantic-drift gate for the referee artifact.

This is deliberately not a theorem prover. It guards fragile literal
contracts that a successful Lean build cannot see: copied constants, rank
offsets, strict endpoints, paper/formal status language, and reference
resolution. The accompanying concordance records the human semantic audit.
"""

from __future__ import annotations

import re
import sys
from dataclasses import dataclass
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
PAPER = ROOT / "paper" / "collatz_first_passage_natural_density.md"
FORMALIZATION = ROOT / "lean" / "FORMALIZATION.md"
PROOF_STATE = ROOT / "proof-state.md"
LEAN_ROOT = ROOT / "lean" / "FirstPassageLinearTransport"
RENDER_SCRIPT = ROOT / "paper" / "render_first_passage_v3_manuscript.sh"


def compact(text: str) -> str:
    """Remove whitespace only; punctuation and mathematical tokens remain."""

    return re.sub(r"\s+", "", text)


@dataclass(frozen=True)
class LiteralCheck:
    name: str
    path: Path
    required: str


def read(path: Path) -> str:
    try:
        return path.read_text(encoding="utf-8")
    except OSError as exc:
        raise RuntimeError(f"cannot read {path.relative_to(ROOT)}: {exc}") from exc


def declaration_present(name: str, lean_text: str) -> bool:
    leaf = re.escape(name.rsplit(".", 1)[-1])
    pattern = (
        rf"\b(?:def|abbrev|structure|inductive|theorem|lemma)\s+"
        rf"(?:[A-Za-z0-9_']+\.)*{leaf}\b"
    )
    return re.search(pattern, lean_text) is not None


def main() -> int:
    failures: list[str] = []
    paper = read(PAPER)
    lean_files = sorted(LEAN_ROOT.glob("*.lean"))
    lean_text = "\n".join(read(path) for path in lean_files)

    checks = [
        LiteralCheck(
            "paper one-block duration corridor uses +2",
            PAPER,
            r"\left|gh-(m-q)\right|\le tm+t+2.",
        ),
        LiteralCheck(
            "paper cumulative corridor pays the rank offset with +3",
            PAPER,
            r"\sum_{i=0}^{j}(t_i m_i+t_i+3).",
        ),
        LiteralCheck(
            "paper timeout event is totalized at the parent rank",
            PAPER,
            r"T^j(x)>2^{q_L(m)}"
            r"\quad\text{for every }0\le j\le m.",
        ),
        LiteralCheck(
            "paper timeout threshold retains the endpoint-scale perturbation",
            PAPER,
            r"r_L=1-\frac{K_0}{2L},"
            r"\qquad"
            r"q_L(m)=\lfloor r_Lm\rfloor.",
        ),
        LiteralCheck(
            "paper low successful durations have a uniform total budget",
            PAPER,
            r"\sum_{\text{successful low stages}}h_i\le S(S+1).",
        ),
        LiteralCheck(
            "paper certified landing is in shell q-1",
            PAPER,
            r"m_{i+1}=q_i-1\qquad(0\le i<j)",
        ),
        LiteralCheck(
            "paper switch endpoint is discharged deterministically",
            PAPER,
            r"If the landing is the upper endpoint \(2^{q_i}\) and \(q_i\le S\), follow its"
            r"deterministic halving orbit to the terminal rank and stop successfully",
        ),
        LiteralCheck(
            "paper timeout support scale",
            PAPER,
            r"\#\mathcal H^{\rm to}_{M,p}"
            r"\ll\sqrt{(M+2)\log(M+2)}.",
        ),
        LiteralCheck(
            "paper critical exponent",
            PAPER,
            r"A_{\rm FP}=\frac1{2(1-H_2(p_*))}",
        ),
        LiteralCheck(
            "paper moving rank buffer",
            PAPER,
            r"\kappa_*L_M-\frac12\log_2(M+2)-\log_2\log(M+3)",
        ),
        LiteralCheck(
            "paper timeout target uses the actual parent shell p-1",
            PAPER,
            r"\operatorname{To}_{L,p-1}(y)",
        ),
        LiteralCheck(
            "paper direct reverse-loss bound at a timeout target",
            PAPER,
            r"E_{2^p}(n)<\frac{p+2}{r_*}.",
        ),
        LiteralCheck(
            "paper timeout target is normalized by the full threshold band",
            PAPER,
            r"\frac{|\mathcal C^{\rm to}_{L,p}|}{2^p}"
            r"\ll p^{-1/2}2^{-\kappa_*p}.",
        ),
        LiteralCheck(
            "paper timeout profile retains the square-root time support",
            PAPER,
            r"\sqrt{M\log M}\,"
            r"L_M^{1/2}2^{-\kappa_*L_M}"
            r"+M^{-\varepsilon}.",
        ),
        LiteralCheck(
            "paper moving shell theorem uses the exact critical buffer",
            PAPER,
            r"C_{\rm exc}\left(2^{-\Delta_M}+M^{-\varepsilon}\right)",
        ),
        LiteralCheck(
            "paper excludes the stretched-log endpoint",
            PAPER,
            r"The endpoint \(\delta=1\) is not asserted.",
        ),
        LiteralCheck(
            "paper fixed-power count keeps a strict rate endpoint",
            PAPER,
            r"for every fixed \(0<\sigma<1\).",
        ),
        LiteralCheck(
            "paper graded clock coefficient",
            PAPER,
            r"\frac{2(1-\alpha)}{\log(4/3)}+\varepsilon",
        ),
        LiteralCheck(
            "paper shortcut clock endpoint is strict",
            PAPER,
            r"For every fixed \(c>c_*\) and \(\beta>0\)",
        ),
        LiteralCheck(
            "formal map records moving profile socket",
            FORMALIZATION,
            "first-bad transport/profile adapter",
        ),
        LiteralCheck(
            "formal map records the public moving theorem",
            FORMALIZATION,
            "collatz_first_passage_moving_polylogarithmic_natural_density_descent",
        ),
        LiteralCheck(
            "formal map records timeout proof route as primary",
            FORMALIZATION,
            "The timeout proof route is separately formalized and is the primary V3.2",
        ),
        LiteralCheck(
            "formal map records the public timeout theorem",
            FORMALIZATION,
            "collatz_first_passage_timeout_moving_polylogarithmic_natural_density_descent",
        ),
        LiteralCheck(
            "proof state records quantitative moving startup as formal",
            PROOF_STATE,
            "uniform moving-stage startup with `pLo.M0 <= L`:"
            " `PROVED-FORMAL`",
        ),
        LiteralCheck(
            "proof state records the moving endpoint assembly as formal",
            PROOF_STATE,
            "moving `Delta_M` shell-density/same-witness producer and public moving endpoint:"
            " `PROVED-FORMAL`",
        ),
        LiteralCheck(
            "proof state records timeout route as manuscript-mapped formal proof",
            PROOF_STATE,
            "timeout proof route as the manuscript-mapped Lean derivation:"
            " `PROVED-FORMAL`",
        ),
    ]

    compact_cache: dict[Path, str] = {}
    for check in checks:
        if check.path not in compact_cache:
            compact_cache[check.path] = compact(read(check.path))
        if compact(check.required) not in compact_cache[check.path]:
            failures.append(
                f"missing literal contract [{check.name}] in "
                f"{check.path.relative_to(ROOT)}"
            )

    lean_literal_checks = [
        (
            "Lean accumulated duration error uses +3",
            "def durationError (t : ℝ) (m : ℕ) : ℝ :="
            " t * (m : ℝ) + t + 3",
        ),
        (
            "Lean moving low step cost is S+4",
            "def movingLowStepCost (S : ℕ) : ℝ := (S : ℝ) + 4",
        ),
        (
            "Lean high potential stores the low reserve",
            "movingLowStepCost S * (S : ℝ)",
        ),
        (
            "Lean low potential is linear in the current rank",
            "movingLowStepCost S * (q : ℝ)",
        ),
        (
            "Lean moving target uses q-1 in both the test and tolerance",
            "if S ≤ q - 1 then shrinkingHighTolerance P M (q - 1) else tLo",
        ),
        (
            "Lean rankwise target density is normalized by 2^q",
            "((landingBad q (movingTargetTolerance P tLo M S q)).card : ℝ) /"
            " (2 : ℝ) ^ q ≤ d",
        ),
        (
            "Lean rankwise first-bad density keeps the linear rank multiplier",
            "H * (1 + 6 / (rStar : ℝ)) * ((q + 1 : ℕ) : ℝ) * d",
        ),
        (
            "Lean moving rank buffer subtracts square-root support and log-log terms",
            "firstPassageEntropyGap * movingTerminalRank A M -"
            " (1 / 2) * Real.logb 2 ((M : ℝ) + 2) -"
            " Real.logb 2 (Real.log ((M : ℝ) + 3))",
        ),
        (
            "Lean fixed-polylog headline keeps both strict constants",
            "(hA : 1 / (2 * (1 - binaryEntropyBaseTwo logThreeTwo)) < A)"
            " (hc : 2 / Real.log (4 / 3) < c)",
        ),
        (
            "Lean stretched exceptional exponent is strictly below the endpoint",
            "(hsigma0 : 0 < sigma) (hsigma : sigma < 1 - delta)",
        ),
        (
            "Lean fixed-power exceptional exponent is strict",
            "(hsigma0 : 0 < sigma) (hsigma1 : sigma < 1)",
        ),
        (
            "Lean graded clock has the paper coefficient and arbitrary slack",
            "(2 * (1 - alpha) / Real.log (4 / 3) + epsilon) *"
            " Real.log n",
        ),
        (
            "Lean public moving endpoint consumes the exact buffer divergence",
            "(hbuffer : Tendsto (movingRankBuffer A) atTop atTop)",
        ),
        (
            "Lean public moving endpoint exposes one same-witness conclusion",
            "collatz_first_passage_moving_polylogarithmic_natural_density_descent",
        ),
        (
            "Lean timeout event uses every time through the parent deadline",
            "def LowStageTimeout (K₀ : ℝ) (L m x : ℕ) : Prop :="
            " ∀ j : Fin (m + 1), 2 ^ timeoutTargetRank K₀ L m < orbit j x",
        ),
        (
            "Lean timeout low potential is current-rank weighted",
            "(S : ℝ) * (q : ℝ)",
        ),
        (
            "Lean timeout high potential carries the square switch reserve",
            "+ (S : ℝ) ^ 2",
        ),
        (
            "Lean timeout target density is normalized by the full landing band",
            "((timeoutLandingBad K₀ L p).card : ℝ) / (2 : ℝ) ^ p ≤",
        ),
        (
            "Lean public timeout endpoint exposes one same-witness conclusion",
            "collatz_first_passage_timeout_moving_polylogarithmic_natural_density_descent",
        ),
    ]
    compact_lean = compact(lean_text)
    for name, required in lean_literal_checks:
        if compact(required) not in compact_lean:
            failures.append(f"missing literal Lean contract [{name}]")

    critical_declarations = [
        "FirstPassageLinearTransport.certified_firstPassage_duration_error",
        "FirstPassageLinearTransport.MovingRecertificationRun.certified_endpoint_shell_eq",
        "FirstPassageLinearTransport.movingTimePotential_step",
        "FirstPassageLinearTransport.MovingRecertificationRun.deviation_add_potential_le",
        "FirstPassageLinearTransport.eventually_movingFeasibleTimes_card_lt_sqrt",
        "FirstPassageLinearTransport.movingFirstBadSourcesAtRank_subset_transport",
        "FirstPassageLinearTransport.movingFirstBadSourcesAtRank_card_le",
        "FirstPassageLinearTransport.movingSeparatedFailureEnvelope_density_terminalProfile",
        "FirstPassageLinearTransport.exists_exact_sharp_critical_low_series_bound",
        "FirstPassageLinearTransport.moving_low_firstBad_sharp_exact_sum_le",
        "FirstPassageLinearTransport.eventually_movingLowStageSetup_M0_le",
        "FirstPassageLinearTransport.exists_eventually_movingEndpointGood_shellError",
        "FirstPassageLinearTransport.eventually_movingEndpointGood_has_shellWitness",
        "FirstPassageLinearTransport.movingEndpointLiteralNaturalDensityDescent",
        "FirstPassageLinearTransport.QuantitativeCollatzMain."
        "collatz_first_passage_moving_polylogarithmic_natural_density_descent",
        "FirstPassageLinearTransport.three_pow_timeoutTargetRank_lt_three_pow_oddCount_succ",
        "FirstPassageLinearTransport.timeoutShellBad_subset_terminalOddUpperShell",
        "FirstPassageLinearTransport.exists_card_timeoutShellBad_endpointRate_le",
        "FirstPassageLinearTransport.TimeoutRecertificationRun.directFirstPassage",
        "FirstPassageLinearTransport.TimeoutRecertificationRun.toCertifiedRankChain",
        "FirstPassageLinearTransport.TimeoutRecertificationRun.scaledReverseLoss_le",
        "FirstPassageLinearTransport.TimeoutRecertificationRun.deviation_add_potential_le",
        "FirstPassageLinearTransport.eventually_timeoutFeasibleTimes_card_lt_sqrt",
        "FirstPassageLinearTransport.timeoutFirstBadSourcesAtRank_subset_transport",
        "FirstPassageLinearTransport.timeoutFirstBadSourcesAtRank_card_le",
        "FirstPassageLinearTransport.timeout_low_firstBad_sharp_sum_canonical_le",
        "FirstPassageLinearTransport.timeoutSeparatedFailureEnvelope_density_sharp_le",
        "FirstPassageLinearTransport.timeoutSource_terminal_or_failure",
        "FirstPassageLinearTransport.eventually_timeoutEndpointGood_has_shellWitness",
        "FirstPassageLinearTransport.timeoutEndpointLiteralNaturalDensityDescent",
        "FirstPassageLinearTransport.QuantitativeCollatzMain."
        "collatz_first_passage_timeout_moving_polylogarithmic_natural_density_descent",
        "FirstPassageLinearTransport.QuantitativeCollatzMain."
        "collatz_first_passage_fixed_polylogarithmic_natural_density_descent",
        "FirstPassageLinearTransport.QuantitativeCollatzMain."
        "collatz_first_passage_quantitative_stretched_exceptional_count",
        "FirstPassageLinearTransport.QuantitativeCollatzMain."
        "collatz_first_passage_raw_stretched_log_natural_density_descent",
        "FirstPassageLinearTransport.QuantitativeCollatzMain."
        "collatz_first_passage_graded_power_natural_density_descent",
    ]
    for declaration in critical_declarations:
        if not declaration_present(declaration, lean_text):
            failures.append(f"mapped Lean declaration is absent: {declaration}")

    exact_profile = re.search(
        r"\btheorem\s+moving_low_firstBad_sharp_exact_sum_le\b(.*?):=\s*by",
        lean_text,
        flags=re.DOTALL,
    )
    if exact_profile is None:
        failures.append("exact-rate sharp moving profile signature is absent")
    else:
        signature = compact(exact_profile.group(1))
        if "b'" in signature or "hbb'" in signature:
            failures.append("exact-rate sharp moving profile still spends b' < b")
        required_exact_tokens = [
            "b₀≤b",
            "Real.sqrtL*Real.exp(-(b*((L-1:ℕ):ℝ)))",
        ]
        for token in required_exact_tokens:
            if compact(token) not in signature:
                failures.append(
                    "exact-rate sharp moving profile lost terminal token: " + token
                )

    forbidden = [
        (
            PAPER,
            r"The one-block corridor error is at most \(tm+t+2\le S+3\)",
            "moving proof must pay the additional rank-offset unit",
        ),
        (
            FORMALIZATION,
            "moving low-phase first-bad transport/profile adapter and its connection",
            "formal boundary predates MovingFirstBad/MovingProfile",
        ),
        (
            PROOF_STATE,
            "moving low-phase first-bad transport/profile adapter is absent",
            "formal boundary predates MovingFirstBad/MovingProfile",
        ),
        (
            PAPER,
            r"V_{\rm lo}(q)=(S+4)q",
            "removed all-prefix low potential returned to the V3.2 manuscript",
        ),
        (
            PAPER,
            r"B^{\rm crit}_{M,q}",
            "removed moving all-prefix target returned to the V3.2 manuscript",
        ),
        (
            FORMALIZATION,
            "The timeout proof route is not yet separately formalized",
            "formal theorem map still marks the completed timeout route as open",
        ),
        (
            PROOF_STATE,
            "timeout proof route as a second Lean derivation: `FORMALIZATION-PENDING`",
            "proof state still marks the completed timeout route as pending",
        ),
        (
            PAPER,
            "has not yet been encoded as a second Lean proof term",
            "manuscript disclosure still marks the completed timeout route as pending",
        ),
    ]
    for path, phrase, reason in forbidden:
        if compact(phrase) in compact(read(path)):
            failures.append(
                f"forbidden stale phrase in {path.relative_to(ROOT)}: {reason}"
            )

    render = read(RENDER_SCRIPT)
    audit_invocations = render.count(
        'python3 -B "$repo_dir/audits/audit_paper_lean_semantics.py"'
    )
    if audit_invocations != 1:
        failures.append(
            "render gate must invoke the semantic audit exactly once; "
            f"found {audit_invocations}"
        )

    labels = re.findall(r"\\label\{([^}]+)\}", paper)
    references = re.findall(r"\\(?:eqref|ref|autoref)\{([^}]+)\}", paper)
    tagged_labels = re.findall(
        r"\\tag\{([A-Za-z0-9]+)\.([0-9]+[a-z]?)\}"
        r"\\label\{(eq:[A-Za-z0-9]+-[0-9]+[a-z]?)\}",
        paper,
    )
    for section, item, label in tagged_labels:
        expected = f"eq:{section.lower()}-{item}"
        if label != expected:
            failures.append(
                f"display tag/label mismatch: {section}.{item} uses {label}, "
                f"expected {expected}"
            )
    duplicate_labels = sorted({label for label in labels if labels.count(label) > 1})
    missing_labels = sorted(set(references) - set(labels))
    if duplicate_labels:
        failures.append(f"duplicate equation labels: {', '.join(duplicate_labels)}")
    if missing_labels:
        failures.append(f"unresolved equation references: {', '.join(missing_labels)}")

    anchors = re.findall(r"\{#([A-Za-z0-9_.:-]+)\}", paper)
    anchors += re.findall(r"<span\s+id=[\"']([^\"']+)[\"']", paper)
    anchor_references = re.findall(r"\]\(#([A-Za-z0-9_.:-]+)\)", paper)
    duplicate_anchors = sorted(
        {anchor for anchor in anchors if anchors.count(anchor) > 1}
    )
    missing_anchors = sorted(set(anchor_references) - set(anchors))
    if duplicate_anchors:
        failures.append(f"duplicate manuscript anchors: {', '.join(duplicate_anchors)}")
    if missing_anchors:
        failures.append(f"unresolved manuscript anchors: {', '.join(missing_anchors)}")

    if failures:
        print("paper_lean_semantic_audit=FAIL")
        for failure in failures:
            print(f"FAIL: {failure}")
        return 1

    print("paper_lean_semantic_audit=PASS")
    print(f"literal_contracts={len(checks) + len(lean_literal_checks)}")
    print(f"critical_declarations={len(critical_declarations)}")
    print(f"equation_labels={len(labels)} equation_references={len(references)}")
    print(f"anchors={len(anchors)} anchor_references={len(anchor_references)}")
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except RuntimeError as exc:
        print(f"paper_lean_semantic_audit=ERROR\n{exc}", file=sys.stderr)
        raise SystemExit(2) from exc
