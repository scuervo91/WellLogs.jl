"""
PoroTrack(args...)  -> PyPlot Plot

Return a plot of Density-Neutron logs in a single track.

<br> The next table show the list of variables allowed:

|PropertyName|Args|Default|Input|Description
|---|---|---|---|---|
|Depth|Mandatory| -- | Array{Number,1}| 1D Array of Depths|
|Density|Mandatory| -- | Array{Number,1}|1D Array of Density Values|
|Neutron|Mandatory| -- | Array{Number,1}|1D Array of Neutron Values|
|DepthFrom|Optional| minimum(Depth) | Number |Set the Depth upper limit to plot|
|DepthTo|Optional| maximum(Depth) | Number |  Set the Depth lower limit to plot|
|denax_color|Optional| "darkred" |denax_color="color" |  Set the Density curve color
|ntr_color|Optional| "darkgreen" |ntr_color="color" |  Set the Neutron curve Color|
|Dtick|Optional|true|Dtick=Bool|Set the Depth ticks On/Off|
|LimeSync|Optionalfalse|LimeSync=true|Sync the plot for Limestone|
|Fill|Optional|true|Fill=Bool| Fill when crossed Neutron-Density|
"""
function PoroTrack(Depth,Density,Neutron;DepthFrom=minimum(Depth),DepthTo=maximum(Depth),
                    denax_color="darkred",ntr_color="darkblue",Dtick=false,LimeSync=false, Fill=true)

 if LimeSync==true
        d=2.71
    else
        d=2.65
    end

    m=(d-1.9)/(0-0.45)
    b=-m*0.45+1.9
    denlim=-0.15*m.+b

denax=gca()
denax.plot(Density,Depth,color=denax_color)
denax.set_ylim([DepthTo,DepthFrom])
denax.set_xlabel("Density")
xticks(range(1.9,stop=denlim,length=4))
denax.set_xlim([1.9,denlim])
denax.tick_params("both",labelsize=6)
denax.grid(true)
denax.set_yticks(range(DepthFrom, stop=DepthTo, length=51),minor=true)
denax.set_yticks(range(DepthFrom, stop=DepthTo, length=11))

ntrax=denax.twiny()
ntrax.plot(Neutron,Depth,color=ntr_color)
xlabel("Neutron")
xticks(range(0.45,stop=-0.15,length=4))
xlim(0.45,-0.15)
ntrax.tick_params("both",labelsize=6)
ntrax.grid(true)
setp(denax.get_yticklabels(),visible=Dtick)
 #Convert the Neutron values to Density Values in order to fill the cross Density-Neutron
#When the track is callibrated for sandstone use m=-1.666667 and b=2.65
#When the track is callibrated for limestone use m=-1.8 and b=2.71

NtrToDen=Neutron.*m.+b
if Fill==true
denax.fill_betweenx(Depth,Density,NtrToDen,where=(Density .< NtrToDen),color="red")
end
    end
