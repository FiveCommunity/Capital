vRP.serials = {}

vRP.genSerial = function(prefix,format,metadata)
    local prefix = (prefix or '')
    local serial = ''

	repeat
		serial = prefix..vRP.generateStringNumber(format)
	until not vRP.serials[serial]

    vRP.serials[serial] = (metadata or true)
    vRP.serials.__save = true
    
	return serial
end

vRP.getSerial = function(serial)
    if serial and vRP.serials[serial] then
        return vRP.serials[serial]
    end
end

vRP.freeSerial = function(serial)
    if serial and vRP.serials[serial] then
        vRP.serials[serial] = nil
        vRP.serials.__save = true
        return true
    end
end

Citizen.CreateThread(function()
    local stringSerial = LoadResourceFile('vrp','cfg/serials.json')
    vRP.serials = json.decode(stringSerial) or {}
    while (true) do
        if vRP.serials.__save then
            vRP.serials.__save = nil
            SaveResourceFile('vrp','cfg/serials.json',json.encode(vRP.serials),-1)
        end
        Citizen.Wait(2000)
    end
end)