if (isServer) then
    AddEventHandler('playerSpawn', function(user_id, source) Player(source).state:set('inAppearance', false, true) end)

    vRP._prepare('appearance:saveClothes', 'update user_datatable set user_clothes = @user_clothes where user_id = @user_id')
    vRP._prepare('appearance:getClothes', 'select user_clothes from user_datatable where user_id = @user_id')
    vRP._prepare('appearance:getCharacter', 'select user_character from user_datatable where user_id = @user_id')
    vRP._prepare('appearance:saveUser', 'update user_datatable set user_character = @user_character where user_id = @user_id')
    vRP._prepare('appearance:getTattoos', 'select user_tattoo from user_datatable where user_id = @user_id')
    vRP._prepare('appearance:saveTattoo', 'update user_datatable set user_tattoo = @user_tattoo where user_id = @user_id')

    local shops = {
        skinshop = function(source, user_id, data, price)
            exports['phone-bank']:createStatement(user_id, { title = 'Loja de Roupas', content = 'Compra de roupas', value = price, type = 'spent' })
            vRP.execute('appearance:saveClothes', { user_id = user_id, user_clothes = json.encode(data) } )
            TriggerClientEvent('notify', source, 'sucesso', 'Loja de Roupas', 'Pagamento <b>efetuado</b> com sucesso!')
        end,
        barbershop = function(source, user_id, data, price)
            exports['phone-bank']:createStatement(user_id, { title = 'Barbearia', content = 'Mudanças na estética', value = price, type = 'spent' })
            vRP.execute('appearance:saveUser', { user_id = user_id, user_character = json.encode(data) } )
            TriggerClientEvent('notify', source, 'sucesso', 'Barbearia', 'Pagamento <b>efetuado</b> com sucesso!')
        end,
        tattooshop = function(source, user_id, data, price)
            exports['phone-bank']:createStatement(user_id, { title = 'Estúdio de Tatuagem', content = 'Mudanças no visual', value = price, type = 'spent' })
            vRP.execute('appearance:saveTattoo', { user_id = user_id, user_tattoo = json.encode(data) } )
            TriggerClientEvent('notify', source, 'sucesso', 'Estúdio de Tatuagem', 'Pagamento <b>efetuado</b> com sucesso!')
        end
    }

    srv.tryPayment = function(price, data, shop)
        local source = source
        local user_id = vRP.getUserId(source)
        if (user_id) then
            if (vRP.tryFullPayment(user_id, price)) then
                shops[shop](source, user_id, data, price)
                return true
            end
        end
        TriggerClientEvent('notify', source, 'negado', 'Loja de Roupas', 'Pagamento negado, Saldo <b>insuficiente</b>!')
        return false
    end

    srv.hasPermission = function(perm)
        local user_id = vRP.getUserId(source)
        return vRP.checkPermissions(user_id, perm)
    end
