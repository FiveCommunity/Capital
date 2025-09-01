local cli = {}
Tunnel.bindInterface('Spray', cli)
local vSERVER = Tunnel.getInterface('Spray')

local config = module('core', 'cfg/cfgSpray')
local configSpray = config.spray

local IsSpraying = false
local lastFormattedText = nil
local FormattedSprayText = ''
local SPRAY_FORWARD_OFFSET = 0.035
local DEBUG_RAY = false

local FORBIDDEN_MATERIALS = {
    [1913209870] = true,
    [-1595148316] = true,
    [510490462] = true,
    [909950165] = true,
    [-1907520769] = true,
    [-1136057692] = true,
    [509508168] = true,
    [1288448767] = true,
    [-786060715] = true,
    [-1931024423] = true,
    [-1937569590] = true,
    [-878560889] = true,
    [1619704960] = true,
    [1550304810] = true,
    [951832588] = true,
    [2128369009] = true,
    [-356706482] = true,
    [1925605558] = true,
    [-1885547121] = true,
    [-1942898710] = true,
    [312396330] = true,
    [1635937914] = true,
    [-273490167] = true,
    [1109728704] = true,
    [223086562] = true,
    [1584636462] = true,
    [-461750719] = true,
    [1333033863] = true,
    [-1286696947] = true,
    [-1833527165] = true,
    [581794674] = true,
    [-913351839] = true,
    [-2041329971] = true,
    [-309121453] = true,
    [-1915425863] = true,
    [1429989756] = true,
    [673696729] = true,
    [244521486] = true,
    [435688960] = true,
    [-634481305] = true,
    [-1634184340] = true,
}

local spray = {
    font = 1,
    text = '',
    color = 1,
    scale = 1,
    scales = { min = 60, max = 200 }
}

local SPRAYS = {}

RegisterNetEvent('gb_spray:setSprays', function(s)
    SPRAYS = s
end)

local fonts = {}
for idx, f in pairs(configSpray.fonts) do
    fonts[idx] = f.label
end

local simpleColors = {}
for idx, c in pairs(configSpray.colors) do
    simpleColors[idx] = c.color.rgb
end

local scaleSelect = {}
for i = spray.scales.min, spray.scales.max, 5 do
    table.insert(scaleSelect, i)
end

local resetFormattedText = function()
    local temporaryText = spray.text
    if (temporaryText ~= lastFormattedText) then
        lastFormattedText = temporaryText
        if (configSpray.fonts[spray.font].forceUppercase) then
            temporaryText = temporaryText:upper()
        end
        FormattedSprayText = RemoveDisallowedCharacters(temporaryText, configSpray.fonts[spray.font].allowedInverse)
    end
end

cli.createSpray = function(text)
    if (not IsSpraying) then
        IsSpraying = true
        spray.text = text
        resetFormattedText()
        WarMenu.OpenMenu('spray')
        startSpray()
    end
end

Citizen.CreateThread(function()
    AddTextEntry('RC_CANCEL', '~INPUT_ENTER~ Cancelar')
    WarMenu.CreateMenu('spray', 'Spray')
    WarMenu.SetSubTitle('spray', 'Customize o spray')
    WarMenu.SetMenuX('spray', 0.75)
    WarMenu.SetMenuY('spray', 0.35)
end)

local SCALEFORM_ID_MIN = 1
local SCALEFORM_ID_MAX = 12
local PLAYER_NAME_HEAP = {}

local rotCam = nil
local wantedSprayLocation = nil
local wantedSprayRotation = nil
local currentSprayRotation = nil
currentComputedRotation = vector3(0,0,0)

