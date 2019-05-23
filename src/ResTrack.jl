
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
        c1=RGB(0.0,0.0,1.0),c2=RGB(0.1,0.6,0.1),Dtick=false)

n=size(Res,2)
pcolor=range(c1, stop=c2, length=n)
pcols = map(col -> (red(col), green(col), blue(col)), pcolor)
linestyles=["--","-","-","-"]
linewidths=[0.5,1,1.5,1.5]
rsax=gca()
for i=1:n
    rsax.plot(Res[:,i],Depth,color=pcols[i],linestyle=linestyles[i],linewidth=linewidths[i])
    end
rsax.set_ylim([DepthTo,DepthFrom])
setp(rsax.get_yticklabels(),visible=Dtick)
rsax.set_xscale("log")
xlim(0.2,20000)
rsax.set_xticks([0.2,2,20,200,2000,20000])
rsax.set_xticklabels([0.2,2,20,200,2000,20000])
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
