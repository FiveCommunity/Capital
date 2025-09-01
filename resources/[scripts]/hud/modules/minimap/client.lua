Minimap = function()
    SetBigmapActive(false, false)
    Citizen.Wait(100)
    SetBlipAlpha(GetNorthRadarBlip(), 0)
    SetMinimapClipType(1)

    local mapPositions = {
        ['minimap'] = {
            alignX = 'L',
            alignY = 'B',
            x = 0.0005,
            y = 0.0,
            width = 0.180,
            height = 0.230
        },
        ['minimap_mask'] = {
			alignX = 'L',
			alignY = 'B',
			x = 0.020,
			y = 0.032,
			width = 0.111,
			height = 0.159
		},
		['minimap_blur'] = {
			alignX = 'L',
			alignY = 'B',
			x = -0.015,
			y = 0.006,
			width = 0.215,
			height = 0.270
		}
    }

    RequestStreamedTextureDict('circlemap', false)
    while (not HasStreamedTextureDictLoaded('circlemap')) do Citizen.Wait(1); end;
    AddReplaceTexture('platform:/textures/graphics', 'radarmasksm', 'circlemap', 'radarmasksm')

    for name, data in pairs(mapPositions) do 
		SetMinimapComponentPosition(name, data.alignX, data.alignY, data.x, data.y, data.width, data.height)
	end

    DisplayRadar(false)
    SetRadarZoom(1100)
end
CreateThread(Minimap)