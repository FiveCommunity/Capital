--==============================================================================
-- Foods
--==========================================================================
config.consumables = {
    ['xburger'] = {
        anim = { 'mp_player_inteat@burger', 'mp_player_int_eat_burger', 49, 60309 }, 
        prop = 'prop_cs_burger_01', 
        consumable = { hunger = -25, thirst = 0, stress = 0, timeout = 5000 }, 
    },
    ['xsalada'] = {
        anim = { 'mp_player_inteat@burger', 'mp_player_int_eat_burger', 49, 60309 }, 
        prop = 'prop_cs_burger_01', 
        consumable = { hunger = -33, thirst = 0, stress = 0, timeout = 5000 }, 
    },
    ['xtudo'] = {
        anim = { 'mp_player_inteat@burger', 'mp_player_int_eat_burger', 49, 60309 }, 
        prop = 'prop_cs_burger_01', 
        consumable = { hunger = -50, thirst = 0, stress = 0, timeout = 5000 }, 
    },
    ['espetinho-camarao'] = {
        anim = { 'mp_player_inteat@burger', 'mp_player_int_eat_burger', 49, 60309 }, 
        prop = 'prop_peyote_chunk_01', 
        consumable = { hunger = -33, thirst = 0, stress = 0, timeout = 5000 }, 
    },
    ['caviar'] = {
        anim = { 'mp_player_inteat@burger', 'mp_player_int_eat_burger', 49, 60309 }, 
        prop = 'prop_peyote_chunk_01', 
        consumable = { hunger = -33, thirst = 0, stress = 0, timeout = 5000 }, 
    },
    ['linguicinha'] = {
        anim = { 'mp_player_inteat@burger', 'mp_player_int_eat_burger', 49, 60309 }, 
        prop = 'prop_peyote_chunk_01', 
        consumable = { hunger = -33, thirst = 0, stress = 0, timeout = 5000 }, 
    },
    ['milho'] = {
        anim = { 'mp_player_inteat@burger', 'mp_player_int_eat_burger', 49, 60309 }, 
        prop = 'prop_peyote_chunk_01', 
        consumable = { hunger = -33, thirst = 0, stress = 0, timeout = 5000 }, 
    },
    --==========================================================================
    ['suco-morango'] = { 
        anim = { 'mp_player_intdrink', 'loop_bottle', 49, 60309 }, 
        prop = 'prop_food_bs_juice02', 
        consumable = { hunger = 0, thirst = -50, stress = 0, timeout = 5000 }, 
    },
    ['suco-banana'] = { 
        anim = { 'mp_player_intdrink', 'loop_bottle', 49, 60309 }, 
        prop = 'prop_food_bs_juice02', 
        consumable = { hunger = 0, thirst = -50, stress = 0, timeout = 5000 }, 
    },
    ['suco-abacaxi'] = { 
        anim = { 'mp_player_intdrink', 'loop_bottle', 49, 60309 }, 
        prop = 'prop_food_bs_juice02', 
        consumable = { hunger = 0, thirst = -50, stress = 0, timeout = 5000 }, 
    },
    ['suco-caju'] = { 
        anim = { 'mp_player_intdrink', 'loop_bottle', 49, 60309 }, 
        prop = 'prop_food_bs_juice02', 
        consumable = { hunger = 0, thirst = -50, stress = 0, timeout = 5000 }, 
    },
    ['caipirosca'] = { 
        anim = { 'mp_player_intdrink', 'loop_bottle', 49, 60309 }, 
        prop = 'prop_food_bs_juice02', 
        consumable = { hunger = 0, thirst = -10, stress = 0, timeout = 5000 }, 
    },
    ['suco-maracuja'] = { 
        anim = { 'mp_player_intdrink', 'loop_bottle', 49, 60309 }, 
        prop = 'prop_food_bs_juice02', 
        consumable = { hunger = 0, thirst = -50, stress = -10, timeout = 5000 }, 
    },
    ['suco-uva'] = { 
        anim = { 'mp_player_intdrink', 'loop_bottle', 49, 60309 }, 
        prop = 'prop_food_bs_juice02', 
        consumable = { hunger = 0, thirst = -50, stress = 0, timeout = 5000 }, 
    },
    ['suco-pessego'] = { 
        anim = { 'mp_player_intdrink', 'loop_bottle', 49, 60309 }, 
        prop = 'prop_food_bs_juice02', 
        consumable = { hunger = 0, thirst = -50, stress = 0, timeout = 5000 }, 
    },
    ['suco-kiwi'] = { 
        anim = { 'mp_player_intdrink', 'loop_bottle', 49, 60309 }, 
        prop = 'prop_food_bs_juice02', 
        consumable = { hunger = 0, thirst = -50, stress = 0, timeout = 5000 }, 
    },
    ['cha-camomila'] = { 
        anim = { 'mp_player_intdrink', 'loop_bottle', 49, 60309 }, 
        prop = 'prop_drink_whtwine', 
        consumable = { hunger = 0, thirst = 0, stress = -15, timeout = 5000 }, 
    },
    
    ['chimarrao'] = { 
        anim = { 'mp_player_intdrink', 'loop_bottle', 49, 60309 }, 
        prop = 'v_res_mcofcup', 
        consumable = { hunger = 0, thirst = 0, stress = -15, timeout = 5000 }, 
    },
    ['iogurte'] = { 
        anim = { 'mp_player_intdrink', 'loop_bottle', 49, 60309 }, 
        prop = 'v_res_mcofcup', 
        consumable = { hunger = 0, thirst = -25, stress = -10, timeout = 5000 }, 
    },
    ['chocolate-quente'] = { 
        anim = { 'mp_player_intdrink', 'loop_bottle', 49, 60309 }, 
        prop = 'v_res_mcofcup', 
        consumable = { hunger = 0, thirst = -25, stress = -10, timeout = 5000 }, 
    },
    --==========================================================================
    ['chocolate'] = {
        anim = { 'mp_player_inteat@burger', 'mp_player_int_eat_burger', 49, 60309 }, 
        prop = 'ng_proc_candy01a', 
        consumable = { hunger = -5, thirst = 0, stress = -20, timeout = 5000 }, 
    },
    ['sanduiche'] = { 
        anim = { 'mp_player_inteat@burger', 'mp_player_int_eat_burger', 49, 60309 }, 
        prop = 'prop_sandwich_01',
        consumable = { hunger = -30, thirst = 0, stress = 0, timeout = 5000 }, 
    },
    ['donut'] = { 
        anim = { 'mp_player_inteat@burger', 'mp_player_int_eat_burger', 49, 60309 }, 
        prop = 'prop_donut_02',
        consumable = { hunger = -5, thirst = 0, stress = -15, timeout = 5000 }, 
    },
    ['pirulito'] = { 
        anim = { 'mp_player_inteat@burger', 'mp_player_int_eat_burger', 49, 60309 }, 
        prop = 'prop_peyote_chunk_01',
        consumable = { hunger = -5, thirst = 0, stress = 0, timeout = 5000 }, 
    },
    ['hotdog'] = { 
        anim = { 'mp_player_inteat@burger', 'mp_player_int_eat_burger', 49, 60309 }, 
        prop = 'prop_cs_hotdog_02',
        consumable = { hunger = -5, thirst = 0, stress = 0, timeout = 5000 }, 
    },
    ['salspatriota'] = { 
        anim = { 'mp_player_inteat@burger', 'mp_player_int_eat_burger', 49, 60309 }, 
        prop = 'prop_cs_hotdog_02',
        consumable = { hunger = -2, thirst = 0, stress = 0, timeout = 5000 }, 
    },
    ['cola'] = { 
        anim = { 'mp_player_intdrink', 'loop_bottle', 49, 60309 }, 
        prop = 'prop_ecola_can', 
        consumable = { hunger = 0, thirst = -25, stress = 0, timeout = 5000 }, 
    },
    ['agua'] = { 
        anim = { 'mp_player_intdrink', 'loop_bottle', 49, 60309 }, 
        prop = 'prop_energy_drink', 
        consumable = { hunger = 0, thirst = -15, stress = 0, timeout = 5000 }, 
        afterItem = 'garrafavazia'
    },
    ['leitinho'] = { 
        anim = { 'mp_player_intdrink', 'loop_bottle', 49, 60309 }, 
        prop = 'prop_energy_drink', 
        consumable = { hunger = 0, thirst = -15, stress = 0, timeout = 5000 }, 
    },
    ['leitetexugo'] = { 
        anim = { 'mp_player_intdrink', 'loop_bottle', 49, 60309 }, 
        prop = 'prop_energy_drink', 
        consumable = { hunger = 0, thirst = -20, stress = 0, timeout = 5000 }, 
    },
    ['pudimratazana'] = { 
        anim = { 'mp_player_inteat@burger', 'mp_player_int_eat_burger', 49, 60309 }, 
        prop = 'prop_peyote_chunk_01',
        consumable = { hunger = -10, thirst = 0, stress = 0, timeout = 5000 }, 
    },
    ['ovoganso'] = { 
        anim = { 'mp_player_inteat@burger', 'mp_player_int_eat_burger', 49, 60309 }, 
        prop = 'prop_peyote_chunk_01',
        consumable = { hunger = -10, thirst = 0, stress = 0, timeout = 5000 }, 
    },
    ['salsired'] = { 
        anim = { 'mp_player_inteat@burger', 'mp_player_int_eat_burger', 49, 60309 }, 
        prop = 'prop_peyote_chunk_01',
        consumable = { hunger = -30, thirst = 0, stress = 0, timeout = 5000 }, 
    },
    ['rosqpau'] = { 
        anim = { 'mp_player_inteat@burger', 'mp_player_int_eat_burger', 49, 60309 }, 
        prop = 'prop_donut_02',
        consumable = { hunger = -20, thirst = 0, stress = 0, timeout = 5000 }, 
    },
    ['brisadeiro'] = { 
        anim = { 'mp_player_inteat@burger', 'mp_player_int_eat_burger', 49, 60309 }, 
        prop = 'prop_choc_ego',
        consumable = { hunger = 0, thirst = 0, stress = -20, timeout = 5000 }, 
    },
    ['pastellontra'] = { 
        anim = { 'mp_player_inteat@burger', 'mp_player_int_eat_burger', 49, 60309 }, 
        prop = 'prop_peyote_chunk_01',
        consumable = { hunger = -10, thirst = 0, stress = 0, timeout = 5000 }, 
    },
    ['bolomel'] = { 
        anim = { 'mp_player_inteat@burger', 'mp_player_int_eat_burger', 49, 60309 }, 
        prop = 'prop_donut_02',
        consumable = { hunger = -30, thirst = 0, stress = 0, timeout = 5000 }, 
    },
    ['paomel'] = { 
        anim = { 'mp_player_inteat@burger', 'mp_player_int_eat_burger', 49, 60309 }, 
        prop = 'prop_choc_ego',
        consumable = { hunger = -30, thirst = 0, stress = 0, timeout = 5000 }, 
    },
    ['chamel'] = { 
        anim = { 'mp_player_intdrink', 'loop_bottle', 49, 60309 }, 
        prop = 'v_res_mcofcup',
        consumable = { hunger = 0, thirst = -50, stress = -15, timeout = 5000 }, 
    },
    ['soda'] = { 
        anim = { 'mp_player_intdrink', 'loop_bottle', 49, 60309 }, 
        prop = 'ng_proc_sodacan_01b', 
        consumable = { hunger = 0, thirst = -25, stress = 0, timeout = 5000 },
    },
    ['vodka'] = { 
        anim = { 'mp_player_intdrink', 'loop_bottle', 49, 60309 }, 
        prop = 'prop_drink_whtwine', 
        consumable = { hunger = 0, thirst = -10, stress = 0, timeout = 5000 }, 
    },
    ['whisky'] = { 
        anim = { 'mp_player_intdrink', 'loop_bottle', 49, 60309 }, 
        prop = 'prop_drink_whtwine', 
        consumable = { hunger = 0, thirst = -10, stress = 0, timeout = 5000 }, 
    },
    ['cerveja'] = { 
        anim = { 'mp_player_intdrink', 'loop_bottle', 49, 60309 }, 
        prop = 'prop_beer_bison', 
        consumable = { hunger = 0, thirst = -10, stress = 0, timeout = 5000 }, 
    },
    ['conhaque'] = { 
        anim = { 'mp_player_intdrink', 'loop_bottle', 49, 60309 }, 
        prop = 'prop_drink_whtwine', 
        consumable = { hunger = 0, thirst = -10, stress = 0, timeout = 5000 }, 
    },
    ['tequila'] = {
        anim = { 'mp_player_intdrink', 'loop_bottle', 49, 60309 }, 
        prop = 'prop_drink_whtwine', 
        consumable = { hunger = 0, thirst = -10, stress = 0, timeout = 5000 }, 
    },
    ['chimas'] = {
        anim = { 'chimas@zacfreitas', 'chimas_clip', 49, 6286 }, 
        prop = 'mah_chimas', 
        consumable = { hunger = 0, thirst = -10, stress = 0, timeout = 5000 }, 
    },
    
    --[ Farmacia ]==============================================================
    ['calmante'] = {
        anim = { 'mp_player_intdrink', 'loop_bottle', 49, 60309 }, 
        prop = 'prop_shot_glass', 
        consumable = { hunger = 0, thirst = 0, stress = -50, timeout = 5000 }, 
    },
    ['gasestrol'] = {
        anim = { 'mp_player_intdrink', 'loop_bottle', 49, 60309 }, 
        prop = 'prop_shot_glass', 
        consumable = { hunger = 0, thirst = 0, stress = 0, poop = -10, timeout = 5000 }, 
    },
}

