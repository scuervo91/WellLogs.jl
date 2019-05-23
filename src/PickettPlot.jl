@userplot pickett

@recipe function f(h::pickett;
                    a=1,m=2,n=2,      #Default values for Archie equation
                    Sw=range(0.2,stop=1,length=5),  #Default Sw range to plot
                    WellName=false)

Rt, Phie, Rw=h.args

PhieRange=range(0.01,stop=1,length=5)        #Porosity range to map Sw lines
PhieRT1=(1/Rw).^(1/-m)                       #Porosiy at Rt=1 to estimate others Sw lines
rts=map(x->(a.*Rw)/(PhieRT1 .^m .* x.^n),Sw) # Rt at Sw Range with porosity PhieRT1
ResPhie1=map(x->(x.*PhieRT1.^m)./a,rts)        # Intercept of every SW to plot each lines at Phie=1
lines=zeros(size(PhieRange,1),size(Sw,1))   #Array of zeros of lines Array
Txpos=zeros(size(Sw,1))
Typos=0.9-0.1*size(Sw,1):0.1:0.9            #Array of Saturation Text positions

j=0
for i in ResPhie1                              #Calculate Sw Lines
    j=j+1
    lines[:,j]=map(x->a.*i.*x.^-m,PhieRange)
    Txpos[j]=a.*i.*Typos[j].^-m
end

tck=map(string,round.(Sw,digits=2))


## Picket Plot

xaxis := :log
yaxis := :log
xlim :=[0.1,20000]
ylim := [0.01,1]
xminorgrid := true
yminorgrid := true
title_location := :left
xlabel := "Rt[Ohm m]"
ylabel := "Phie[]"
title --> (WellName==false ? :none : WellName)
yticks --> [0.01,0.1,1]
legend --> :bottomleft

c=range(RGB(0.0,1.0,0.0),stop=RGB(0.0,0.0,1.0),length=length(Sw))

cg=ColorGradient(c)
legendtitle := "Water Saturations[]"
xmirror := true

@series begin
    seriestype := :path
    line_z := (1:length(Sw))'
    linecolor := cg
    linewidth := 3
    lab := map(string,round.(Sw,digits=2))
    lines, PhieRange
end

@series begin
    seriestype := :scatter
    lab := "LogData"
    Rt, Phie
end


end #End Function
