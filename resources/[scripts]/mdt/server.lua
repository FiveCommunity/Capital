
vSERVER = {}
Tunnel.bindInterface(GetCurrentResourceName(), vSERVER)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARE
-----------------------------------------------------------------------------------------------------------------------------------------
vRP._prepare('mdt/get_user_inssues','SELECT * FROM mdt WHERE user_id = @user_id')
vRP._prepare('mdt/get_user_arrest','SELECT * FROM mdt WHERE user_id = @user_id AND type = @type')
vRP._prepare('mdt/add_user_inssues','INSERT INTO mdt(user_id,type,value,data,info,officer) VALUES(@user_id,@type,@value,@data,@info,@officer)')
vRP._prepare('mdt/id_get_mdt','SELECT * FROM mdt WHERE mdt_id = @id')
vRP._prepare('mdt/id_remove_mdt','DELETE FROM mdt WHERE mdt_id = @id')

vRP._prepare('mdt/createTable', 
    [[CREATE TABLE IF NOT EXISTS `mdt` (
		`mdt_id` INT(11) NOT NULL AUTO_INCREMENT,
		`user_id` INT(11) NOT NULL,
		`type` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
		`value` TEXT NOT NULL DEFAULT '' COLLATE 'utf8mb4_general_ci',
		`data` VARCHAR(50) NOT NULL DEFAULT '' COLLATE 'utf8mb4_general_ci',
		`info` TEXT NOT NULL DEFAULT '' COLLATE 'utf8mb4_general_ci',
		`officer` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
		PRIMARY KEY (`mdt_id`) USING BTREE
	);]]
)