startSpray = function()
    local ttl = 30
    Citizen.CreateThread(function()
        while (IsSpraying) do
            if (WarMenu.IsMenuOpened('spray')) then
                if WarMenu.ComboBox('Fonte', fonts, spray.font, spray.font, function(currentIndex, selectedIndex)
                    spray.font = currentIndex
                    resetFormattedText()
				end) then
                elseif WarMenu.ColorSelector('Cor', simpleColors, spray.color, function(i) 
                    spray.color = i 
                end) then
                elseif WarMenu.ComboBox('Tamanho', scaleSelect, spray.scale, spray.scale, function(currentIndex, selectedIndex)
					spray.scale = currentIndex
                end) then
                elseif WarMenu.Button('Confirmar') then
                    WarMenu.CloseMenu()
                    PersistSpray()
                    IsSpraying = false
                    spray.text = ''
                end
                WarMenu.Display()
            else
                IsSpraying = false
                spray.text = ''
                LocalPlayer.state.BlockTasks = false
            end
            Citizen.Wait(1)
        end
    end)

    Citizen.CreateThread(function()
        while (IsSpraying) do
            if IsSpraying then
                local rayEndCoords, rayNormal, fwdVector = FindRaycastedSprayCoords()
                if rayEndCoords and rayNormal then
                    local cIndex = 'color'
                    local sprayCoords = rayEndCoords + fwdVector * SPRAY_FORWARD_OFFSET

                    local isInterior = GetInteriorFromEntity(PlayerPedId()) > 0
                    if (not isInterior) then cIndex = GetColorByTime(); end;

                    DrawSpray(PLAYER_NAME_HEAP[SCALEFORM_ID_MAX], {
                        location = sprayCoords,
                        rotation = rayNormal, 
                        
                        scale = (scaleSelect[spray.scale] / 10.0) * configSpray.fonts[spray.font].sizeMult,
                        text = FormattedSprayText,
                        font = configSpray.fonts[spray.font].font,
                        color = configSpray.colors[spray.color][cIndex].hex,
                    })
                end

                if wantedSprayLocation and wantedSprayRotation then
                    if ttl >= 0 then
                        ttl = ttl - 1
                    end
                    if currentSprayRotation ~= wantedSprayRotation or not currentSprayRotation or ttl < 0 then
                        ttl = 30
                        local wantedSprayRotationFixed = vector3(
                            wantedSprayRotation.x, 
                            wantedSprayRotation.y, 
                            wantedSprayRotation.z + 0.03
                        )

                        local camRot = GetRotationThruCamera(wantedSprayLocation, wantedSprayRotationFixed)
                        currentSprayRotation = wantedSprayRotation
                        currentComputedRotation = camRot
                    end
                end
            end
            Citizen.Wait(1)
        end
    end)
end

Citizen.CreateThread(function()
    Citizen.Wait(100)
    for _, fontData in pairs(configSpray.fonts) do
        RegisterFontFile(fontData.font)
        RegisterFontId(fontData.font)
    end

    rotCam = CreateCam('DEFAULT_SCRIPTED_CAMERA', 0)
    while true do
        local idle = 1000
        local scaleformHandleIdx = SCALEFORM_ID_MIN
        local ped = PlayerPedId()
        local pCoord = GetEntityCoords(ped)
        local cIndexTime = GetColorByTime()
                
        for _, sprays in pairs(SPRAYS) do
            
            local cIndex = 'color'
            if (not sprays.interior) then cIndex = cIndexTime; end;
            sprays.color = configSpray.colors[sprays.originalColor][cIndex].hex
            
            local distance = #(pCoord - sprays.location)
            if (distance <= 50.0) then
                idle = 1
                DrawSpray(PLAYER_NAME_HEAP[scaleformHandleIdx], sprays)
                scaleformHandleIdx = scaleformHandleIdx + 1
                if (scaleformHandleIdx >= SCALEFORM_ID_MAX) then break; end;
            end
        end
        Citizen.Wait(idle)
    end
end)

GetRotationThruCamera = function(location, normal)
    local camLookPosition = location - normal * 10
    SetCamCoord(rotCam,  location.x, location.y, location.z)
    PointCamAtCoord(rotCam, camLookPosition.x, camLookPosition.y, camLookPosition.z)
    SetCamActive(rotCam, true)
    Citizen.Wait(0)
    local rot =  GetCamRot(rotCam, 2)
    SetCamActive(rotCam, false)
    return rot
end

local isCancelled = false

DrawSpray = function(scaleformHandle, sprayData, meth)
    if (scaleformHandle and HasScaleformMovieLoaded(scaleformHandle)) then
        if (not IsPauseMenuActive()) then
            PushScaleformMovieFunction(scaleformHandle, 'SET_PLAYER_NAME')
            PushScaleformMovieFunctionParameterString("<FONT color='#" .. sprayData.color .. "' FACE='" .. sprayData.font .. "'>" .. sprayData.text)
            PopScaleformMovieFunctionVoid()

            if (not sprayData.realRotation) then
                wantedSprayLocation = sprayData.location
                wantedSprayRotation = sprayData.rotation
            end

            DrawScaleformMovie_3dNonAdditive(
                scaleformHandle,
                sprayData.location,
                sprayData.realRotation or currentComputedRotation,
                1.0,
                1.0,
                1.0,
                sprayData.scale, sprayData.scale,
                1.0,
                2
            )
        end
    end
