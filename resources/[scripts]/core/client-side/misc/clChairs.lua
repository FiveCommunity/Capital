-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:SENTARR
-----------------------------------------------------------------------------------------------------------------------------------------
local chairOffsets = {
	[-171943901] = 0.0,  -- ESSAS SAO AS HASH DE ALGUMAS CADEIRAS/BANCOS A NUMERAO E ALTURA DO BANCO PRA FICAR SENTADO BUNITINHO
	[-109356459] = 0.5,
	[1805980844] = 0.5,
	[-99500382] = 0.3,
	[1262298127] = 0.0,
	[1737474779] = 0.5,
	[2040839490] = 0.0,
	[1037469683] = 0.4,
	[867556671] = 0.4,
	[-1521264200] = 0.0,
	[-741944541] = 0.4,
	[-591349326] = 0.5,
	[-293380809] = 0.5,
	[-628719744] = 0.5,
	[-1317098115] = 0.5,
	[1630899471] = 0.5,
	[38932324] = 0.5,
	[-523951410] = 0.5,
	[725259233] = 0.5,
	[764848282] = 0.5,
	[2064599526] = 0.5,
	[536071214] = 0.5,
	[589738836] = 0.5,
	[146905321] = 0.5,
	[47332588] = 0.5,
	[-1118419705] = 0.5,
	[538002882] = -0.1,
	[-377849416] = 0.5,
	[96868307] = 0.5,
	[-1195678770] = 0.7,
	[-853526657] = -0.1,
	[652816835] = 0.8,
	[-1235256368] = -0.1,
	[-1761659350] = 0.1,
	[3059710928] = -0.0,
	
}

local chairs = { -171943901,-109356459,1805980844,-99500382,1262298127,1737474779,2040839490,-741944541,-1235256368,-1761659350, 3059710928,1037469683,867556671,-1521264200,-741944541,-591349326,-293380809,-628719744,-1317098115,1630899471,38932324,-523951410,725259233,764848282,2064599526,536071214,589738836,146905321,47332588,-1118419705,538002882,-377849416,96868307,-1195678770,-853526657,652816835 }

Citizen.CreateThread(function()
    exports.target:RemoveTargetModel(chairs,'Sentar')
    exports.target:AddTargetModel(chairs,{
        options = {
            {
                icon = 'fas fa-chair',
                label = 'Sentar',
                action = function(e)
                    local ped = PlayerPedId()
                    if (GetEntityHealth(ped) > 101) then
                        local model = GetEntityModel(e)
                        local objCoords = GetEntityCoords(e)

                        FreezeEntityPosition(e,true)
                        SetEntityCoords(ped, objCoords.x, objCoords.y, objCoords.z+(chairOffsets[model] or 0), 1, 0, 0, 0)
                        if chairOffsets[model] == 0.7 then
                            SetEntityHeading(ped,GetEntityHeading(e))
                        else
                            SetEntityHeading(ped,GetEntityHeading(e)-180.0)
                        end

                        vRP.playAnim(false,{ task = 'PROP_HUMAN_SEAT_CHAIR_MP_PLAYER' },false)
                    end
                end,
            }
        },
        distance = 1.5
    })
end)