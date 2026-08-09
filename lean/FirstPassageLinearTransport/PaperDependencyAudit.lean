/-
Copyright (c) 2026 Idris Ali Shaik. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Idris Ali Shaik
-/
import FirstPassageLinearTransport.Main
import ImportGraph.RequiredModules
import Lean.DeclarationRange
import Lean.Server.References

/-!
# First-passage manuscript dependency audit

Declaration-level dependency audit for the standalone first-passage
linear-transport manuscript.

Imports show what was available during elaboration; axiom reports show the
trusted principles of finished declarations; the kernel graph follows
constants retained in compiled declaration types and proof terms; and the
source graph follows identifier uses retained in Lean's `.ilean` metadata.
These are separate checks.

For every mapped referee-facing root below, this audit reports its source
module and line, kernel and combined source/kernel closures, and transitive
edges between manuscript milestones. It then runs reverse reachability from
all theorems exported by `Main` plus the mapped internal roots and reports
every retained source theorem outside that combined closure. The ordinary
clean build remains a separate source-reconstruction gate.
-/

open Lean Elab Command

private structure PaperRoot where
  paperLabel : String
  decl : Name

private def paperRoots : Array PaperRoot := #[
  ⟨"Theorem 1.1 (optimized fixed-polylogarithmic descent)",
    `FirstPassageLinearTransport.QuantitativeCollatzMain.collatz_first_passage_fixed_polylogarithmic_natural_density_descent⟩,
  ⟨"Theorem 1.1 (endpoint exponent identity)",
    `FirstPassageLinearTransport.timeSupportCriticalExponent_eq_entropy⟩,
  ⟨"Theorem 1.1 (clock identity)",
    `FirstPassageLinearTransport.fixedPolylogClockCritical_eq_paper⟩,
  ⟨"Theorem 1.1 (strict parameter selection)",
    `FirstPassageLinearTransport.exists_shrinkingPolylogParameterPackage⟩,
  ⟨"Theorem 1.1 (literal terminal witness)",
    `FirstPassageLinearTransport.shrinkingSource_lands_below_horizon⟩,
  ⟨"Theorem 1.1 (same-witness orbit ceiling)",
    `FirstPassageLinearTransport.eventually_shrinkingPolylogGood_has_shellLanding_with_orbitCeiling⟩,
  ⟨"Theorem 1.1 (assembled quantitative theorem)",
    `FirstPassageLinearTransport.shrinkingFixedPolylogNaturalDensityDescent⟩,
  ⟨"Theorem 1.1 (support-sensitive time transport)",
    `FirstPassageLinearTransport.lossFiltered_arbitraryTarget_transport_atTimes_uniform⟩,
  ⟨"Theorem 1.1 (square-root feasible-time support)",
    `FirstPassageLinearTransport.shrinkingFeasibleTimes_card_lt_sqrt⟩,
  ⟨"Theorem 1.1 (support-sensitive first-bad profile)",
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
  ⟨"Lemma 6.1 (duration corridor)",
    `FirstPassageLinearTransport.certified_firstPassage_duration_corridor⟩,
  ⟨"Lemma 6.1 (square-root feasible-time support)",
    `FirstPassageLinearTransport.shrinkingFeasibleTimes_card_lt_sqrt⟩,
  ⟨"Theorem 6.2 (support-sensitive terminal profile)",
    `FirstPassageLinearTransport.shrinkingSeparatedFailureEnvelope_density_terminalProfile⟩,
  ⟨"Theorem 6.2 (polylogarithmic shell profile)",
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
  ⟨"Corollary 1.4, timed fixed-power descent",
    `FirstPassageLinearTransport.QuantitativeCollatzMain.collatz_first_passage_fixed_power_natural_density_descent⟩,
  ⟨"Companion strict stretched-log exceptional count",
    `FirstPassageLinearTransport.QuantitativeCollatzMain.collatz_first_passage_quantitative_stretched_exceptional_count⟩,
  ⟨"Companion raw stretched-log 10.44 clock",
    `FirstPassageLinearTransport.QuantitativeCollatzMain.collatz_first_passage_raw_stretched_log_natural_density_descent⟩,
  ⟨"Companion stretched-log shortcut orbit ceiling",
    `FirstPassageLinearTransport.QuantitativeCollatzMain.collatz_first_passage_stretched_log_descent_with_orbit_ceiling⟩,
  ⟨"Corollary 1.4 (quantitative fixed-power count)",
    `FirstPassageLinearTransport.QuantitativeCollatzMain.collatz_first_passage_quantitative_fixed_power_exceptional_count⟩,
  ⟨"Corollary 1.4 (fixed-depth density pullback)",
    `FirstPassageLinearTransport.bootstrapSet_powerDense⟩,
  ⟨"Corollary 1.4 (graded height clock)",
    `FirstPassageLinearTransport.stageClock_le_heightClock⟩,
  ⟨"Corollary 1.4 (graded parameter selection)",
    `FirstPassageLinearTransport.exists_gradedClockParameters⟩,
  ⟨"Corollary 1.4 (internal graded theorem)",
    `FirstPassageLinearTransport.firstPassageLinearTransportGradedPower⟩,
  ⟨"Corollary 1.4 (public graded theorem)",
    `FirstPassageLinearTransport.QuantitativeCollatzMain.collatz_first_passage_graded_power_natural_density_descent⟩
]

