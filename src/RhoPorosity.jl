function RhoPorosity(RhoLog,RhoMa,RhoF)
    phi=(RhoMa.-RhoLog)./(RhoMa.-RhoF)
end