function varyNumber(var) return (var and (var ~= 0)); end;

config.itemFunctions['type:consumivel'] = function(source, user_id, index, amount, slot, UserInventory)
    if (_using[user_id]) then return; end;
    if (Player(source).state.pedSwimming) then return TriggerClientEvent('notify', source, 'negado', 'Mochila', 'Você não pode <b>consumir</b> um item enquanto estiver nadando.'); end;
    
    local cItem = config.consumables[index]
    if (cItem) then
        local consumable = cItem.consumable
        
        local time = parseInt(consumable.timeout / 1000)
        _using[user_id] = (os.time() + time)

        if (cItem.anim) then
            if (cItem.prop) then
                vRPclient.CarregarObjeto(source, cItem.anim[1], cItem.anim[2], cItem.prop, cItem.anim[3], cItem.anim[4])
            else 
                vRPclient._playAnim(source, true, { cItem.anim }, true)
            end
        end

        TriggerClientEvent('ProgressBar', source, consumable.timeout)
        repeat
            if (os.time() >= _using[user_id]) then
                if (UserInventory:tryGetItem(index, 1, slot, true)) then
                    _using[user_id] = nil
                    --====
                    if varyNumber(consumable.hunger) then
                        exports.vrp:varyNeeds(user_id, 'hunger', consumable.hunger)
                    end
                    if varyNumber(consumable.thirst) then
                        exports.vrp:varyNeeds(user_id, 'thirst', consumable.thirst)
                    end
                    if varyNumber(consumable.stress) then
                        exports.vrp:varyNeeds(user_id, 'stress', consumable.stress)
                    end
                    -- if varyNumber(consumable.urine) then
                    --     exports.vrp:varyNeeds(user_id, 'urine', consumable.urine)
                    -- end
                    -- if varyNumber(consumable.poop) then
                    --     exports.vrp:varyNeeds(user_id, 'poop', consumable.poop)
                    -- end
                    --====
                    if (cItem.afterItem) then 
                        UserInventory:generateItem(cItem.afterItem, 1, nil, nil, true)
                    end
                    --====
                    ClearPedTasks(GetPlayerPed(source))
                    vRPclient.DeletarObjeto(source)
                    TriggerClientEvent('Notify', source, 'sucesso', 'Mochila', 'Você consumiu um(a) <b>'..vRP.itemNameList(index)..'</b>.')
                end
            end
            Citizen.Wait(100)
        until (not _using[user_id])
    end
    return true