private def isProjectDecl (n : Name) : Bool :=
  `FirstPassageLinearTransport |>.isPrefixOf n

private def isProjectModule (n : Name) : Bool :=
  `FirstPassageLinearTransport |>.isPrefixOf n

private def mainModule : Name :=
  `FirstPassageLinearTransport.Main

private def declarationLine (decl : Name) : CommandElabM Nat := do
  match ← findDeclarationRanges? decl with
  | some ranges => pure ranges.range.pos.line
  | none => pure 0

private def projectClosure (root : Name) : CommandElabM NameSet := do
  let used ← liftCoreM <| root.transitivelyUsedConstants
  pure <| used.fold (init := {}) fun acc decl =>
    if isProjectDecl decl then acc.insert decl else acc

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

private partial def combinedClosureFrom
    (env : Environment) (sourceEdges : Array (Name × Name))
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
          let pending := sourceEdges.foldl (init := pending) fun todo edge =>
            if edge.1 == current && !seen.contains edge.2 then edge.2 :: todo else todo
          go pending seen

private def combinedClosure
    (env : Environment) (sourceEdges : Array (Name × Name))
    (root : Name) : NameSet :=
  combinedClosureFrom env sourceEdges [root]

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

elab "#paper_dependency_audit" : command => do
  let env ← getEnv
  let importedProjectModules := env.header.moduleNames.toList
    |>.filter isProjectModule
    |>.mergeSort Name.lt
  let sourceEdges ← sourceReferenceEdges importedProjectModules
  let mut closures : Array (PaperRoot × NameSet × NameSet) := #[]
  let mut unionKernelDecls : NameSet := {}
  let mut unionCombinedDecls : NameSet := {}

  for root in paperRoots do
    discard <| getConstInfo root.decl
    let kernelClosure ← projectClosure root.decl
    let combined := combinedClosure env sourceEdges root.decl
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
  let mainTheorems := theoremDeclarationsInModule env mainModule
  let publicRootSet := paperRoots.foldl
    (init := mainTheorems.foldl (init := ({} : NameSet)) fun roots root =>
      roots.insert root) fun roots root => roots.insert root.decl
  let publicRootNames := publicRootSet.toList
  let importedModuleSet := importedProjectModules.foldl
    (init := ({} : NameSet)) fun modules moduleName => modules.insert moduleName
  let retainedTheorems := theoremDeclarationsIn env importedModuleSet
  let mainReachableDecls := combinedClosureFrom env sourceEdges publicRootNames

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
