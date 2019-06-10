function VDLTrack(Depth,vdl;DepthFrom=minimum(Depth),DepthTo=maximum(Depth),Dtick=false)

    x=1:size(vdl,2)
    X, Y =meshgrid(x,Depth)

    vdlax=gca()
    vdlax.contour(X,Y,vdl, cmap="Greys")
    vdlax.set_ylim([DepthTo,DepthFrom])
    vdlax.set_xlabel("VDL")
    vdlax.set_yticks(range(DepthFrom, stop=DepthTo, length=51),minor=true)
    vdlax.set_yticks(range(DepthFrom, stop=DepthTo, length=11))
    vdlax.xaxis.tick_top()
    vdlax.xaxis.set_label_position("top")
    setp(vdlax.get_yticklabels(),visible=Dtick)
end
