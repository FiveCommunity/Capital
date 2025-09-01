local srv = {}
Tunnel.bindInterface('NpcWeapons', srv)

local user_weapons = {}
local ped_cache = {}

local function checkPoliceCount()
    if not npcWeapons.minPolice then return true end
    return #vRP.getUsersByPermission('policia.permissao') >= npcWeapons.minPolice
end

local function notifyPlayer(source, message)
    TriggerClientEvent('notify', source, 'negado', 'Venda de peças de armas', message)
end

local function isPedAvailable(ped)
    return not ped_cache[ped] or ped_cache[ped] <= os.time()
end

local function findSellableWeapon(Inventory)
    for weapon, info in pairs(npcWeapons.list) do
        local sell_amount = math.random(info.Amount.Min, info.Amount.Max)
        local amount = Inventory:getItemAmount(weapon)
        if amount >= sell_amount then
            local sell_price = math.random(info.Price.Min, info.Price.Max)
            return weapon, sell_amount, sell_price * sell_amount
        end
    end
    return nil
end

function srv.checkWeapons(ped)
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id then return false end

    if not isPedAvailable(ped) or not checkPoliceCount() then
        notifyPlayer(source, 'Já estou <b>satisfeito</b>, amanhã pego mais.')
        return false
    end

    local Inventory = vRP.PlayerInventory(user_id)
   
    if not Inventory then return false end

    local weapon, amount, price = findSellableWeapon(Inventory)
    if not weapon then return false end
    user_weapons[user_id] = { weapon, amount, price }
    ped_cache[ped] = os.time() + npcWeapons.pedCooldown
    exports.hud:insertWanted(user_id, 60, 1200)

    return true
end

function srv.PaymentWeapons()
    local source = source
    local user_id = vRP.getUserId(source)
    if not user_id or not user_weapons[user_id] then return end

    local Inventory = vRP.PlayerInventory(user_id)
    if not Inventory then return end

    local weapon, amount, price = table.unpack(user_weapons[user_id])
    if Inventory:tryGetItem(weapon, amount, nil, true) then
        Player(source).state.weaponEvidence = true
        Inventory:generateItem('dinheirosujo', price, nil, nil, true)
        local Coords = GetEntityCoords(GetPlayerPed(source))
        exports.vrp:reportUser(user_id, {
            percentage = 40,
            notify = {
                type = 'default',
                title = 'Tráfico de Armas',
                message = 'Denúncia de populares, tráfico de armas na região.',
                coords = Coords,
                time = 8000
            },
            blip = {
                id = user_id,
                text = 'Tráfico de Armas',
                coords = Coords,
                timeout = 30000
            }
        })

        user_weapons[user_id] = nil
    end
end