else
    Cache = { Cam = 'body', Heading = 0.0, oldHeading = 0.0 }

    Utils  = {
        Cam = { active = nil },
        Skinshop = {},
        Barbershop = {},
        Ready = false
    }

    Cams = {
        body = function()
            Utils.Cam:Create({ x = 0.0, y = 2.8, z = 1.2, fov = 35.0 }, { index = 21 }, false)
        end,
        head = function()
            Utils.Cam:Create({ x = 0.0, y = 2.0, z = 0.5, fov = 10.0 }, { index = 31086 }, false)
        end,
    }

    -- [ General ] --

    local openUi = {
        barbershop = function(index)
            openBarberShop(index) 
        end,
        skinshop = function(index)
            openSkinShop(index)
        end,
        tattooshop = function(index)
            openTattooShop(index)
        end
    }

    local nearestBlips = {}
    local threadStarted = false
    
    local startThread = function()
        if (threadStarted) then return; end;
        threadStarted = true

        Citizen.CreateThread(function()
            while (countTable(nearestBlips) > 0) do
                local ped = PlayerPedId()
                local cache = nearestBlips
                for index, dist in pairs(cache) do
                    local _config = configLocs[index]
                    DrawMarker(27, _config.coord.x, _config.coord.y, _config.coord.z, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 3, 187, 232, 155, 0, 0, 0, 1)
                
                    if (dist <= 1.2 and IsControlJustPressed(0, 38)) and (GetEntityHealth(ped) > 100 and not IsPedInAnyVehicle(ped)) and (not exports.hud:isWanted(true)) and (not LocalPlayer.state.Handcuff and not LocalPlayer.state.StraightJacket) then
                        if (vSERVER.hasPermission(_config.perm)) then
                            if (_config.type) then openUi[_config.type](index); end;
                        else
                            TriggerEvent('notify', 'negado', 'Loja', 'Sem permissão!')
                        end
                    end
                end
                Citizen.Wait(4)
            end
            threadStarted = false
        end)
    end

    local addBlips = function()
        for _, v in pairs(configLocs) do
            if (v.showBlip) then
                local coords = v.coord
                local blipConfig = configBlip[v.type]

                local blip = AddBlipForCoord(coords.xyz)
                SetBlipSprite(blip, blipConfig.id)
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
        addBlips()
        while (true) do
            local ped = PlayerPedId()
            local pCoord = GetEntityCoords(ped)
            nearestBlips = {}
            for k, v in pairs(configLocs) do
                local distance = #(pCoord - v.coord.xyz)
                if (distance <= 5.0) then
                    nearestBlips[k] = distance
                end
            end
            if (countTable(nearestBlips) > 0) then startThread(); end;
            Citizen.Wait(500)
        end
    end)

    setPlayersVisible = function(bool)
        local ped = PlayerPedId()
        CreateThread(function()
            while (LocalPlayer.state.inAppearance) do
                for _, player in ipairs(GetActivePlayers()) do
                    local otherPlayer = GetPlayerPed(player)
                    if (ped ~= otherPlayer) then
                        SetEntityVisible(otherPlayer, bool)
                    end
                end
                InvalidateIdleCam()
                Citizen.Wait(1)
            end
        end)
    end

    RegisterNuiCallback('changeCam', function(data, cb)
        if (LocalPlayer.state.inAppearance) then
            local newHeading = (data.rotation + 0.00)
            if (Cache.Heading ~= newHeading) then
                Cache.Heading = newHeading
                SetEntityHeading(PlayerPedId(), (Cache.oldHeading + newHeading))
            end

            local newPov = data.type
            if (Cams[newPov]) and (Cache.Cam ~= newPov) then 
                Cache.Cam = newPov
                Cams[newPov]()
            end
        end

        cb('Ok')
    end)

    closeUi = function()
        local ped = PlayerPedId()

        LocalPlayer.state.Hud = true
        LocalPlayer.state.inAppearance = false

        setPlayersVisible(true)
        SetNuiFocus(false, false)
        Utils.Cam:Destroy()

        if (oldCustom) then Utils.Skinshop:SetClothes(ped, oldCustom); end;

        fixAppearance(ped)

        oldCustom = {}
    end

    RegisterNuiCallback('close', function(data, cb)
        closeUi()

        cb('Ok')
    end)

    AddStateBagChangeHandler('inAppearance', nil, function(bagName, key, value) 
        local entity = GetPlayerFromStateBagName(bagName)
        if (entity == 0) or (PlayerId() ~= entity) then return; end;
        
        Citizen.CreateThread(function()
            local ped = PlayerPedId()
            local oldCoord = GetEntityCoords(ped)
            while (LocalPlayer.state.inAppearance) do
                ped = PlayerPedId()
                local distance = #(oldCoord - GetEntityCoords(ped))
                if (GetEntityHealth(ped) <= 100) or (distance >= 10.0) then
                    closeUi()
                    SendNUIMessage({ action = 'close' })
                end
                Citizen.Wait(1000)
            end
        end)
    end)

    -- [ Cam System ] --

    local Cam = Utils.Cam
    
    function Cam:Create(offset, bone, render)
        while (IsCamInterpolating(GetRenderingCam())) do Citizen.Wait(1); end;

        if (DoesCamExist(self.active)) then
            if (render) then RenderScriptCams(false, false, 0, false, false); end;
            SetCamActive(self.active, false)
            DestroyCam(self.active, false)
            self.active = nil
        end

        local ped = PlayerPedId()
        local coordsCam = GetOffsetFromEntityInWorldCoords(ped, offset.x, offset.y, offset.z)

        self.active = CreateCam('DEFAULT_SCRIPTED_CAMERA')

        SetCamCoord(self.active, coordsCam.x, coordsCam.y, coordsCam.z)
        SetCamRot(self.active, GetCamRot(self.active, 1))
        SetCamFov(self.active, offset.fov)
        SetCamActive(self.active, true)

        if (bone.index) then PointCamAtPedBone(self.active, ped, bone.index, 0.0, 0.0, 0.0); end;
        RenderScriptCams(true, true, 1500, true, true)
    end

    function Cam:Destroy()
        if (DoesCamExist(self.active)) then
            RenderScriptCams(false, false, 0, false, false)
            SetCamActive(self.active, false)
            DestroyCam(self.active, false)
            self.active = nil
        end
    end

    -- [ Skinshop System ] --

    local Skinshop = Utils.Skinshop

    function Skinshop:parsePart(key)
        if (type(key) == 'string' and string.sub(key, 1, 1) == 'p') then
            return true, tonumber(string.sub(key, 2))
        else
            return false, tonumber(key)
        end
    end

    function Skinshop:SetClothes(ped, clothes)
        for k, v in pairs(clothes) do
            if (k ~= 'pedModel') then
                local isProp, index = self:parsePart(k)
                if (isProp) then
                    if (v.model < 0) then
                        ClearPedProp(ped,index)
                    else
                        SetPedPropIndex(ped, index, v.model, v.var, (v.palette or 0))
                    end
                else
                    if (k ~= 2 and k ~= 12) then
                        SetPedComponentVariation(ped, parseInt(k), v.model, v.var, (v.palette or 0))
                    end
                end
            end
        end
        TriggerEvent('gb:barberUpdate')
	    TriggerEvent('gb:tattooUpdate')
    end

    -- [ Barbershop System ] --

    local Barbershop = Utils.Barbershop

    function Barbershop:Float(number)
        return (number + 0.0)
    end
end