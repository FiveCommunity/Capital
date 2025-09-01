-- [ Replace Plates ] --
local plates = {
    {
        plate = 'plate01',
        img = 'plates/particular.png',
        normal = true,
    },
    {
        plate = 'plate02',
        img = 'plates/servico.png',
        normal = true,
    },
    {
        plate = 'plate03',
        img = 'plates/particular.png',
        normal = true,
    },
    {
        plate = 'plate04',
        img = 'plates/servico.png',
        normal = true,
    },
    {
        plate = 'plate05',
        img = 'plates/oficial.png',
        normal = true,
    },
    {
        plate = 'yankton_plate',
        img = 'plates/testes.png',
        normal = true,
    }
}

local custom_normal_file = 'plates/mercosul_normal.png'
local custom_normal_name = 'generic_normal'

local runtimeTexture = 'capital_plates'
local plateTxd = CreateRuntimeTxd(runtimeTexture)

CreateRuntimeTextureFromImage(plateTxd, custom_normal_name, custom_normal_file)

for k, v in pairs(plates) do
    local plateName = v.plate
    local plateNormal = v.plate..'_n'
    
    if (v.img) then
        CreateRuntimeTextureFromImage(plateTxd, plateName, v.img)
        AddReplaceTexture('vehshare', plateName, runtimeTexture, plateName)
    end

    if (v.normal) then
        CreateRuntimeTextureFromImage(plateTxd, plateNormal, custom_normal_file)
        AddReplaceTexture('vehshare', plateNormal, runtimeTexture, custom_normal_name)
    end
end

SetDefaultVehicleNumberPlateTextPattern(-1, 'AAA 1111')