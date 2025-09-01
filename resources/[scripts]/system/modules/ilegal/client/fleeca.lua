srv = {}
Tunnel.bindInterface('sv_fleeca',srv)
local vSERVER = Tunnel.getInterface('sv_fleeca')

local robberyOngoing = false
local dinheiroON = false
local CashPile = nil
local laptop = nil
local hackearText = false
local bankBank = ''

local BankHeists = {
    -- ['Fleeca Bank Highway'] = {
    --     Bank_Vault = { model = -63539571, coord = vec3(-2958.53,482.27,15.835), hStart = 0.0, hEnd = -79.5 },
    --     Blip = { coord = vec3(-2956.78,477.14,15.7), h = 357.97 },
    --     Hack_Robbing = { coord = vec3(-2956.37,482.00,15.69), h = 357.97 },
    --     Cash_Pile = { coord = vec3(-2954.10,484.38,16.26), h = 86.88 }
    -- },
    -- ['Fleeca Bank Top'] = {
    --     Bank_Vault = {model = 2121050683, coord = vec3(-352.72,-53.56,49.50), hStart = 249.84, hEnd = -183.59 },
    --     Blip = { coord = vec3(-358.18,-53.72,49.04), h = 252.82 },
    --     Hack_Robbing = { coord = vec3(-353.72,-55.49,49.04), h = 252.82 },
    --     Cash_Pile = { coord = vec3(-352.00,-58.39,49.60), h = 160.58 } 
    -- },
    -- ['Fleeca Bank Invader'] = {
    --     Bank_Vault = { model = 2121050683, coord = vec3(-104.81,6473.64,31.95), hStart = -63.16, hEnd = -170.16 },
    --     Blip = { coord = vec3(-1215.0,-338.6,37.79), h = 297.11 },
    --     Hack_Robbing = { coord = vec3(-1210.38,-336.55,37.79), h = 297.11 },
    --     Cash_Pile = { coord = vec3(-1207.2,-337.49,38.61), h = 35.15 }
    -- },
    -- ['Bank Paleto'] = {
    --     Bank_Vault = { model = -1185205679, coord = vec3(-105.11,6472.81,31.63), hStart = 46.0, hEnd = 150.0 },
    --     Blip = { coord = vector3(-111.6791, 6471.706, 31.62195), h = 311.811 },
    --     Hack_Robbing = { coord = vector3(-105.6659, 6470.505, 31.62195), h = 133.228 },
    --     Cash_Pile = { coord = vec3(-104.68,6477.29,32.50), h = 35.15 }
    -- },  
}

Citizen.CreateThread(function()
    ResetDoors()
    while true do
        local idle = 1000
        local ped = PlayerPedId()
        for k,v in pairs(BankHeists) do
            if not robberyOngoing then
                local iniciarAssalto = v.Blip.coord
                local distance = #(GetEntityCoords(ped) - iniciarAssalto)
                if distance <= 5.0 then
                    idle = 5
                    Text3D(iniciarAssalto.x,iniciarAssalto.y,iniciarAssalto.z,'~g~E~w~ - ROUBAR FLEECA',400)
                    if distance <= 1.2 and IsControlJustPressed(0,38) --[[and vSERVER.checkPermission()]] and vSERVER.checkPolice() and not IsPedInAnyVehicle(ped) and GetEntityHealth(ped) > 100 then
                        robberyOngoing = true
                        _rouboFunction()
                        ResetDoor(k)
                        TriggerEvent('Notify','sucesso','Roubo iniciado com <b>sucesso</b>.')
                    end
                end
            end
        end
        Wait(idle)
    end
end)

