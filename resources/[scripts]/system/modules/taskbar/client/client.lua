local cli = {}
Tunnel.bindInterface('Taskbar', cli)

local Status = ''
local Progress = false

RegisterNUICallback('failure', function(Data, Callback)
	SetNuiFocus(false, false)
	Status = 'failure'
	Progress = false
	Callback('Ok')
end)

RegisterNUICallback('success', function(Data, Callback)
	SetNuiFocus(false, false)
	Status = 'success'
	Progress = false
	Callback('Ok')
end)

taskBar = function(Timer)
	if (Progress) then return; end;

	Progress = true
	SetNuiFocus(true,false)
	SendNUIMessage({ 
        type = 'open', 
        time = Timer 
    })

	while (Progress) do Citizen.Wait(0); end;

	if (Status == 'success') then return true; end;
	return false
end

cli.Task = function(Amount, Speed)
    local Return = true
	for Number = 1, Amount do
		if (not taskBar(Speed)) then
			Return = false
			break
		end
	end
	return Return
end
exports('Task', cli.Task)