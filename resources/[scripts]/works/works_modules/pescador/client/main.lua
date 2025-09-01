cPESC = {}
Tunnel.bindInterface(GetCurrentResourceName()..':pescador', cPESC)

local blips = { radius = {}, coords = {} }

local createAreas = function()
    for k, v in pairs(Pescador.areas) do
        blips.coords[k] = AddBlipForCoord(v.cds.x, v.cds.y, v.cds.z)

        SetBlipSprite(blips.coords[k], 68)
        SetBlipScale(blips.coords[k], 0.4)
        SetBlipColour(blips.coords[k], 0)
        SetBlipAsShortRange(blips.coords[k], true)

        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString('Área de Pesca')
        EndTextCommandSetBlipName(blips.coords[k])

        blips.radius[k] = AddBlipForRadius(v.cds.x, v.cds.y, v.cds.z, v.r)
        SetBlipColour(blips.radius[k], 13)
        SetBlipAlpha(blips.radius[k], 150)
    end
end

local deleteAreas = function()
    for i = 1, #blips.radius do RemoveBlip(blips.radius[i]); end;
    for i = 1, #blips.coords do RemoveBlip(blips.coords[i]); end;

    blips.radius = {}
    blips.coords = {}
end

cPESC.nearest = function()
    if (inWork == 'Pescador') then
        local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(ped)
        for _, v in pairs(Pescador.areas) do
            local dist = #(pedCoords - v.cds)
            if (dist <= v.r) then
                return true
            end
        end
    end
    return false
end

RegisterJob({
    name = 'Pescador',
    business = 'Boat House',
    payment = 'Itens',
    routes = 0,
    description = 'Pesque os peixes e traga alimento para os cidadãos.',
    url = 'img/pescador.png',

    start = function()
        if (not inWork) then
            inWork = 'Pescador';

            createAreas()
            TriggerEvent('notify', 'importante', 'Pescador', 'Você entrou em <b>serviço</b>! Adicionamos no seu <b>GPS</b> áreas de pesca.<br><br>Pressione <b>F7</b> para sair do serviço.', 8000)
        end
    end,

    stop = function()
        inWork = false
        deleteAreas()
        TriggerEvent('notify', 'importante', 'Pescador', 'Você saiu de <b>serviço</b>!', 8000)
    end
})