Citizen.CreateThread(function() vRP.execute('mdt/createTable') end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- VARS
-----------------------------------------------------------------------------------------------------------------------------------------
local perms = {
	open = { 'policia.permissao', 'staff.permissao' },

	apply = { 'policia.permissao', 'staff.permissao' },

	delete = { '+PMC.Coronel', '+Juridico.SecretarioGeral' }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function vSERVER.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)
	return _permCheck(user_id,perms.open)
end

function _permCheck(user_id,tbl)
	for i,p in ipairs(tbl) do
		if vRP.hasPermission(user_id,p) then
			return true
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEARCH INFO
-----------------------------------------------------------------------------------------------------------------------------------------
function vSERVER.infoUser(user)
	local source = source
	local user_id = vRP.getUserId(source)
	if user and user_id then
		
		        local tickets = 0 -- exports.bank removido

		local identity = vRP.getUserIdentity(user)

		local arrests = vRP.query('mdt/get_user_arrest',{ user_id = user, type = 'arrest' })
		local warnings = vRP.query('mdt/get_user_arrest',{ user_id = user, type = 'warning' })
		if (identity) then
			        local driveLicense = '000-000'
        if GetResourceState('driving_school') == 'started' and exports.driving_school and exports.driving_school.getUserLicense then
            driveLicense = exports.driving_school:getUserLicense(user)
        end
        return driveLicense,vRP.hasPermission(user,'cacador.permissao'),identity.firstname,identity.lastname,identity.age,'000-000',identity.registration,#arrests,#warnings,tickets
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEARCH ARRESTS
-----------------------------------------------------------------------------------------------------------------------------------------
function vSERVER.arrestsUser(user)
	local source = source
	local user_id = vRP.getUserId(source)
	if user and user_id then
		local data = vRP.query('mdt/get_user_arrest',{ user_id = user, type = 'arrest' })
		local arrest = {}
		if data then
			for k,v in pairs(data) do
				table.insert(arrest,{ id = v.mdt_id, data = v.data, value = v.value, info = v.info, officer = v.officer })
			end
			return arrest
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEARCH TICKETS
-----------------------------------------------------------------------------------------------------------------------------------------
function vSERVER.ticketsUser(user)
	local source = source
	local user_id = vRP.getUserId(source)
	if user and user_id then
		local data = vRP.query('mdt/get_user_arrest',{ user_id = user, type = 'ticket' })
		local arrest = {}
		if data then
			for k,v in pairs(data) do
				table.insert(arrest,{ id = v.mdt_id, data = v.data, value = v.value, info = v.info, officer = v.officer })
			end
			return arrest
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEARCH WARNINGS
-----------------------------------------------------------------------------------------------------------------------------------------
function vSERVER.warningsUser(user)
	local source = source
	local user_id = vRP.getUserId(source)
	if user and user_id then
		local data = vRP.query('mdt/get_user_arrest',{ user_id = user, type = 'warning' })
		local arrest = {}
		if data then
			for k,v in pairs(data) do
				table.insert(arrest,{ id = v.mdt_id, data = v.data, value = v.value, info = v.info, officer = v.officer })
			end
			return arrest
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- WARNING
-----------------------------------------------------------------------------------------------------------------------------------------
function vSERVER.warningUser(user,info)
	local source = source
	local user_id = vRP.getUserId(source)
	if (_permCheck(user_id, perms.apply)) then
		local ofidtt = vRP.getUserIdentity(user_id)
		local officer = user_id..'# '..ofidtt.firstname..' '..ofidtt.lastname

		TriggerClientEvent('Notify', source, 'sucesso', 'MDT', 'Aviso aplicado com sucesso.', 8000)

		vRP.insert('mdt/add_user_inssues', { 
			user_id = user, 
			type = 'warning', 
			value = 0, 
			data = os.date('%d/%m/%Y %H:%M'), 
			info = info, 
			officer = officer 
		})

		vRP.webhook('mdtwarn', {
			title = 'mdt warn',
			descriptions = {
				{ 'officer', officer },
				{ 'target', user },
				{ 'info', info }
			}
		})     
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TICKET
-----------------------------------------------------------------------------------------------------------------------------------------
function vSERVER.ticketUser(user,value,info)
	local source = source
	local user_id = vRP.getUserId(source)
	if (_permCheck(user_id, perms.apply)) then
		local ofidtt = vRP.getUserIdentity(user_id)
		local officer = user_id..'# '..ofidtt.firstname..' '..ofidtt.lastname
		if (user > 0) and (value > 0) then
			local nidentity = vRP.getUserIdentity(user)
			if (not nidentity) then
				return TriggerClientEvent('notify', source, 'negado', 'Multa', 'Cidadão inexistente!')
			end

			exports['phone-bank']:createFine(user, { reason = 'Infringindo as leis da cidade', content = info, value = value })
			TriggerClientEvent('notify', source, 'sucesso', 'Multa', 'Você aplicou uma multa de <b>R$'..vRP.format(value)..'</b> no <b>'..nidentity.firstname..' '..nidentity.lastname..'</b>.')

			local nsource = vRP.getUserSource(user)
			if (nsource) then
				exports['lb-phone']:SendNotification(nsource, {
					app = 'capital-bank',
					title = 'Multa',
					content = 'Você foi multado no valor de R$'..vRP.format(value)..'!'
				})
			end

			vRP.insert('mdt/add_user_inssues', { 
				user_id = user, 
				type = 'ticket', 
				value = value, 
				data = os.date('%d/%m/%Y %H:%M'), 
				info = info, 
				officer = officer 
			})

			vRP.webhook('fines', {
				title = 'Banco',
				descriptions = {
					{ 'action', '(fines)' },
					{ 'officer', officer },
					{ 'target', user },
					{ 'reason', info },
					{ 'fine value', vRP.format(value) }
				}
			}) 
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TICKET
-----------------------------------------------------------------------------------------------------------------------------------------
function vSERVER.arrestUser(user,value,info)
	local source = source
	local user_id = vRP.getUserId(source)
	if (_permCheck(user_id,perms.apply)) then
		local ofidtt = vRP.getUserIdentity(user_id)
		local officer = user_id..'# '..ofidtt.firstname..' '..ofidtt.lastname

		TriggerEvent('gb_interactions:prender', source, user_id, user, value, info)

		vRP.insert('mdt/add_user_inssues', { 
			user_id = user, 
			type = 'arrest', 
			value = parseInt(value), 
			data = os.date('%d/%m/%Y %H:%M'), 
			info = info, 
			officer = officer 
		})
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETE
-----------------------------------------------------------------------------------------------------------------------------------------
function vSERVER.deleteMdtId(mdt_id)
	local source = source
	local user_id = vRP.getUserId(source)
	if _permCheck(user_id,perms.delete) then
		if mdt_id then
			local data = vRP.query('mdt/id_get_mdt',{ id = mdt_id })[1]	
			if data then
				
				TriggerClientEvent('mdt:close',source)
				if vRP.request(source, 'MDT', 'Gostaria de apagar este registro pagando <b>R$ 2.500</b>?', 30000) then
					
					if vRP.tryFullPayment(user_id,2500) then
					
						local afct = vRP.execute('mdt/id_remove_mdt',{ id = mdt_id })
						if afct > 0 then
							TriggerClientEvent('Notify', source, 'sucesso', 'MDT', 'Registro Apagado com Sucesso.', 8000)

							vRP.webhook('mdtdelete', {
								title = 'mdt delete',
								descriptions = {
									{ 'id', user_id },
									{ 'info', json.encode(data) }
								}
							})    
							return true
						end
					else
						TriggerClientEvent('Notify', source, 'negado', 'MDT', 'Dinheiro insuficiente.', 8000)
					end
				end
			end
		end
	else
		TriggerClientEvent('Notify', source, 'negado', 'MDT', 'Sem permissão.', 8000)
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOOGLE PORT
-----------------------------------------------------------------------------------------------------------------------------------------
-- function vSERVER.togglePort(user)
-- 	local source = source
-- 	local user_id = vRP.getUserId(source)
-- 	if _permCheck(user_id,perms.edit) then
-- 		local ouser_id = parseInt(user)
-- 		if ouser_id then
-- 			local wport = getUserPort(ouser_id)
-- 			if (not wport) then	
-- 				setUserPort(ouser_id,true)
-- 				TriggerClientEvent('Notify',source,'sucesso','Porte Adicionado com Sucesso.',8000)
-- 			else
-- 				setUserPort(ouser_id,false)
-- 				TriggerClientEvent('Notify',source,'sucesso','Porte Removido com Sucesso.',8000)
-- 			end
-- 			vRP._webhook(webhookporte,'```prolog\n[ID]: '..user_id..' \n[==============EDITOU PORTE==============] \n[PASSAPORTE]: '..ouser_id..'\n[Porte]: '..tostring(not wport)..''..os.date('\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S')..' \r```')		
-- 			return true
-- 		end
-- 	else
-- 		TriggerClientEvent('Notify',source,'negado','Sem permissão.',8000)
-- 	end
-- 	return false
-- end

local porteMethods = {
	-- > Porte de Caça
	['caca'] = function(source, officerId, data)
		local identity = vRP.getUserIdentity(data.user_id) 
		if (identity) then
			
			if (data.value == 'Adicionar') then
				if _permCheck(officerId,{ '+PMC.Major' }) then
					vRP.addTemporaryGroup(data.user_id, 'Cacador', 15)
					TriggerClientEvent('notify', source, 'sucesso', 'Porte', 'Você adicionou o porte do(a) <b>'..identity.firstname..' '..identity.lastname..'</b>!')
					return true
				else
					TriggerClientEvent('notify', source, 'negado', 'Porte', 'Sem permissão.',8000)
				end
			else
				if _permCheck(officerId,{ 'policia.permissao' }) then
					vRP.removeUserGroup(data.user_id, 'Cacador')
					TriggerClientEvent('notify', source, 'sucesso', 'Porte', 'Você removeu o porte do(a) <b>'..identity.firstname..' '..identity.lastname..'</b>!')
					return true
				else
					TriggerClientEvent('notify', source, 'negado', 'Porte', 'Sem permissão.',8000)
				end
			end

		else
			TriggerClientEvent('notify', source, 'negado', 'Porte', 'Jogador <b>inexistente</b>!')
		end
		return false
	end
}

function vSERVER.togglePort(data)
	local source = source
	local user_id = vRP.getUserId(source)
	if (user_id) then
		if (porteMethods[data.method]) then
			return porteMethods[data.method](source, user_id, data)
		end
	end
	return false
end

function getUserPort(user_id)
	return vRP.hasGroup(parseInt(user_id), 'PorteArmas')
end
exports('getUserPort',getUserPort)

function setUserPort(user_id,state)
	if state then 
		vRP.addUserGroup(user_id, 'PorteArmas')
	else 
		vRP.removeUserGroup(user_id, 'PorteArmas')
	end
end
exports('setUserPort',setUserPort)