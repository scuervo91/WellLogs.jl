function PermWR(Phie,Swir;Fluid="Oil",Author="Timur")
    #https://www.spec2000.net/15-permwyllie.htm

    if (Author=="Timur")
        Dperm=4.4
        Eperm=2.0

        if (Fluid=="Oil")
         Cperm=3400
        elseif (Fluid=="Gas")
            Cperm=340
        end

    elseif (Author=="Morris")
        Dperm=6.0
        Eperm=2.0
           if (Fluid=="Oil")
         Cperm=65000
         elseif (Fluid=="Gas")
            Cperm=6500
        end

        end

    k=Cperm .* (Phie .^ Dperm) ./ (Swir .^ Eperm)
end
