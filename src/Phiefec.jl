function Phiefec(RhoPorosity,NeutronPorosity,Vshale)
    phi=(((RhoPorosity.^2 .+ NeutronPorosity.^2)./2)^0.5).*(1-Vshale)
end
