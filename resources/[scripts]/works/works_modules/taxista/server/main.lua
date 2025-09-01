sTAXI = {}
Tunnel.bindInterface(GetCurrentResourceName()..':taxi',sTAXI)

local userTaxiRoutes = {}
local userTaxiPeds = {}

function removeTaxiService(user_id)
    vRP.removeUserGroup(user_id,'Taxista')
    if userTaxiRoutes[user_id] then
        userTaxiRoutes[user_id] = nil
    end
end

function sTAXI.toggleService(status)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        if status then
            vRP.addUserGroup(user_id, 'Taxista')
            userTaxiRoutes[user_id] = {}
        else
            removeTaxiService(user_id)
        end
    end
end

function sTAXI.generateRace(stage)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local taxiData = userTaxiRoutes[user_id]
        if taxiData then
            local dests = {}

            if (stage == 'currentDeliver') then
                dests = Taxista.deliveries
            else
                dests = Taxista.clients
            end

            taxiData[stage] = (taxiData[stage] or 0)
                       
            local selected = taxiData[stage]
            while (selected == taxiData[stage]) do
                selected = math.random(1,#dests)
                Citizen.Wait(1)
            end

            taxiData[stage] = selected

            return selected
        end
    end
end

function sTAXI.distanceDeliver(dest,dist)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local taxiData = userTaxiRoutes[user_id]
        if taxiData then
            if (taxiData.currentDeliver == dest) then
                taxiData.distance = dist
                return true
            end
        end
    end
end

function sTAXI.payment(clock)
    local source = source
    
    if (math.abs(GetGameTimer()-clock) > 4000) then return; end;
    
    local user_id = vRP.getUserId(source)
    if user_id then
        local taxiData = userTaxiRoutes[user_id]
        if (taxiData and taxiData.currentDeliver) then
            
            local dest = Taxista.deliveries[taxiData.currentDeliver]
            
            if #(GetEntityCoords(GetPlayerPed(source)) - dest.coords.xyz) <= 10 then
                
                local payment = parseInt( (Taxista.distance_price / 1000) * taxiData.distance )
                if (payment > 570) then payment = math.random(600,700); end;
                
                vRP.giveMoney(user_id, payment)
                TriggerClientEvent('Notify',source,'importante','Taxista','Viagem finalizada!<br>Você recebeu <b>R$ '..vRP.format(payment)..',00</b>!',8000)
            end
        end
    end
end

RegisterNetEvent('works:taxi:managePed',function(netPed,value)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id and netPed then
        if (not userTaxiPeds[user_id]) then userTaxiPeds[user_id] = {}; end;
        if value then
            userTaxiPeds[user_id][netPed] = true
        else
            userTaxiPeds[user_id][netPed] = nil
            local ped = NetworkGetEntityFromNetworkId(netPed)
            if ped and DoesEntityExist(ped) then
                DeleteEntity(ped)
            end
        end
    end
end)

AddEventHandler('vRP:playerLeave', function(user_id,source)
    removeTaxiService(user_id)
    if userTaxiPeds[user_id] then
        for k,v in pairs(userTaxiPeds[user_id]) do
            local ped = NetworkGetEntityFromNetworkId(k)
            if ped and DoesEntityExist(ped) then
                DeleteEntity(ped)
            end
        end
        userTaxiPeds[user_id] = nil
    end
end)