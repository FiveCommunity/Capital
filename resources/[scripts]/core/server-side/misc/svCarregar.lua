local carregarSrc = {}
local carregarStarting = {}

RegisterServerEvent('vrp_carry:carryStart', function()
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        if (vRP.getInventoryItemAmount(user_id, 'cordas') >= 1) or (vRP.getInventoryItemAmount(user_id, 'cp-cordas') >= 1)  then
            local sync_player = vRPclient.getNearestPlayer(source, 3)
            if (sync_player) and not carregarStarting[source] then
                carregarStarting[source] = true
                if Player(sync_player).state.Handcuff or Player(sync_player).state.StraightJacket or (GetEntityHealth(GetPlayerPed(sync_player)) <= 100) or exports.hud:request(sync_player, 'Carregar', 'Voce aceita ser carregado?', 30000) then
                    local animationLib = 'missfinale_c2mcs_1'
                    local animationLib2	= 'nm'
                    local animation = 'fin_c2_mcs_1_camman'
                    local animation2 = 'firemans_carry'
                    local distans = 0.15
                    local distans2 = 0.27
                    local height = 0.63
                    local length = 100000
                    local spin = 0.0			
                    local controlFlagSrc = 49
                    local controlFlagTarget = 33
                    local animFlagTarget = 1
                        
                    carregarSrc[source] = sync_player

                    TriggerClientEvent('vrp_carry:carryTarget', sync_player, source, animationLib2, animation2, distans, distans2, height, length,spin,controlFlagTarget,animFlagTarget)
			        TriggerClientEvent('vrp_carry:carryMe', source, animationLib, animation,length,controlFlagSrc,animFlagTarget)
                end
                carregarStarting[source] = nil
            end
        else
            TriggerClientEvent('notify', source, 'Carregar', 'Você precisa de uma <b>corda</b>!')
        end
    end
end)

RegisterServerEvent('vrp_carry:carryTryStop', function()
	local source = source
	local sync_player = carregarSrc[source]
	if (sync_player) then
		carregarSrc[source] = nil
		TriggerClientEvent('vrp_carry:carryStop', source)
		TriggerClientEvent('vrp_carry:carryStop', sync_player)
	end
end)

local cavalinhoSrc = {}
RegisterServerEvent('vrp_carry:piggyBackStart', function()	
	local source = source
	local user_id = vRP.getUserId(source)
    if (user_id) then
        if (vRP.getInventoryItemAmount(user_id, 'cordas') >= 1) then
            local sync_player = vRPclient.getNearestPlayer(source,3)
            if sync_player and (not carregarStarting[source]) then
                carregarStarting[source] = true
                if Player(sync_player).state.Handcuff or Player(sync_player).state.StraightJacket or (GetEntityHealth(GetPlayerPed(sync_player)) <= 100 or exports.hud:request(sync_player, 'Carregar', 'Voce aceita ser carregado?', 30000)) then
                    local animationLib = 'anim@arena@celeb@flat@paired@no_props@'
                    local animation = 'piggyback_c_player_a'
                    local animation2 = 'piggyback_c_player_b'
                    local distans = -0.07
                    local distans2 = 0.0
                    local height = 0.45
                    local spin = 0.0		
                    local length = 100000
                    local controlFlagSrc = 49
                    local controlFlagTarget = 33
                    local animFlagTarget = 1

                    cavalinhoSrc[source] = sync_player

                    TriggerClientEvent('vrp_carry:piggyBackTarget', sync_player, source, animationLib, animation2, distans, distans2, height, length,spin,controlFlagTarget,animFlagTarget)
                    TriggerClientEvent('vrp_carry:piggyBackMe', source, animationLib, animation,length,controlFlagSrc,animFlagTarget)
                end
                carregarStarting[source] = nil
            end
        end
    end
end)

RegisterServerEvent('vrp_carry:piggyBackTryStop', function(targetSrc)
	local source = source
	local sync_player = cavalinhoSrc[source]
	if sync_player then
		cavalinhoSrc[source] = nil
		TriggerClientEvent('vrp_carry:piggyBackStop', source)
		TriggerClientEvent('vrp_carry:piggyBackStop', sync_player)
	end
end)