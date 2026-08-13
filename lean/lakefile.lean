import Lake
open Lake DSL

package FirstPassageLinearTransport where
  leanOptions := #[
    ⟨`autoImplicit, false⟩,
    ⟨`relaxedAutoImplicit, false⟩
  ]

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git" @ "v4.15.0"

@[default_target]
lean_lib FirstPassageLinearTransport where
  moreLeanArgs := #["-DmaxHeartbeats=20000000"]
  /- Keep this list equal to the canonical `Main` import closure plus the
  three audit roots. An omitted dependency makes a clean build fail; an
  alternate module here would make the canonical/alternate split fail. -/
  globs := #[
    .one `FirstPassageLinearTransport.AdjustableBarrierDensity,
    .one `FirstPassageLinearTransport.AdjustableEnvelope,
    .one `FirstPassageLinearTransport.AsymptoticBounds,
    .one `FirstPassageLinearTransport.Barrier,
    .one `FirstPassageLinearTransport.BarrierDensity,
    .one `FirstPassageLinearTransport.Basic,
    .one `FirstPassageLinearTransport.Bootstrap,
    .one `FirstPassageLinearTransport.BootstrapSchedule,
    .one `FirstPassageLinearTransport.ClockBudget,
    .one `FirstPassageLinearTransport.Constants,
    .one `FirstPassageLinearTransport.Density,
    .one `FirstPassageLinearTransport.EntropyBarrier,
    .one `FirstPassageLinearTransport.Envelope,
    .one `FirstPassageLinearTransport.FiniteStartup,
    .one `FirstPassageLinearTransport.FirstBadEnvelope,
    .one `FirstPassageLinearTransport.FirstPassage,
    .one `FirstPassageLinearTransport.FixedPolylogParameters,
    .one `FirstPassageLinearTransport.GlobalAssembly,
    .one `FirstPassageLinearTransport.GradedClock,
    .one `FirstPassageLinearTransport.GradedPowerDescent,
    .one `FirstPassageLinearTransport.HeadlineParameters,
    .one `FirstPassageLinearTransport.HeightSensitiveClock,
    .one `FirstPassageLinearTransport.LossTransport,
    .one `FirstPassageLinearTransport.Main,
    .one `FirstPassageLinearTransport.MovingEndpointAssembly,
    .one `FirstPassageLinearTransport.MovingEndpointAsymptotics,
    .one `FirstPassageLinearTransport.MovingEndpointParameters,
    .one `FirstPassageLinearTransport.MovingEndpointProfile,
    .one `FirstPassageLinearTransport.MovingEndpointScalars,
    .one `FirstPassageLinearTransport.MovingFirstBad,
    .one `FirstPassageLinearTransport.MovingLowDensity,
    .one `FirstPassageLinearTransport.MovingLowParameters,
    .one `FirstPassageLinearTransport.MovingLowSetup,
    .one `FirstPassageLinearTransport.MovingProfile,
    .one `FirstPassageLinearTransport.MovingSharpProfile,
    .one `FirstPassageLinearTransport.MovingSharpTail,
    .one `FirstPassageLinearTransport.MovingTimeSupport,
    .one `FirstPassageLinearTransport.NaturalDensityDescent,
    .one `FirstPassageLinearTransport.NestedRecertification,
    .one `FirstPassageLinearTransport.OrbitCeiling,
    .one `FirstPassageLinearTransport.Parameters,
    .one `FirstPassageLinearTransport.Parity,
    .one `FirstPassageLinearTransport.PolylogExceptionalCount,
    .one `FirstPassageLinearTransport.PolylogTarget,
    .one `FirstPassageLinearTransport.PowerDescent,
    .one `FirstPassageLinearTransport.Pullback,
    .one `FirstPassageLinearTransport.QuantitativeNaturalDensityDescent,
    .one `FirstPassageLinearTransport.RankScaledLoss,
    .one `FirstPassageLinearTransport.RawClockBudget,
    .one `FirstPassageLinearTransport.RawDynamics,
    .one `FirstPassageLinearTransport.RawNaturalDensityDescent,
    .one `FirstPassageLinearTransport.RecertificationRun,
    .one `FirstPassageLinearTransport.RecertificationStep,
    .one `FirstPassageLinearTransport.Scalar,
    .one `FirstPassageLinearTransport.SharpEntropyBarrier,
    .one `FirstPassageLinearTransport.ShrinkingBarrierCore,
    .one `FirstPassageLinearTransport.ShrinkingBarrierRun,
    .one `FirstPassageLinearTransport.ShrinkingExecution,
    .one `FirstPassageLinearTransport.ShrinkingFirstBad,
    .one `FirstPassageLinearTransport.ShrinkingHighDensity,
    .one `FirstPassageLinearTransport.ShrinkingNaturalDensityDescent,
    .one `FirstPassageLinearTransport.ShrinkingOrbitCeiling,
    .one `FirstPassageLinearTransport.ShrinkingParameters,
    .one `FirstPassageLinearTransport.ShrinkingPolylogProfile,
    .one `FirstPassageLinearTransport.ShrinkingProfile,
    .one `FirstPassageLinearTransport.ShrinkingSchedules,
    .one `FirstPassageLinearTransport.ShrinkingTailAsymptotics,
    .one `FirstPassageLinearTransport.ShrinkingTimeSupport,
    .one `FirstPassageLinearTransport.StretchedExceptionalCount,
    .one `FirstPassageLinearTransport.StretchedLogLanding,
    .one `FirstPassageLinearTransport.TerminalProfile,
    .one `FirstPassageLinearTransport.TerminalTail,
    .one `FirstPassageLinearTransport.TimeSupportTransport,
    .one `FirstPassageLinearTransport.TimeoutCore,
    .one `FirstPassageLinearTransport.TimeoutDensity,
    .one `FirstPassageLinearTransport.TimeoutEndpointAsymptotics,
    .one `FirstPassageLinearTransport.TimeoutEndpointNaturalDensity,
    .one `FirstPassageLinearTransport.TimeoutEndpointProfile,
    .one `FirstPassageLinearTransport.TimeoutEndpointWitness,
    .one `FirstPassageLinearTransport.TimeoutEnvelope,
    .one `FirstPassageLinearTransport.TimeoutExecution,
    .one `FirstPassageLinearTransport.TimeoutFirstBad,
    .one `FirstPassageLinearTransport.TimeoutOrbitCeiling,
    .one `FirstPassageLinearTransport.TimeoutProfile,
    .one `FirstPassageLinearTransport.TimeoutRun,
    .one `FirstPassageLinearTransport.TimeoutTimeSupport,
    .one `FirstPassageLinearTransport.Transport,
    .one `FirstPassageLinearTransport.TwoRegimeClock,
    .one `FirstPassageLinearTransport.TwoRegimeExecution,
    .one `FirstPassageLinearTransport.TwoRegimePolylogProfile,
    .one `FirstPassageLinearTransport.TwoRegimeProfile,
    .one `FirstPassageLinearTransport.TwoRegimeRun,
    .one `FirstPassageLinearTransport.TwoRegimeSchedules,
    .one `FirstPassageLinearTransport.TwoRegimeTailAsymptotics,
    .one `FirstPassageLinearTransport.VaryingDensity,
    .one `FirstPassageLinearTransport.PaperAudit,
    .one `FirstPassageLinearTransport.PaperDependencyAudit,
    .one `FirstPassageLinearTransport.TimeoutEndpointAudit
  ]

/-- Optional retained V3.1 route. It is compiled only when this library or one
of its modules is requested explicitly. -/
lean_lib FirstPassageLinearTransportAlternates where
  roots := #[`FirstPassageLinearTransport.Alternates]
  moreLeanArgs := #["-DmaxHeartbeats=20000000"]
  globs := #[
    .one `FirstPassageLinearTransport.MovingExecution,
    .one `FirstPassageLinearTransport.MovingOrbitCeiling,
    .submodules `FirstPassageLinearTransport.Alternates
  ]
