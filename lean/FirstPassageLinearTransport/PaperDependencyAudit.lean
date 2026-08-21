/-
Copyright (c) 2026 Idris Ali Shaik. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Idris Ali Shaik
-/
import FirstPassageLinearTransport.Main
import FirstPassageLinearTransport.PaperCor12Item1
import ImportGraph.RequiredModules
import Lean.DeclarationRange
import Lean.Server.References

/-!
# First-passage manuscript dependency audit

Declaration-level dependency audit for the standalone first-passage
linear-transport manuscript. The V3.2 timeout moving-endpoint headline and its
complete producer/transport/witness chain are included among the public roots;
`TimeoutEndpointAudit` additionally checks those internal cut vertices. The
retained V3.1 all-prefix realization is isolated in
`FirstPassageLinearTransport.Alternates.AllPrefix` and is not imported here.

Imports show what was available during elaboration; axiom reports show the
trusted principles of finished declarations; the kernel graph follows
constants retained in compiled declaration types and proof terms; and the
source graph follows identifier uses retained in Lean's `.ilean` metadata.
These are separate checks.

For every mapped referee-facing root below, this audit reports its source
module and line, kernel and combined source/kernel closures, and transitive
edges between manuscript milestones. It then runs reverse reachability at two
resolutions. The theorem report starts from every theorem exported by `Main`
plus the mapped internal roots. The declaration report separately classifies
every source-authored theorem, definition, opaque declaration, axiom, or
inductive declaration as reachable from the public `Main` surface, reachable
only from an important manuscript cut vertex, reachable only from another
mapped companion root visible in the canonical environment, or outside all
three cones. The optional all-prefix library is audited separately and is not
counted by this canonical declaration pass. This distinction prevents
an imported file from hiding unrelated declarations merely because one theorem
in that file is needed. The ordinary clean build remains a separate
source-reconstruction gate. Optional declarations moved to alternate or
legacy libraries are intentionally absent from this canonical environment.
-/

open Lean Elab Command

private structure PaperRoot where
  paperLabel : String
  decl : Name

