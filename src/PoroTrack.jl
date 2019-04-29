###########################################################
#Porosity Track Function Logs density and Neutron
###########################################################
function PoroTrack(Depth,Density,Neutron;DepthFrom=minimum(Depth),DepthTo=maximum(Depth),
                    denax_color="darkred",ntr_color="darkblue",Dtick=false,LimeSync=false)

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
denax.fill_betweenx(Depth,Density,NtrToDen,where=(Density .< NtrToDen),color="red");
    end
