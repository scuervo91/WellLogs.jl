function PickettPlot(Rt,Phie,Rw;      #Must provide Rt, Phie and Rw
                    a=1,m=2,n=2,      #Default values for Archie equation
                    Sw=range(0.2,stop=1,length=5),  #Default Sw range to plot
                    WellName="-")

PhieRange=range(0.01,stop=1,length=5)        #Porosity range to map Sw lines
PhieRT1=(1/Rw).^(1/-m)                       #Porosiy at Rt=1 to estimate others Sw lines
rts=map(x->(a.*Rw)/(PhieRT1 .^m .* x.^n),Sw) # Rt at Sw Range with porosity PhieRT1
ResPhie1=map(x->(x.*PhieRT1.^m)./a,rts)        # Intercept of every SW to plot each lines at Phie=1
lines=zeros(size(PhieRange,1),size(Sw,1))   #Array of zeros of lines Array
Txpos=zeros(size(Sw,1))
Typos=0.9-0.1*size(Sw,1):0.1:0.9
j=0

for i in ResPhie1                              #Calculate Sw Lines
    j=j+1
    lines[:,j]=map(x->a.*i.*x.^-m,PhieRange)
    Txpos[j]=a.*i.*Typos[j].^-m
end

tck=map(string,round.(Sw,digits=2))


## Picket Plot
p1=Plots.plot(lines,PhieRange,xaxis=:log,yaxis=:log,ylim=[0.01,1], xlim=[0.1,10000],
              xminorgrid=true,yminorgrid=true,title_location=:left,
              xlabel="Rt[Ohm m]", ylabel="Phie[]",formatter = identity,title="PicketPlot $WellName",
              yticks=[0.01,0.1,1],legend=:bottomleft,lab=map(string,round.(Sw,digits=2)),
              legendtitle="Water Saturations",seriescolor=:grays,xmirror=true)
p1=Plots.scatter!(Rt,Phie,color=:black,lab="LogData")
p1=Plots.annotate!([(Txpos,Typos,tck,6)])

end #End Function
