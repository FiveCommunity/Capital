srv = {}
Tunnel.bindInterface('sv_fleeca',srv)
local vSERVER = Tunnel.getInterface('sv_fleeca')
local idgens = Tools.newIDGenerator()

local webhookbankrobbery = 'https://discord.com/api/webhooks/1222369412150202408/jVuFc9TGzSGsQ5GqIvHAcinLwHJtkVuw8fqgF-wozZ8FU1RZ3RrTRI7hFMuSMl4xg5iB'

local blips = {}
local fleecaTimer = 0
local moneyHeist = {}
local inRobbery = {}

local BankHeists = {
    -- ['Fleeca Bank Highway'] = {
    --     ['Money'] = 275000,
    -- },
    -- ['Fleeca Bank Top'] = {
    --     ['Money'] = 275000,
    -- },
    -- ['Fleeca Bank Invader'] = {
    --     ['Money'] = 2800000,
    -- },
    ['Bank Paleto'] = {
        ['Money'] = 1500000,
    },
}

srv.checkPermission = function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,'ilegal.permissao') then
			return true
		end
		TriggerClientEvent('Notify',source,'Negado','Você não é de <b>facção</b> para realizar esse assalto.')
		return false
	end
end

srv.StartBankRobbery = function(bankId)
    TriggerClientEvent('bankrobbery:openDoor',-1,bankId)
    TriggerClientEvent('bankrobbery:startRobbery',-1,bankId)
    TriggerClientEvent('vrp_sound:source',source,'bankdoor',0.5)
end

-- srv.ResetMoney = function(bankId)
--     moneyHeist[bankId] = nil
-- end

srv.CheckPayment = function(bankId)
	local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        
        if (inRobbery[user_id] == bankId) then
        
            local currentBank = parseInt(moneyHeist[bankId])

            if (currentBank < BankHeists[bankId]['Money']) then
                
                local cashRecieved = 50000
                
                moneyHeist[bankId] = currentBank + cashRecieved
                
                vRP.giveInventoryItem(user_id,'dinheirosujo',cashRecieved)
                TriggerClientEvent('Notify',source,'Roubo','Recebeu <b>'..cashRecieved..'x</b> de <b>Dinheiro Sujo</b>.')
                
                if (moneyHeist[bankId] >= BankHeists[bankId]['Money']) then
                    inRobbery[user_id] = nil
                    TriggerClientEvent('bankrobbery:deleteEntity',source)
                end
            else
                inRobbery[user_id] = nil
                TriggerClientEvent('bankrobbery:deleteEntity',source)
            end
        end
    end
end

srv.checkPolice = function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local policia = vRP.getUsersByPermission('policia.permissao')
        -- if #policia < 15 then
		-- 	TriggerClientEvent('Notify',source,'Roubo','Não possui <b>contingente</b> o suficiente para fazer essa ação. <br> - É necessário : <b>15 policias</b> para fazer está ação.')
        --     return false
        -- elseif (os.time()-fleecaTimer) <= 43200 then
        --     TriggerClientEvent('Notify',source,'Roubo','Os cofres estão vazios, aguarde <b>'..vRP.format(parseInt((43200-(os.time()-fleecaTimer))))..' segundos</b> até que os civis efetuem depositos.',8000)
        --     return false
        -- end
        return true
    end
end

srv.CheckRobbery = function(bankId)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
    local coords = GetEntityCoords( GetPlayerPed(source) )
    if user_id then
        vRP.setUserTimer(user_id, "wanted", 300)
        
        inRobbery[user_id] = bankId
        fleecaTimer = os.time()
        SetTimeout(43200*1000,function() moneyHeist[bankId] = nil; end)

        TriggerClientEvent('vrp_sound:source',source,'alarm',0.2)
        
        exports.vrp:reportUser(user_id, {
            notify = { 
                type = 'default', 
                title = 'Roubo ao Banco Paleto', 
                message = 'Denúncia Anônima',
                coords = coords,
                time = 8000
            },
            blip = {
                id = user_id, 
                text = 'Roubo ao Banco Paleto', 
                coords = coords,
                colour = 46,      
                timeout = 30000
            }
        })

        vRP.webhook('roubos',{
            title = 'roubos',
            descriptions = {
                { 'action', 'bank robbery' },
                { 'user', user_id },
                { 'local', bankId },
                { 'coord', tostring(coords) }
            }
        })
    end
end

srv.KeyCard = function()
	local source = source
    local user_id = vRP.getUserId(source)
	if user_id then
        if vRP.tryGetInventoryItem(user_id,'flipper-mk5',1) then  
			return true 
        end
        TriggerClientEvent('Notify',source,'Negado','Você não possui <b>1x</b> de <b>Flipper MK5</b>.') 
        return false
	end
end