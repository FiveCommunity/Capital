local blips = {};
RegisterNetEvent('reportUser:blip', function(data)
    local id = data.id
    if (not DoesBlipExist(blips[id])) then
        blips[id] = AddBlipForCoord(data.coords)

        SetBlipScale(blips[id], (data.scale or 0.5))
		SetBlipSprite(blips[id], (data.sprite or 161))
		SetBlipColour(blips[id], (data.colour or 1))
        BeginTextCommandSetBlipName('STRING')
		AddTextComponentString(data.text)
        EndTextCommandSetBlipName(blips[id])
		SetBlipAsShortRange(blips[id], true)

        Citizen.SetTimeout((data.timeout or 30000), function()
            if (DoesBlipExist(blips[id])) then RemoveBlip(blips[id]); blips[id] = nil; end;
        end)
    end
end)