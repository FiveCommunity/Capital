local cli = {}
Tunnel.bindInterface('HomeRobbery', cli)
local vSERVER = Tunnel.getInterface('HomeRobbery')

local sHOME = Tunnel.getInterface('homes')


local inRobbery = false
local homesConfig = {}

Citizen.CreateThread(function()
    homesConfig = HomesRobbery.getHomes()
end)

function nearestHome(coords)
    for name,info in pairs(homesConfig) do
        local distance = #(coords - info.coord)
        if (distance <= 1.5) then
            return name
        end
    end
end

RegisterNetEvent('robbery:homes',function(itemSlot)
    if (not inRobbery) then
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        if (GetEntityHealth(ped) > 100) and (not IsPedInAnyVehicle(ped)) then
            local home = nearestHome(coords)
            if home then
                local homeData = homesConfig[home]
                if (homeData.type ~= 'apartament') then
                    if (GetSelectedPedWeapon(ped) == GetHashKey('WEAPON_UNARMED')) then
                        vRP.playAnim(true, {{'amb@prop_human_parking_meter@female@idle_a','idle_a_female'}}, true)

                        local start, interior = vSERVER.tryUnlockHome(home,itemSlot)
                        if start then
                            startHomeRobbery(home,interior)
                        end

                        vRP.stopAnim(true)
                    else
                        TriggerEvent('Notify', 'negado', 'Roubo a Residência', 'Você não pode roubar o <b>Residência</b> com uma arma na mão, guarde ela.') 
                    end
                end
            end
        end
    end
end)

function startHomeRobbery(homeName,interior, dontReport)
    local homeData = homesConfig[homeName]  
    if homeData then
        local loots = {}
        local interiorData = HomesRobbery.interiors[interior]
        local recentReport = false

        inRobbery = true

        Citizen.CreateThread(function()
            
            DoScreenFadeOut(1000)
            while (not IsScreenFadedOut()) do
                Citizen.Wait(10)
            end           
            
            sHOME.setBucket(homeName, true)

            local ped = PlayerPedId()
            
            SetEntityCoords(ped,interiorData._door.x,interiorData._door.y,interiorData._door.z)
            SetEntityHeading(ped,interiorData._door.w)
            
            exports.core:blockStealth(false)
            TaskForceMotionState(ped, 1110276645, 1)

            Citizen.Wait(800)
            DoScreenFadeIn(1000)

            while inRobbery do
                ped = PlayerPedId()
                local coords = GetEntityCoords(ped)

                local noise = GetPlayerCurrentStealthNoise(PlayerId())
                if (noise > 1.5) and (not recentReport) and (not dontReport) then
                    recentReport = true
                    vSERVER.stealthFail(homeName)
                    Citizen.SetTimeout(8000,function() recentReport = false end)
                end

                if (not GetPedStealthMovement(ped)) and exports.core:IsCrouched() then
                    ExecuteCommand('Crouch')
                    TaskForceMotionState(ped, 1110276645, 1)
                end

                for k,v in pairs(interiorData) do
                    local dist = #(coords - v.xyz)
                    if (dist <= 0.5) then
                        if (k ~= '_door') then
                            if (not loots[k]) and (not dontReport) then
                                DrawMarker3D(v,'~b~[E]~w~ - ROUBAR')
                                if IsControlJustPressed(0,38) then
                                    loots[k] = true
                                    
                                    SetEntityHeading(ped,v.w)

                                    LocalPlayer.state.BlockTasks = true
                                    LocalPlayer.state.freezeEntity = true
                                    vRP.playAnim(true, {{'amb@prop_human_parking_meter@female@idle_a','idle_a_female'}}, true)
                                    
                                    TriggerEvent('ProgressBar',6000)
                                    Wait(6000)
                                    
                                    vRP.stopAnim(true)
                                    LocalPlayer.state.freezeEntity = false
                                    LocalPlayer.state.BlockTasks = false

                                    vSERVER.lootHome(homeName,k)
                                end
                            end
                        else
                            DrawMarker3D(v,'~b~[E]~w~ - SAIR')
                            if IsControlJustPressed(0,38) then
                                
                                DoScreenFadeOut(1000)
                                while (not IsScreenFadedOut()) do
                                    Citizen.Wait(10)
                                end  

                                sHOME.setBucket(homeName, false)
                                vSERVER.robberyDone(homeName)
                                exports.core:blockStealth(true)
                                SetEntityCoords(ped,homeData.coord.x,homeData.coord.y,homeData.coord.z)
                                Citizen.Wait(800)
                                DoScreenFadeIn(1000)
                                inRobbery = false
                            end
                        end

                    end
                end

                Citizen.Wait(1)
            end
        end)
    end
end
cli.startHomeRobbery = startHomeRobbery

DrawMarker3D = function(coords, text)
	SetDrawOrigin(coords.x, coords.y, coords.z, 0); 
	SetTextFont(4)     
	SetTextProportional(0)     
	SetTextScale(0.35,0.35)    
	SetTextColour(255,255,255,255)   
	SetTextDropshadow(0, 0, 0, 0, 255)     
	SetTextEdge(2, 0, 0, 0, 150)     
	SetTextDropShadow()     SetTextOutline()     
	SetTextEntry("STRING")     SetTextCentre(1)     
	AddTextComponentString(text) 
	DrawText(0.0, 0.0)     
	ClearDrawOrigin() 
end

local blip = {}
RegisterNetEvent('homes_robbery:blip', function(coord, user_id)
	if (not DoesBlipExist(blip[user_id])) then
		PlaySoundFrontend(-1, 'Enter_1st', 'GTAO_FM_Events_Soundset', false)

		blip[user_id] = AddBlipForCoord(coord)
		SetBlipScale(blip[user_id], 0.5)
		SetBlipSprite(blip[user_id], 58)
		SetBlipColour(blip[user_id], 3)
		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString('Roubo Residência')
		EndTextCommandSetBlipName(blip[user_id])
		SetBlipAsShortRange(blip[user_id], true)

		Citizen.SetTimeout(35000,function()
			if (DoesBlipExist(blip[user_id])) then
				RemoveBlip(blip[user_id])
			end
		end)
	end
end)