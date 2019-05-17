@userplot iwm

@recipe function f(h::iwm; m=100, n=100, p=2, Fill=true, Color = :Spectral, Levels=false, Title=false)

    fill --> Fill
    ylabel -->"North [m]"
    xlabel -->"East [m]"
    color --> Color

    if Levels!=false
        levels:=Levels
    end

    if Title!=false
        title := title
    end

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

@series begin
    seriestype := :contour
    clabels := true
    Xrange, Yrange, Z
end
end
