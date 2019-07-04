"""
AddColPetro(args...)  -->DataFrames

It adds specified colums to a given DataFrames

<br> The next table show the list of variables allowed:

|PropertyName|Args|Default|Input|Description
|---|---|---|---|---|
|Log|Mandatory|--|DataFrame|This is the entire WellLog|
|DenPhi|Opcional|false|DenPhi=Bool|Adds a Porosity from density column to Log DataFramed called DenPhi|
|Phie|Opcional|false|Phie=Bool|Adds a Effective porosity column to Log DataFramed called Phie|
|Sw|Opcional|false|Sw=Bool|Adds a Water Saturarion column to Log DataFramed called Sw|
|Perm|Opcional|false|Perm=Bool|Adds a Permeability column to Log DataFramed called Perm|
|PayFlag|Opcional|false|PayFlag=Bool|Adds a Pay column to Log DataFramed called PayFlag|
|Kh|Opcional|false|Kh=Bool|Adds a Flow Capacity column to Log DataFramed called Sw|
|All|Opcional|false|All=Bool|Adds all of column listed above|
"""
function AddColPetro(Log;Vsh=false,
                     DenPhi=false,
                     Phie=false,
                     Sw=false,
                     Perm=false,
                     PayFlag=false,
                     Kh=false,
                     All=false)

    if All==true
       Log.Vsh=zeros(size(Log,1))
       Log.Phie=zeros(size(Log,1))
       Log.Sw=zeros(size(Log,1))
       Log.Perm=zeros(size(Log,1))
       Log.PayFlag=zeros(size(Log,1))
       Log.Kh=zeros(size(Log,1))
       Log.KhCum=zeros(size(Log,1))
       Log.DenPhi=zeros(size(Log,1))
    else

        if Vsh==true
        Log.Vsh=zeros(size(Log,1))
        end

        if Phie==true
        Log.Phie=zeros(size(Log,1))
        end

        if Sw==true
        Log.Sw=zeros(size(Log,1))
        end

        if Perm==true
        Log.Perm=zeros(size(Log,1))
        end

        if PayFlag==true
        Log.PayFlag=zeros(size(Log,1))
        end

        if Kh==true
        Log.Kh=zeros(size(Log,1))
        Log.KhCum=zeros(size(Log,1))
        end

        if DenPhi==true
        Log.DenPhi=zeros(size(Log,1))
        end
    end

    return Log
end