end
--==============================================================================
-- Drugs
--==============================================================================
config.drugs = {
    ['viagra'] = {
        anim = { 'anim@mp_fm_event@intro', 'beast_transform' },
        timeout = 5000,
        hunger = 0, thirst = 0, stress = 10,
        health = 10, armour = 0, stamina = nil, 
    },
    ['balinha'] = {
        anim = { 'anim@mp_fm_event@intro', 'beast_transform' },
        effect = { 'DrugsTrevorClownsFight', 20 },
        timeout = 5000,
        hunger = 0, thirst = 0, stress = 10,
        health = 0, armour = 0, stamina = { 1.30, 10000 }, 
    },
    ['erva'] = {
        anim = { 'anim@mp_fm_event@intro', 'beast_transform' },
        timeout = 5000,
        hunger = 10, thirst = 0, stress = -10,
        health = 0, armour = 0, stamina = nil,    
    },
    ['farinha'] = {
        anim = { 'anim@mp_fm_event@intro', 'beast_transform' },
        timeout = 5000,
        hunger = 0, thirst = 0, stress = 10,
        health = 0, armour = 0, stamina = { 1.30, 10000 },    
    },
    ['heroina'] = {
        anim = { 'anim@mp_fm_event@intro', 'beast_transform' },
        effect = { 'DrugsTrevorClownsFight', 20 },
        timeout = 5000,
        hunger = 0, thirst = 0, stress = 10,
        health = 0, armour = 5, stamina = nil,    
    },
    ['meta'] = {
        anim = { 'anim@mp_fm_event@intro', 'beast_transform' },
        timeout = 5000,
        hunger = 0, thirst = 0, stress = 10,
        health = 0, armour = 5, stamina = nil,    
    },
    ['lanca'] = {
        anim = { 'anim@mp_fm_event@intro', 'beast_transform' },
        effect = { 'DrugsTrevorClownsFight', 20 },
        timeout = 5000,
        hunger = 0, thirst = 0, stress = 10,
        health = 10, armour = 0, stamina = nil,    
    },
    ['oxy'] = {
        anim = { 'anim@mp_fm_event@intro', 'beast_transform' },
        timeout = 5000,
        hunger = 0, thirst = 0, stress = 90,
        health = 10, armour = 0, stamina = nil,    
    },
    ['skunk'] = {
        anim = { 'anim@mp_fm_event@intro', 'beast_transform' },
        timeout = 5000,
        hunger = 0, thirst = 10, stress = -10,
        health = 0, armour = 0, stamina = nil,    
    },
    ['melzinho'] = {
        anim = { 'anim@mp_fm_event@intro', 'beast_transform' },
        timeout = 5000,
        hunger = 0, thirst = 0, stress = -10,
        health = 0, armour = 0, stamina = nil,
    },
}

