"""
PermTrack(args...)  -> PyPlot Plot

Returns a plot of permeability in a single track

<br> The next table show the list of variables allowed:

<br> The next table show the list of variables allowed:
|PropertyName|Args|Default|Input|Description
|---|---|---|---|---|
|Depth|Mandatory| -- | Array{Number,1}| 1D Array of Depths|
|K|Mandatory| -- | Array{Number,1}|1D Array of Permeability Values|
|DepthFrom|Optional| minimum(Depth) | Number |Set the Depth upper limit to plot|
|DepthTo|Optional| maximum(Depth) | Number |  Set the Depth lower limit to plot|
|Dtick|Optional|true|Dtick=Bool|Set the Depth ticks On/Off|
"""
function PermTrack(Depth,Perm;DepthFrom=minimum(Depth),DepthTo=maximum(Depth),Dtick=false)
    permax=gca()
    permax.plot(Perm,Depth,linewidth=1,color="black")
    #permax.set_xlim([0.1,10])
    permax.set_ylim([DepthTo,DepthFrom])
    setp(permax.get_yticklabels(),visible=Dtick)
    permax.set_yticks(range(DepthFrom, stop=DepthTo, length=51),minor=true)
    permax.set_yticks(range(DepthFrom, stop=DepthTo, length=11))
    permax.tick_params("both",labelsize=6)
    permax.set_xlabel("Permeability[md]")
    permax.xaxis.tick_top()
    permax.xaxis.set_label_position("top")
    permax.set_xscale("log")
end
