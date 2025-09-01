vRP.getMenuCelular = function()
	return menu_celular
end

local menu_celular = false

RegisterNetEvent('status:celular', function(status)
	menu_celular = status
	if menu_celular then
		Citizen.CreateThread(function()
			while (menu_celular) do
				Citizen.Wait(1)
				BlockWeaponWheelThisFrame()
				DisableControlAction(0, 16, true)
				DisableControlAction(0, 17, true)
				DisableControlAction(0, 24, true)
				DisableControlAction(0, 25, true)
				DisableControlAction(0, 29, true)
				DisableControlAction(0, 56, true)
				DisableControlAction(0, 57, true)
				DisableControlAction(0, 73, true)
				DisableControlAction(0, 166, true)
				DisableControlAction(0, 167, true)
				DisableControlAction(0, 170, true)				
				DisableControlAction(0, 182, true)	
				DisableControlAction(0, 187, true)
				DisableControlAction(0, 188, true)
				DisableControlAction(0, 189, true)
				DisableControlAction(0, 190, true)
				DisableControlAction(0, 243, true)
				DisableControlAction(0, 245, true)
				DisableControlAction(0, 257, true)
				DisableControlAction(0, 288, true)
				DisableControlAction(0, 289, true)
				DisableControlAction(0, 344, true)			
			end
		end)
	end
end)

local objIDS = Tools.newIDGenerator()
local objects = {}

vRP.loadAnimSet = function(dict)
	RequestAnimSet(dict)
	while not HasAnimSetLoaded(dict) do Citizen.Wait(10) end
	SetPedMovementClipset(PlayerPedId(), dict, 0.25)
end

vRP.CarregarAnim = function(dict)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do Citizen.Wait(10) end
end

vRP.CarregarObjeto = function(dict, anim, prop, flag, hand, pos1, pos2, pos3, pos4, pos5, pos6, anim2)
	local ped = PlayerPedId()

	RequestModel(GetHashKey(prop))
	while not HasModelLoaded(GetHashKey(prop)) do
		Citizen.Wait(10)
	end

	local id = objIDS:gen()

	if pos1 then
		if (anim2) then 
			vRP.CarregarAnim(dict)
			TaskPlayAnim(ped,dict,anim,3.0,3.0,-1,flag,0,0,0,0)
		end
		
		local coords = GetOffsetFromEntityInWorldCoords(ped,0.0,0.0,-5.0)
		local object = CreateObject(GetHashKey(prop),coords.x,coords.y,coords.z,true,true,true)
		SetEntityCollision(object,false,false)
		AttachEntityToEntity(object,ped,GetPedBoneIndex(ped,hand),pos1,pos2,pos3,pos4,pos5,pos6,true,true,false,true,1,true)
		Citizen.InvokeNative(0xAD738C3085FE7E11,object,true,true)
		objects[id] = object
	else
		vRP.CarregarAnim(dict)
		TaskPlayAnim(ped,dict,anim,3.0,3.0,-1,flag,0,0,0,0)
		local coords = GetOffsetFromEntityInWorldCoords(ped,0.0,0.0,-5.0)
		local object = CreateObject(GetHashKey(prop),coords.x,coords.y,coords.z,true,true,true)
		SetEntityCollision(object,false,false)
		AttachEntityToEntity(object,ped,GetPedBoneIndex(ped,hand),0.0,0.0,0.0,0.0,0.0,0.0,false,false,false,false,2,true)
		Citizen.InvokeNative(0xAD738C3085FE7E11,object,true,true)
		objects[id] = object
	end

	LocalPlayer.state.PlayAnim = true
	return id
end

vRP.DeletarObjeto = function(id)
	vRP.stopAnim(true)
	TriggerEvent('animationsEvent', 'binoculos', false)
	TriggerEvent('animationsEvent', 'camera2', false)
	if id and objects[id] then
		if DoesEntityExist(objects[id]) then
			TriggerServerEvent("trydeleteobj",ObjToNet(objects[id]))
			objects[id] = nil
			objIDS:free(id)
		end
	else
		for idx,obj in pairs(objects) do
			if DoesEntityExist(obj) then
				TriggerServerEvent("trydeleteobj",ObjToNet(obj))
				objects[idx] = nil
				objIDS:free(idx)
			end
		end
	end
end

RegisterNetEvent("syncclean")
AddEventHandler("syncclean",function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				SetVehicleDirtLevel(v,0.0)
				SetVehicleUndriveable(v,false)
				vRP.DeletarObjeto()
			end
		end
	end
end)

RegisterNetEvent("syncdeleteped")
AddEventHandler("syncdeleteped",function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToPed(index)
		if DoesEntityExist(v) then
			Citizen.InvokeNative(0xAD738C3085FE7E11,v,true,true)
			SetPedAsNoLongerNeeded(Citizen.PointerValueIntInitialized(v))
			DeletePed(v)
		end
	end
end)