function ResTrack(Depth;Res,DepthFrom=minimum(Depth),DepthTo=maximum(Depth),c1=RGB(0,0,1.),c2=RGB(0.1,0.6,0.1),Dtick=false)

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
