function PropDist(  Prop;                  #Array or Datagrame with the property
                    Distr=Normal,        #Distribution to fit
                    DisHist=false,        #Determine if make an Histogram
                    PropName=false,
                    HistColor="darkblue")       #Property Name

    #Prop distribution
    MinProp=minimum(Prop)
    MaxProp=maximum(Prop)
    PropRange=range(MinProp,stop=MaxProp,length=100)
    DisProp=Distributions.fit(Distr, Prop[:]*1)
    DisParam=params(DisProp)
    FitProp=pdf.(DisProp, PropRange);

    println(DisProp)

if Distr==LogNormal
    PropMean=exp(DisParam[1]+(DisParam[2]^2)/2)
    println("LogNormal distribution mean is $PropMean")
    end
    if DisHist==true
        ax=gca()
        ax.hist(Prop,bins=round(Int,sqrt(size(Prop,1))),density=1, color=HistColor)
        ax.plot(PropRange,FitProp,linestyle="--",color="black")
        ax.set_xlabel("$PropName")
        ax.set_title("$PropName Distribution")
    end

return DisProp
end
