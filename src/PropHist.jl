"""
PropDist(args...)--> UnivariateDistribution

Fit the given data to a specific statistical distribution
Distributions.jl package is used to fit

The next table show the list of variables allowed:

|PropertyName|Args|Default|Input|Description
|---|---|---|---|---|
|Prop|Mandatory|--|Array{Number,1}| Data to fit|
|Distr|Mandatory|--|Distr=Distribution|Distribution to fit the data given|
"""
@userplot prophist

@recipe function f(h::prophist)

    x, d=h.args


    MinProp=minimum(x)
    MaxProp=maximum(x)
    PropRange=range(MinProp,stop=MaxProp,length=100)
    DisProp=Distributions.fit(d, x[:]*1)
    DisParam=params(DisProp)
    FitProp=pdf.(DisProp, PropRange);
    Quant=quantile.(DisProp,[0.1,0.5,0.9])

@series begin
        seriestype := :histogram
        normalize := true
        bins := bins=round(Int,sqrt(size(x,1)))
        seriescolor --> :red
        label --> "Histogram"
        x
    end

@series begin
        seriestype := :path
        linestyle := :dash
        linewidth := 3
        linecolor --> :black
        label --> "Probabilitic Distribution Fitted"
        PropRange, FitProp

 end
println("Percentiles 10% - %50 - 90% \n         $Quant ")
end
