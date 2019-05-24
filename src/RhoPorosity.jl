"""
RhoPorosity(args...)

Calculate the porosity from density log

`` { \\phi  }_{ \\rho  }=\\frac { { \\rho  }_{ ma }-{ \\rho  }_{ log } }{ { \\rho  }_{ ma }-{ \\rho  }_{ Fluid } } ``

## Input Example

```julia
RhoPorosity(RhoLog,RhoMa,RhoF)
```
"""
function RhoPorosity(RhoLog,RhoMa,RhoF)
    phi=(RhoMa.-RhoLog)./(RhoMa.-RhoF)
end
