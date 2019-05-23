"""
KhTrack(args...)  -> PyPlot Plot

Return a plot Normalized Flow Capacity Kh logs in a single track.

<br> The next table show the list of variables allowed:

<br> The next table show the list of variables allowed:
|PropertyName|Args|Default|Input|Description
|---|---|---|---|---|
|Depth|Mandatory| -- | Array{Number,1}| 1D Array of Depths|
|Kh|Mandatory| -- | Array{Number,1}|1D Array of Vshale Values|
|DepthFrom|Optional| minimum(Depth) | Number |Set the Depth upper limit to plot|
|DepthTo|Optional| maximum(Depth) | Number |  Set the Depth lower limit to plot|
|Dtick|Optional|true|Dtick=Bool|Set the Depth ticks On/Off|
"""
function KhTrack(Depth,Kh;DepthFrom=minimum(Depth),DepthTo=maximum(Depth),Dtick=false)
    khax=gca()
    khax.plot(Kh,Depth,linewidth=2,color="black")
    khax.set_xlim([0,1])
    khax.set_ylim([DepthTo,DepthFrom])
    khax.set_xlabel("Norm. Flow Capacity")
    khax.xaxis.tick_top()
    khax.xaxis.set_label_position("top")
    setp(khax.get_yticklabels(),visible=Dtick)
    khax.set_yticks(range(DepthFrom, stop=DepthTo, length=51),minor=true)
    khax.set_yticks(range(DepthFrom, stop=DepthTo, length=11))
end
