local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

anim = {}
Tunnel.bindInterface("fluxo-animacoes",anim)

local animDelay = {}

RegisterNetEvent("animacoes:e:together",function(emoteKey)
	local src = source
	local user_id = vRP.getUserId(src)
	if not user_id then
		return
	end

	local identidade = vRP.getUserIdentity(user_id)
	local nplayer = vRPclient.getNearestPlayer(src,2)
	if nplayer and tonumber(nplayer) > 0 then
		if emoteKey == 'beijar' then
			local ok = vRP.request(nplayer, "Você aceitar beijar o "..identidade.name.." "..identidade.firstname.." ?", 60)
			if ok then
				vRPclient._playAnim(src,true,{{"mp_ped_interaction","kisses_guy_a",1}},false)
				vRPclient._playAnim(nplayer,true,{{"mp_ped_interaction","kisses_guy_a",1}},false)
			else
				vRPclient._notify(src, "Seu beijo foi recusado :c")
			end
		end
	else
		vRPclient._notify(src, "Nenhum player próximo!")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /e2
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('e2', function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"staff.permissao") then
		local nplayer = vRPclient.getNearestPlayer(source,2)
		if nplayer then
			TriggerClientEvent("emotes",nplayer,args[1])
		end
	end
end)
RegisterCommand('e3', function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	print('animacao', user_id)
	if vRP.hasPermission(user_id,"staff.permissao") then
		print(user_id)
		local nplayer = vRP.getUserSource(parseInt(args[2]))
		if nplayer then
			TriggerClientEvent("emotes",nplayer,args[1])
		end
	end
end)
RegisterCommand('e4', function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id, "mindmaster.permissao") and #args > 0 then
		local players = vRPclient.getNearestPlayers(source, parseInt(args[2]))
		async(function()
			for plSource,plDistance in pairs(players) do
				TriggerClientEvent("emotes", parseInt(plSource), args[1])
			end
			TriggerClientEvent("emotes", source, args[1])
		end)
	end
end)

function anim.checkitem(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryItemAmount(user_id,item) >= 1 then
			return true 
		else
			TriggerClientEvent("Notify",source,"negado","Você não possui um <b>"..item.."</b> na mochila.") 
			return false
		end
	end
end

RegisterNetEvent("tryclean",function(nveh)
	if vRP.validateType(source, nveh) then
		TriggerClientEvent("syncclean",-1,nveh)
	end
end)

-- RegisterNetEvent("syncdeleteveh")
-- AddEventHandler("syncdeleteveh",function(index)
-- 	Citizen.CreateThread(function()
-- 		if NetworkDoesNetworkIdExist(index) then
-- 			SetVehicleAsNoLongerNeeded(index)
-- 			SetEntityAsMissionEntity(index,true,true)
-- 			local v = NetToVeh(index)
-- 			if DoesEntityExist(v) then
-- 				SetVehicleHasBeenOwnedByPlayer(v,false)
-- 				PlaceObjectOnGroundProperly(v)
-- 				SetEntityAsNoLongerNeeded(v)
-- 				SetEntityAsMissionEntity(v,true,true)
-- 				DeleteVehicle(v)
-- 			end
-- 		end
-- 	end)
-- end)

RegisterServerEvent('PiggyBack:sync')
AddEventHandler('PiggyBack:sync', function(target, animationLib, animation, animation2, distans, distans2, height,targetSrc,length,spin,controlFlagSrc,controlFlagTarget,animFlagTarget)
	if targetSrc == -1 then
		return vRP.validateType(source, {})
	end
	TriggerClientEvent('PiggyBack:syncTarget', targetSrc, source, animationLib, animation2, distans, distans2, height, length,spin,controlFlagTarget,animFlagTarget)	
	TriggerClientEvent('PiggyBack:syncMe', source, animationLib, animation,length,controlFlagSrc,animFlagTarget)
end)

RegisterServerEvent('PiggyBack:stop')
AddEventHandler('PiggyBack:stop', function(targetSrc)
	TriggerClientEvent('PiggyBack:cl_stop', targetSrc)
end)

RegisterServerEvent('CarryPeople:sync55')
AddEventHandler('CarryPeople:sync55', function(target, animationLib,animationLib2, animation, animation2, distans, distans2, height,targetSrc,length,spin,controlFlagSrc,controlFlagTarget,animFlagTarget)
	if targetSrc == -1 then
		return vRP.validateType(source, {})
	end
	TriggerClientEvent('CarryPeople:syncTarget55', targetSrc, source, animationLib2, animation2, distans, distans2, height, length,spin,controlFlagTarget,animFlagTarget)
	TriggerClientEvent('CarryPeople:syncMe55', source, animationLib, animation,length,controlFlagSrc,animFlagTarget)
end)

RegisterServerEvent('CarryPeople:stop55')
AddEventHandler('CarryPeople:stop55', function(targetSrc)
	TriggerClientEvent('CarryPeople:cl_stop55', targetSrc)
end)
