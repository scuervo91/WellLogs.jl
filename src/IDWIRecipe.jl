"""
idwi(args...)  -->Plot

iwm is a Plot Recipe in which makes a spatial interpolation of data provided applying Inverse Weight Mapping.


General equation for spatial interpolation is:
``{ Z }^{ * }=\\sum _{ i=1 }^{ n }{ { \\lambda  }_{ i }{ z }_{ i } } ``

where ``\\lambda`` is the weight Parameter

Applying the Inverse‐Distance Weighted Interpolation

``{ Z }\\left( x \\right) =\\frac { \\sum _{ i=1 }^{ n }{ { w }_{ i }{ z }_{ i } }  }{ \\sum _{ i=1 }^{ n }{ { z }_{ i } }  } \\\\ \\\\ { w }_{ i }=\\frac { 1 }{ { d }_{ i }^{ n } } ``

<br> The next table show the list of variables allowed:

|PropertyName|Args|Default|Input|Description
|---|---|---|---|---|
|x|Mandatory|--|Array{Number,1}| X values|
|y|Mandatory|--|Array{Number,1}| Y values|
|z|Mandatory|--|Array{Number,1}| Z values|
|m|Optional|m=100|m=number| Number of grids in y axis|
|n|Optional|n=100|n=number| Number of grids in x axis|
|p|Optional|p=2|p=number| IDWI exponent. The greater more influenced by near points|
"""
@userplot idwi

@recipe function f(h::idwi; m=100, n=100, p=2, surf=false)


    ylabel --> "North [m]"
    xlabel --> "East [m]"
    seriescolor --> :Spectral

x, y, z = h.args

# Build the grid of prediction points

    ## X & Y range
  Xrange=range(minimum(x),stop=maximum(x),length=n)
  Yrange=range(minimum(y),stop=maximum(y),length=m)



    ## X & Y grids
  X=repeat(Xrange',length(Yrange),1)
  Y=repeat(Yrange,1,length(Xrange))

    # X & Y grids converted to vectors
    Xvec=vec(X)
    Yvec=vec(Y)

    #Number of Sample Points and Prediction Points
    Nsp=length(x)                           #Numbers of Sample Points
    Npp=length(Xrange)*length(Yrange)       #Number of Prediction Points



    #DISTANCE BETWEEN PREDICTION AND SAMPLE POINTS---------------------------
    #Matrix of distance   I x J    Sample Points x Prediction Points

    d=zeros(Nsp,Npp)
    for i=1:Nsp
        for j=1:Npp
            d[i,j]=sqrt((x[i]-Xvec[j]).^2+(y[i]-Yvec[j]).^2)
        end
    end


    #Estimate the matrix of weights

    W=map(dis->(1 ./(dis.^p)),d)

    #Calculate value in prediction point in a vector

    Zvec=zeros(Npp)
    for i=1:Npp
        Zvec[i]=W[:,i]'*z ./ sum(W[:,i])
    end

    Z=reshape(Zvec,m,n)

#Coutour series
if surf==true
    @series begin
        seriestype := :surface
        zflip := true
        Xrange, Yrange, Z
        end
else
@series begin
    seriestype := :contour
    clabels := true
    fill --> true

    Xrange, Yrange, Z
end
end
end
