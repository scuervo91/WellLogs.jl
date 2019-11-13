function FormationsTrack(Depth,WellUnit;DepthFrom=minimum(Depth),DepthTo=maximum(Depth),
                        FmC1=RGB(0.0,0.0,1.0), FmC2=RGB(1.0,0.0,0.0), FmAlpha=0.7)

    ax=gca()                       #If Units are Provided
    ntop=size(WellUnit,1)
    if ntop==1
            zcolor=range(FmC1, stop=FmC2, length=2)
        else
            zcolor=range(FmC1, stop=FmC2, length=ntop)
    end
    zcols = map(col -> (red(col), green(col), blue(col)), zcolor)

    for i=1:ntop
        ax.axhspan(WellUnit[i,1],WellUnit[i,2],xmin=0,xmax=1,alpha=FmAlpha,color=zcols[i])
        ax.hlines([WellUnit[i,1],WellUnit[i,2]],0,1, linewidth=0.5)
    end
    setp(ax.get_yticklabels(),visible=false)
    setp(ax.get_xticklabels(),visible=false)
    ax.set_ylim([DepthTo,DepthFrom])
end
