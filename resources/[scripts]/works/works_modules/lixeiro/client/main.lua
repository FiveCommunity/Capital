sTRASH = Tunnel.getInterface(GetCurrentResourceName()..':trash')

local isCheck = false

Citizen.CreateThread(function()

    exports["target"]:RemoveTargetModel(Lixeiro.trashes, "Vasculhar Lixeira")
	exports["target"]:AddTargetModel(Lixeiro.trashes,{ 
        options = {
            { 
                icon = "fas fa-trash-alt",
                label = "Vasculhar Lixeira",
                distance = 1.5,

                canInteract = function(entity)
                    NetworkRegisterEntityAsNetworked(entity)
                    FreezeEntityPosition(entity,true)
                    return (not isCheck) and NetworkGetEntityIsNetworked(entity)
                end,

                action = function(entity)
                    local model = GetEntityModel(entity)
                    local coords = GetEntityCoords(entity)
                    local identifier = (tostring(model):sub(5)..Round(coords.x,1)..Round(coords.y,1)..Round(coords.z,1)):gsub("%.","-")

                    if (isCheck) then return; end;
                    isCheck = true

                    if sTRASH.tryLootTrash(identifier) then
                        local ped = PlayerPedId()
                        FreezeEntityPosition(ped,true)

                        LocalPlayer.state.BlockTasks = true
                        TriggerEvent('gb_animations:setAnim', 'mexer')
                        TriggerEvent('ProgressBar', 10000)
                    
                        SetTimeout(10000,function()
                            ped = PlayerPedId()
                            ClearPedTasks(ped)
                            FreezeEntityPosition(ped,false)                    
                            LocalPlayer.state.BlockTasks = false
                            isCheck = false
                        end)
                    else
                        isCheck = false
                    end
                end
            }
        }
    })
end)

function Round(num,numDecimalPlaces)
	local mult = 10^(numDecimalPlaces or 0)
	return math.floor(num*mult+0.5) / mult
end