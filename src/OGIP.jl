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
