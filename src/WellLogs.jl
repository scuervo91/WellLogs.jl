module WellLogs

using PyPlot
using Colors
using Distributions
using Plots
using Statistics


export KhTrack, ResTrack, SwTrack, LithoTrack, PermTrack, VshTrack, PoroTrack,
        Phiefec, SwArchie, PermWR, RhoPorosity, Vshale, AddColPetro, PetroPhysics, PropDist,
        PickettPlot, OGIP, OOIP, TopDistance

#Track functions
include("KhTrack.jl")
include("ResTrack.jl")
include("SwTrack.jl")
include("LithoTrack.jl")
include("PermTrack.jl")
include("VshTrack.jl")
include("PoroTrack.jl")

#Formula PetroPhysics
include("Phiefec.jl")
include("SwArchie.jl")
include("PermWR.jl")
include("RhoPorosity.jl")
include("Vshale.jl")

#Formula for include PetroPhysics estimates in well logs
include("AddColPetro.jl")
include("PetroPhysics.jl")
include("PropDist.jl")
include("PickettPlot.jl")


#Formula for volumetrics estimates
include("OGIP.jl")
include("OOIP.jl")

include("TopDistance.jl")

end # module
