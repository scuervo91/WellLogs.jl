"""
Sw(args...)

Calculate the water saturation

`` { Sw }^{ n }=\\frac { a\\quad { Rw } }{ { \\Phi  }^{ m }\\quad Rt } ``

## Input Example

```julia
SwArchie(a,m,n,Rw,phi,rt)
```
"""
function SwFunction(a,m,n,Rw,phi,rt;Rsh=4.0,Vsh=0,α=0.3,Method="Archie")

    if Method == "Archie"
        Sw=((a.*Rw)./(rt.*phi.^m)).^(1/n)
    elseif Method == :Smdx #https://www.spec2000.net/14-sws.htm

            C=((1 .-Vsh).*a.*Rw)./(phi.^m)
            D=C.*Vsh./(2 .* Rsh)
            E=C./rt
            Sw=((D.^2 .+ E).^0.5 .- D).^(2 ./n)
    elseif Method == "Indo"
       A=(1 ./rt).^0.5
       B=(Vsh.^(1 .-(Vsh./2)))/(Rsh.^0.5)
       C=((phi.^m)./(a*Rw)).^0.5
       Sw=(A./(B+C)).^(2 ./n)
   elseif Method == "Fertl"
       A=phi.^(-m./2)
       B=(a.*Rw)./rt
       C=((α.*Vsh)./2).^2
       D=(α.*Vsh)./2
       Sw=A.*(((B.+C).^0.5)-D)
   end

    return Sw
end
