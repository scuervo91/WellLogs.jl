###########################################################
#Permeability Track
###########################################################
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
