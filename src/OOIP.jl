function OOIP(;Area=640,Height=1,Phi=0, Sw=0, Bo=0,
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