private def paperRoots : Array PaperRoot := #[
  ⟨"Theorem 1.1 (canonical timeout moving polylogarithmic endpoint)",
    `FirstPassageLinearTransport.QuantitativeCollatzMain.collatz_first_passage_moving_polylogarithmic_natural_density_descent⟩,
  ⟨"Theorem 1.1 (explicit timeout compatibility name)",
    `FirstPassageLinearTransport.QuantitativeCollatzMain.collatz_first_passage_timeout_moving_polylogarithmic_natural_density_descent⟩,
  ⟨"Theorem 1.1 (literal timeout natural-density assembly)",
    `FirstPassageLinearTransport.timeoutEndpointLiteralNaturalDensityDescent⟩,
  ⟨"Theorem 1.1 (timeout shell-error producer)",
    `FirstPassageLinearTransport.exists_eventually_timeoutEndpointGood_shellError⟩,
  ⟨"Theorem 1.1 (timeout same-witness execution)",
    `FirstPassageLinearTransport.eventually_timeoutEndpointGood_has_shellWitness⟩,
  ⟨"Lemma 6.3 (literal parent-rank timeout event)",
    `FirstPassageLinearTransport.LowStageTimeout⟩,
  ⟨"Lemma 6.3 (timeout implies terminal odd-count excess)",
    `FirstPassageLinearTransport.three_pow_timeoutTargetRank_lt_three_pow_oddCount_succ⟩,
  ⟨"Lemma 6.3 (timeout target lies in terminal binomial tail)",
    `FirstPassageLinearTransport.timeoutShellBad_subset_terminalOddUpperShell⟩,
  ⟨"Lemma 6.3 (sharp timeout endpoint-rate density)",
    `FirstPassageLinearTransport.exists_card_timeoutShellBad_endpointRate_le⟩,
  ⟨"Lemma 6.3 (timeout nested direct first passage)",
    `FirstPassageLinearTransport.TimeoutRecertificationRun.directFirstPassage⟩,
  ⟨"Lemma 6.3 (timeout run-to-rank-chain adapter)",
    `FirstPassageLinearTransport.TimeoutRecertificationRun.toCertifiedRankChain⟩,
  ⟨"Lemma 6.3 (timeout rank-scaled reverse loss)",
    `FirstPassageLinearTransport.TimeoutRecertificationRun.scaledReverseLoss_le⟩,
  ⟨"Lemma 6.3 (timeout cumulative corridor)",
    `FirstPassageLinearTransport.TimeoutRecertificationRun.deviation_add_potential_le⟩,
  ⟨"Lemma 6.3 (timeout square-root feasible-time support)",
    `FirstPassageLinearTransport.eventually_timeoutFeasibleTimes_card_lt_sqrt⟩,
  ⟨"Proposition 6.4 (timeout first-bad transport)",
    `FirstPassageLinearTransport.timeoutFirstBadSourcesAtRank_subset_transport⟩,
  ⟨"Proposition 6.4 (timeout first-bad count)",
    `FirstPassageLinearTransport.timeoutFirstBadSourcesAtRank_card_le⟩,
  ⟨"Proposition 6.4 (sharp timeout rank sum)",
    `FirstPassageLinearTransport.timeout_low_firstBad_sharp_sum_canonical_le⟩,
  ⟨"Proposition 6.4 (timeout separated shell profile)",
    `FirstPassageLinearTransport.timeoutSeparatedFailureEnvelope_density_sharp_le⟩,
  ⟨"Proposition 6.4 (timeout run totalization)",
    `FirstPassageLinearTransport.timeoutSource_terminal_or_failure⟩,
  ⟨"Theorem 1.1 (timeout same-witness orbit ceiling)",
    `FirstPassageLinearTransport.TimeoutRecertificationRun.orbit_le_start_power⟩,
  ⟨"Theorem 1.1 (timeout logarithmic clock)",
    `FirstPassageLinearTransport.eventually_timeoutRun_elapsed_add_switch_lt_shellClock⟩,
  ⟨"Corollary 1.2(1) (fixed-polylogarithmic descent)",
    `FirstPassageLinearTransport.QuantitativeCollatzMain.collatz_first_passage_fixed_polylogarithmic_natural_density_descent⟩,
  ⟨"Corollary 1.2(1) (exact exceptional-rate range)",
    `FirstPassageLinearTransport.paper_cor12_item1_fixed_polylog⟩,
  ⟨"Corollary 1.2(1) (endpoint exponent identity)",
    `FirstPassageLinearTransport.timeSupportCriticalExponent_eq_entropy⟩,
  ⟨"Corollary 1.2(1) (clock identity)",
    `FirstPassageLinearTransport.fixedPolylogClockCritical_eq_paper⟩,
  ⟨"Corollary 1.2(1) (strict parameter selection)",
    `FirstPassageLinearTransport.exists_shrinkingPolylogParameterPackage⟩,
  ⟨"Corollary 1.2(1) (literal terminal witness)",
    `FirstPassageLinearTransport.shrinkingSource_lands_below_horizon⟩,
  ⟨"Corollary 1.2(1) (same-witness orbit ceiling)",
    `FirstPassageLinearTransport.eventually_shrinkingPolylogGood_has_shellLanding_with_orbitCeiling⟩,
  ⟨"Corollary 1.2(1) (assembled quantitative theorem)",
    `FirstPassageLinearTransport.shrinkingFixedPolylogNaturalDensityDescent⟩,
  ⟨"Corollary 1.2(1) (support-sensitive time transport)",
    `FirstPassageLinearTransport.lossFiltered_arbitraryTarget_transport_atTimes_uniform⟩,
  ⟨"Corollary 1.2(1) (square-root feasible-time support)",
    `FirstPassageLinearTransport.shrinkingFeasibleTimes_card_lt_sqrt⟩,
  ⟨"Corollary 1.2(1) (support-sensitive first-bad profile)",
    `FirstPassageLinearTransport.eventually_shrinkingFailureEnvelope_density_polylog_le⟩,
  ⟨"Lemma 2.1 (varying dyadic summation)",
    `FirstPassageLinearTransport.naturalDensityOne_assembleDyadic⟩,
  ⟨"Lemma 2.1 (quantitative stretched dyadic summation)",
    `FirstPassageLinearTransport.QuantitativeDensity.badCount_assembleDyadic_le_stretched_log⟩,
  ⟨"Proposition 2.2 (parity-vector bijection)",
    `FirstPassageLinearTransport.parityCode_bijective⟩,
  ⟨"Proposition 2.3 (exact affine iterate)",
    `FirstPassageLinearTransport.exact_affine_iterate⟩,
  ⟨"Lemma 3.1 (maximal Boolean barrier)",
    `FirstPassageLinearTransport.barrierHitCount_le_exp⟩,
  ⟨"Lemma 3.1 (shell barrier count)",
    `FirstPassageLinearTransport.card_shellMaximalParityBad_le⟩,
  ⟨"Lemma 3.2 (uniform affine correction)",
    `FirstPassageLinearTransport.orbit_envelope_of_maximalBarrier⟩,
  ⟨"Proposition 3.3 (dense initial window)",
    `FirstPassageLinearTransport.initialWindowGood_powerDense⟩,
  ⟨"Proposition 3.3 (dense barrier set)",
    `FirstPassageLinearTransport.extendedWindow_powerDense⟩,
  ⟨"Lemma 4.1 (first-passage band)",
    `FirstPassageLinearTransport.firstPassage_band⟩,
  ⟨"Lemma 4.1 (reverse product)",
    `FirstPassageLinearTransport.reverse_product_identity⟩,
  ⟨"Lemma 4.1 (reverse bounds)",
    `FirstPassageLinearTransport.firstPassage_reverse_bounds⟩,
  ⟨"Lemma 4.2 (loss-filtered odd-count rigidity)",
    `FirstPassageLinearTransport.lossFiltered_oddCount_rigidity⟩,
  ⟨"Lemma 4.2 (loss-filtered tagged-fiber bound)",
    `FirstPassageLinearTransport.lossFilteredTaggedFiber_bound⟩,
  ⟨"Proposition 4.3 (loss-filtered target transport)",
    `FirstPassageLinearTransport.lossFiltered_arbitraryTarget_transport⟩,
  ⟨"Proposition 4.3 (restricted loss-filtered transport)",
    `FirstPassageLinearTransport.lossFiltered_arbitraryTarget_transport_restricted⟩,
  ⟨"Lemma 5.1 (nested direct first passage)",
    `FirstPassageLinearTransport.CertifiedRankChain.directFirstPassage⟩,
  ⟨"Lemma 5.1 (literal run-to-chain realization)",
    `FirstPassageLinearTransport.RecertificationRun.toCertifiedRankChain⟩,
  ⟨"Lemma 5.2 (exact loss concatenation)",
    `FirstPassageLinearTransport.scaledReverseLoss_add_rescaled⟩,
  ⟨"Lemma 5.2 (rank-scaled reverse loss)",
    `FirstPassageLinearTransport.CertifiedRankChain.scaledReverseLoss_le⟩,
  ⟨"Theorem 5.3 (first-bad terminal profile)",
    `FirstPassageLinearTransport.generatedFirstBadSources_density_terminalProfile⟩,
  ⟨"Theorem 5.3 (literal first-bad realization)",
    `FirstPassageLinearTransport.RecertificationRun.toGeneratedFirstBadLanding⟩,
  ⟨"Formal alternate (literal shrinking re-certification run)",
    `FirstPassageLinearTransport.ShrinkingRecertificationRun⟩,
  ⟨"Formal alternate (landing-selected target tolerance)",
    `FirstPassageLinearTransport.shrinkingTargetTolerance⟩,
  ⟨"Formal alternate (separated first-bad envelope)",
    `FirstPassageLinearTransport.shrinkingSeparatedFailureEnvelope⟩,
  ⟨"Formal alternate (all-prefix duration corridor)",
    `FirstPassageLinearTransport.certified_firstPassage_duration_corridor⟩,
  ⟨"Formal alternate (deterministic certified landing shell)",
    `FirstPassageLinearTransport.ShrinkingRecertificationRun.certified_endpoint_shell_eq⟩,
  ⟨"Formal alternate (cumulative telescoping corridor)",
    `FirstPassageLinearTransport.ShrinkingRecertificationRun.deviation_add_potential_le⟩,
  ⟨"Formal alternate (shrinking square-root feasible-time support)",
    `FirstPassageLinearTransport.shrinkingFeasibleTimes_card_lt_sqrt⟩,
  ⟨"Proposition 6.2 / shared high route (inactive tolerance cap)",
    `FirstPassageLinearTransport.shrinkingHighTolerance_eq_formula⟩,
  ⟨"Proposition 6.2 / shared high route (quadratic exponent)",
    `FirstPassageLinearTransport.shrinkingHighTolerance_sq_mul⟩,
  ⟨"Proposition 6.2 / shared high route (initial density)",
    `FirstPassageLinearTransport.card_shellInitialWindowBad_shrinking_le⟩,
  ⟨"Proposition 6.2 / shared high route (landing density)",
    `FirstPassageLinearTransport.card_landingBad_shrinking_high_density_le⟩,
  ⟨"Formal alternate (support-sensitive terminal profile)",
    `FirstPassageLinearTransport.shrinkingSeparatedFailureEnvelope_density_terminalProfile⟩,
  ⟨"Formal alternate (polylogarithmic shell profile)",
    `FirstPassageLinearTransport.eventually_shrinkingFailureEnvelope_density_polylog_le⟩,
  ⟨"Compatible stage-parameter selection",
    `FirstPassageLinearTransport.exists_stageSetup⟩,
  ⟨"Height-sensitive first-passage clock",
    `FirstPassageLinearTransport.stageLength_le_heightSensitiveHorizon⟩,
  ⟨"Raw orbit time conversion",
    `FirstPassageLinearTransport.rawOrbit_rawTime_eq_orbit⟩,
  ⟨"Raw stopped-bootstrap clock",
    `FirstPassageLinearTransport.eventuallyShellRawClockLt⟩,
  ⟨"Internal raw-clock assembly",
    `FirstPassageLinearTransport.firstPassageLinearTransportRawMain⟩,
  ⟨"All-prefix stopped-bootstrap envelope",
    `FirstPassageLinearTransport.orbit_le_stageClock_ceiling⟩,
  ⟨"Scheduled intermediate-orbit ceiling",
    `FirstPassageLinearTransport.eventuallyShellOrbitCeiling⟩,
  ⟨"Internal orbit-ceiling assembly",
    `FirstPassageLinearTransport.firstPassageLinearTransportOrbitCeiling⟩,
  ⟨"Internal quantitative stretched count",
    `FirstPassageLinearTransport.firstPassageLinearTransportQuantitativeStretched⟩,
  ⟨"Internal quantitative fixed-power count",
    `FirstPassageLinearTransport.firstPassageLinearTransportQuantitativeFixedPower⟩,
  ⟨"Companion stretched-log theorem (timed)",
    `FirstPassageLinearTransport.QuantitativeCollatzMain.collatz_first_passage_stretched_log_natural_density_descent⟩,
  ⟨"Companion stretched-log theorem (unclocked)",
    `FirstPassageLinearTransport.QuantitativeCollatzMain.collatz_first_passage_stretched_log_natural_density_descent_unclocked⟩,
  ⟨"Corollary 1.5, timed fixed-power descent",
    `FirstPassageLinearTransport.QuantitativeCollatzMain.collatz_first_passage_fixed_power_natural_density_descent⟩,
  ⟨"Companion strict stretched-log exceptional count",
    `FirstPassageLinearTransport.QuantitativeCollatzMain.collatz_first_passage_quantitative_stretched_exceptional_count⟩,
  ⟨"Companion raw stretched-log 10.44 clock",
    `FirstPassageLinearTransport.QuantitativeCollatzMain.collatz_first_passage_raw_stretched_log_natural_density_descent⟩,
  ⟨"Companion stretched-log shortcut orbit ceiling",
    `FirstPassageLinearTransport.QuantitativeCollatzMain.collatz_first_passage_stretched_log_descent_with_orbit_ceiling⟩,
  ⟨"Corollary 1.5 (quantitative fixed-power count)",
    `FirstPassageLinearTransport.QuantitativeCollatzMain.collatz_first_passage_quantitative_fixed_power_exceptional_count⟩,
  ⟨"Corollary 1.5 (literal T_min adapter)",
    `FirstPassageLinearTransport.orbitMinimum_le_power_iff_hasFixedPowerDescent⟩,
  ⟨"Corollary 1.5 (fixed-depth density pullback)",
    `FirstPassageLinearTransport.bootstrapSet_powerDense⟩,
  ⟨"Corollary 1.5 (graded height clock)",
    `FirstPassageLinearTransport.stageClock_le_heightClock⟩,
  ⟨"Corollary 1.5 (graded parameter selection)",
    `FirstPassageLinearTransport.exists_gradedClockParameters⟩,
  ⟨"Corollary 1.5 (internal graded theorem)",
    `FirstPassageLinearTransport.firstPassageLinearTransportGradedPower⟩,
  ⟨"Corollary 1.5 (public graded theorem)",
    `FirstPassageLinearTransport.QuantitativeCollatzMain.collatz_first_passage_graded_power_natural_density_descent⟩
]