config.itemFunctions['type:droga'] = function(source, user_id, index, amount, slot, UserInventory)
    if (_using[user_id]) then return; end;
    if (Player(source).state.pedSwimming) then return TriggerClientEvent('notify', source, 'negado', 'Mochila', 'Você não pode <b>consumir</b> um item enquanto estiver nadando.'); end;
    
    local cItem = config.drugs[index]
    if (cItem) then
              
        local time = parseInt(cItem.timeout / 1000)
        _using[user_id] = (os.time() + time)

        if (cItem.anim) then
            if (cItem.anim.prop) then 
                vRPclient._CarregarObjeto(source, cItem.anim[1], cItem.anim[2], cItem.prop, cItem.anim[3], cItem.anim[4])
            else
                vRPclient._playAnim(source, true, { cItem.anim }, true)
            end
        end

        TriggerClientEvent('ProgressBar', source, cItem.timeout)
        repeat
            if (os.time() >= _using[user_id]) then
                if (UserInventory:tryGetItem(index, 1, slot, true)) then
                    _using[user_id] = nil

                    --====
                    if varyNumber(cItem.hunger) then
                        exports.vrp:varyNeeds(user_id, 'hunger', cItem.hunger)
                    end
                    if varyNumber(cItem.thirst) then
                        exports.vrp:varyNeeds(user_id, 'thirst', cItem.thirst)
                    end
                    if varyNumber(cItem.stress) then
                        exports.vrp:varyNeeds(user_id, 'stress', cItem.stress)
                    end
                    --====
                    if varyNumber(cItem.health) then
                        vRPclient.varyHealth(source,cItem.health)
                    end
                    if varyNumber(cItem.armour) then
                        vRPclient.varyArmour(source,cItem.armour)
                    end
                    if cItem.stamina then
                        Player(source).state.Stamina = cItem.stamina[1]
                        Citizen.SetTimeout( cItem.stamina[2], function()
                            Player(source).state.Stamina = nil
                        end)
                    end
                    --====
                    if (cItem.effect) then
                        vRPclient._playScreenEffect(source, cItem.effect[1], cItem.effect[2])
                    end
                    if (cItem.afterItem) then 
                        UserInventory:generateItem(cItem.afterItem, 1, nil, nil, true)
                    end

                    ClearPedTasks(GetPlayerPed(source))
                    vRPclient.DeletarObjeto(source)

                    TriggerClientEvent('Notify', source, 'sucesso', 'Mochila', 'Você consumiu um(a) <b>'..vRP.itemNameList(index)..'</b>.')
                end
            end
            Citizen.Wait(100)
        until (not _using[user_id])
    end
    return true
