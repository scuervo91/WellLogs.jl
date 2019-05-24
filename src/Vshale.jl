"""
Vshale(args...)

Calculate the Vshale from logs

`` Vshale=\\frac { { GR }_{ log }-{ GR }_{ Sand } }{ { GR }_{ Sh }-{ GR }_{ Sand } } ``

## Input Example

```julia
Vshale(Gr,GrSand,GrShale)
```
"""
function Vshale(Gr,GrSand,GrShale)
    Vsh=(Gr.-GrSand)./(GrShale.-GrSand)
end
