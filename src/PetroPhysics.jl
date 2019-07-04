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
                     Kh=false   )            #If requiered Flow Capacity percentage

#Get the index of the range depth
frr=findall(x->x==DepthFrom,Log.Md)
too=findall(x->x==DepthTo,Log.Md)

# convert the index from Array{Int64} to Int64
fr=frr[1]
to=too[1]


####################################################
# VSHALE
####################################################

if Vsh != false
  #Vsh[1]= GrSand
  #Vsh[2]= GrShale

        for i=fr:to
         Log.Vsh[i]=Vshale(Log.GammaRay[i],Vsh[1],Vsh[2])
         if Log.Vsh[i]>1
            Log.Vsh[i]=1
        end
        end

end

####################################################
# DenPhi
####################################################

    if DenPhi != false
    #DenPhi[1]= RhoMatrix
    #DenPhi[2]= RhoFluid


    for i=fr:to
           Log.DenPhi[i]= RhoPorosity(Log.Density[i],DenPhi[1],DenPhi[2])
        if Log.DenPhi[i]<0
            Log.DenPhi[i]=0
        end
        end

    end
####################################################
# Phie
####################################################
    if Phie != false


         for i=fr:to
        Log.Phie[i]=Phiefec(Log.DenPhi[i],Log.NeutronSand[i],Log.Vsh[i])
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


      for i=fr:to
        Log.Sw[i]=SwArchie(Sw[1],Sw[2],Sw[3],Sw[4],Sw[5][i],Sw[6][i])
          if Log.Sw[i]>1
            Log.Sw[i]=1
            end
      end

    end

####################################################
# Perm
####################################################
  if Perm != false
  #Perm[1]=Fluid "Oil" or "Gas"
  #Perm[2]=Author "Timur" or "Morris"

    for i=fr:to
     Log.Perm[i]=PermWR(Log.Phie[i],Log.Sw[i],Fluid=Perm[1],Author=Perm[2])
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

    for i=fr:to
     Log.PayFlag[i]=(Log.Vsh[i].<PayFlag[1]).*
            (Log.Phie[i].>PayFlag[2]).*
            (Log.Sw[i].<PayFlag[3]).*
            (Log.Perm[i].>=PayFlag[4]).*1
    end

  end

 ####################################################
# Flow Capacity Kh
####################################################
  if Kh != false

     Kh=zeros(to-fr+2)
     KhCum=zeros(to-fr+2)
    for i=fr:to
        j=i-fr+2
        Kh[j]=Log.Perm[i].*(Log.Md[i]-Log.Md[i-1]).*Log.PayFlag[i];
        Log.Kh[i]=Kh[j]
        KhCum[j]=KhCum[j-1]+Kh[j]
    end
     KhTotal=sum(Kh)
    for i=fr:to
        j=i-fr+2
        Log.KhCum[i]=1-(KhCum[j]/KhTotal)
    end


  end


return Log

end
