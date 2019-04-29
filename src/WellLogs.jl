module WellLogs

using PyPlot
using Colors

export KhTrack, ResTrack, SwTrack, LithoTrack, PermTrack, VshTrack, PoroTrack,
        Phiefec, SwArchie, PermWR, RhoPorosity, Vshale, AddColPetro, PetroPhysics

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

end # module
