"""
TopDistance(args...)

Estimate the distance between points given. Plot either distance between each point or distance with respect to specific point

``D=\\sqrt { { \\left( { X }_{ 1 }-{ X }_{ 2 } \\right)  }^{ 2 }+{ \\left( { Y }_{ 1 }-{ Y }_{ 2 } \\right)  }^{ 2 }{ +\\left( { Z }_{ 1 }-{ Z }_{ 2 } \\right)  }^{ 2 } } ``

The next table show the list of variables allowed:

|PropertyName|Args|Default|Input|Description
|---|---|---|---|---|
|x|Mandatory|--|Array{number,1}|X coordinate of points|
|y|Mandatory|--|Array{number,1}|Y coordinate of points|
|z|Optional|z=false|Array{number,1}|z coordinate of points. If not set, a zeros array is established|
|Names|Optional|Names=false|Array{String,1}|Name of each point. If not set a numbered list is created as a name|
|Show|Optional|Show=false|Show=Number|Refers to a numbered point which distance between other points and this are shown <br> if not set, all distances are shown|
"""
@userplot topdistance

@recipe function f(h::topdistance;
            Names=false,Show=false)

    if length(h.args)==2
        x, y = h.args
    elseif length(h.args)==3
        x, y, z = h.args
    end

    n=size(x,1)  #Number of inputs
    list=1:n    #Numbered list of elements

    if length(h.args)==2      #If height not provided, zero vector is created
        z=zeros(n)
    end

    if Names==false  #If names are not provided, it is created a numbered list
        Names=1:n
    end

        WellSym=map(x->Symbol(x),Names)     #DataFrame COlumns Name
        Distance=DataFrame()

        for i=1:n
            Distance[WellSym[i]]=zeros(n)
            for j=1:n
              Distance[WellSym[i]][j]=sqrt( (x[i]-x[j])^2  + (y[i]-y[j])^2 + (z[i]-z[j])^2)
            end
        end

    if Show==false                         # If Show==false plot each distance of each well, otherwise plot distance Well choosed
        m=binomial(n,2)
        AvrD=DataFrame(X=zeros(m),Y=zeros(m),Dist=zeros(m))
        k=0
           for i=1:n-1
               for j=i+1:n
                k=k+1
                AvrD.X[k]=mean([x[i],x[j]])
                AvrD.Y[k]=mean([y[i],y[j]])
                AvrD.Dist[k]=round(Distance[i,j],digits=2)
                end
            end

    else
        m=n-1
        AvrD=DataFrame(X=zeros(m),Y=zeros(m),Dist=zeros(m))
        c=list[list.!=Show]
        k=0

        for i in c
            k=k+1
            AvrD.X[k]=mean([x[Show],x[i]])
            AvrD.Y[k]=mean([y[Show],y[i]])
            AvrD.Dist[k]=round(Distance[Show,i],digits=2)
        end
    end

# Plot the Distances


@series begin
    seriestype := :scatter
    seriescolor := :black
    series_annotations := map(x->Plots.text(x,:left,:top,13),Names)
    x, y
end
#
@series begin
        seriestype := :scatter
        seriescolor := :white
        series_annotations := map(x->Plots.text(x ,:right,:top,8),AvrD.Dist)
        AvrD.X,AvrD.Y
end


    ## Plot properties for union lines
    seriestype := :path
    linestyle := :dot
    arrow := Plots.arrow(:open, :both )
    seriescolor := :black
    legend := false


if Show==false  # If Show==false plot each distance of each well, otherwise plot distance Well choosed
    for i=1:n-1
        for j=i+1:n

            @series begin
                        x[[i,j]],y[[i,j]]
                    end
        end
    end
else
    for i in c
                     @series begin
                        x[[Show,i]],y[[Show,i]]
                    end
    end


end

end
