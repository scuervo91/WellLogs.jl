###########################################################
#KhTrack
###########################################################


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
