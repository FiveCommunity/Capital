local bansType = {
    ['vehicles'] = function(source, user_id, model)
        local coords = GetEntityCoords(GetPlayerPed(source))
        exports.garage:deleteNearest(coords, 5.0)
        
        local whitelist_id = exports.system:getUserWhitelist(user_id)
        if (whitelist_id) then
            exports.system:setUserBanned(whitelist_id, true, 'Spawn de veículo', 0, 0)
        end

        DropPlayer(source, '[GB Anti-Cheat]: Você foi banido por spawnar um veículo.')

        vRP.webhook('anticheatgb', {
            title = 'Capital Anticheat',
            descriptions = {
                { 'user', user_id },
                { 'banned', 'true' },
                { 'coord', tostring(GetEntityCoords(GetPlayerPed(source))) },
                { 'type', 'Spawn de veículo' },
                { 'vehicle model', model }
            }
        })  
    end
}

RegisterNetEvent('gb_anticheat', function(type, model)
    local source = source
    local user_id = vRP.getUserId(source)
    if (user_id) then
        if (bansType[type]) then
            bansType[type](source, user_id, model)
        end
    end
end)

RegisterNetEvent('gb_core:shoting', function(coord)
    local source = source
    if Player(source).state.isPlayingEvent then 
        return 
    end 
    local user_id = vRP.getUserId(source)
    if (user_id) then
        vRP.webhook('disparos', {
            title = 'disparos',
            descriptions = {
                { 'user', user_id },
                { 'coord', tostring(coord) }
            }
        })  

        if (GetPlayerRoutingBucket(source) ~= 0) then return; end;
        if (vRP.checkPermissions(user_id, { 'policia.permissao', 'staff.permissao', 'attachs2.permissao' })) then return; end;

        exports.vrp:reportUser(user_id, {
            notify = { 
                type = 'default', 
                title = 'Disparos arma de fogo', 
                message = 'Denúncia Anônima',
                coords = coord,
                time = 8000
            },
            blip = {
                id = user_id, 
                text = 'Disparos arma de fogo', 
                coords = coord,
                sprite = 10, colour = 1, 
                timeout = 15000
            }
        })
    end
end)

local srv = {}
Tunnel.bindInterface(GetCurrentResourceName()..':misc', srv)

srv.setBucket = function(number)
    local source = source
    SetPlayerRoutingBucket(source, number)
end