end
--==============================================================================
-- Combos
--==============================================================================
local combosFood = {
    ['combo-camarao'] = { 
        ['espetinho-camarao'] = 1,
        ['suco-morango'] = 1
    },
    ['combo-milho'] = { 
        ['milho'] = 1,
        ['suco-abacaxi'] = 1
    },
    ['combo-chocolate'] = { 
        ['chocolate'] = 1,
        ['suco-kiwi'] = 1
    },
    ['combo-caviar'] = { 
        ['caviar'] = 1,
        ['suco-caju'] = 1
    },
}

config.itemFunctions["type:combo-food"] = function(source,user_id,item,amount,slot)
    if combosFood[item] then
        if vRP.tryGetInventoryItem(user_id, item, 1, slot) then
            for item, qtd in pairs(combosFood[item]) do
                vRP.giveInventoryItem(user_id, item, qtd)
            end
            TriggerClientEvent('Notify', source, 'importante', 'Inventário', 'Você abriu o combo: <b>'..vRP.itemNameList(item)..'</b>.')
            return true
        end
    end
end
--==============================================================================
-- Bags
--==============================================================================
local mochilaWeights = {
    ['mochila'] = { vary = 10, varySlots = 10 },
    ['mochila-pequena'] = { vary = 5, varySlots = 5 },
    ['mochila-grande'] = { set = 130, setSlots = 130 },
}