private def isProjectDecl (n : Name) : Bool :=
  `FirstPassageLinearTransport |>.isPrefixOf n

private def isProjectModule (n : Name) : Bool :=
  `FirstPassageLinearTransport |>.isPrefixOf n

private def mainModule : Name :=
  `FirstPassageLinearTransport.Main

private def expectedMainTheorems : NameSet :=
  [
    `FirstPassageLinearTransport.QuantitativeCollatzMain.collatz_first_passage_moving_polylogarithmic_natural_density_descent,
    `FirstPassageLinearTransport.QuantitativeCollatzMain.collatz_first_passage_timeout_moving_polylogarithmic_natural_density_descent,
    `FirstPassageLinearTransport.QuantitativeCollatzMain.collatz_first_passage_fixed_polylogarithmic_natural_density_descent,
    `FirstPassageLinearTransport.QuantitativeCollatzMain.collatz_first_passage_stretched_log_natural_density_descent,
    `FirstPassageLinearTransport.QuantitativeCollatzMain.collatz_first_passage_stretched_log_natural_density_descent_unclocked,
    `FirstPassageLinearTransport.QuantitativeCollatzMain.collatz_first_passage_fixed_power_natural_density_descent,
    `FirstPassageLinearTransport.QuantitativeCollatzMain.collatz_first_passage_quantitative_stretched_exceptional_count,
    `FirstPassageLinearTransport.QuantitativeCollatzMain.collatz_first_passage_raw_stretched_log_natural_density_descent,
    `FirstPassageLinearTransport.QuantitativeCollatzMain.collatz_first_passage_stretched_log_descent_with_orbit_ceiling,
    `FirstPassageLinearTransport.QuantitativeCollatzMain.collatz_first_passage_quantitative_fixed_power_exceptional_count,
    `FirstPassageLinearTransport.QuantitativeCollatzMain.collatz_first_passage_graded_power_natural_density_descent
  ].foldl (init := {}) fun names theoremName => names.insert theoremName

