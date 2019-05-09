function OGIP(;Area=640,Height=1,Phi=0, Sw=0, Bg=false,
                Pres=0, Temp=0, z=0,
                PhiDist=Normal(), SwDist=Normal(), n=1000,
                DisHist=false,
                Quant=[0.1,0.5,0.9])

          #When is only a well for the analysis the area is ussually difined as 640 acres
     #https://www.spec2000.net/16-ooip.htm

    if Bg==false
        Bg=0.02827*z*Temp/Pres
    end

    if PhiDist==Normal() && SwDist==Normal()
        Ogip=0.000043560*Area*Height*Phi*(1-Sw)/Bg
        println("Original Gas In Place Deterministic Results \n Area = $Area Acre \n Height= $Height ft \n Phi= $Phi \n Sw= $Sw \n Bg= $Bg ft3|scf \n---------\n OGIP=$Ogip Bscf")
    elseif PhiDist!=Normal() && SwDist!=Normal()
        PhiSample=rand(Truncated(PhiDist,0,1),n)
        SwSample=rand(Truncated(SwDist,0,1),n)
        Ogip=map((x,y)->0.000043560*Area*Height*x*(1-y)/Bg,PhiSample,SwSample)
        if DisHist!=false

        fig=subplots(2,2,figsize=(5,5))
        subplot(112)
        PropDist(Ogip,PropName="Original Gas In Place",DisHist=true,HistColor="darkred")
        subplot(221)
        PropDist(PhiSample,PropName="Porosity",DisHist=true,HistColor="darkgreen")
        subplot(222)
        PropDist(SwSample,PropName="Water Saturation",DisHist=true,HistColor="darkblue")
            end
        PhiQ=quantile.(PhiDist,Quant)
        SwQ=quantile.(SwDist,Quant)
        OgipQ=quantile!(Ogip,Quant)

        println("Original Gas In Place Probabilistic Results \n Area = $Area Acre \n Height= $Height ft \n Bg= $Bg ft3|scf \n  Quantiles $Quant \n Phi       $PhiQ \n Sw       $SwQ \n --------- \n OGIP=      $OgipQ ")

    elseif PhiDist!=Normal()
        PhiSample=rand(Truncated(PhiDist,0,1),n)
        Ogip=map(x->0.000043560*Area*Height*x*(1-Sw)/Bg,PhiSample)

        if DisHist!=false

        fig=subplots(2,1,figsize=(5,5))
        subplot(211)
        PropDist(Ogip,PropName="Original Gas In Place",DisHist=true,HistColor="darkred")
        subplot(212)
        PropDist(PhiSample,PropName="Porosity",DisHist=true,HistColor="darkgreen")
            end
        PhiQ=quantile.(PhiDist,Quant)
        OgipQ=quantile!(Ogip,Quant)

println("Original Gas In Place Probabilistic Results \n Area = $Area Acre \n Height= $Height ft \n Bg= $Bg ft3|scf \n Sw= $Sw \n  Quantiles $Quant \n Phi       $PhiQ \n---------\n OGIP       $OgipQ")

    else
        SwSample=rand(Truncated(SwDist,0,1),n)
        Ogip=map(x->0.000043560*Area*Height*Phi*(1-x)/Bg,SwSample)

                if DisHist!=false

        fig=subplots(2,1,figsize=(5,5))
        subplot(211)
        PropDist(Ogip,PropName="Original Gas In Place",DisHist=true,HistColor="darkred")
        subplot(212)
        PropDist(SwSample,PropName="Water Saturation",DisHist=true,HistColor="darkblue")
            end
        SwQ=quantile.(SwDist,Quant)
        OgipQ=quantile!(Ogip,Quant)

println("Original Gas In Place Probabilistic Results \n Area = $Area Acre \n Height= $Height ft \n Bg= $Bg ft3|scf \n Phi= $Phi \n \n Quantiles $Quant \n Sw       $SwQ \n---------\n OGIP       $OgipQ")


    end




end