config.itemFunctions["type:mochila"] = function(source,user_id,item,amount,slot,UserInventory)
    local weight = mochilaWeights[item]
    if weight then
        local done = false   
        --[ WEIGHT ]============================================================
        if (weight.set) then
            if UserInventory:tryGetItem(item,1,slot) then
                UserInventory:setMaxWeight(weight.set)
                local backpacks = vRP.weightsVip()
                for group, gweight in pairs(backpacks) do
                    if (vRP.hasGroup(user_id, group)) then
                        UserInventory:varyMaxWeight(gweight)
                    end
                end
                done = true
            end
        end
        if (weight.vary) then
            local currentMax = UserInventory:getMaxWeight()
            if (currentMax+weight.vary) <= 130 then
                if UserInventory:tryGetItem(item,1,slot) then
                    UserInventory:varyMaxWeight(weight.vary)
                    done = true
                end
            else
                TriggerClientEvent('Notify', source, 'negado', 'Inventário', 'Nível máximo da mochila atingido!')
                return
            end
        end
        --[ SLOTS ]=============================================================
        if (weight.setSlots) then
            if (done) or UserInventory:tryGetItem(item,1,slot) then
                UserInventory:setMaxSlots(weight.setSlots)
                done = true
            end
        end
        if (weight.varySlots) then
            local currentMax = UserInventory:getMaxSlots()
            if (currentMax+weight.varySlots) <= 130 then
                if (done) or UserInventory:tryGetItem(item,1,slot) then
                    UserInventory:varyMaxSlots(weight.varySlots)
                    done = true
                end
            end
        end
        --[ NOTIFY ]============================================================
        if (done) then
            vRPclient._playAnim(source, true,{{ 'clothingshirt', 'try_shirt_positive_d' }}, true)
            TriggerClientEvent('Notify', source, 'sucesso', 'Inventário', 'Você equipou sua mochila com sucesso!')
            
            TriggerClientEvent('ProgressBar', source, 5000)            
            Citizen.Wait(5000)
            
            ClearPedTasks(GetPlayerPed(source))
            return true
        end
    end
end

-- local mochilaSlots = {
--     ['bolso-pequeno'] = 5,
--     ['bolso-medio'] = 10,
--     ['bolso-grande'] = 30,
-- }

-- config.itemFunctions["type:slots"] = function(source,user_id,item,amount,slot,UserInventory)
--     local slots = mochilaSlots[item]
--     if slots then
--         if (UserInventory:getMaxSlots()+slots <= 100) then
--             if UserInventory:tryGetItem(item,1,slot) then
--                 UserInventory:varyMaxSlots(slots)
--                 vRPclient._playAnim(source, true,{{ 'clothingshirt', 'try_shirt_positive_d' }}, false)
--                 TriggerClientEvent('Notify', source, 'sucesso', 'Inventário', 'Você utilizou um bolso com sucesso!')
--             end
--         else
--             TriggerClientEvent('Notify', source, 'negado', 'Inventário', 'Você pode possuir até 100 slots!')
--         end
--     end
-- end
--==============================================================================
-- Coletes
--==============================================================================
local coleteWait = {}
config.itemFunctions["type:colete"] = function(source, user_id, item, amount, slot, UserInventory)
    local ped = GetPlayerPed(source)
    
    if (coleteWait[user_id]) and (coleteWait[user_id] > os.time()) then
        TriggerClientEvent('Notify', source, 'negado', 'Inventário', 'Aguarde <b>'..(coleteWait[user_id]-os.time())..'</b> segundos para equipar outro Colete!')
        return false
    end
    coleteWait[user_id] = (os.time()+300)

    if UserInventory:tryGetItem(item, 1, slot) then
        Player(source).state.BlockTasks = true
        vRPclient._playAnim(source, true, { { 'clothingshirt', 'try_shirt_positive_d' } }, false)
        TriggerClientEvent('ProgressBar', source, 10000)
        Citizen.SetTimeout(10000, function()
            if (GetEntityHealth(ped) > 100) then
                vRPclient.setArmour(source, 100)
                ClearPedTasks(source)
                Player(source).state.BlockTasks = false
                TriggerClientEvent('Notify', source, 'sucesso', 'Inventário', 'Colete <b>utilizado</b> com sucesso!')
            end
        end)
        return true
    end
