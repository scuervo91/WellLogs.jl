function CalTrack(Depth,cal,bit;DepthFrom=minimum(Depth),DepthTo=maximum(Depth),Dtick=false)

    calax=gca()
    calax.plot(cal,Depth, color="red",linewidth=1, linestyle="--")
    calax.plot(bit,Depth, color="black",linewidth=0.5)
    calax.set_ylim([DepthTo,DepthFrom])
    calax.set_xlim([5,17])
    calax.set_xlabel("Diameter Inches")
    calax.set_yticks(range(DepthFrom, stop=DepthTo, length=51),minor=true)
    calax.set_yticks(range(DepthFrom, stop=DepthTo, length=11))
    calax.xaxis.tick_top()
    calax.xaxis.set_label_position("top")
    calax.tick_params("both",labelsize=8)
    setp(calax.get_yticklabels(),visible=Dtick)
    calax.fill_betweenx(Depth,cal,bit,where=(cal .< bit),color="yellow")
    calax.fill_betweenx(Depth,cal,bit,where=(cal .> bit),color=(0.2,0.4,0.8))
end
