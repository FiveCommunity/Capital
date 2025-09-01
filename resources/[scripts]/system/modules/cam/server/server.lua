local vCLIENT = Tunnel.getInterface('Cam')

RegisterCommand('cam', function(source)
	local user_id = vRP.getUserId(source)
	if (user_id) and vRP.checkPermissions(user_id, { 'staff.permissao', 'cam.permissao', 'jornal.permissao' }) then
		exports.chat:DisableChat(source, false)
		if Player(source).state.Cam then
			vCLIENT.resumeCam(source)
		else
			Player(source).state.Cam = true
			vCLIENT.openCam(source)
		end
	end
end)

RegisterNetEvent('gb_cam:disableCam', function()
	local source = source
	Player(source).state.Cam = false
	exports.chat:DisableChat(source, true)
end)