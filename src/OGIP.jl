"""
OGIP(args...)

Calcute the Original Gas In Place either Deterministic or Probabilistic

``OGIP=\\frac { 4.356\\times { 10 }^{ -5 }\\quad A\\quad h\\quad Phi\\quad (1-Sw) }{ Bg } `` in Bscf or MMMscfd
<br> Bg can be supplied or be calculated with a Pressure, Temperature in °F and Z
<br>``Bg=\\frac { 0.02827\\quad z\\quad T }{ P } `` in ft3/scf. From Tarek Ahmed Reservoir Handbook 4ed pg 66
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
    OGIP(Area=600,Height=30,Phi=0.3,Sw=0.3, Temp=180, Pres=2800, z=0.99,PhiDist=Normal(0.18,0.03), SwDist=Normal(0.3,0.05))

    Original Gas In Place Probabilistic Results
    Area = 600 Acre
    Height= 30 ft
    Bg= 0.006393798639642858 ft3|scf
    Percentiles [0.1, 0.5, 0.9]
    Phi       [0.141553, 0.18, 0.218447]
    Sw       [0.235922, 0.3, 0.364078]
    ---------
    OGIP=      [12.1409, 15.4248, 19.1437] Bscf
```
Number of samples n can be set. Default n=1000
<br>Percentiles can be set. Default Perc=[0.1,0.5,0.9]
<br> A plot can be display by setting DistHist=true. Default DisHist=false
"""
function OGIP(;Area=640,Height=1,Phi=0, Sw=0, Bg=false,
                Pres=0, Temp=0, z=0,
                PhiDist=Normal(), SwDist=Normal(), n=1000,
                DisHist=false,
                Perc=[0.1,0.5,0.9],
                Fsize=[7,7])

          #When is only a well for the analysis the area is ussually difined as 640 acres
     #https://www.spec2000.net/16-ooip.htm

    if Bg==false
        TempR=459.67+Temp
        Bg=0.02827*z*TempR/Pres
    end

    if PhiDist==Normal() && SwDist==Normal()
        Ogip=0.000043560*Area*Height*Phi*(1-Sw)/Bg
        println("Original Gas In Place Deterministic Results \n Area = $Area Acre \n Height= $Height ft \n Phi= $Phi \n Sw= $Sw \n Bg= $Bg ft3|scf \n---------\n OGIP=$Ogip Bscf")
    elseif PhiDist!=Normal() && SwDist!=Normal()
        PhiSample=rand(Truncated(PhiDist,0,1),n)
        SwSample=rand(Truncated(SwDist,0,1),n)
        Ogip=map((x,y)->0.000043560*Area*Height*x*(1-y)/Bg,PhiSample,SwSample)
        if DisHist!=false

        fig=subplots(2,2,figsize=Fsize)
        subplot(211)
        PropDist(Ogip,PropName="Original Gas In Place [Bscf]",DisHist=true,HistColor="darkred")
        subplot(223)
        PropDist(PhiSample,PropName="Porosity",DisHist=true,HistColor="darkgreen")
        subplot(224)
        PropDist(SwSample,PropName="Water Saturation",DisHist=true,HistColor="darkblue")
        subplots_adjust(hspace=0.5)
            end
            PhiQ=quantile.(Truncated(PhiDist,0,1),Perc)
            SwQ=quantile.(Truncated(SwDist,0,1),Perc)
        OgipQ=quantile!(Ogip,Perc)

        println("Original Gas In Place Probabilistic Results \n Area = $Area Acre \n Height= $Height ft \n Bg= $Bg ft3|scf \n Percentiles $Perc \n Phi       $PhiQ \n Sw       $SwQ \n --------- \n OGIP=      $OgipQ Bscf")

    elseif PhiDist!=Normal()
        PhiSample=rand(Truncated(PhiDist,0,1),n)
        Ogip=map(x->0.000043560*Area*Height*x*(1-Sw)/Bg,PhiSample)

        if DisHist!=false

        fig=subplots(2,1,figsize=(5,5))
        subplot(211)
        PropDist(Ogip,PropName="Original Gas In Place [Bscf]",DisHist=true,HistColor="darkred")
        subplot(212)
        PropDist(PhiSample,PropName="Porosity",DisHist=true,HistColor="darkgreen")
        subplots_adjust(hspace=0.5)
            end
        PhiQ=quantile.(Truncated(PhiDist,0,1),Perc)
        OgipQ=quantile!(Ogip,Perc)

println("Original Gas In Place Probabilistic Results \n Area = $Area Acre \n Height= $Height ft \n Bg= $Bg ft3|scf \n Sw= $Sw \n Percentiles $Perc \n Phi       $PhiQ \n---------\n OGIP       $OgipQ Bscf")

    else
        SwSample=rand(Truncated(SwDist,0,1),n)
        Ogip=map(x->0.000043560*Area*Height*Phi*(1-x)/Bg,SwSample)

                if DisHist!=false

        fig=subplots(2,1,figsize=(5,5))
        subplot(211)
        PropDist(Ogip,PropName="Original Gas In Place [Bscf]",DisHist=true,HistColor="darkred")
        subplot(212)
        PropDist(SwSample,PropName="Water Saturation",DisHist=true,HistColor="darkblue")
        subplots_adjust(hspace=0.5)
            end
        SwQ=quantile.(Truncated(SwDist,0,1),Perc)
        OgipQ=quantile!(Ogip,Perc)

println("Original Gas In Place Probabilistic Results \n Area = $Area Acre \n Height= $Height ft \n Bg= $Bg ft3|scf \n Phi= $Phi \n \n Percentiles $Perc \n Sw       $SwQ \n---------\n OGIP       $OgipQ Bscf")


    end




end
