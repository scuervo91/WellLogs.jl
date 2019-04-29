
function VshTrack(Depth,Vsh;DepthFrom=minimum(Depth),DepthTo=maximum(Depth),Dtick=false,PhiePlot=false)
vshax=gca()
vshax.plot(Vsh,Depth,linewidth=1,linestyle="--",color="black")
vshax.set_xlim([0,1])
vshax.set_ylim([DepthTo,DepthFrom])
vshax.set_yticks(range(DepthFrom, stop=DepthTo, length=51),minor=true)
vshax.set_yticks(range(DepthFrom, stop=DepthTo, length=11))
vshax.tick_params("both",labelsize=6)
vshax.set_xlabel("VShale")
setp(vshax.get_yticklabels(),visible=Dtick)
vshax.fill_betweenx(Depth,Vsh,1,where=(Vsh .<= 1),color="gold")

if PhiePlot!=false
phieax=vshax.twiny()
phieax.plot(PhiePlot,Depth,linewidth=1,color="black")
phieax.set_xlim([1,0])
setp(phieax.get_yticklabels(),visible=Dtick)
phieax.set_xlabel("Phie")
phieax.tick_params("both",labelsize=6)

phieax.fill_betweenx(Depth,PhiePlot,0,where=(Vsh .<= 1),color="red")
end

end
###########################################################
#VshTrack Function
###########################################################
