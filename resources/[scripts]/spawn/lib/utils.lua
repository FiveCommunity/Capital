if (isServer) then
    vRP._prepare('spawn:getCharacters', 'select * from user_characters where steam = @steam')
    vRP._prepare('spawn:createCharacter', 'insert ignore into user_characters (steam, firstname, lastname, age, registration, rh) values (@steam, @firstname, @lastname, @age, @registration, @rh)')
    vRP._prepare('spawn:saveDatatable', 'insert ignore into user_datatable (user_id, user_character, user_tattoo, user_clothes) values (@user_id, @user_character, @user_tattoo, @user_clothes)')
    vRP._prepare('spawn:getUserDatatable', 'select * from user_datatable where user_id = @user_id')
    vRP._prepare('spawn:checkAccount', 'select * from user_characters where id = @user_id and steam = @steam')
    vRP._prepare('spawn:createMoneyTable', 'insert ignore into user_moneys (user_id, bank, coins) values (@user_id, @bank, 0)')

    srv.changeSession = function(session)
        local source = source
        if (not session) then session = (source + 1000); end;
        SetPlayerRoutingBucket(source, session)
    end

    updateDiscord = function(user_id)
        if (user_id) then
            local identity = vRP.getUserIdentity(user_id)
            if (identity) then
                local whitelistId = exports.system:getUserWhitelist(user_id)
                if (not whitelistId) then return; end;

                local discord_id = exports.system:getUserDiscord(whitelistId)
                if (discord_id) then
                    exports.system:sendMessageForDiscord({
                        discordId = discord_id,
                        userId = user_id,
                        city = 'capitalcity',
                        name = identity.firstname..' '..identity.lastname
                    }, 'change_name')
                end
            end
        end
    end
else
    LocalPlayer.state:set('resetAppearance', false, true)

    Utils  = {
        Cam = { active = nil },
        Creator = {},
        Ready = false
    }

    RegisterNUICallback('NuiReady', function(data, cb)
        Utils.Ready = true
        cb('Ok')
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

    -- [ Creator System ] --

    local Creator = Utils.Creator

    function Creator:parsePart(key)
        if (type(key) == 'string' and string.sub(key, 1, 1) == 'p') then
            return true, tonumber(string.sub(key, 2))
        else
            return false, tonumber(key)
        end
    end

    function Creator:RequestModel(model)
        RequestModel(model) 
        while (not HasModelLoaded(model)) do 
            RequestModel(model) 
            Citizen.Wait(10) 
        end

        SetPlayerModel(PlayerId(), model)
        SetModelAsNoLongerNeeded(model)

        return true
    end

    function Creator:SetClothes(ped, clothes)
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
                    if k ~= 12 then
                        if (k ~= 2) then SetPedComponentVariation(ped, parseInt(k), v.model, v.var, (v.palette or 0)); end; 
                    end
                end
            end
        end
    end

    function Creator:Float(number)
        return (number + 0.0)
    end
    
    function Creator:Decrease(number, quantity)
        return (number - quantity)
    end

    function Creator:Teleport(x, y, z)
        local ply = PlayerPedId()
        if string.find(type(x), 'vec') then x, y, z = table.unpack(x) end
        SetEntityCoords(PlayerPedId(), x+0.0001, y+0.0001, z+0.0001, 1, 0, 0, 1)
        FreezeEntityPosition(ply, true)
        SetEntityCoords(ply, x + 0.0001, y + 0.0001, z + 0.0001, 1, 0, 0, 1)
        while (not HasCollisionLoadedAroundEntity(ply)) do
            FreezeEntityPosition(ply, true)
            SetEntityCoords(ply, x + 0.0001, y + 0.0001, z + 0.0001, 1, 0, 0, 1)
            RequestCollisionAtCoord(x, y, z)
            Wait(500)
        end
        SetEntityCoords(ply, x + 0.0001, y + 0.0001, z + 0.0001, 1, 0, 0, 1)
        FreezeEntityPosition(ply, false)
        Wait(1000)
    end
end