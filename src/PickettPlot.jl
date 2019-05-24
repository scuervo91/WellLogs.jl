"""
pickett(args...)

pickett is plot recipe which plots the Pickett Plot for Water Saturation

Picket Plot is a graphical representation of the Archie Equation for estimating Sw

by rearranging the Archie equation

``{ Sw }^{ n }=\\frac { a\\quad { Rw } }{ { \\Phi  }^{ m }\\quad Rt } \\\\ \\\\ nLog\\left( Sw \\right) =Log\\left( a\\quad Rw \\right) -mLog\\left( \\phi  \\right) -Log(Rt)\\\\ \\\\ When\\quad Sw=1\\\\ \\\\ Log\\left( Rt \\right) =-mLog\\left( \\phi  \\right) +Log\\left( a\\quad Rw \\right)  ``

Where a plot of scale Log-Log produces a straight line representing Sw=1 with a slope of ``-m`` and intercept at Phi=100% of ``a*Rw``

Then, the desired Sw lines are plotted together with Rt and Phie from Logs.

The next table show the list of variables allowed:

|PropertyName|Args|Default|Input|Description
|---|---|---|---|---|
|Rt|Mandatory|--|Array{Number,1}|Deep resistivity from Logs|
|Phie|Mandatory|--|Array{Number,1}|Effective Porosity from Logs|
|a|Optional|a=1|a=Number|a constant from archie Equation|
|m|Optional|m=2|a=Number|m cementation constant from archie Equation|
|n|Optional|n=2|a=Number|n exponent from archie Equation|
|Sw|Optional|Sw=range(0.2,stop=1,length=5)|Sw=range(Initial Sw,stop=Final Sw,length=Number)|Range of Sw lines|
|WellName|Optional|WellName=false|WellName="string"|Plot name|
"""
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
