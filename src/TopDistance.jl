function TopDistance(x,y;z=false,Names=false,Show=false,PlotTitle="", Xlabel="", Ylabel="")


    if size(x,1)!=size(y,1)                       #eval if input is equal
        error("x & y must be equally sized")
    end

    n=size(x,1)  #Number of inputs
    list=1:n    #Numbered list of elements

    if z==false      #If height not provided, zero vector is created
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

p=Plots.scatter(x,y,leg=false,
                title="Distances $PlotTitle",xlabel=Xlabel,ylabel=Ylabel,
                yformatter=:auto)

p=Plots.annotate!(x,y,map(x->Plots.text(x,:left,:top,8),Names))
p=Plots.annotate!(AvrD.X,AvrD.Y,map(x->Plots.text("$x ",:left,:top,8),AvrD.Dist))

if Show==false  # If Show==false plot each distance of each well, otherwise plot distance Well choosed
    for i=1:n-1
        for j=i+1:n
        p=Plots.plot!(x[[i,j]],y[[i,j]],arrow=:arrow,linestyle=:dot,color=:black)
        end
    end
else
    for i in c
         Plots.plot!(x[[Show,i]],y[[Show,i]],arrow=:arrow,linestyle=:dot,color=:black)
    end
end

display(p)
return Distance, AvrD

end #End Function