private def declarationLine (decl : Name) : CommandElabM Nat := do
  match ← findDeclarationRanges? decl with
  | some ranges => pure ranges.range.pos.line
  | none => pure 0

/-- Exact source span retained by Lean for a declaration.  The external
partition harness consumes this field; unlike a textual declaration regex it
also handles attributes, equations, structures, and multi-line commands. -/
private def declarationRangeText (decl : Name) : CommandElabM String := do
  match ← findDeclarationRanges? decl with
  | some ranges =>
      let start := ranges.range.pos
      let stop := ranges.range.endPos
      pure s!"{start.line}:{start.column}-{stop.line}:{stop.column}"
  | none => pure "0:0-0:0"

private partial def projectClosureFrom
    (env : Environment) (pending : List Name) (seen : NameSet) : NameSet :=
  match pending with
  | [] => seen
  | current :: rest =>
      if seen.contains current then
        projectClosureFrom env rest seen
      else
        let seen := seen.insert current
        let dependencies := match env.find? current with
          | some info => info.getUsedConstantsAsSet
          | none => {}
        let pending := dependencies.fold (init := rest) fun todo dependency =>
          if isProjectDecl dependency && !seen.contains dependency then
            dependency :: todo
          else
            todo
        projectClosureFrom env pending seen

/-- Project-only kernel closure.  Traversal stops at Mathlib constants because
Mathlib cannot depend back on this package; avoiding the full Mathlib closure
makes the referee dependency gate deterministic and substantially faster. -/
private def projectClosure (root : Name) : CommandElabM NameSet := do
  let env ← getEnv
  let directDependencies := match env.find? root with
    | some info => info.getUsedConstantsAsSet.toList.filter isProjectDecl
    | none => []
  pure <| projectClosureFrom env directDependencies {}

