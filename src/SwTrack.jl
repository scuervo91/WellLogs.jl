###########################################################
#Water Saturation Track
###########################################################
function SwTrack(Depth,Sw;DepthFrom=minimum(Depth),DepthTo=maximum(Depth),Dtick=false)
    swax=gca()
    swax.plot(Sw,Depth,linewidth=1,color="black")
     swax.set_xlim([0,1])
    swax.set_ylim([DepthTo,DepthFrom])
    setp(swax.get_yticklabels(),visible=Dtick)
    swax.set_yticks(range(DepthFrom, stop=DepthTo, length=51),minor=true)
    swax.set_yticks(range(DepthFrom, stop=DepthTo, length=11))
    swax.tick_params("both",labelsize=6)
    swax.set_xlabel("Water Saturation")
    swax.xaxis.tick_top()
    swax.xaxis.set_label_position("top")
    swax.fill_betweenx(Depth,0,Sw,where=(0 .<= Sw),color="blue")
end
