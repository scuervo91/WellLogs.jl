function CCLTrack(Depth,ccl;DepthFrom=minimum(Depth),DepthTo=maximum(Depth),Dtick=false)

    cclax=gca()
    cclax.plot(ccl,Depth, color="black",linewidth=0.5)
    cclax.set_ylim([DepthTo,DepthFrom])
    cclax.set_xlim([-50,50])
    cclax.set_xlabel("CCL")
    cclax.set_yticks(range(DepthFrom, stop=DepthTo, length=51),minor=true)
    cclax.set_yticks(range(DepthFrom, stop=DepthTo, length=11))
    cclax.xaxis.tick_top()
    cclax.xaxis.set_label_position("top")
    cclax.tick_params("both",labelsize=8)
    setp(cclax.get_yticklabels(),visible=Dtick)
end
