cLEI = {}
Tunnel.bindInterface(GetCurrentResourceName()..':leiteiro', cLEI)
sLEI = Tunnel.getInterface(GetCurrentResourceName()..':leiteiro')

local cows = {}

local createCows = function()
    for i = 1, #Leiteiro.cowsCoord do
        math.randomseed(GetGameTimer())

        local coords = Leiteiro.cowsCoord[i]
        local mhash = Leiteiro.cows[math.random(#Leiteiro.cows)]

        RequestModel(mhash)
        while (not HasModelLoaded(mhash)) do Citizen.Wait(1); end;

        cows[i] = CreatePed(5, mhash, coords.x, coords.y, (coords.z-0.97), coords.w)
        FreezeEntityPosition(cows[i], true)
        SetEntityInvincible(cows[i], true)
        SetBlockingOfNonTemporaryEvents(cows[i], true)
        SetModelAsNoLongerNeeded(mhash)

        local stateBag = Entity(cows[i]).state
        stateBag.farmer = true
        stateBag.id = i

        Citizen.Wait(200)
    end
end

Citizen.CreateThread(function()
    if GetResourceState('target') == 'started' and exports.target then
        exports.target:RemoveTargetModel(Leiteiro.cows, 'Ordenha')
        exports.target:AddTargetModel(Leiteiro.cows, {
        options = {
            {
                icon = 'fas fa-cow',
                label = 'Ordenha',
                canInteract = function(entity)
                    return sLEI.verifyCow(Entity(entity).state.id)
                end,
                action = function(entity)
                    sLEI.receivePayment(entity, Entity(entity).state.id)
                end
            }
        },
        distance = 2.0
    })
    end

    createCows()
end)

cLEI.verifyEntity = function(entity)
    for _, ped in pairs(cows) do
        if (ped == entity) then
            return true
        end
    end
    return false
end

AddEventHandler('onResourceStart', function(rsc)
    if (GetCurrentResourceName() ~= rsc) then return; end;
    
    for _, ped in pairs(GetGamePool('CPed')) do
        local stateBag = Entity(ped).state
        if (stateBag.farmer) then
            DeleteEntity(ped)
        end
    end
end)