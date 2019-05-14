function InverseWeightMap(x,y,z;
                          m=100,n=100,  #Grid Dimension for Prediction Points
                          p=2,          #Inverse Weight exponent Parameter
                          PlotMap=false) #Choose how to plot the map, "Surface", "Contour" , "SurfCon" )
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

    W=map(dis->(1 ./(dis.^2)),d)

    #Calculate value in prediction point in a vector

    Zvec=zeros(Npp)
    for i=1:Npp
        Zvec[i]=W[:,i]'*z ./ sum(W[:,i])
    end

    Z=reshape(Zvec,m,n)

clr = matplotlib.colors.LinearSegmentedColormap.from_list("", ["red","violet","blue"])

    if PlotMap=="Surface"

         fig = subplots(1,1)
         ax=gca(projection="3d")
         ax.plot_surface(X,Y,Z,cmap=clr)
         ax.set_zlim(maximum(z),minimum(z))
         ax.scatter(x,y,z)

    elseif PlotMap=="Contour"

         fig = subplots(1,1)
         ax=gca()
         ax.contourf(X,Y,Z,cmap=clr)

    end

    #return Z

end