end

Citizen.CreateThread(function() 
    while (true) do
        LoadAllSprayScaleforms()
		Citizen.Wait(5000)
	end 
end)

LoadAllSprayScaleforms = function()
    for i = SCALEFORM_ID_MIN, SCALEFORM_ID_MAX do
        local paddedI = i

        if (paddedI < 10) then
            paddedI = "0" .. paddedI
        end

        if (not PLAYER_NAME_HEAP[i] or not HasScaleformMovieLoaded(PLAYER_NAME_HEAP[i])) then
            PLAYER_NAME_HEAP[i] = RequestScaleformMovieInteractive('PLAYER_NAME_' .. paddedI)
            while (not HasScaleformMovieLoaded(PLAYER_NAME_HEAP[i])) do Citizen.Wait(0); end;
        end
    end
end

rgbToHex = function(rgb)
	local hexadecimal = ''
	for key, value in pairs(rgb) do
		local hex = ''
		while (value > 0) do
			local index = math.fmod(value, 16) + 1
			value = math.floor(value / 16)
			hex = string.sub('0123456789ABCDEF', index, index) .. hex			
		end

		if (string.len(hex) == 0) then
			hex = '00'
		elseif(string.len(hex) == 1)then
			hex = '0' .. hex
		end

		hexadecimal = (hexadecimal..hex)
	end
	return hexadecimal
end

PersistSpray = function()
    local ped = PlayerPedId()
    IsSpraying = false
    local rayEndCoords, rayNormal, sprayFwdVector = FindRaycastedSprayCoords()
    if (rayEndCoords and rayNormal) then
        local sprayLocation = (rayEndCoords + sprayFwdVector * SPRAY_FORWARD_OFFSET)
        local canPos = vector3(0.072, 0.041, -0.06)
        local canRot = vector3(33.0, 38.0, 0.0)
        local canObj = CreateObject(`ng_proc_spraycan01b`, 0.0, 0.0, 0.0, true, false, false)
        AttachEntityToEntity(canObj, ped, GetPedBoneIndex(ped, 57005), canPos.x, canPos.y, canPos.z, canRot.x, canRot.y, canRot.z, true, true, false, true, 1, true )
        
        Citizen.CreateThread(function()
            isCancelled = false
            Citizen.Wait(2000)
            while (not isCancelled) do
                SprayEffects()
                Citizen.Wait(5000)
            end
        end)

        CancellableProgress(20000, 'anim@amb@business@weed@weed_inspecting_lo_med_hi@', 'weed_spraybottle_stand_spraying_01_inspector', 16, 'Criando o spray...', 'spray', function()
            vSERVER.addSpray({
                location = sprayLocation,
                realRotation = currentComputedRotation, 
                scale = (scaleSelect[spray.scale] / 10.0) * configSpray.fonts[spray.font].sizeMult,
                text = FormattedSprayText,
                font = configSpray.fonts[spray.font].font,
                originalColor = spray.color,
                interior = (GetInteriorFromEntity(ped) > 0)
            })

            ClearPedTasks(ped)
            DeleteObject(canObj)
            isCancelled = true
        end,
        function()
            ClearPedTasks(ped)
            DeleteObject(canObj)
            isCancelled = true
        end)

    end
end

RemoveDisallowedCharacters = function(str, inverse)
    local replaced, _ = str:gsub(inverse, '')
    return replaced
end

local LastRayStart = nil
local LastRayDirection = nil
local LastComputedRayEndCoords = nil
local LastComputedRayNormal = nil
local LastError = nil

FindRaycastedSprayCoords = function()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)

    local cameraRotation = GetGameplayCamRot()
	local cameraCoord = GetGameplayCamCoord()
	local direction = RotationToDirection(cameraRotation)

    local rayStart = cameraCoord
    local rayDirection = direction

    if not LastRayStart or not LastRayDirection or ((not LastComputedRayEndCoords or not LastComputedRayNormal) and not LastError) or rayStart ~= LastRayStart or rayDirection ~= LastRayDirection then
        LastRayStart = rayStart
        LastRayDirection = rayDirection

        local result, error, rayEndCoords, rayNormal = FindRaycastedSprayCoordsNotCached(ped, coords, rayStart, rayDirection)

        if (result) then
            if LastSubtitleText then
                LastSubtitleText = nil
            end

            LastComputedRayEndCoords = rayEndCoords
            LastComputedRayNormal = rayNormal
            LastError = nil

            return LastComputedRayEndCoords, LastComputedRayNormal, LastComputedRayNormal
        else
            LastComputedRayEndCoords = nil
            LastComputedRayNormal = nil
            LastError = error
            DrawSubtitleText(error)
        end
    else
        return LastComputedRayEndCoords, LastComputedRayNormal, LastComputedRayNormal
    end

