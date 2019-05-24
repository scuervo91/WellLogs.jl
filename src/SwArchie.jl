"""
SwArchie(args...)

Calculate the water saturation from Archie Equation

`` { Sw }^{ n }=\\frac { a\\quad { Rw } }{ { \\Phi  }^{ m }\\quad Rt } ``

## Input Example

```julia
SwArchie(a,m,n,Rw,phi,rt)
```
"""
function SwArchie(a,m,n,Rw,phi,rt)
    Sw=((a.*Rw)./(rt.*phi^m))^(1/n)
end
