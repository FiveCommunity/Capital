-- Libraries
Tunnel = module('vrp','lib/Tunnel')
Proxy = module('vrp','lib/Proxy')
Tools = module('vrp','lib/Tools')
PolyZone = {}

-- Proxies
local _ServerSide = IsDuplicityVersion()
if (_ServerSide) then
    vRP = Proxy.getInterface('vRP')
    vRPclient = Tunnel.getInterface('vRP')
else
    vRP = Proxy.getInterface('vRP')
    vRPserver = Tunnel.getInterface('vRP')

    LoadAnim = function(Dict)
        while (not HasAnimDictLoaded(Dict)) do
            RequestAnimDict(Dict)
            Citizen.Wait(1)
        end
        return true
    end

    loadModel = function(model)
        Citizen.CreateThread(function()
            while (not HasModelLoaded(model)) do
                RequestModel(model)
                Citizen.Wait(1)
            end
        end)
    end
    
    Text3D = function(x,y,z,text,size)
        local onScreen,_x,_y = World3dToScreen2d(x,y,z)
        if onScreen then
            SetTextFont(4)
            SetTextScale(0.35,0.35)
            SetTextColour(255,255,255,155)
            SetTextEntry("STRING")
            SetTextCentre(1)
            AddTextComponentString(text)
            DrawText(_x,_y)
            local factor = (string.len(text))/size
            DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,80)
        end
    end

    Text2D = function(font, x, y, text, scale)
        SetTextFont(font)
        SetTextProportional(7)
        SetTextScale(scale, scale)
        SetTextColour(255, 255, 255, 255)
        SetTextDropShadow(0, 0, 0, 0,255)
        SetTextEdge(4, 0, 0, 0, 255)
        SetTextEntry("STRING")
        AddTextComponentString(text)
        DrawText(x, y)
    end

    DrawText3Ds = function(x, y, z, text, scale)
        local onScreen, _x, _y = World3dToScreen2d(x, y, z)
        if onScreen then
            scale = (scale or 0.25)
            SetTextScale(scale, scale)
            SetTextFont(4)
            SetTextProportional(1)
            SetTextColour(255, 255, 255, 215)
            SetTextEntry("STRING")
            SetTextCentre(1)
            AddTextComponentString(text)
            DrawText(_x, _y)
            local factor = (string.len(text)) / 370
            -- DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 41, 11, 41, 68)
        end
    end

    DrawText3D = function(coords, text)
        SetDrawOrigin(coords.x, coords.y, coords.z+0.5, 0); 
        SetTextFont(4)     
        SetTextProportional(0)     
        SetTextScale(0.35,0.35)    
        SetTextColour(255,255,255,155)   
        SetTextDropshadow(0, 0, 0, 0, 255)     
        SetTextEdge(2, 0, 0, 0, 150)     
        SetTextDropShadow()     SetTextOutline()     
        SetTextEntry("STRING")     SetTextCentre(1)     
        AddTextComponentString(text) 
        DrawText(0.0, 0.0)     
        ClearDrawOrigin() 
    end
end