private def sourceReferenceEdges
    (modules : List Name) : CommandElabM (Array (Name × Name)) := do
  let searchPath ← liftIO searchPathRef.get
  let mut edges : Array (Name × Name) := #[]
  for moduleName in modules do
    let some path ← liftIO <| searchPath.findModuleWithExt "ilean" moduleName
      | throwError m!"Missing .ilean metadata for imported project module {moduleName}"
    let ilean ← liftIO <| Server.Ilean.load path
    for (ident, info) in ilean.references.toArray do
      let dependency ← match ident with
        | .const _ identName => pure identName.toName
        | .fvar .. => continue
      if isProjectDecl dependency then
        for usage in info.usages do
          if let some parent := usage.parentDecl? then
            let source := parent.name.toName
            if isProjectDecl source then
              edges := edges.push (source, dependency)
  pure edges

private def sourceReferenceGraph
    (edges : Array (Name × Name)) : NameMap (Array Name) :=
  edges.foldl (init := {}) fun graph edge =>
    let dependencies := (graph.find? edge.1).getD #[]
    graph.insert edge.1 (dependencies.push edge.2)

private partial def combinedClosureFrom
    (env : Environment) (sourceGraph : NameMap (Array Name))
    (roots : List Name) : NameSet :=
  go roots {}
where
  go (pending : List Name) (seen : NameSet) : NameSet :=
    match pending with
    | [] => seen
    | current :: rest =>
        if seen.contains current then
          go rest seen
        else
          let seen := seen.insert current
          let kernelDependencies := match env.find? current with
            | some info => info.getUsedConstantsAsSet
            | none => {}
          let pending := kernelDependencies.fold (init := rest) fun todo dependency =>
            if isProjectDecl dependency && !seen.contains dependency then
              dependency :: todo
            else
              todo
          let sourceDependencies := (sourceGraph.find? current).getD #[]
          let pending := sourceDependencies.foldl (init := pending) fun todo dependency =>
            if !seen.contains dependency then dependency :: todo else todo
          go pending seen

private def combinedClosure
    (env : Environment) (sourceGraph : NameMap (Array Name))
    (root : Name) : NameSet :=
  combinedClosureFrom env sourceGraph [root]

private def projectModulesFor
    (env : Environment) (decls : NameSet) : NameSet :=
  decls.fold (init := {}) fun modules decl =>
    match env.getModuleFor? decl with
    | some moduleName => modules.insert moduleName
    | none => modules

