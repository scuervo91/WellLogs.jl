"""
SwTrack(args...)  -> PyPlot Plot

Return a plot of Sw log in a single track.

<br> The next table show the list of variables allowed:

<br> The next table show the list of variables allowed:
|PropertyName|Args|Default|Input|Description
|---|---|---|---|---|
|Depth|Mandatory| -- | Array{Number,1}| 1D Array of Depths|
|Sw|Mandatory| -- | Array{Number,1}|1D Array of Sw Values|
|DepthFrom|Optional| minimum(Depth) | Number |Set the Depth upper limit to plot|
|DepthTo|Optional| maximum(Depth) | Number |  Set the Depth lower limit to plot|
|Dtick|Optional|true|Dtick=Bool|Set the Depth ticks On/Off|
"""
function SwTrack(Depth,Sw;DepthFrom=minimum(Depth),DepthTo=maximum(Depth),Dtick=false,CutOff=0.6,fill=false)
    swax=gca()
    swax.plot(Sw,Depth,linewidth=1,color="black")
     swax.set_xlim([1,0])
    swax.set_ylim([DepthTo,DepthFrom])
    setp(swax.get_yticklabels(),visible=Dtick)
    swax.set_yticks(range(DepthFrom, stop=DepthTo, length=51),minor=true)
    swax.set_yticks(range(DepthFrom, stop=DepthTo, length=11))
    swax.tick_params("both",labelsize=6)
    swax.set_xlabel("Water Saturation")
    swax.xaxis.tick_top()
    swax.xaxis.set_label_position("top")
    if fill==true
        swax.fill_betweenx(Depth,CutOff,Sw,where=(CutOff .>= Sw),color="green")
    end
end