end

FindRaycastedSprayCoordsNotCached = function(ped, coords, rayStart, rayDirection)
    local rayHit, rayEndCoords, rayNormal, materialHash = CheckRay(ped, rayStart, rayDirection)
    local ray2Hit, ray2EndCoords, ray2Normal, _ = CheckRay(ped, rayStart + vector3(0.0, 0.0, 0.2), rayDirection)
    local ray3Hit, ray3EndCoords, ray3Normal, _ = CheckRay(ped, rayStart + vector3(1.0, 0.0, 0.0), rayDirection)
    local ray4Hit, ray4EndCoords, ray4Normal, _ = CheckRay(ped, rayStart + vector3(-1.0, 0.0, 0.0), rayDirection)
    local ray5Hit, ray5EndCoords, ray5Normal, _ = CheckRay(ped, rayStart + vector3(0.0, 1.0, 0.0), rayDirection)
    local ray6Hit, ray6EndCoords, ray6Normal, _ = CheckRay(ped, rayStart + vector3(0.0, -1.0, 0.0), rayDirection)

    local isOnGround = ray2Normal.z > 0.9

    if (not isOnGround and rayHit and ray2Hit and ray3Hit and ray4Hit and ray5Hit and ray6Hit) then
        if (not FORBIDDEN_MATERIALS[materialHash]) then
            if #(coords - rayEndCoords) < 3.0 then
                if (IsNormalSame(rayNormal, ray2Normal)
                and IsNormalSame(rayNormal, ray3Normal)
                and IsNormalSame(rayNormal, ray4Normal)
                and IsNormalSame(rayNormal, ray5Normal)
                and IsNormalSame(rayNormal, ray6Normal)
                and IsOnPlane(rayEndCoords, ray2EndCoords, ray3EndCoords, ray4EndCoords, ray5EndCoords, ray6EndCoords)) then
                    return true, '', rayEndCoords, rayNormal, rayNormal
                else
                    return false, 'A <b>superfície</b> não é plana o suficiente'
                end
            else 
                return false, 'A <b>superfície</b> está muito longe'
            end
        else
            return false, 'Você não pode usar o spray nesta <b>superfície</b>'
        end
    else
        return false, 'Aponte o <b>spray</b> para uma parede plana'
    end
end

local Hour = 12

GetColorByTime = function()
    if (Hour <= 5 or Hour >= 21) then return 'colorDarkest'; end;
    if (Hour <= 7 or Hour >= 19) then return 'colorDarker'; end;
    return 'color'
end

RotationToDirection = function(rotation)
	local adjustedRotation = { 
		x = (math.pi / 180) * rotation.x, 
		y = (math.pi / 180) * rotation.y, 
		z = (math.pi / 180) * rotation.z 
	}
	return vector3(
        -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)), 
		math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)), 
		math.sin(adjustedRotation.x)
    )
end

CheckRay = function(ped, coords, direction)
    local rayEndPoint = coords + direction * 1000.0

    local rayHandle = StartShapeTestRay(
        coords.x,
        coords.y,
        coords.z,
    
        rayEndPoint.x,
        rayEndPoint.y,
        rayEndPoint.z,
        1, 
        ped
    )

    local retval --[[ integer ]], 
            hit --[[ boolean ]], 
            endCoords --[[ vector3 ]], 
            surfaceNormal --[[ vector3 ]], 
            materialHash,
            entityHit --[[ Entity ]] = GetShapeTestResultEx(rayHandle)

    local debugLineR = 0
    local debugLineG = 0

    if (DEBUG_RAY) then
        if hit == 1 then
            debugLineG = 255
        else
            debugLineR = 255
        end

        DrawLine(
            coords.x,
            coords.y,
            coords.z,
        
            rayEndPoint.x,
            rayEndPoint.y,
            rayEndPoint.z,
            debugLineR,
            debugLineG,
            0,
            255
        )
    end
    return hit == 1, endCoords, surfaceNormal, materialHash
end

IsNormalSame = function(norm1, norm2)
    local xDist = math.abs(norm1.x - norm2.x)
    local yDist = math.abs(norm1.y - norm2.y)
    local zDist = math.abs(norm1.z - norm2.z)
    return xDist < 0.01 and yDist < 0.01 and zDist < 0.01
