"""
OOIP(args...)

Calcute the Original Oil In Place either Deterministic or Probabilistic

``OGIP=\\frac { 7.758\\times { 10 }^{ -- }\\quad A\\quad h\\quad Phi\\quad (1-Sw) }{ BO } `` in MMbbl

 ## *Deterministic Estimation*
 ### Example
```julia
    OGIP(Area=600,Height=30,Phi=0.3,Sw=0.3, Temp=180, Pres=2800, z=0.99)
    Original Gas In Place Deterministic Results
     Area = 600 Acre
    Height= 30 ft
     Phi= 0.3
     Sw= 0.3
     Bg= 0.006393798639642858 ft3|scf
    ---------
    OGIP=25.752578284072662 Bscf
```
## Probabilistic estimations
### Example
```julia
OOIP(Area=640,Height=60,Phi=0.18, Sw=0.4, Bo=1.1, PhiDist=Normal(0.18,0.05), SwDist=Normal(0.3,0.07))

Original Oil In Place Probabilistic Results
 Area = 640 Acre
 Height= 60 ft
 Bo= 1.1 bbl/stb
 Percentiles [0.1, 0.5, 0.9]
 Phi       [0.115963, 0.18001, 0.244082]
 Sw       [0.210295, 0.300001, 0.389709]
 ---------
 Ooip=      [20.9416, 33.8834, 47.0785] MMbbl
 ```

Number of samples n can be set. Default n=1000
<br>Percentiles can be set. Default Perc=[0.1,0.5,0.9]
<br> A plot can be display by setting DistHist=true. Default DisHist=false
"""
function OOIP(;Area=640,Height=1,Phi=0, Sw=0, Bo=1,
                PhiDist=Normal(), SwDist=Normal(), n=1000,
                DisHist=false,
                Perc=[0.1,0.5,0.9])

          #When is only a well for the analysis the area is ussually difined as 640 acres
     #https://www.spec2000.net/16-ooip.htm


    if PhiDist==Normal() && SwDist==Normal()
        Ooip=0.007758*Area*Height*Phi*(1-Sw)/Bo
        println("Original Oil In Place Deterministic Results \n Area = $Area Acre \n Height= $Height ft \n Phi= $Phi \n Sw= $Sw \n Bo= $Bo bbl/stb \n---------\n OOIP=$Ooip MMbbl")
    elseif PhiDist!=Normal() && SwDist!=Normal()
        PhiSample=rand(Truncated(PhiDist,0,1),n)
        SwSample=rand(Truncated(SwDist,0,1),n)
        Ooip=map((x,y)->0.007758*Area*Height*x*(1-y)/Bo,PhiSample,SwSample)
        if DisHist!=false

        fig=subplots(2,2,figsize=(5,5))
        subplot(211)
        PropDist(Ooip,PropName="Original Oil In Place[MMbbl]",DisHist=true,HistColor="darkgreen")
        subplot(223)
        PropDist(PhiSample,PropName="Porosity",DisHist=true,HistColor="darkgreen")
        subplot(224)
        PropDist(SwSample,PropName="Water Saturation",DisHist=true,HistColor="darkblue")
        subplots_adjust(hspace=0.5)
            end
        PhiQ=quantile.(Truncated(PhiDist,0,1),Perc)
        SwQ=quantile.(Truncated(SwDist,0,1),Perc)
        OoipQ=quantile!(Ooip,Perc)

        println("Original Oil In Place Probabilistic Results \n Area = $Area Acre \n Height= $Height ft \n Bo= $Bo bbl/stb \n Percentiles $Perc \n Phi       $PhiQ \n Sw       $SwQ \n --------- \n Ooip=      $OoipQ MMbbl")

    elseif PhiDist!=Normal()
        PhiSample=rand(Truncated(PhiDist,0,1),n)
        Ooip=map(x->0.007758*Area*Height*x*(1-Sw)/Bo,PhiSample)

        if DisHist!=false

        fig=subplots(2,1,figsize=(5,5))
        subplot(211)
        PropDist(Ooip,PropName="Original Oil In Place [MMbbl]",DisHist=true,HistColor="darkred")
        subplot(212)
        PropDist(PhiSample,PropName="Porosity",DisHist=true,HistColor="darkgreen")
        subplots_adjust(hspace=0.5)
            end
        PhiQ=quantile.(Truncated(PhiDist,0,1),Perc)
        OoipQ=quantile!(Ooip,Perc)

println("Original Oil In Place Probabilistic Results \n Area = $Area Acre \n Height= $Height ft \n Bo= $Bo bbl/stb \n Sw= $Sw \n Percentiles $Perc \n Phi       $PhiQ \n---------\n Ooip       $OoipQ MMbbl")

    else
        SwSample=rand(Truncated(SwDist,0,1),n)
        Ooip=map(x->0.007758*Area*Height*Phi*(1-x)/Bo,SwSample)

                if DisHist!=false

        fig=subplots(2,1,figsize=(5,5))
        subplot(211)
        PropDist(Ooip,PropName="Original Oil In Place [MMbbl]",DisHist=true,HistColor="darkred")
        subplot(212)
        PropDist(SwSample,PropName="Water Saturation",DisHist=true,HistColor="darkblue")
        subplots_adjust(hspace=0.5)
            end
        SwQ=quantile.(Truncated(SwDist,0,1),Perc)
        OoipQ=quantile!(Ooip,Perc)

println("Original Oil In Place Probabilistic Results \n Area = $Area Acre \n Height= $Height ft \n Bo= $Bo bbl/stb \n Phi= $Phi \n \n Percentiles $Perc \n Sw       $SwQ \n---------\n Ooip       $OoipQ MMbbl")


    end




end
