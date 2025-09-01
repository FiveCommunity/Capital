function isTrunkRobberyVehicle(entity)
    return NetworkGetEntityIsNetworked(entity) and (not Entity(entity).state['id']) and (not Entity(entity).state['trunk_robbery'])
end

function robberyTrunk(entity)
	TriggerServerEvent('trydoors', VehToNet(entity), 5)
    if (math.random(1,100) <= 50) then TriggerServerEvent('trunkRob:callPolice'); end;
   
    LocalPlayer.state.BlockTasks = true
    LocalPlayer.state.disableTarget = true

    vRP.playAnim(false, {{'amb@prop_human_parking_meter@female@idle_a','idle_a_female'}}, true)

    local running = true
    local timeout = GetGameTimer()+20000

    TriggerEvent('ProgressBar', 20000)

    while (timeout > GetGameTimer()) do
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local dist =  #(coords - GetEntityCoords(entity))
        if (not DoesEntityExist(entity)) or ( dist > 5 ) or IsDisabledControlPressed(0,167) then
            TriggerEvent('Notify', 'negado', 'Roubos', 'O Roubo foi <b>cancelado</b>!')
            TriggerEvent('ProgressBar', 0)
            running = false
            break;
        end
        Citizen.Wait(1)
    end

    LocalPlayer.state.BlockTasks = false
    LocalPlayer.state.disableTarget = false

    ClearPedTasks(PlayerPedId())
    TriggerServerEvent('trydoors', VehToNet(entity), 5)
    
    if running then
        TriggerServerEvent('trunkRob:robbery',VehToNet(entity))
    end
end

Citizen.CreateThread(function()
    exports["target"]:RemoveTargetBone('boot',{ "Roubar Porta-Malas" })
    exports["target"]:AddTargetBone('boot',{
        options = { 
            { 
                icon = "fas fa-screwdriver",
                label = "Roubar Porta-Malas",
                canInteract = function(entity)
                    return TrunkRobbery.PlayerWeapons[GetSelectedPedWeapon(PlayerPedId())] and isTrunkRobberyVehicle(entity)
                end,
                action = robberyTrunk,
                distance = 1.0
            },            
        }
    })
end)

local blip = {}
RegisterNetEvent('trunk_robbery:blip', function(coord, user_id)
	if (not DoesBlipExist(blip[user_id])) then
		PlaySoundFrontend(-1, 'Enter_1st', 'GTAO_FM_Events_Soundset', false)

		blip[user_id] = AddBlipForCoord(coord)
		SetBlipScale(blip[user_id], 0.5)
		SetBlipSprite(blip[user_id], 58)
		SetBlipColour(blip[user_id], 3)
		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString('Roubo Porta-Malas')
		EndTextCommandSetBlipName(blip[user_id])
		SetBlipAsShortRange(blip[user_id], true)

		Citizen.SetTimeout(35000,function()
			if (DoesBlipExist(blip[user_id])) then
				RemoveBlip(blip[user_id])
			end
		end)
	end
end)