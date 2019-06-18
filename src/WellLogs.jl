module WellLogs

using PyPlot
using Colors
using Distributions
using Plots
using Statistics
using DataFrames
using RecipesBase

export KhTrack, ResTrack, SwTrack, LithoTrack, PermTrack, VshTrack, PoroTrack,
        Phiefec, SwArchie, PermWR, RhoPorosity, Vshale, AddColPetro, PetroPhysics,
        OGIP, OOIP, meshgrid, VDLTrack, CBLTrack, CCLTrack, Reg, CalTrack

#Track functions
include("KhTrack.jl")
include("ResTrack.jl")
include("SwTrack.jl")
include("LithoTrack.jl")
include("PermTrack.jl")
include("VshTrack.jl")
include("PoroTrack.jl")
include("VdlTrack.jl")
include("CblTrack.jl")
include("CCLTrack.jl")
include("CalTrack.jl")


#Utility Functions
include("meshgrid.jl")
include("Reg.jl")


#Formula PetroPhysics
include("Phiefec.jl")
include("SwArchie.jl")
include("PermWR.jl")
include("RhoPorosity.jl")
include("Vshale.jl")

#Formula for include PetroPhysics estimates in well logs
include("AddColPetro.jl")
include("PetroPhysics.jl")
include("PropHist.jl")
include("PickettPlot.jl")


#Formula for volumetrics estimates
include("OGIP.jl")
include("OOIP.jl")

include("TopDistance.jl")


#Plot Recipes
include("IDWIRecipe.jl")


end # module
