-- Libraries
Tunnel = module('vrp','lib/Tunnel')
Proxy = module('vrp','lib/Proxy')
Tools = module('vrp','lib/Tools')

-- Proxies
if IsDuplicityVersion() then
    vRP = Proxy.getInterface('vRP')
    vRPclient = Tunnel.getInterface('vRP')
    idgens = Tools.newIDGenerator()
else
    vRP = Proxy.getInterface('vRP')
    vRPserver = Tunnel.getInterface('vRP')

    drawTxt = function(text,font,x,y,scale,r,g,b,a)
        SetTextFont(font)
        SetTextScale(scale,scale)
        SetTextColour(r,g,b,a)
        SetTextOutline()
        SetTextCentre(1)
        SetTextEntry('STRING')
        AddTextComponentString(text)
        DrawText(x,y)
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

    DrawText3Ds = function(x, y, z, text)
        local onScreen, _x, _y = World3dToScreen2d(x, y, z)
        if onScreen then
            SetTextScale(0.3, 0.3)
            SetTextFont(4)
            SetTextProportional(1)
            SetTextOutline(1)
            SetTextColour(255, 255, 255, 215)
            SetTextEntry("STRING")
            SetTextCentre(1)
            AddTextComponentString(text)
            DrawText(_x, _y)
            local factor = (string.len(text)) / 370
        end
    end
end