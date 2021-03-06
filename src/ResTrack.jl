
"""
ResTrack(args...)  -> PyPlot Plot

Return a plot of resistivities logs in a single track.

<br> The next table show the list of variables allowed:
|PropertyName|Args|Default|Input|Description
|---|---|---|---|---|
|Depth|Mandatory| -- | Array{Number,1}| 1D Array of Depths|
|Res|Mandatory| -- | Array{Number,n}|2D Array of Resistivities Values sorted by colums|
|DepthFrom|Optional| minimum(Depth) | Number |Set the Depth upper limit to plot|
|DepthTo|Optional| maximum(Depth) | Number |  Set the Depth lower limit to plot|
|c1|Optional|c1=RGB(0.0,0.0,1.0)|c1=RGB(r,g,b)|Set the initial color for <br> a Color gradient Resistivities curves|
|c1|Optional|c1=RGB(0.1,0.6,0.1)|c1=RGB(r,g,b)|Set the final color for <br> a Color gradient Resistivities curves|
|Dtick|Optional|true|Dtick=Bool|Set the Depth ticks On/Off|

"""
function ResTrack(Depth;Res,DepthFrom=minimum(Depth),DepthTo=maximum(Depth),
        c1=RGB(0.0,0.0,1.0),c2=RGB(0.1,0.6,0.1),Dtick=false,ResRange=[0.2,20000])

n=size(Res,2)
pcolor=range(c1, stop=c2, length=n)
pcols = map(col -> (red(col), green(col), blue(col)), pcolor)
linestyles="-"
linewidths=collect(range(1, stop=1.5, length=n))
rsax=gca()
for i=1:n
    rsax.plot(Res[:,i],Depth,color=pcols[i],linestyle=linestyles,linewidth=linewidths[i])
    end
rsax.set_ylim([DepthTo,DepthFrom])
setp(rsax.get_yticklabels(),visible=Dtick)
rsax.set_xscale("log")
xlim(ResRange[1],ResRange[2])
ticks=round.(10 .^(range(log10(ResRange[1]), stop=log10(ResRange[2]), length=1+Int(log10(ResRange[2]/ResRange[1])))),digits=1)
rsax.set_xticks(ticks)
rsax.set_xticklabels(ticks)
xlabel("Resistivity")
rsax.grid(true)
rsax.grid(true, which="minor", axis="x",linewidth=0.5, linestyle="--")
rsax.xaxis.tick_top()
rsax.xaxis.set_label_position("top")
rsax.tick_params("both",labelsize=6)
rsax.xformatter = :auto
    rsax.set_yticks(range(DepthFrom, stop=DepthTo, length=51),minor=true)
    rsax.set_yticks(range(DepthFrom, stop=DepthTo, length=11))

    end