_rouboFunction = function()
    Citizen.CreateThread(function()
        while robberyOngoing do
            local idle = 1000
            local ped = PlayerPedId()
            for k,v in pairs(BankHeists) do
                if robberyOngoing then
                    if not dinheiroON then
                        local StartPosition = v.Hack_Robbing
                        local distance = #(GetEntityCoords(ped) - StartPosition.coord)
                        if distance <= 5.0 then
                            idle = 5
                            Text3D(StartPosition.coord.x,StartPosition.coord.y,StartPosition.coord.z,'~g~E~w~ - HACKEAR',400)
                            if distance <= 1.2 and IsControlJustPressed(0,38) and vSERVER.checkPolice() and not IsPedInAnyVehicle(ped) and GetEntityHealth(ped) > 100 then
                                if vSERVER.KeyCard() then
                                    vSERVER.CheckRobbery(k)
                                    HackAnimStart(StartPosition.coord.x,StartPosition.coord.y,StartPosition.coord.z-0.97,StartPosition.h)
                                    TriggerEvent('mhacking:show')
                                    TriggerEvent('mhacking:start',3,60, function (success,time) mycallback(k,success,time) end)
                                    bankBank = k
                                    dinheiroON = true
                                end
                            end
                        end
                    end
                end
            end
            Wait(idle)
        end
    end)
end

mycallback = function(bank,success,time)
    if success then
        TriggerEvent('mhacking:hide')
        vSERVER.StartBankRobbery(bank)
        HackAnimStop()
        LocalPlayer.state.BlockTasks = false
	else
        TriggerEvent('mhacking:hide')
        HackAnimStop()
		LocalPlayer.state.BlockTasks = false
	end
end

HackAnimStart = function(x,y,z,h)
    local ped = PlayerPedId()
    SetEntityCoords(ped,x,y,z)
    SetEntityHeading(ped,h)
    vRP._playAnim(false,{{'anim@heists@ornate_bank@hack','hack_enter'}},false)
    Wait(8000)
    vRP._playAnim(false,{{'anim@heists@ornate_bank@hack','hack_loop'}},true)
    laptop = CreateObject(GetHashKey('prop_laptop_01a'),x-0.4,y+0.2,z-1,true,true,true)
    SetEntityHeading(laptop,h)
end

HackAnimStop = function()
    vRP._playAnim(false,{{'anim@heists@money_grab@briefcase','exit'}},true)
    Wait(1500)
    DeleteObject(laptop)
    vRP._stopAnim(false)    
end

RegisterNetEvent('bankrobbery:startRobbery')
AddEventHandler('bankrobbery:startRobbery',function(bankId)
    StartRobbery(bankId)
end)

RegisterNetEvent('bankrobbery:deleteEntity')
AddEventHandler('bankrobbery:deleteEntity',function()
    DeleteEntity(CashPile)
    robberyOngoing = false
    dinheiroON = false
end)


StartRobbery = function(bankId)
    robberyOngoing = true
    local CashPosition = BankHeists[bankId].Cash_Pile
    loadModel('bkr_prop_bkr_cashpile_04')
    loadAnimDict('anim@heists@ornate_bank@grab_cash_heels')
    CashPile = CreateObject(GetHashKey('bkr_prop_bkr_cashpile_04'),CashPosition.coord.x,CashPosition.coord.y,CashPosition.coord.z,false)
    PlaceObjectOnGroundProperly(CashPile)
    SetEntityRotation(CashPile,0,0,CashPosition['h'],2)
    FreezeEntityPosition(CashPile, true)
    SetEntityAsMissionEntity(CashPile,true,true)
    Citizen.CreateThread(function()
        while dinheiroON do
            local idle = 1000
            local ped = PlayerPedId()
            
            local Cash = BankHeists[bankId]['Money']
            local distanceCheck = #(GetEntityCoords(ped) - CashPosition.coord)
            if distanceCheck <= 10 then
                idle = 5
                Text3D(CashPosition.coord.x,CashPosition.coord.y,CashPosition.coord.z,'~g~E~w~ - PEGAR DINHEIRO',400)
                if distanceCheck <= 1.5 and IsControlJustPressed(0,38) and not IsPedInAnyVehicle(ped) and GetEntityHealth(ped) > 100 then
                    GrabCash(bankId)
                    _exitFleeca(CashPosition.coord.x,CashPosition.coord.y,CashPosition.coord.z)
                end
            end
        
            Wait(idle)
        end
    end)
end

local exitRunning = false
_exitFleeca = function(x,y,z)
    if (not exitRunning) then
        exitRunning = true
        Citizen.CreateThread(function()
            while dinheiroON do
                
                local idle = 1000
                local ped = PlayerPedId()
                local distance = #(GetEntityCoords(ped) - vec3(x,y,z))
                if distance >= 5.0 or GetEntityHealth(ped) <= 100 then
                    idle = 5
                    robberyOngoing = false
                    dinheiroON = false
                    vSERVER.ResetMoney(bankBank)
                    DeleteEntity(CashPile)
                    Wait(1000)
                    TriggerEvent('Notify','aviso','Você saiu de perto do <b>cofre</b>.')
                end
                
                Wait(idle)
            end
            exitRunning = nil
        end)
    end
