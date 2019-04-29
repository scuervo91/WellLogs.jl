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