end
--==============================================================================
-- VIPS
--==============================================================================
config.vips = {
    ['vip-bronze'] = {
        group = 'VipBronze',
        days = 30 -- expira em quantos dias?
    },
    ['vip-prata'] = {
        group = 'VipPrata',
        days = 30 -- expira em quantos dias?
    },
    ['vip-ouro'] = {
        group = 'VipOuro',
        days = 30 -- expira em quantos dias?
    },
    ['vip-capital'] = {
        group = 'VipCapital',
        days = 30, -- expira em quantos dias?
        giveItens = {
            ['lockpick'] = 10,
            ['telefone'] = 1,
            ['mochila-grande'] = 2,
            ['placa-vip'] = 1,
        }
    },
    ['bolso-pequeno'] = {
        group = 'Slots05',
        days = 30,
        exec = function(source,user_id,UserInventory)
            UserInventory:varyMaxSlots(5)
            exports['hydrus.gg']:schedule(user_id,{ 'exports', 'vrp', 'varyInventoryMaxSlots', user_id, -5 }, 86400*30)
        end,
    },
    ['bolso-medio'] = {
        group = 'Slots10',
        days = 30,
        exec = function(source,user_id,UserInventory)
            UserInventory:varyMaxSlots(10)
            exports['hydrus.gg']:schedule(user_id,{ 'exports', 'vrp', 'varyInventoryMaxSlots', user_id, -10 }, 86400*30)
        end,
    },
    ['bolso-grande'] = {
        group = 'Slots30',
        days = 30,
        exec = function(source,user_id,UserInventory)
            UserInventory:varyMaxSlots(30)
            exports['hydrus.gg']:schedule(user_id,{ 'exports', 'vrp', 'varyInventoryMaxSlots', user_id, -30 }, 86400*30)
        end,
    },
}

config.itemFunctions["type:vip"] = function(source, user_id, item, amount, slot, UserInventory)
    local cVip = config.vips[item]
    if (cVip) then

        local checkSpace = function()
            if (cVip.giveItens) then
                for item, quantity in pairs(cVip.giveItens) do
                    if (not UserInventory:haveSpace(item, quantity)) then
                        TriggerClientEvent('notify', source, 'negado', 'VIP', 'Espaço <b>insuficiente</b> na mochila, tente novamente mais tarde!')
                        return false
                    end
                end
            end
            return true
        end


        if (checkSpace()) then
            if (UserInventory:tryGetItem(item, 1)) then
                if (cVip.days) then
                    vRP.addTemporaryGroup(user_id, cVip.group, cVip.days)
                else
                    vRP.addUserGroup(user_id, cVip.group)
                end
            
                local backpacks = vRP.weightsVip()
                if (backpacks[cVip.group]) then
                    UserInventory:varyMaxWeight(backpacks[cVip.group])
                end

                if (cVip.giveItens) then
                    for item, quantity in pairs(cVip.giveItens) do
                        UserInventory:generateItem(item, quantity, nil, nil, true)
                    end
                end

                if (cVip.exec) then
                    cVip.exec(source, user_id, UserInventory)
                end

                vRP.webhook('activevip', {
                    title = 'ativou vip',
                    descriptions = {
                        { 'user', user_id },
                        { 'vip', (vRP.itemNameList(item) or item) },
                        { 'group', cVip.group },
                        { 'days', (cVip.days or 0) },
                    }
                })

                TriggerClientEvent('Notify', source, 'sucesso', 'VIP', 'Parabéns! Você ativou o <b>'..vRP.getGroupTitle(cVip.group)..'</b>!')
            end
        end
    end
end
--==============================================================================
-- CLOTHES
--==============================================================================
cacheUserClothes = {}