end

_JT = {}

function JT(dim)
    local n={ values={}, positions={}, directions={}, sign=1 }
    setmetatable(n,{__index=_JT})
    for i=1,dim do
        n.values[i]=i
        n.positions[i]=i
        n.directions[i]=-1
    end
    return n
end
 
function _JT:largestMobile()
    for i=#self.values,1,-1 do
        local loc=self.positions[i]+self.directions[i]
        if loc >= 1 and loc <= #self.values and self.values[loc] < i then
            return i
        end
    end
    return 0
end
 
function _JT:next()
    local r=self:largestMobile()
    if r==0 then return false end
    local rloc=self.positions[r]
    local lloc=rloc+self.directions[r]
    local l=self.values[lloc]
    self.values[lloc],self.values[rloc] = self.values[rloc],self.values[lloc]
    self.positions[l],self.positions[r] = self.positions[r],self.positions[l]
    self.sign=-self.sign
    for i=r+1,#self.directions do self.directions[i]=-self.directions[i] end
    return true
end  
 
-- matrix class
 
_MTX={}
function MTX(matrix)
    setmetatable(matrix,{__index=_MTX})
    matrix.rows=#matrix
    matrix.cols=#matrix[1]
    return matrix
end
 
function _MTX:dump()
    for _,r in ipairs(self) do
    end
end
 
function _MTX:perm() return self:det(1) end

function _MTX:det(perm)
    local det=0
    local jt=JT(self.cols)
    repeat
        local pi=perm or jt.sign
        for i,v in ipairs(jt.values) do
            pi=pi*self[i][v]
        end
        det=det+pi
    until not jt:next()
    return det
end
 
IsOnPlane = function(a,b,c,d,e,f)
    local det1 = MTX{
        {a.x, b.x, c.x, d.x},
        {a.y, b.y, c.y, d.y},
        {a.z, b.z, c.z, d.z},
        {1  , 1  , 1  , 1  , 1  },
    }
  
    local det2 = MTX{
        {a.x, c.x, e.x, f.x},
        {a.y, c.y, e.y, f.y},
        {a.z, c.z, e.z, f.z},
        {1  , 1  , 1  , 1  , 1  },
    }
    return math.abs(det1:det()) < 0.1 and math.abs(det2:det()) < 0.1
end

CancellableProgress = function(time, animDict, animName, flag, text, item, finish, cancel, opts)
    if (not opts) then opts = {} end

    IsCancelled = false
   
    local ped = PlayerPedId()
    
    LocalPlayer.state.BlockTasks = true
    
    if (animDict) then
        LoadAnimDict(animDict)
        TaskPlayAnim(ped, animDict, animName, opts.speedIn or 1.0, opts.speedOut or 1.0, -1, flag, 0, 0, 0, 0 )
    end
    
    TriggerEvent('progressBar', text, time)
    local LastHp = GetEntityHealth(ped)

    local timeLeft = time
    while (true) do
        Citizen.Wait(0)
        timeLeft = timeLeft - (GetFrameTime() * 1000)

        if (timeLeft <= 0) then break; end;

        local newHp = GetEntityHealth(ped)
        if (newHp ~= LastHp) then IsCancelled = true; end;

        LastHp = newHp
        DisableControlAction(0, 23, true)
        DisplayHelpTextThisFrame('RC_CANCEL', true)
        
        if (IsControlPressed(0, 23) or IsDisabledControlPressed(0, 23)) then 
            LocalPlayer.state.BlockTasks = false
            IsCancelled = true
        end

        if (IsCancelled) then
            if (animDict) then ClearPedTasks(ped) end

            if (cancel) then
                TriggerEvent('progressBar', 'Cancelando...', 1)
                cancel()
                return
            end
        end
    end
    
    if animDict then
        StopAnimTask(ped, animDict, animName, 1.0)
    end

    if finish then
        LocalPlayer.state.BlockTasks = false
        if vSERVER.getItem(item) then
            finish()
        else
            cancel()
        end
    end
end

