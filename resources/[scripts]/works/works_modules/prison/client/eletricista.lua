sELETR = Tunnel.getInterface(GetCurrentResourceName()..':prison:eletric')

local eletricData = {
    select = 0
}

RegisterJob({
    name = 'Prison - Eletricista',
    business = 'Bolingbroke',
    payment = 'Itens',
    routes = 0,
    description = '',
    url = '',
    hidden = true,

    start = function()
        if (not inWork) then
            inWork = 'Prison - Eletricista'

            TriggerEvent('notify', 'importante', 'Eletricista', 'Você entrou em <b>serviço</b>! Limpe os locais para receber bonificações.<br><br>Pressione <b>F7</b> para sair do serviço.', 8000)
                        
            eletricData.select = sELETR.startRoute()

            Citizen.CreateThread(function()
                
                while (inWork) do
                    local ped = PlayerPedId()
                    local coords = GetEntityCoords(ped)
                    -- Point
                    local pointCoord = PrisonEletricista.points[eletricData.select]
                    local dist = #(coords - pointCoord.xyz)
                    
                    DrawMarker(0, pointCoord.x, pointCoord.y, pointCoord.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 3, 187, 232, 155, 1, 0, 0, 1, 0, 0, 0)
                    if (dist < 1.2) and (IsControlJustPressed(0,38) and not IsPedInAnyVehicle(ped)) then
                                    
                        if (type(pointCoord) == 'vector4') then
                            SetEntityHeading(ped,pointCoord.w)
                        end

                        LocalPlayer.state.freezeEntity = true
                        LocalPlayer.state.BlockTasks = true

                        TriggerEvent('gb_animations:setAnim', 'martelo')
                        TriggerEvent('ProgressBar', 15000)
                    
                        Wait(15000)
                       
                        ClearPedTasks(ped)
                        vRP.DeletarObjeto()
                        LocalPlayer.state.freezeEntity = false
                        LocalPlayer.state.BlockTasks = false

                        eletricData.select = sELETR.receivePayment()                        
                    end
                    Wait(1)
                end

                sELETR.reset()
                eletricData.select = 0
            end)
        end
    end,

    stop = function()
        inWork = false
        TriggerEvent('notify', 'importante', 'Eletricista', 'Você saiu de <b>serviço</b>!', 8000)
    end
})