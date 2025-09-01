interactionVerification = function(ply)
    if (GetEntityHealth(ply) <= 100 or IsPedInAnyVehicle(ply) or exports.hud:isWanted(true)) then
        return false
    end 
    return true
end

insideHome = function() return currentHome.inside, currentHome.name; end;
exports('insideHome', insideHome)

DrawMarker3D = function(coords, text)
    SetDrawOrigin(coords.x, coords.y, coords.z, 0); 
    SetTextFont(4)     
    SetTextProportional(0)     
    SetTextScale(0.35,0.35)    
    SetTextColour(255,255,255,255)   
    SetTextDropshadow(0, 0, 0, 0, 255)     
    SetTextEdge(2, 0, 0, 0, 150)     
    SetTextDropShadow()     SetTextOutline()     
    SetTextEntry("STRING")     SetTextCentre(1)     
    AddTextComponentString(text) 
    DrawText(0.0, 0.0)     
    ClearDrawOrigin() 
end

drawTxt = function(text, font, x, y, scale, r, g, b, a)
    SetTextFont(font)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextOutline()
    SetTextCentre(1)
    SetTextEntry('STRING')
    AddTextComponentString(text)
    DrawText(x, y)
end