config.clothes = {
    ['mascara'] = function(source, user_id, customization)
        local number = 1
        if (not cacheUserClothes[user_id].mask) and (customization[number].model and customization[number].model ~= 0) then
            cacheUserClothes[user_id].mask = {
                model = customization[number].model,
                var = customization[number].var,
                palette = customization[number].palette
            }
        else
            if (customization[number].model ~= 0) and (cacheUserClothes[user_id].mask ~= customization[number].model) then
                cacheUserClothes[user_id].mask = {
                    model = customization[number].model,
                    var = customization[number].var,
                    palette = customization[number].palette
                }
            end
        end

        if (cacheUserClothes[user_id].mask) then
            TriggerClientEvent('inventory:clothes', source, 'mask', cacheUserClothes[user_id].mask)
        end 
    end,

    ['oculos'] = function(source, user_id, customization)
        local number = 'p1'
        if (not cacheUserClothes[user_id].glasses) and (customization[number].model and customization[number].model ~= -1) then
            cacheUserClothes[user_id].glasses = {
                model = customization[number].model,
                var = customization[number].var,
                palette = customization[number].palette
            }
        else
            if (customization[number].model ~= -1) and (cacheUserClothes[user_id].glasses ~= customization[number].model) then
                cacheUserClothes[user_id].glasses = {
                    model = customization[number].model,
                    var = customization[number].var,
                    palette = customization[number].palette
                }
            end
        end

        if (cacheUserClothes[user_id].glasses) then
            TriggerClientEvent('inventory:clothes', source, 'glasses', cacheUserClothes[user_id].glasses)
        end 
    end,

    ['chapeu'] = function(source, user_id, customization)
        local number = 'p0'
        if (not cacheUserClothes[user_id].hat) and (customization[number].model and customization[number].model ~= -1) then
            cacheUserClothes[user_id].hat = {
                model = customization[number].model,
                var = customization[number].var,
                palette = customization[number].palette
            }
        else
            if (customization[number].model ~= -1) and (cacheUserClothes[user_id].hat ~= customization[number].model) then
                cacheUserClothes[user_id].hat = {
                    model = customization[number].model,
                    var = customization[number].var,
                    palette = customization[number].palette
                }
            end
        end

        if (cacheUserClothes[user_id].hat) then
            TriggerClientEvent('inventory:clothes', source, 'hat', cacheUserClothes[user_id].hat)
        end 
    end,

    ['sapatos'] = function(source, user_id, customization)
        local models = {
            [GetHashKey('mp_m_freemode_01')] = 34,
            [GetHashKey('mp_f_freemode_01')] = 35
        }

        local model = models[GetEntityModel(GetPlayerPed(source))]
        if (model) then
            local number = 6
            if (not cacheUserClothes[user_id].shoes) and (customization[number].model and customization[number].model ~= model) then
                cacheUserClothes[user_id].shoes = {
                    model = customization[number].model,
                    var = customization[number].var,
                    palette = customization[number].palette
                }
            else
                if (customization[number].model ~= model) and (cacheUserClothes[user_id].shoes ~= customization[number].model) then
                    cacheUserClothes[user_id].shoes = {
                        model = customization[number].model,
                        var = customization[number].var,
                        palette = customization[number].palette
                    }
                end
            end

            if (cacheUserClothes[user_id].shoes) then
                TriggerClientEvent('inventory:clothes', source, 'shoes', cacheUserClothes[user_id].shoes)
            end 
        end
    end,
}

config.itemFunctions['type:clothes'] = function(source, user_id, item, amount, slot, UserInventory)
    local data = UserInventory:getSlot(slot)
    if (vRP.calcDurability(data) < 100) then

        local clothes = config.clothes[item]
        if (clothes) then 
            if (not cacheUserClothes[user_id]) then
                cacheUserClothes[user_id] = {}
            end

            local customization = vRPclient.getCustomization(source)
            clothes(source, user_id, customization) 
        end

    else
        TriggerClientEvent('Notify', source, 'negado', 'Mochila', 'Esta <b>roupa</b> está danificada!')
    end
end

AddEventHandler('inventory:switchClothes', function(user_id) if (cacheUserClothes[user_id]) then cacheUserClothes[user_id] = nil; end; end)

config.itemFunctions["type:radar"] = function(source,user_id, item, amount, slot, UserInventory)
    exports.radar:activeRadar(source, user_id)
end

config.itemFunctions["type:weapon_box"] = function(source, user_id, item, amount, slot, UserInventory)
    local gun = item:gsub("^box_", "")

    if UserInventory:tryGetItem(item, 1, slot, false) then
        if UserInventory:haveSpace(gun, 1) then
            UserInventory:generateItem(gun, 1, nil, { prefix = 'EB' }, true)
        else
            UserInventory:giveItem(item, 1)
            TriggerClientEvent('notify', source, 'negado', 'Mochila', 'Espaço <b>insuficiente</b> na mochila, tente novamente mais tarde!')
        end
    end
end