local propwlwl = {
    [1393541839] = true,
    [-131025346] = true,
    [1729911864] = true,
	[1298918533] = true,

	-- PARAQUEDAS --
	[1269906701] = true,
	[-1038982469] = true,
	[-313681483] = true,
	[1336576410] = true,
	[1740193300] = true,
	[1654893215] = true,
	[1746997299] = true,
	[643651670] = true,
	[218548447] = true,
	[-155651337] = true,
	
	[-422877666] = true, -- VIBRADOR

	[GetHashKey("prop_car_engine_01")] = true,
	[GetHashKey("prop_cs_burger_01")] = true,
	[GetHashKey("prop_cs_hotdog_01")] = true,
	[GetHashKey("prop_amb_donut")] = true,
	[GetHashKey("prop_sandwich_01")] = true,
	[GetHashKey("prop_choc_ego")] = true,

	[GetHashKey("prop_binoc_01")] = true,
	[GetHashKey("prop_pap_camera_01")] = true,

	-- RCORE POOL --
	[1184113278] = true,
    [GetHashKey("prop_pool_cue")] = true,
    [GetHashKey("prop_poolball_1")] = true,
    [GetHashKey("prop_poolball_10")] = true,
    [GetHashKey("prop_poolball_11")] = true,
    [GetHashKey("prop_poolball_12")] = true,
    [GetHashKey("prop_poolball_13")] = true,
    [GetHashKey("prop_poolball_14")] = true,
    [GetHashKey("prop_poolball_15")] = true,
    [GetHashKey("prop_poolball_2")] = true,
    [GetHashKey("prop_poolball_3")] = true,
    [GetHashKey("prop_poolball_4")] = true,
    [GetHashKey("prop_poolball_5")] = true,
    [GetHashKey("prop_poolball_6")] = true,
    [GetHashKey("prop_poolball_7")] = true,
    [GetHashKey("prop_poolball_8")] = true,
    [GetHashKey("prop_poolball_9")] = true,
    [GetHashKey("prop_poolball_cue")] = true,
	-- RCORE POOL --

	[-205311355] = true,
	[1245865676] = true,
	[-874338148] = true,
    [GetHashKey("prop_mp_barrier_02b")] = true,
    [GetHashKey("prop_mp_cone_02")] = true,
    [GetHashKey("prop_amb_phone")] = true,
	[GetHashKey("hei_prop_dlc_tablet")] = true,
	[GetHashKey("prop_tennis_rack_01b")] = true,
	[GetHashKey("prop_buck_spade_09")] = true,
	[GetHashKey("prop_range_target_01")] = true,
	[GetHashKey("ng_proc_paper_02a")] = true,
	[GetHashKey("prop_mp_cone_02")] = true,
	[GetHashKey("prop_sign_road_06g")] = true,
	[GetHashKey("ng_proc_spraycan01b")] = true,
	[GetHashKey("p_loose_rag_01_s")] = true,
	[GetHashKey("prop_cs_fuel_nozle")] = true,
	[GetHashKey("hei_prop_heist_thermite_flash")] = true,
	[GetHashKey("p_ld_heist_bag_s_pro_o")] = true,
	[GetHashKey("prop_anim_cash_pile_02")] = true,
	[GetHashKey("prop_laptop_01a")] = true,
	[GetHashKey("bkr_prop_bkr_cashpile_04")] = true,
	[GetHashKey("prop_anim_cash_note")] = true,
	[GetHashKey("gnd_desfribilador_maleta")] = true,
	[GetHashKey("prop_cs_tablet")] = true,
	[GetHashKey("h4_prop_bush_cocaplant_01")] = true,
	[GetHashKey("prop_am_box_wood_01")] = true,
	[GetHashKey("h4_prop_tree_umbrella_sml_01")] = true,
	[GetHashKey("prop_cs_hand_radio")] = true,
	[GetHashKey("prop_paper_bag_small")] = true,
	[GetHashKey("prop_binoc_01")] = true,
	[GetHashKey("sln_moon")] = true,
    [GetHashKey("gnd_varinha_01")] = true,
	[GetHashKey("gnd_varinha_02")] = true,
	[GetHashKey("gnd_varinha_03")] = true,
	[GetHashKey("gnd_varinha_04")] = true,
	[GetHashKey("gnd_varinha_05")] = true,
    [GetHashKey("universestore_knife_e")] = true,
	[GetHashKey("universestore_sfera_hell_01a")] = true,
	[GetHashKey("universestore_sfera_hell_01b")] = true,
	[GetHashKey("universestore_sfera_hell_01c")] = true,
	[GetHashKey("grimorio_azul_hz")] = true,
	[GetHashKey("oml_c_quebra")] = true,
	[GetHashKey("prop_table_03b_cs")] = true,
	[GetHashKey("mah_chimas")] = true,
    [GetHashKey("prop_donut_02")] = true,
	[GetHashKey("prop_peyote_chunk_01")] = true,
	[GetHashKey("ng_proc_sodacan_01b")] = true,
	[GetHashKey("lb_phone_prop")] = true,
	[GetHashKey("ng_proc_candy01a")] = true,
	[GetHashKey("gnd_ice_cube_prop")] = true,
    [GetHashKey('p_crahsed_heli_s')] = true,  
    [GetHashKey('gnd_desfribilador_prop')] = true,  
    [GetHashKey('prop_rub_carwreck_2')] = true,  
    [GetHashKey('prop_rub_carwreck_5')] = true,  
    [GetHashKey('prop_rub_carwreck_12')] = true,  
    [GetHashKey('prop_rub_carwreck_14')] = true,  
    [GetHashKey('prop_rub_carwreck_17')] = true,  
    [GetHashKey('prop_film_cam_01')] = true,  
}


RegisterCommand('get7', function(source, args)
    local userId = vRP.getUserId(source)
    
    if vRP.hasPermission(userId, 'streamer.permissao') then
        local nPlayer = vRPclient.getNearestPlayer(source, 2)
        local nUserId = vRP.getUserId(nPlayer)

        local userIdentity = vRP.getUserIdentity(userId)
        local nUserIdentity = vRP.getUserIdentity(nUserId)

        vRP.webhook('https://discord.com/api/webhooks/1311356082538549269/QWKHWpuuzdKwKmP_AHzLpXbkDXqYwZZ1zUyuRM-3eCXYWTe5YosUyKmlZf8XuFle-C1N', {
            title = 'Denuncia 7 Tela',
            descriptions = {
                { 'ID Denunciante', userId },
                { 'Nome Denunciante', userIdentity.firstname..' '..userIdentity.lastname},
                { '--', '--' },
                { 'ID Denunciado', nUserId },
                { 'Nome Denunciado', nUserIdentity.firstname..' '..nUserIdentity.lastname },
                { 'Steam Denunciado', nUserIdentity.steam },
            }
        }) 
    end
end)

-- AddEventHandler('entityCreating', function(entity)  
--     if DoesEntityExist(entity) then
--         local entitytype = GetEntityType(entity)
--         local model = GetEntityModel(entity)
--         if entitytype and entitytype == 3 and not propwlwl[model] then
--             DeleteEntity(entity)
--             CancelEvent()
--         --else
--             --print('Prop gerada fora da Whitelist, prop deletada [HASH]: '..GetHashKey(entity))
--         end
--     end
-- end)

RegisterNetEvent('perfectCity:Bucket', function(bucket)
    local _source = source
    SetPlayerRoutingBucket(_source, bucket)
end)