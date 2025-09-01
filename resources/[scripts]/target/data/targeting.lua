local currentResourceName = GetCurrentResourceName()
local targeting = exports[currentResourceName]

function GetSourceByPed(_ped) return GetPlayerServerId(NetworkGetPlayerIndexFromPed(_ped)) end;

-- targeting:AddGlobalPlayer({
--     options = {
--         {
--             action = function(entity)
--                 TriggerServerEvent('vrp_inventory:revistar', GetSourceByPed(entity))
--             end,
--             canInteract = function(entity)
--                 if (IsEntityPlayingAnim(entity, 'mp_arresting', 'idle_a', 3)) or (IsEntityPlayingAnim(entity, 'random@arrests@busted', 'idle_a', 3)) or (IsEntityPlayingAnim(entity, 'random@arrests@busted', 'idle_a', 3)) or (IsEntityPlayingAnim(entity, 'random@mugging3', 'handsup_standing_base', 3)) and (GetEntityHealth(entity) > 100) then
--                     return true
--                 end
--                 return false
--             end,

--             icon = "fas fa-search",
--             label = "Revistar",
--         },

--         {
--             action = function(entity)
--                 TriggerServerEvent('gb_interactions:reanimar', GetSourceByPed(entity))
--             end,
--             canInteract = function(entity)
--                 return (GetEntityHealth(entity) < 100)
--             end,

--             icon = "fas fa-search",
--             permissions = { 'hospital.permissao' },
--             label = "Reanimar",
--         },


--     },
--     distance = 2.0
-- })