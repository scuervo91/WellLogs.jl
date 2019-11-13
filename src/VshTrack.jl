"""
VshTrack(args...)  -> PyPlot Plot

Return a plot of Vshale logs and optionally Effective porosity in a single track.

<br> The next table show the list of variables allowed:

<br> The next table show the list of variables allowed:
|PropertyName|Args|Default|Input|Description
|---|---|---|---|---|
|Depth|Mandatory| -- | Array{Number,1}| 1D Array of Depths|
|Vsh|Mandatory| -- | Array{Number,1}|1D Array of Vshale Values|
|PhiePlot|Optional| -- | Array{Number,1}|1D Array of Phie Values|
|DepthFrom|Optional| minimum(Depth) | Number |Set the Depth upper limit to plot|
|DepthTo|Optional| maximum(Depth) | Number |  Set the Depth lower limit to plot|
|Dtick|Optional|true|Dtick=Bool|Set the Depth ticks On/Off|
"""
function VshPhieTrack(Depth,Vsh;DepthFrom=minimum(Depth),DepthTo=maximum(Depth),Dtick=false,PhiePlot=false,Phiemax=0.30)
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
phieax.set_xlim([Phiemax,0])
setp(phieax.get_yticklabels(),visible=Dtick)
phieax.set_xlabel("Phie")
phieax.tick_params("both",labelsize=6)

phieax.fill_betweenx(Depth,PhiePlot,0,where=(Vsh .<= 1),color="red")
else
    vshax.xaxis.set_label_position("top")
    vshax.xaxis.tick_top()

end

end
###########################################################
#VshTrack Function
###########################################################
function VshTrack(Depth,Vsh;DepthFrom=minimum(Depth),DepthTo=maximum(Depth),Dtick=false,CutOff=0.7,fill=true)
vshax=gca()
vshax.plot(Vsh,Depth,linewidth=1,linestyle="--",color="black")
vshax.set_xlim([1,0])
vshax.set_ylim([DepthTo,DepthFrom])
vshax.set_yticks(range(DepthFrom, stop=DepthTo, length=51),minor=true)
vshax.set_yticks(range(DepthFrom, stop=DepthTo, length=11))
vshax.tick_params("both",labelsize=6)
vshax.set_xlabel("VShale")
setp(vshax.get_yticklabels(),visible=Dtick)
if fill==true
    vshax.fill_betweenx(Depth,CutOff,Vsh,where=(CutOff .>= Vsh),color="gold")
end   
vshax.xaxis.set_label_position("top")
vshax.xaxis.tick_top()
end


function PhieTrack(Depth,Phie;DepthFrom=minimum(Depth),DepthTo=maximum(Depth),Dtick=false,CutOff=0.08,Phiemax=0.30,fill=false)
    phieax=gca()
    phieax.plot(Phie,Depth,linewidth=1,color="black")
    phieax.set_ylim([DepthTo,DepthFrom])
    phieax.set_xlim([0,Phiemax])
    setp(phieax.get_yticklabels(),visible=Dtick)
    phieax.set_xlabel("Phie")
    phieax.tick_params("both",labelsize=6)
    if fill==true
        phieax.fill_betweenx(Depth,CutOff,Phie,where=(CutOff .<= Phie),color="red")
    end
    phieax.xaxis.set_label_position("top")
    phieax.xaxis.tick_top()
end
