# WellLogs.jl

## Introduction
This package is being designed among others to provide Petroleum Engineering tools in a modern programming language. This package is part of the project 7G which  proposes to make basic but powerful engineering software packages that cover the main topics of the Oil and Gas development phases which could be applied to any case study by suitable engineers.

There are five topics in which the project is going to be focused on:

<br>-Geoscience* (Current Package)
<br>-Reservoir
<br>-Production
<br>-Economics
<br>-Integration

<br> The package will always be in permanent development and open to suggestions to enhance the program. As the code has been written so far by a code enthusiastic Petroleum Engineer I hope to learn as much as possible to get better and usefull programs.

## WellLogs.jl Description
WellLogs.jl is package to visualize Oil And Gas Well logs in order to make interpretetion and petrophysics analysis via PyPlot plots.

<br> The visualization of logs is based on Tracks functions. Each log track is implemented through a single function that plot the desired data. For example, the Lithology Track is composed generally by GammaRay and Sp logs, so LithoTrack function can plot the GammaRay and SP logs with optional features like add Well tops (Formations or Units), Gr clean and Gr shale to Vshale estimations, etc...

The visualization of logs is customizable through the use of Subplots to show any track as well as the use [Interact.jl](https://github.com/JuliaGizmos/Interact.jl) to add interactivity, mainly depth limits.

## Tutorial

Load Packages required:
```julia
using Interact
using PyPlot
using CSV
using Colors
using DataFrames
using Statistics
using Query
using Interpolations
using Distributions
using WellLogs
```

The logs, perforations and Formation and Tops units, in this case, are stored in CSV files which are loaded:

```julia
Logs=CSV.read("~\\Logs.csv")
Fms=CSV.read("~\\FormationTops.csv")
Perfs=CSV.read("~\\Perforations.csv")
Units=CSV.read("~\\UnitsTops.csv")
```

Logs Example
| WellId | Md | GammaRay  | Sp
| --- | --- | --- | --- |
| 1 | 0 | 123 | 345 |
| ... | ... | 678 | 987 |
| 2 | 6839 | 843 | 548|

```julia
@manipulate for from=9000, to=10180

    fig, axes=subplots(1,3,figsize=(10,5))
    withfig(fig,clear=false) do
        for ax in axes
            ax.cla()
        end
 subplot(131)        
 LithoTrack(Logs.Md,Logs.GammaRay,SponPot=Logs.SP,DepthFrom=from,DepthTo=to,WellUnit=Units[:,[:MdTop,:MdBottom]],UnitAlpha=0.5)       

  subplot(132)
 PoroTrack(Logs.Md,Logs.Density,Logs.NeutronSand,DepthFrom=from,DepthTo=to)

 subplot(133)        
 ResTrack(Logs.Md,Res=[Logs.ShallowRes Logs.MediumRes Logs.DeepRes],DepthFrom=from,DepthTo=to)
    end
end
```

<img src="WellLog_Ex1.PNG" height="200"><br>
