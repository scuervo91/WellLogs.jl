"""
Phiefec(args...)

Calculate the Efective porosity by estimating the Geometric mean to Density and neutron Porosity

`` Phie=\\sqrt { \\frac { { RhoPhi }^{ 2 }+{ NeutronPhi }^{ 2 } }{ 2 }  } \\times \\left( 1-Vshale \\right)  ``
"""
function Phiefec(RhoPorosity,NeutronPorosity,Vshale)
    phi=(((RhoPorosity.^2 .+ NeutronPorosity.^2)./2)^0.5).*(1-Vshale)
end