end

GrabCash = function(bankId)
    TriggerEvent('Notify','aviso','Não saia do <b>cofre</b>, caso saia o roubo irá ser <b>cancelado</b>.')
    TaskPlayAnim(PlayerPedId(),'anim@heists@ornate_bank@grab_cash_heels','grab',8.0,-8.0,-1,1,0,false,false,false)
    Citizen.Wait(7500)
    ClearPedTasks(PlayerPedId())
    vSERVER.CheckPayment(bankId)
end

loadAnimDict = function(dict)
    Citizen.CreateThread(function()
        while (not HasAnimDictLoaded(dict)) do
            RequestAnimDict(dict)
            Citizen.Wait(10)
        end
    end)
end

loadModel = function(model)
    Citizen.CreateThread(function()
        while not HasModelLoaded(model) do
            RequestModel(model)
        Citizen.Wait(10)
        end
    end)
end

RegisterNetEvent('bankrobbery:openDoor')
AddEventHandler('bankrobbery:openDoor', function(bankId)
    ResetDoor(bankId)
    local Bank = BankHeists[bankId]
    local ped = PlayerPedId()
    local coord = GetEntityCoords(ped)
    
    while (#(coord - Bank['Bank_Vault'].coord) > 80) do
        ped = PlayerPedId()
        coord = GetEntityCoords(ped)
        Citizen.Wait(500)
    end

    local door = GetClosestObjectOfType(Bank['Bank_Vault'].coord.x,Bank['Bank_Vault'].coord.y,Bank['Bank_Vault'].coord.z,3.0,Bank['Bank_Vault'].model)
    local rotation = GetEntityRotation(door)['z']
    local dif = Bank['Bank_Vault'].model
	Citizen.CreateThread(function()
        FreezeEntityPosition(door, false)
        if dif == -1185205679 then
            while rotation <= Bank['Bank_Vault'].hEnd do
                Citizen.Wait(10)
                rotation = rotation + 0.25
                SetEntityRotation(door,0.0,0.0,rotation)
            end
        else
            while rotation >= Bank['Bank_Vault'].hEnd do
                Citizen.Wait(10)
                rotation = rotation - 0.25
                SetEntityRotation(door,0.0,0.0,rotation)
            end
        end
		FreezeEntityPosition(door,true)
    end)
end)

ResetDoor = function(bankId)
    local Bank = BankHeists[bankId]
    local door = GetClosestObjectOfType(Bank['Bank_Vault'].coord.x,Bank['Bank_Vault'].coord.y,Bank['Bank_Vault'].coord.z,3.0,Bank['Bank_Vault'].model)
    SetEntityRotation(door, 0.0, 0.0, Bank['Bank_Vault'].hStart, 0.0)
end

ResetDoors = function()
    for bank, values in pairs(BankHeists) do
        local door = GetClosestObjectOfType(values['Bank_Vault'].coord.x,values['Bank_Vault'].coord.y,values['Bank_Vault'].coord.z,3.0,values['Bank_Vault'].model)
        SetEntityRotation(door,0.0,0.0,values['Bank_Vault'].hStart,0.0)
        FreezeEntityPosition(door,true)
    end
end

local blip = nil
RegisterNetEvent('blip:criar:banco')
AddEventHandler('blip:criar:banco',function(x,y,z,bankId)
	if not DoesBlipExist(blip) then
		blip = AddBlipForCoord(x,y,z)
		SetBlipScale(blip,0.5)
		SetBlipSprite(blip,161)
		SetBlipColour(blip,59)
		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString('Roubo ao: ~g~'..bankId)

		EndTextCommandSetBlipName(blip)
		SetBlipAsShortRange(blip,false)
		SetBlipRoute(blip,true)
        SetTimeout(30*1000,function()
            if DoesBlipExist(blip) then
                RemoveBlip(blip)
                blip = nil
            end
        end)
	end
end)