SprayEffects = function()
    local dict = 'scr_recartheft'
    local name = 'scr_wheel_burnout'
    
    local ped = PlayerPedId()
    local fwd = GetEntityForwardVector(ped)
    local coords = GetEntityCoords(ped) + fwd * 0.5 + vector3(0.0, 0.0, -0.5)

	RequestNamedPtfxAsset(dict)
    while (not HasNamedPtfxAssetLoaded(dict)) do Citizen.Wait(0); end;

	local pointers = {}
    local color = configSpray.colors[spray.color]['color'].rgb
    local heading = GetEntityHeading(ped)

    UseParticleFxAssetNextCall(dict)
    SetParticleFxNonLoopedColour(color[1] / 255, color[2] / 255, color[3] / 255)
    SetParticleFxNonLoopedAlpha(1.0)
    local ptr = StartNetworkedParticleFxNonLoopedAtCoord(
        name, 
        coords.x, coords.y, coords.z + 2.0, 
        0.0, 0.0, heading, 
        0.7, 
        0.0, 0.0, 0.0
    )
    RemoveNamedPtfxAsset(dict)
end

LoadAnimDict = function(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(100)
    end
end

local LastSubtitleText = nil

DrawSubtitleText = function(text)
    if (text ~= LastSubtitleText) then
        LastSubtitleText = text
        TriggerEvent('notify', 'Spray', text)
        Citizen.Wait(1000)
    end
end

local DBL_EPSILON = 2.2204460492503131E-16

DrawPositionMatrix = function(start, normal)
    local stdStart = start - GetEntityForwardVector(PlayerPedId())
    DrawLine(
        stdStart.x, stdStart.y, stdStart.z,
        stdStart.x + 1.0, stdStart.y, stdStart.z,
        255, 0, 0, 255
    )
    
    DrawLine(
        stdStart.x, stdStart.y, stdStart.z,
        stdStart.x, stdStart.y + 1.0, stdStart.z,
        0, 0, 255, 255
    )
    
    DrawLine(
        stdStart.x, stdStart.y, stdStart.z,
        stdStart.x, stdStart.y, stdStart.z+1.0,
        0, 255, 0, 255
    )

    local newZ = normalize(vCross(normal, vector3(0, 0, 1)))
    local newX = normalize(vCross(normal, newZ))

    DrawLine(
        start.x, start.y, start.z,
        start.x + normal.x, start.y + normal.y, start.z + normal.z,
        255, 0, 0, 255
    )

    DrawLine(
        start.x, start.y, start.z,
        start.x + newZ.x, start.y + newZ.y, start.z + newZ.z,
        0, 255, 0, 255
    )

    DrawLine(
        start.x, start.y, start.z,
        start.x + newX.x, start.y + newX.y, start.z + newX.z,
        0, 0, 255, 255
    )

end

vCross = function(v, u)
    local a, b, c = v.x, v.y, v.z
    local xOut = b * u.z - c * u.y
    local yOut = c * u.x - a * u.z
    local zOut = a * u.y - b * u.x
    return vector3(xOut, yOut, zOut)
end

normalize = function(v)
    local len = #v
    return (len == 0 and v or scale(v, 1/len))
end

scale = function(v, s)
    return vector3(
        v.x * s,
        v.y * s,
        v.z * s
    )
end

RegisterNetEvent('gb_spray:removeClosestSpray', function()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)

    local closestSprayId = nil
    local closestSprayDist = nil

    for _, spray in pairs(SPRAYS) do
        local sprayPos = spray.location
        local dist = #(sprayPos - coords)
        if (dist < 3.0 and (not closestSprayDist or closestSprayDist > dist)) then
            closestSprayId = spray.id
            closestSprayDist = dist
        end
    end
    
    if (closestSprayId) then
        local ragProp = CreateSprayRemoveProp(ped)
        CancellableProgress(30000, 'timetable@maid@cleaning_window@idle_a', 'idle_a', 1, 'Removendo o spray...', 'removedor-spray',
        function()
            ClearPedTasks(ped)
            RemoveSprayRemoveProp(ragProp)
            TriggerServerEvent('gb_spray:remove', closestSprayId)
        end, 
        function()
            ClearPedTasks(ped)
            RemoveSprayRemoveProp(ragProp)
        end)
    else
        TriggerEvent('notify', 'Spray', 'Não há <b>sprays</b> para remover')
    end
end)

CreateSprayRemoveProp = function(ped)
    local ragProp = CreateObject(
        `p_loose_rag_01_s`,
        0.0, 0.0, 0.0,
        true, false, false
    )

    AttachEntityToEntity(ragProp, ped, GetPedBoneIndex(ped, 28422), x, y, z, ax, ay, az, true, true, false, true, 1, true)
    return ragProp
end

RemoveSprayRemoveProp = function(ent)
    if (NetworkGetEntityOwner(ent) ~= PlayerId()) then end
    DeleteEntity(ent)
end