function CBLTrack(Depth,cbl;DepthFrom=minimum(Depth),DepthTo=maximum(Depth),Dtick=false)

    cblaxf=gca()
    cblaxf.plot(cbl,Depth, color="darkred",linewidth=0.5)
    cblaxf.set_ylim([DepthTo,DepthFrom])
    cblaxf.set_xlim([0,100])
    cblaxf.set_xlabel("CBL")
    cblaxf.set_yticks(range(DepthFrom, stop=DepthTo, length=51),minor=true)
    cblaxf.set_yticks(range(DepthFrom, stop=DepthTo, length=11))
    cblaxf.xaxis.tick_top()
    cblaxf.xaxis.set_label_position("bottom")
    cblaxf.tick_params("both",labelsize=8)
    setp(cblaxf.get_yticklabels(),visible=Dtick)

    cblaxp=cblaxf.twiny()
    cblaxp.plot(cbl,Depth, color="darkblue",linewidth=0.5)
    cblaxp.set_ylim([DepthTo,DepthFrom])
    cblaxp.set_xlim([0,20])
    cblaxp.set_xlabel("CBLx5")
    cblaxp.set_yticks(range(DepthFrom, stop=DepthTo, length=51),minor=true)
    cblaxp.set_yticks(range(DepthFrom, stop=DepthTo, length=11))
    cblaxp.xaxis.set_label_position("top")
end
