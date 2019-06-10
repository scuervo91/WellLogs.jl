"""
LithoTrack(args...)  -> PyPlot Plot

Return a plot of Lithology Logs (GammaRay and SP) in a single track.
<br> Mandatory series to plot are Depth, GammaRay
<br> Optional series is the Spontaneous Potential (SP)
<br>
<br> For log analysis purposes can be included the next properties:
<br> --> highlighted Formations
<br> --> highlighted Units
<br> --> highlighted Formations
<br> --> Lines that indicate a Clean GammaRay and Shale GammaRay for Vshale visualization
<br> --> Lines that indicate a SSP and PSP for Spontaneous Potential analysis
<br> --> Line that show a provided depth with correlation purpose
<br> The next table show the list of variables allowed:

|PropertyName|Args|Default|Input|Description
|---|---|---|---|---|
|Depth|Mandatory| -- | Array{Number,1}| 1D Array of Depths|
|GammaRay|Mandatory| -- | Array{Number,1}|1D Array of GammaRay Values|
|GRMax|Optional|150|GRMax=Number| Set the max GammaRay Limit|
|SponPot|Optional| false | Array{Number,1}| 1D Array of SP values|
|DepthFrom|Optional| minimum(Depth) | Number |Set the Depth upper limit to plot|
|DepthTo|Optional| maximum(Depth) | Number |  Set the Depth lower limit to plot|
|spax_color|Optional| "black" |spax_color="color" |  Set the SP curve color
|grax_color|Optional| "darkgreen" |grax_color="color" |  Set the GammaRay curve Color|
|Dtick|Optional|true|Dtick=Bool|Set the Depth ticks On/Off|
|WellUnit|Optional|false|Array{Number,2} <br> WellUnit=Units[:,[:Top,:Bottom]]|Add Units range to highlight. <br>Array mx2 m=number of units Colums Top-Base|
|UnitC1|Optional|RGB(0.9,0.9,0.2)|UnitC1=RGB(r,g,b)|Set the initial color for <br> a Color gradient to highlight units|
|UnitC2|Optional|RGB(1.0,0.0,0.1)|UnitC1=RGB(r,g,b)|Set the final color for <br> a Color gradient to highlight units|
|WellFm|Optional|false|Array{Number,2} <br> WellFm=Fms[:,[:Top,:Bottom]]|Add Units range to highlight. <br>Array mx2 m=number of units Colums Top-Base|
|FmC1|Optional|RGB(0.0,0.0,1.0)|FmC1=RGB(r,g,b)|Set the initial color for <br> a Color gradient to highlight Formations|
|FmC2|Optional|RGB(1.0,0.0,0.0)|FmC1=RGB(r,g,b)|Set the initial color for <br> a Color gradient to highlight Formations|
|WellPerf|Optional|false|Array{Number,2} <br> WellFm=Fms[:,[:Top,:Bottom]]|Add Perforations interval to highlight . <br> with a vertical dashed line |
|GrSand|Optional|false|Array{Number,1} <br> GRSand=[grsand,from,to]| Add Clean GammaRay vertical line to calibrate|
|GrShale|Optional|false|Array{Number,1} <br> GRShale=[grshale,from,to]| Add Shale GammaRay vertical line to calibrate|
|SSP|Optional|false|Array{Number,1} <br> SSP=[SSP,from,to]| Add SSP vertical line to calibrate|
|PSP|Optional|false|Array{Number,1} <br> PSP=[SSP,from,to]| Add PSP vertical line to calibrate|
|LineCorrelate|Optional|false|LineCorrelate=Number|Add a horizontal line for correlation purposes|
|Pay|Optional|false|Array{Bool,1}| Add a scatter line indicating the pay depth|
|WellName|Optional|false|String <br> WellName="Name"|Add a Name for titles|
"""
function LithoTrack(Depth,GammaRay;SponPot=false,DepthFrom=minimum(Depth),DepthTo=maximum(Depth),
                    spax_color="black",grax_color="darkgreen",
                    Dtick=true,
                    WellUnit=false, UnitC1=RGB(0.9,0.9,0.2), UnitC2=RGB(1.0,0.0,0.1), UnitAlpha=0.1,
                    WellFm=false, FmC1=RGB(0.0,0.0,1.0), FmC2=RGB(1.0,0.0,0.0), FmAlpha=0.1,
                    WellPerf=false,
                    GRSand=false, GRShale=false,
                    SSP=false, PSP=false,
                    LineCorrelate=false,
                    Pay=false,
                    WellName=false,
                    GRMax=150)

  #If the Spontaneous Potential is provided
if SponPot != false
    spax=gca()                                                #get the axes
    spax.plot(SponPot,Depth,color=spax_color,linewidth=0.5,linestyle="--")                             #Line Color
    spax.set_ylim([DepthTo,DepthFrom])                          #Set the y limits
    spax.set_ylabel("Depth")                                  #Set the y label
    spax.set_xlabel("Sp")                                     #Set the x label
    xticks(range(minimum(SponPot[SponPot.>-999.25]),maximum(SponPot[SponPot.>-999.25]),length=4))      #Set the intervals of ticks
    spax.set_xlim([minimum(SponPot[SponPot.>-999.25]),maximum(SponPot[SponPot.>-999.25])])                  #Set x Limits
    spax.tick_params("both",labelsize=8)                      #Set fontsize of both axis
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
    xticks(0:50:GRMax)
    grax.set_xlim([0,GRMax])
    grax.tick_params("both",labelsize=8)
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
        grax.axhspan(WellFm[i,1],WellFm[i,2],xmin=0,xmax=GRMax,alpha=FmAlpha,color=zcols[i])
        grax.hlines([WellFm[i,1],WellFm[i,2]],0,GRMax, linewidth=0.5)
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
        grax.axhspan(WellUnit[i,1],WellUnit[i,2],xmin=0,xmax=GRMax,alpha=UnitAlpha,color=zcols[i])
        grax.hlines([WellUnit[i,1],WellUnit[i,2]],0,GRMax, linewidth=0.5)
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
      grax.hlines(LineCorrelate,0,GRMax, linewidth=1,linestyle="--",color="red")
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
