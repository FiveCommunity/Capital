cli = {}
Tunnel.bindInterface(GetCurrentResourceName(), cli)
vSERVER = Tunnel.getInterface(GetCurrentResourceName())

local configBank = config.bank
local configGeneral = config.general

local propCaixas = {
    "prop_atm_01",
    "prop_atm_02",
    "prop_atm_03",
    "prop_fleeca_atm"
}

Citizen.CreateThread(function()
    addBlips()
    StopScreenEffect('MenuMGSelectionIn')

    exports["target"]:RemoveTargetModel(propCaixas, "Caixa Eletrônico")
	exports["target"]:AddTargetModel(propCaixas, { options = { { icon = "fas fa-wallet", label = "Caixa Eletrônico", distance = 1.5, action = function(e) openBank(); end } }})

    for _, v in pairs(configBank) do
        TriggerEvent('insert:hoverfy', v.coord, 'E', 'Interagir', 2.0)
    end
end)

local checkDistance = function()
    local pCoord = GetEntityCoords(PlayerPedId())
    for index, v in pairs(configBank) do
        local distance = #(pCoord - v.coord)
        if (distance <= 2.0) then
            return index
        end
    end
    return false
end

RegisterCommand('+openBank', function()
    local index = checkDistance()
    if (configBank[index]) then openBank(configBank[index]); end;
end)
RegisterKeyMapping('+openBank', 'Abrir o Banco', 'keyboard', 'E')

openBank = function(config)
    if config and config.perm and (not vSERVER.checkPermission(config.perm)) then
        return
    end
    local carteira, banco, nome = vSERVER.playerInfo()
    LocalPlayer.state.Hud = false
    StartScreenEffect('MenuMGSelectionIn', 0, true)
    SetNuiFocus(true, true)
    SendNUIMessage({
        type = 'show',
        nome = nome,
        bank = banco,
        money = carteira,
        key_pix = vSERVER.getPix(),
        rendimentos = vSERVER.getRendimento()
    })
end

RegisterNetEvent('open:bank', function()
    local carteira, banco, nome = vSERVER.playerInfo()
    LocalPlayer.state.Hud = false
    StartScreenEffect('MenuMGSelectionIn', 0, true)
    SetNuiFocus(true, true)
    SendNUIMessage({
        type = 'show',
        nome = nome,
        bank = banco,
        money = carteira,
        key_pix = vSERVER.getPix(),
        rendimentos = vSERVER.getRendimento()
    })
end)

RegisterNUICallback('ws:update_key', function(data, cb)
    local key = vSERVER.getPix()
    if (key) then cb({ chave = key }) end
end)

RegisterNUICallback('register_pix',function(data, cb)
    local key = data.key if (key) then vSERVER.createPix(key:upper()) end
end)

RegisterNUICallback('edit_pix',function(data, cb)
    local key = data.key if (key) then vSERVER.editPix(key:upper()) end
end)

RegisterNUICallback('remove_pix',function(data, cb)
    vSERVER.removePix()
end)

RegisterNUICallback('ws:sacar',function(data, cb)
    local value = tonumber(data.value)
    if (value ~= nil and value > 0) then vSERVER.sacar(value); end;
end)

RegisterNUICallback('ws:depositar',function(data, cb)
    local value = tonumber(data.value)
    if (value ~= nil and value > 0) then vSERVER.depositar(value); end;
end)

RegisterNUICallback('ws:transferir',function(data, cb)
    local id, value = tonumber(data.id), tonumber(data.value)
    if (id ~= nil and id > 0 and value ~= nil and value > 0) then vSERVER.transferir(id, value); end;
end)

RegisterNUICallback('ws:limpar_transferencia',function(data, cb)
    vSERVER.clearTransferencia()
end)

RegisterNUICallback('get_multas',function(data, cb)
    local multas = vSERVER.getMultas()
    if (multas) then cb({ multas = multas }); end;
end)

RegisterNUICallback('gerate_grafico',function(data, cb)
    local ganhou,perdeu,multas,total,rendimento = vSERVER.generateData()
    if (ganhou and perdeu and multas and total and rendimento) then
        cb({ ganhou = ganhou, perdeu = perdeu, multas = multas, total = total, rendimento = rendimento})
    end
end)

RegisterNUICallback('pagar_multa',function(data)
    local id = tonumber(data.id_multa)
    if id then vSERVER.pagarMultas(id); end;
end)

RegisterNUICallback('ws:get_trans',function(data, cb)
    local historyCache = vSERVER.getHistoricoBank()
    if (historyCache) then cb({ trans = historyCache }); end;
end)

RegisterNUICallback('ws:update_money',function(data, cb)
    local wallet,bank = vSERVER.updateMoney()
    if (wallet and bank) then cb({ money = wallet,bank = bank }); end;
end)

RegisterNUICallback('ws:close',function(data, cb)
    StopScreenEffect('MenuMGSelectionIn')
    SetNuiFocus(false, false)
    LocalPlayer.state.Hud = true
end)

RegisterNetEvent('bank_notify', function(type, title, message)
    SendNUIMessage({
        type = 'notify',
        mode = type,
        title = title,
        message = message,
    })
end)

addBlips = function()
    for _, v in pairs(configBank) do
        if (v.blip) then
            local blip = AddBlipForCoord(v.coord.x,v.coord.y,v.coord.z)
            SetBlipSprite(blip, 207)
            SetBlipAsShortRange(blip, true)
            SetBlipColour(blip, 0)
            SetBlipScale(blip, 0.7)
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentString('Banco')
            EndTextCommandSetBlipName(blip)
        end
    end
end
--[[ 
CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(ped)

        local topZ = GetHeightmapTopZForPosition(pedCoords.x, pedCoords.y) 
        local height = pedCoords.z - topZ

        print(height)
        Wait(100)
    end
end) ]]