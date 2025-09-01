function vehicleGlobal() 
    return config.vehicles
end
exports('vehicleGlobal',vehicleGlobal)

function getHashModel(hash)
	if config.hashes[hash] then return config.hashes[hash]; end;
    print("^1[garages] Vehicle ["..hash.."] not found.^0")
end
exports('getHashModel',getHashModel)

function vehHashData(hash,displayName)
	if config.hashes[hash] then
        local vname = config.hashes[hash]
        return vname, config.vehicles[vname]
    end
    print("^1[garages] Vehicle ["..hash.."/"..tostring(displayName).."] not found.^0")
end
exports('vehHashData',vehHashData)

function vehicleName(vname)
	if config.vehicles[vname] then return config.vehicles[vname].name; end;
    print("^1[garages] Vehicle ["..tostring(vname).."] not found.^0")
end
exports('vehicleName',vehicleName)

function vehicleMaker(vname)
	if config.vehicles[vname] then return config.vehicles[vname].maker; end;
    print("^1[garages] Vehicle ["..tostring(vname).."] not found.^0")
end
exports('vehicleMaker',vehicleMaker)

function vehiclePrice(vname)
    if config.vehicles[vname] then return config.vehicles[vname].price; end;
    print("^1[garages] Vehicle ["..tostring(vname).."] not found.^0")
end
exports('vehiclePrice',vehiclePrice)

function vehicleTrunk(vname)
	if config.vehicles[vname] then return config.vehicles[vname].trunk; end;
    print("^1[garages] Vehicle ["..tostring(vname).."] not found.^0")
    return 0
end
exports('vehicleTrunk',vehicleTrunk)

function vehicleGlove(vname)
	if config.vehicles[vname] then return config.vehicles[vname].glove; end;
    print("^1[garages] Vehicle ["..tostring(vname).."] not found.^0")
    return 0
end
exports('vehicleGlove',vehicleGlove)

function vehicleType(vname)
    if config.vehicles[vname] then return config.vehicles[vname].type; end;
    print("^1[garages] Vehicle ["..tostring(vname).."] not found.^0")
end
exports('vehicleType',vehicleType)

function vehicleClass(vname)
    if config.vehicles[vname] then return config.vehicles[vname].class; end;
    print("^1[garages] Vehicle ["..tostring(vname).."] not found.^0")
end
exports('vehicleClass',vehicleClass)

function vehicleBanned(vname)
    if config.vehicles[vname] then return config.vehicles[vname].banned; end;
    print("^1[garages] Vehicle ["..tostring(vname).."] not found.^0")
end
exports('vehicleBanned',vehicleBanned)

function vehicleModelData(vname)
    if config.vehicles[vname] then return config.vehicles[vname]; end;
    print("^1[garages] Vehicle ["..tostring(vname).."] not found.^0")
end
exports('vehicleModelData',vehicleModelData)

function vehicleShootConfig(vname)
    if config.vehicles[vname] then return config.vehicles[vname].shootoff; end;
    print("^1[garages] Vehicle ["..tostring(vname).."] not found.^0")
end
exports('vehicleShootConfig',vehicleShootConfig)

function vehiclesList()
    return config.vehicles
end
exports('vehiclesList', vehiclesList)