local config = module('core', 'cfg/cfgAnimations')
local configAnimations = config.animations

local function handcuffed(source)
    local state = Player(source).state
    return (state.Handcuff or state.StraightJacket)
end

RegisterCommand('e', function(source, args)
    local _userId = vRP.getUserId(source)
    if (GetEntityHealth(GetPlayerPed(source)) > 100) and not handcuffed(source) then
        local animation = configAnimations.animations[args[1]]
        if (animation) then
            if (animation.noCommand) then return; end;
            if (vRP.checkPermissions(_userId, animation.perm)) then
                TriggerClientEvent('gb_animations:setAnim', source, args[1])
            end
        end
    end
end)

RegisterCommand('e2', function(source, args)
    local user_id = vRP.getUserId(source)
    if (user_id) and vRP.hasPermission(user_id, 'staff.permissao') then
        local animation = configAnimations.animations[args[1]]
        if (animation) then
            local nsource = (args[2] and vRP.getUserSource(parseInt(args[2])) or vRPclient.getNearestPlayer(source, 2.0))
            if (nsource) then
                TriggerClientEvent('gb_animations:setAnim', nsource, args[1])
                vRP.webhook('animation', {
                    title = 'animação',
                    descriptions = {
                        { 'action', '(e2)' },
                        { 'staff', user_id },
                        { 'target', vRP.getUserId(nsource) },
                        { 'anim', args[1] }
                    }
                })     
            end
        else
            TriggerClientEvent('notify', source, 'Animação', 'Você não escolheu uma <b>dança</b> existente!')
        end
    end
end)

RegisterCommand('e3', function(source, args)
    local user_id = vRP.getUserId(source)
    if (user_id) and vRP.hasPermission(user_id, 'staff.permissao') then
        local animation = configAnimations.animations[args[1]]
        if (animation) then
            local radius = (args[2] and parseInt(args[2]) or 10)

            local players = vRPclient.getNearestPlayers(source, radius)
            for src, id in pairs(players) do
                TriggerClientEvent('gb_animations:setAnim', src, args[1])
            end

            vRP.webhook('animation', {
                title = 'animação',
                descriptions = {
                    { 'action', '(e3)' },
                    { 'staff', user_id },
                    { 'anim', args[1] },
                    { 'radius', radius }
                }
            })     
        else
            TriggerClientEvent('notify', source, 'Animação', 'Você não escolheu uma <b>dança</b> existente!')
        end
    end
end)

RegisterCommand('ec', function(source, args)
    local _userId = vRP.getUserId(source)
    if (GetEntityHealth(GetPlayerPed(source)) > 100) and not handcuffed(source) then
        local animation = configAnimations.shared[args[1]]
        if (animation) then
            if (vRP.checkPermissions(_userId, animation.perm)) then
                local nSource = vRPclient.getNearestPlayer(source, 2)
                if (nSource) then
                    if (GetEntityHealth(GetPlayerPed(nSource)) > 100) and not handcuffed(nSource) then 
                        local identity = vRP.getUserIdentity(_userId)
                        local request = exports.hud:request(nSource, 'Animação', 'Você deseja aceitar a animação '..args[1]:upper()..' de '..identity.firstname..' '..identity.lastname..'?', 30000)
                        if (request) then
                            TriggerClientEvent('gb_animations:setAnimShared', source, args[1], nSource)
                            TriggerClientEvent('gb_animations:setAnimShared2', nSource, animation.otherAnim, source)
                        end
                    end
                end
            end
        end
    end
end)

RegisterCommand('andar', function(source, args)
    local user_id = vRP.getUserId(source)
    if (user_id and args[1]) then
        local anim = configAnimations.walkAnim[parseInt(args[1])]
        if (anim) and vRP.checkPermissions(user_id, anim.perm) then
            TriggerClientEvent('anim-setWalking', source, anim.anim)
        end
    end
end)

RegisterCommand('ex', function(source, args)
    local user_id = vRP.getUserId(source)
    if (user_id and args[1]) then
        local anim = configAnimations.expression[args[1]]
        if (anim) and vRP.checkPermissions(user_id, anim.perm) then
            TriggerClientEvent('anim-setExpression', source, anim.anim)
        end
    end
end)


RegisterNetEvent('gb_animation:sharedServer', function(target)
    TriggerClientEvent('gb_animation:sharedClearAnimation', target)
end)

RegisterNetEvent('gb_interactions:execAnimation', function(value)
    local _source = source
    local _userId = vRP.getUserId(source)
    if (GetEntityHealth(GetPlayerPed(_source)) > 100) and not handcuffed(_source) then
        if (value[1] == 'shared') then
            local animation = configAnimations.shared[value[2]]
            if (animation) then
                if (vRP.checkPermissions(_userId, animation.perm)) then
                    local nSource = vRPclient.getNearestPlayer(_source, 2)
                    if (nSource) then
                        if (GetEntityHealth(GetPlayerPed(nSource)) > 100) and not handcuffed(nSource) then
                            local identity = vRP.getUserIdentity(_userId)
                            local request = exports.hud:request(nSource, 'Animação', 'Você deseja aceitar a animação '..value[2]:upper()..' de '..identity.firstname..' '..identity.lastname..'?', 30000)
                            if (request) then
                                TriggerClientEvent('gb_animations:setAnimShared', _source, value[2], nSource)
                                TriggerClientEvent('gb_animations:setAnimShared2', nSource, animation.otherAnim, _source)
                            end
                        end
                    end
                end
            end
        else
            local animation = configAnimations.animations[value[2]]
            if (animation) then
                if (vRP.checkPermissions(_userId, animation.perm)) then
                    TriggerClientEvent('gb_animations:setAnim', _source, value[2])
                end
            end
        end  
    end
end)