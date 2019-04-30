function LithoTrack(Depth,GammaRay;SponPot=false,DepthFrom=minimum(Depth),DepthTo=maximum(Depth),
                    spax_color="black",grax_color="darkgreen",
                    Dtick=true,
                    WellUnit=false,UnitC1=RGB(0.9,0.9,0.2),UnitC2=RGB(1,0.0,0.1),
                    WellFm=false,FmC1=RGB(0.0,0.0,1.0),FmC2=RGB(1.0,0.0,0.0),
                    WellPerf=false,
                    GRSand=false, GRShale=false,
                    SSP=false, PSP=false,
                    LineCorrelate=false,
                    Pay=false,
                    WellName=false)

  #If the Spontaneous Potential is provided
if SponPot != false
    spax=gca()                                                #get the axes
    spax.plot(SponPot,Depth,color=spax_color,linewidth=0.5,linestyle="--")                             #Line Color
    spax.set_ylim([DepthTo,DepthFrom])                          #Set the y limits
    spax.set_ylabel("Depth")                                  #Set the y label
    spax.set_xlabel("Sp")                                     #Set the x label
    xticks(range(minimum(SponPot[SponPot.>-999.25]),maximum(SponPot[SponPot.>-999.25]),length=4))      #Set the intervals of ticks
    spax.set_xlim([minimum(SponPot[SponPot.>-999.25]),maximum(SponPot[SponPot.>-999.25])])                  #Set x Limits
    spax.tick_params("both",labelsize=6)                      #Set fontsize of both axis
    spax.grid(true)                                           #Set the grid
    f = matplotlib.ticker.FormatStrFormatter("%1.2f")         #
    spax.xaxis.set_major_formatter(f)                         # Set format of tick labels
    grax=spax.twiny()                                         #Set the second x axis
else
    grax=gca()                                            #set gamma ray axis
    grax.set_ylim([DepthTo,DepthFrom])                    #Set the y limits
    grax.xaxis.set_label_position("top")
    grax.xaxis.tick_top()
end

grax.plot(GammaRay,Depth,color=grax_color)
    xlabel("GammaRay")
    xticks(0:50:150)
    grax.set_xlim([0,150])
    grax.tick_params("both",labelsize=6)
    grax.grid(true)
    setp(grax.get_yticklabels(),visible=Dtick)
    grax.set_yticks(range(DepthFrom, stop=DepthTo, length=51),minor=true)
    grax.set_yticks(range(DepthFrom, stop=DepthTo, length=11))

if WellFm != false                                     #If Formations are Provided
    ntop=size(WellFm,1)
    if ntop==1
        zcolor=range(FmC1, stop=FmC2, length=2)
    else
        zcolor=range(FmC1, stop=FmC2, length=ntop)
    end
    zcols = map(col -> (red(col), green(col), blue(col)), zcolor)

    for i=1:ntop
        grax.axhspan(WellFm[i,1],WellFm[i,2],xmin=0,xmax=150,alpha=0.3,color=zcols[i])
        grax.hlines([WellFm[i,1],WellFm[i,2]],0,150, linewidth=0.5)
    end
end

if WellUnit != false                                     #If Units are Provided
    ntop=size(WellUnit,1)
    if ntop==1
        zcolor=range(UnitC1, stop=UnitC2, length=2)
    else
        zcolor=range(UnitC1, stop=UnitC2, length=ntop)
    end
    zcols = map(col -> (red(col), green(col), blue(col)), zcolor)

    for i=1:ntop
        grax.axhspan(WellUnit[i,1],WellUnit[i,2],xmin=0,xmax=150,alpha=0.5,color=zcols[i])
        grax.hlines([WellUnit[i,1],WellUnit[i,2]],0,150, linewidth=0.5)
    end
end

if WellPerf!=false                                        #If WellPerf are Provided
    nperf=size(WellPerf,1)
    for i=1:nperf
        grax.plot([5,5],[WellPerf[i,1],[WellPerf[i,2]]],color=:black,linestyle="--",linewidth=2)
    end
end

if GRSand!=false
       grax.vlines(GRSand[1],GRSand[2],GRSand[3],color=:gold,linestyle="--",linewidth=1.5)
end

 if GRShale!=false
        grax.vlines(GRShale[1],GRShale[2],GRShale[3],color=:gray,linestyle="--",linewidth=1.5)
end

if SSP!=false
       spax.vlines(SSP[1],SSP[2],SSP[3],color=:gold,linestyle="--",linewidth=1.5)
end

 if PSP!=false
        spax.vlines(PSP[1],PSP[2],PSP[3],color=:gray,linestyle="--",linewidth=1.5)
end

 if LineCorrelate!=false                            #If want to use a line to correlate
      grax.hlines(LineCorrelate,0,150, linewidth=1,linestyle="--",color="red")
    end

 if WellName!=false
grax.set_title(WellName)
    end

 if Pay!=false
 rt=findall(x->x==1,Pay)
 Payd=Depth[rt]
 yPay=zeros(size(Payd,1)).+148
 grax.scatter(yPay,Payd,color="red",linewidth=4)
 end





end