private def theoremDeclarationsIn
    (env : Environment) (modules : NameSet) : Array Name :=
  env.constants.toList.foldl (init := #[]) fun declarations entry =>
    let (decl, info) := entry
    match info with
    | .thmInfo _ =>
        match env.getModuleFor? decl with
        | some moduleName =>
            if isProjectDecl decl && modules.contains moduleName then
              declarations.push decl
            else
              declarations
        | none => declarations
    | _ => declarations

private def theoremDeclarationsInModule
    (env : Environment) (moduleName : Name) : Array Name :=
  theoremDeclarationsIn env (({} : NameSet).insert moduleName)

private def isPrimarySourceDeclaration : ConstantInfo → Bool
  | .axiomInfo _ | .defnInfo _ | .thmInfo _ | .opaqueInfo _ | .inductInfo _ => true
  | .quotInfo _ | .ctorInfo _ | .recInfo _ => false

private partial def finalString? : Name → Option String
  | .anonymous => none
  | .str _ suffix => some suffix
  | .num pre _ => finalString? pre

private def isGeneratedEliminator (decl : Name) : Bool :=
  match finalString? decl with
  | some suffix =>
      suffix == "recOn" || suffix == "casesOn" || suffix == "noConfusion"
  | none => false

private def declarationKind : ConstantInfo → String
  | .axiomInfo _ => "axiom"
  | .defnInfo _ => "definition"
  | .thmInfo _ => "theorem"
  | .opaqueInfo _ => "opaque"
  | .inductInfo _ => "inductive"
  | .quotInfo _ => "quotient"
  | .ctorInfo _ => "constructor"
  | .recInfo _ => "recursor"

private def companionPaperRoot (root : PaperRoot) : Bool :=
  root.paperLabel.startsWith "Formal alternate"

elab "#paper_dependency_audit" : command => do
  let env ← getEnv
  let importedProjectModules := env.header.moduleNames.toList
    |>.filter isProjectModule
    |>.mergeSort Name.lt
  let sourceEdges ← sourceReferenceEdges importedProjectModules
  let sourceGraph := sourceReferenceGraph sourceEdges
  let mut closures : Array (PaperRoot × NameSet × NameSet) := #[]
  let mut unionKernelDecls : NameSet := {}
  let mut unionCombinedDecls : NameSet := {}

  for root in paperRoots do
    discard <| getConstInfo root.decl
    let kernelClosure ← projectClosure root.decl
    let combined := combinedClosure env sourceGraph root.decl
    closures := closures.push (root, kernelClosure, combined)
    unionKernelDecls := kernelClosure.fold (init := unionKernelDecls) fun acc decl =>
      acc.insert decl
    unionCombinedDecls := combined.fold (init := unionCombinedDecls) fun acc decl => acc.insert decl

    let kernelModules := projectModulesFor env kernelClosure
    let combinedModules := projectModulesFor env combined
    let moduleName := (env.getModuleFor? root.decl).getD `unknown
    let line ← declarationLine root.decl
    logInfo m!"PAPER_ROOT\t{root.paperLabel}\t{root.decl}\t{moduleName}:{line}\t\
      KERNEL_DECLS={kernelClosure.size}\tKERNEL_MODULES={kernelModules.size}\t\
      COMBINED_DECLS={combined.size}\tCOMBINED_MODULES={combinedModules.size}"

  /-
  Fail loudly if the referee-facing theorem is ever rewired to the retained
  all-prefix implementation. Import reachability and proof-term reachability
  are checked separately.
  -/
  let canonicalMoving :=
    `FirstPassageLinearTransport.QuantitativeCollatzMain.collatz_first_passage_moving_polylogarithmic_natural_density_descent
  let timeoutAssembly :=
    `FirstPassageLinearTransport.timeoutEndpointLiteralNaturalDensityDescent
  let allPrefixAssembly :=
    `FirstPassageLinearTransport.movingEndpointLiteralNaturalDensityDescent
  let allPrefixShellProducer :=
    `FirstPassageLinearTransport.exists_eventually_movingEndpointGood_shellError
  let allPrefixConditionalProfile :=
    `FirstPassageLinearTransport.movingSeparatedFailureEnvelope_density_sharp_le
  let allPrefixStartup :=
    `FirstPassageLinearTransport.eventually_movingLowStageSetup_M0_le
  let canonicalClosure ← projectClosure canonicalMoving
  unless canonicalClosure.contains timeoutAssembly do
    throwError "Canonical moving theorem no longer depends on the timeout assembly"
  if canonicalClosure.contains allPrefixAssembly then
    throwError "Canonical moving theorem regressed to the all-prefix assembly"
  if canonicalClosure.contains allPrefixShellProducer then
    throwError "Canonical moving theorem regressed to the all-prefix shell producer"
  if canonicalClosure.contains allPrefixConditionalProfile then
    throwError "Canonical moving theorem regressed to the all-prefix conditional profile"
  if canonicalClosure.contains allPrefixStartup then
    throwError "Canonical moving theorem regressed to the all-prefix startup package"
  let alternatePrefix := `FirstPassageLinearTransport.Alternates
  for moduleName in env.header.moduleNames do
    if alternatePrefix.isPrefixOf moduleName then
      throwError m!"Canonical paper target imports optional alternate module {moduleName}"
  logInfo "TIMEOUT_ROUTE_GUARD\tPASS"
  logInfo "MAIN_ALTERNATE_IMPORT_GUARD\tPASS"

  logInfo m!"PAPER_GRAPH_ROOTS\t{paperRoots.size}"
  for (root, _, closure) in closures do
    for dependency in paperRoots do
      if root.decl != dependency.decl && closure.contains dependency.decl then
        logInfo m!"PAPER_COMBINED_TRANSITIVE_EDGE\t{root.paperLabel}\t{dependency.paperLabel}"

  let kernelModules := projectModulesFor env unionKernelDecls
  let combinedModules := projectModulesFor env unionCombinedDecls
  let elaborationOnlyModules := combinedModules.toList
    |>.filter (!kernelModules.contains ·)
    |>.mergeSort Name.lt
  let importOnlyModules := importedProjectModules
    |>.filter (!combinedModules.contains ·)
    |>.mergeSort Name.lt

  logInfo m!"PAPER_KERNEL_PROJECT_DECLARATIONS\t{unionKernelDecls.size}"
  logInfo m!"PAPER_KERNEL_PROJECT_MODULES\t{kernelModules.size}"
  logInfo m!"PAPER_COMBINED_PROJECT_DECLARATIONS\t{unionCombinedDecls.size}"
  logInfo m!"PAPER_COMBINED_PROJECT_MODULES\t{combinedModules.size}"
  logInfo m!"PAPER_GRAPH_IMPORTED_MODULES\t{importedProjectModules.length}"
  logInfo m!"PAPER_SOURCE_REFERENCE_EDGES\t{sourceEdges.size}"
  for moduleName in elaborationOnlyModules do
    logInfo m!"PAPER_ELABORATION_ONLY_MODULE\t{moduleName}"
  for moduleName in importOnlyModules do
    logInfo m!"PAPER_IMPORT_ONLY_MODULE\t{moduleName}"

  /-
  Reverse reachability from every theorem exported by `Main` and every
  mapped internal manuscript milestone. This is intentionally broader than
  either root class alone: terminal public corollaries and manuscript-level
  internal results are roots in their own right and must not be classified as
  unused merely because no other mapped theorem depends on them.
  -/
  let mainModuleTheorems := theoremDeclarationsInModule env mainModule
  let mut mainTheorems : Array Name := #[]
  for theoremName in mainModuleTheorems do
    let line ← declarationLine theoremName
    if line > 0 then
      mainTheorems := mainTheorems.push theoremName
    else
      logInfo m!"MAIN_GENERATED_HELPER\t{theoremName}"
  for theoremName in mainTheorems do
    unless expectedMainTheorems.contains theoremName do
      throwError m!"Unexpected public theorem in Main: {theoremName}"
  for theoremName in expectedMainTheorems.toList do
    unless mainTheorems.contains theoremName do
      throwError m!"Expected public theorem missing from Main: {theoremName}"
  if mainTheorems.size != expectedMainTheorems.size then
    throwError m!"Unexpected public theorem count in Main: got {mainTheorems.size}, expected {expectedMainTheorems.size}"
  logInfo "MAIN_PUBLIC_SURFACE_GUARD\tPASS"
  let publicRootSet := paperRoots.foldl
    (init := mainTheorems.foldl (init := ({} : NameSet)) fun roots root =>
      roots.insert root) fun roots root => roots.insert root.decl
  let publicRootNames := publicRootSet.toList
  let importedModuleSet := importedProjectModules.foldl
    (init := ({} : NameSet)) fun modules moduleName => modules.insert moduleName
  let retainedTheorems := theoremDeclarationsIn env importedModuleSet
  let mainReachableDecls := combinedClosureFrom env sourceGraph publicRootNames

  /-
  The broad theorem report above deliberately protects every mapped root.
  The declaration-level report below is more discriminating: a declaration
  needed by an internal manuscript cut vertex is not described as part of the
  public `Main` proof. Roots labelled as formal alternates in the manuscript
  map are treated as companion roots here; the separately packaged all-prefix
  realization is not imported by this audit.
  -/
  let mainOnlyReachableDecls :=
    combinedClosureFrom env sourceGraph mainTheorems.toList
  let canonicalPaperRootNames := paperRoots.toList
    |>.filter (!companionPaperRoot ·)
    |>.map (·.decl)
  let companionPaperRootNames := paperRoots.toList
    |>.filter companionPaperRoot
    |>.map (·.decl)
  let canonicalPaperReachableDecls :=
    combinedClosureFrom env sourceGraph canonicalPaperRootNames
  let companionPaperReachableDecls :=
    combinedClosureFrom env sourceGraph companionPaperRootNames

  let retainedProjectDeclarations := env.constants.toList.filter fun entry =>
    let (decl, info) := entry
    isProjectDecl decl && isPrimarySourceDeclaration info &&
      !isGeneratedEliminator decl &&
      match env.getModuleFor? decl with
      | some moduleName => importedModuleSet.contains moduleName
      | none => false

  let mut retainedSourceDeclarations : Array (Name × ConstantInfo × Nat) := #[]
  for entry in retainedProjectDeclarations do
    let (decl, info) := entry
    let line ← declarationLine decl
    if line > 0 then
      retainedSourceDeclarations := retainedSourceDeclarations.push (decl, info, line)

  let mut mainSourceDeclarations : Array (Name × ConstantInfo × Nat) := #[]
  let mut paperOnlySourceDeclarations : Array (Name × ConstantInfo × Nat) := #[]
  let mut companionOnlySourceDeclarations : Array (Name × ConstantInfo × Nat) := #[]
  let mut unreachableSourceDeclarations : Array (Name × ConstantInfo × Nat) := #[]
  for entry in retainedSourceDeclarations do
    let (decl, info, line) := entry
    if mainOnlyReachableDecls.contains decl then
      mainSourceDeclarations := mainSourceDeclarations.push (decl, info, line)
    else if canonicalPaperReachableDecls.contains decl then
      paperOnlySourceDeclarations := paperOnlySourceDeclarations.push (decl, info, line)
    else if companionPaperReachableDecls.contains decl then
      companionOnlySourceDeclarations := companionOnlySourceDeclarations.push (decl, info, line)
    else
      unreachableSourceDeclarations := unreachableSourceDeclarations.push (decl, info, line)

  logInfo m!"RETAINED_PRIMARY_PROJECT_DECLARATIONS\t{retainedProjectDeclarations.length}"
  logInfo m!"RETAINED_PRIMARY_SOURCE_DECLARATIONS\t{retainedSourceDeclarations.size}"
  logInfo m!"MAIN_REACHABLE_SOURCE_DECLARATIONS\t{mainSourceDeclarations.size}"
  logInfo m!"PAPER_ONLY_REACHABLE_SOURCE_DECLARATIONS\t{paperOnlySourceDeclarations.size}"
  logInfo m!"COMPANION_ONLY_REACHABLE_SOURCE_DECLARATIONS\t{companionOnlySourceDeclarations.size}"
  logInfo m!"UNREACHABLE_SOURCE_DECLARATIONS\t{unreachableSourceDeclarations.size}"

  for moduleName in importedProjectModules do
    let inModule := retainedSourceDeclarations.filter fun entry =>
      env.getModuleFor? entry.1 == some moduleName
    if !inModule.isEmpty then
      let mainCount := (inModule.filter fun entry =>
        mainOnlyReachableDecls.contains entry.1).size
      let paperCount := (inModule.filter fun entry =>
        !mainOnlyReachableDecls.contains entry.1 &&
          canonicalPaperReachableDecls.contains entry.1).size
      let companionCount := (inModule.filter fun entry =>
        !mainOnlyReachableDecls.contains entry.1 &&
          !canonicalPaperReachableDecls.contains entry.1 &&
          companionPaperReachableDecls.contains entry.1).size
      let unreachableCount := inModule.size - mainCount - paperCount - companionCount
      logInfo m!"DECLARATION_REACHABILITY_MODULE\t{moduleName}\t\
        SOURCE_PRIMARY={inModule.size}\tMAIN={mainCount}\tPAPER_ONLY={paperCount}\t\
        COMPANION_ONLY={companionCount}\tUNREACHABLE={unreachableCount}"

  for entry in mainSourceDeclarations do
    let (decl, info, line) := entry
    let moduleName := (env.getModuleFor? decl).getD `unknown
    let sourceRange ← declarationRangeText decl
    logInfo m!"MAIN_SOURCE_DECLARATION\t{declarationKind info}\t\
      {moduleName}:{line}\t{decl}\tRANGE={sourceRange}"
  for entry in paperOnlySourceDeclarations do
    let (decl, info, line) := entry
    let moduleName := (env.getModuleFor? decl).getD `unknown
    let sourceRange ← declarationRangeText decl
    logInfo m!"PAPER_ONLY_SOURCE_DECLARATION\t{declarationKind info}\t\
      {moduleName}:{line}\t{decl}\tRANGE={sourceRange}"
  for entry in companionOnlySourceDeclarations do
    let (decl, info, line) := entry
    let moduleName := (env.getModuleFor? decl).getD `unknown
    let sourceRange ← declarationRangeText decl
    logInfo m!"COMPANION_ONLY_SOURCE_DECLARATION\t{declarationKind info}\t\
      {moduleName}:{line}\t{decl}\tRANGE={sourceRange}"
  for entry in unreachableSourceDeclarations do
    let (decl, info, line) := entry
    let moduleName := (env.getModuleFor? decl).getD `unknown
    let sourceRange ← declarationRangeText decl
    logInfo m!"UNREACHABLE_SOURCE_DECLARATION\t{declarationKind info}\t\
      {moduleName}:{line}\t{decl}\tRANGE={sourceRange}"

  let unreachableTheorems := retainedTheorems.filter fun theoremName =>
    !mainReachableDecls.contains theoremName
  let mut sourceTheorems : Array Name := #[]
  let mut sourceUnreachableTheorems : Array Name := #[]
  for theoremName in retainedTheorems do
    let line ← declarationLine theoremName
    if line > 0 then
      sourceTheorems := sourceTheorems.push theoremName
      if !mainReachableDecls.contains theoremName then
        sourceUnreachableTheorems := sourceUnreachableTheorems.push theoremName
  logInfo m!"MAIN_FILE_THEOREMS\t{mainTheorems.size}"
  logInfo m!"PUBLIC_TERMINAL_ROOTS\t{publicRootNames.length}"
  logInfo m!"RETAINED_PROJECT_THEOREMS\t{retainedTheorems.size}"
  logInfo m!"RETAINED_SOURCE_THEOREMS\t{sourceTheorems.size}"
  logInfo m!"MAIN_REACHABLE_PROJECT_DECLARATIONS\t{mainReachableDecls.size}"
  logInfo m!"MAIN_UNREACHABLE_PROJECT_THEOREMS\t{unreachableTheorems.size}"
  logInfo m!"MAIN_UNREACHABLE_SOURCE_THEOREMS\t{sourceUnreachableTheorems.size}"

  for moduleName in importedProjectModules do
    let moduleTheorems := theoremDeclarationsInModule env moduleName
    let mut moduleSourceTheorems : Array Name := #[]
    let mut sourceUnreachableInModule : Array Name := #[]
    for theoremName in moduleTheorems do
      let line ← declarationLine theoremName
      if line > 0 then
        moduleSourceTheorems := moduleSourceTheorems.push theoremName
        if !mainReachableDecls.contains theoremName then
          sourceUnreachableInModule := sourceUnreachableInModule.push theoremName
    if !moduleSourceTheorems.isEmpty then
      logInfo m!"MAIN_REACHABILITY_MODULE\t{moduleName}\t\
        SOURCE_THEOREMS={moduleSourceTheorems.size}\t\
        REACHABLE={moduleSourceTheorems.size - sourceUnreachableInModule.size}\t\
        UNREACHABLE={sourceUnreachableInModule.size}"
    for theoremName in sourceUnreachableInModule do
      let line ← declarationLine theoremName
      logInfo m!"MAIN_UNREACHABLE_SOURCE_THEOREM\t{moduleName}:{line}\t{theoremName}"

#paper_dependency_audit
