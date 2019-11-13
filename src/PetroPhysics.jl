"""
PetroPhysics(args...)

Calculate basic petrophysics properties according the WellLog
It is requiered that the WellLog be a DataFrame type with the columns of the new properties already created
They can be created with the function ``AddColPetro``

The next table show the list of variables allowed:

|PropertyName|Args|Default|Input|Description
|---|---|---|---|---|
|Log|Mandatory|--|DataFrame|Well Logs dataframe file|
|DepthFrom|Mandatory| -- | Number |Set the Depth upper limit to estimate properties|
|DepthTo|Mandatory| -- | Number |  Set the Depth lower limit to estimate properties|
|Vsh|Optional|false|Vsh=[GrSand, GrShale]|Calculates the Vsh of the given interval|
|Phie|Optional|false|Phie=true|Calculates the Phie of the given interval.It is requiered Vsh, DenPhi, and Neutron Logs|
|Sw|Optional|false|Sw=[a,m,n,Rw]|Calculates the Sw of the given interval with archie parameters. It is requiered Phie and DeepRes logs|
|Perm|Optional|false|Perm=[Fluid, Author]|Calculates the Permeability of the given interval with using Author and Fluids coeficients|
|PayFlag|Optional|false|PayFlag=[VshCutoff,PhieCutOff,SwCutoff,KCutOff]|Calculates the Pay of the given interval using the CutOff specified|
|Kh|Optional|false|Kh=true|Calculates the Flow Capacity and Normalized Cumulative Flow Capacity for picking perfs of the given interval|
"""
function PetroPhysics(Log,DepthFrom,DepthTo;    #range of depth to calculate Petrophysics
                     Vsh=false,                #If caculate Vshale   [GrSand, GrShale]
                     DenPhi=false,              #If caculate Porosity from Density Log  [RhoMatrix, RhoFluid]
                     Phie=false,               #If caculate Efective Porosity. It is requiered Vsh, DenPhi, and Neutron
                     Sw=false,                 #If caculate Water Saturation. It is requiered Phie and DeepRes [a,m,n,Rw]
                     Perm=false,               #If caculate Permeability).    Phie, Sw, Fluid, Author [Fluid, Author]
                     PayFlag=false,          #If calculate PayFlag. It is requiered Vsh,Phie,Sw,Perm [VshCutoff,PhieCutOff,SwCutoff,KCutOff]
                     Kh=false,               #If requiered Flow Capacity percentage
                     DepthType= :Md)

#Get the index of the range depth
frr=findall(x->x==DepthFrom,Log[!,DepthType])
too=findall(x->x==DepthTo,Log[!,DepthType])

# convert the index from Array{Int64} to Int64
fr=frr[1]
to=too[1]

ColumnList=names(Log)

####################################################
# VSHALE
####################################################

if Vsh != false
  #Vsh[1]= GrSand
  #Vsh[2]= GrShale
    if (:Vsh in ColumnList) == false
      Log.Vsh=zeros(size(Log,1)).+1
    end

        for i=fr:to
         Log.Vsh[i]=Vshale(Log[!,Vsh[1]][i],Vsh[2],Vsh[3])
         if Log.Vsh[i]>1
            Log.Vsh[i]=1
        end
        end

end

####################################################
# DenPhi
####################################################

    if DenPhi != false
    #DenPhi[2]= RhoMatrix
    #DenPhi[3]= RhoFluid
    if (:DenPhi in ColumnList) == false

       Log.DenPhi=zeros(size(Log,1))
    end

    for i=fr:to
           Log.DenPhi[i]= RhoPorosity(Log[!,DenPhi[1]][i],DenPhi[2],DenPhi[3])
        if Log.DenPhi[i]<0
            Log.DenPhi[i]=0
        end
        end

    end
####################################################
# Phie
####################################################
    if Phie != false
        if (:Phie in ColumnList) == false
          Log.Phie=zeros(size(Log,1))
        end

        if size(Phie,1)==3
            for i=fr:to
                Log.Phie[i]=Phiefec(Log[!,Phie[1]][i],Log[!,Phie[2]][i],Log[!,Phie[3]][i])
            end
        elseif size(Phie,1)==2
            for i=fr:to
                Log.Phie[i]=Log[!,Phie[1]][i].*(1 .-Log[!,Phie[2]][i] )
            end

        end
    end
####################################################
# Sw
####################################################
    if Sw != false
     #Sw[1]=a
    #Sw[2]=m
    #Sw[3]=n
    #Sw[4]=Rw
    #Sw[5]=Phie
    #Sw[6]=DeepRes
    #Sw[7]=Shale Resistivity
    #Sw[8]=Vshale
    #Sw[9]=Method [:Archie, :Smdx, :Indo]
    if (:Sw in ColumnList) == false
      Log.Sw=zeros(size(Log,1)).+2
    end

      for i=fr:to
            try
                Log.Sw[i]=SwFunction(Sw[1],Sw[2],Sw[3],Sw[4],Log[!,Sw[5]][i],Log[!,Sw[6]][i],
                             Rsh=Sw[7],Vsh=Log[!,Sw[8]][i],α=Sw[10],Method=Sw[9])
            catch e
                Log.Sw[i]=1
            end
          if Log.Sw[i]>1
            Log.Sw[i]=1
            end
      end

    end

####################################################
# Perm
####################################################
  if Perm != false
      #Perm[1]=phi
      #Perm[2]=Sw
      #Perm[3]=Fluid "Oil" or "Gas"
      #Perm[4]=Author "Timur" or "Morris"
  if (:Perm in ColumnList) == false
    Log.Perm=zeros(size(Log,1))
  end

    for i=fr:to
     Log.Perm[i]=PermWR(Log[!,Perm[1]][i],Log[!,Sw[2]][i],Fluid=Perm[3],Author=Perm[4])
    end

  end

 ####################################################
# PayFlag
####################################################
  if PayFlag != false

 #PayFlag[1]=VshCutoff
 #PayFlag[2]=PhieCutOff
 #PayFlag[3]=SwCutoff
 #PayFlag[4]=KCutOff
 if (:PayFlag in ColumnList) == false
   Log.PayFlag=zeros(size(Log,1))
 end

    for i=fr:to
     Log.PayFlag[i]=(Log[!,PayFlag[1]][i].<=PayFlag[2]).*
            (Log[!,PayFlag[3]][i].>=PayFlag[4]).*
            (Log[!,PayFlag[5]][i].<=PayFlag[6]).*
            (Log[!,PayFlag[7]][i].>=PayFlag[8]).*1
    end

  end

 ####################################################
# Flow Capacity Kh
####################################################
  if Kh != false
      #md
      #Perm
      #Payflag
      if (:Kh in ColumnList) == false
        Log.Kh=zeros(size(Log,1))
      end

      if (:KhCum in ColumnList) == false
        Log.KhCum=zeros(size(Log,1))
      end

     KH=zeros(to-fr+2)
     KHCum=zeros(to-fr+2)
    for i=fr:to
        j=i-fr+2
        KH[j]=Log[!,Kh[2]][i].*(Log[!,Kh[1]][i].-Log[!,Kh[1]][i-1]).*Log[!,Kh[3]][i]
        Log.Kh[i]=KH[j]
        KHCum[j]=KHCum[j-1]+KH[j]
    end
     KhTotal=sum(KH)
    if KhTotal > 0
        for i=fr:to
            j=i-fr+2
            Log.KhCum[i]=1-(KHCum[j]/KhTotal)
        end
    end

  end


return Log

end
