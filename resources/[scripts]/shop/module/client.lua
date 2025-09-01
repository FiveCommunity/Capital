local addBlips = function()
    for _, v in pairs(configGeneral) do
        if (v.showBlip) then
            local coords = v.coord
            local blipConfig = configBlips[v.config]

            local blip = AddBlipForCoord(coords.xyz)
            SetBlipSprite(blip, blipConfig.sprite)
            SetBlipColour(blip, blipConfig.color)
            SetBlipScale(blip, blipConfig.scale)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentString(blipConfig.name)
            EndTextCommandSetBlipName(blip)
        end
    end
end

Citizen.CreateThread(function()
    TransitionFromBlurred(1000);
    addBlips();
    for k, v in pairs(configMachines) do
        exports.target:RemoveTargetModel(v.hash,v.name)
        exports.target:AddTargetModel(v.hash,{
            options = {
                {
                    icon = 'fas fa-cash-register',
                    label = v.name,
                    action = function(entity)
                        openShop(v)
                    end,
                }
            },
            distance = 1.5
        })
    end
end)

RegisterNetEvent('shop:open', function(arg)
    print(json.encode(configGeneral[arg], { indent = true }))
    openShop( configGeneral[arg] )
end)

local shopOpenned = false;
function openShop(config)
    if (config) then
        if (vSERVER.checkPermission(config.perm)) then
            shopOpenned = config.config
            print(json.encode(configShops[config.config], { indent  = true }))
            TransitionToBlurred(1000)
            SetNuiFocus(true, true)
            SendNUIMessage({
                action = 'shop',
                data = {
                    show = true,
                    wallet = vSERVER.getUserWallet(),
                    coins = (config.vip and vSERVER.getUserCoins() or false),
                    name = config.name,
                    type = config.type,
                    shopColor = config.color,
                    items = configShops[config.config]
                }
            })
        end
    end
end

----------------------------------------------------------------
-- Callback's
----------------------------------------------------------------
RegisterNUICallback('Checkout', function(data, cb)
    vSERVER.checkoutItem(data, shopOpenned)
    SendNUIMessage({
        action = 'wallet',
        wallet = vSERVER.getUserWallet()
    })

    cb('Ok')
end)

RegisterNUICallback('close', function(data, cb)
    shopOpenned = false
    SetNuiFocus(false, false)
    TransitionFromBlurred(1000)

    cb('Ok')
end)