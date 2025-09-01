--==============================================================================
-- CACHE IDENTITY
--==============================================================================
local cacheIdentity, cacheUserIdentity = {}, {}

vRP.PlayerIdentity = function(user_id)
	if (user_id) then
		if (cacheUserIdentity[user_id]) then return cacheUserIdentity[user_id]; end;

		local self = { id = user_id, identity = exports.oxmysql:query_async('select * from user_characters where id = ?', { user_id })[1] }

		--[ REGISTER ]======================================================

		if (self.identity) then
			if (GetResourceState('lb-phone') == 'started') then
				local userHasNumber = exports.oxmysql:scalar_async('select phone_number from phone_phones where owner_id = ? and name is not null', { tostring ( user_id ) })
				self.identity.phone = (userHasNumber and exports['lb-phone']:FormatNumber(userHasNumber) or '(000) 000-000')
			end
			
			if (not cacheIdentity[self.identity.registration]) then
				cacheIdentity[self.identity.registration] = self.identity
			end

			if (self.identity.phone) then
				if (not cacheIdentity[self.identity.phone]) then
					cacheIdentity[self.identity.phone] = self.identity
				end
			end
		end

		--===============================================================

		self.getIdentity = function()
			return self.identity
		end

		self.update = function(_, type, data)
			local updateTypes = {
				['name'] = function(data)
					self.identity.firstname = data.firstname
					self.identity.lastname = data.lastname

					exports.oxmysql:update_async('update user_characters set firstname = ?, lastname = ? where id = ?', { self.identity.firstname, self.identity.lastname, self.id })
				end,

				['phone'] = function(data)
					if (cacheIdentity[self.identity.phone]) then cacheIdentity[self.identity.phone] = nil; end;

					self.identity.phone = data.phone
					cacheIdentity[self.identity.phone] = self.identity
				end
			}

			if (updateTypes[type]) then updateTypes[type](data); end;
		end

		cacheUserIdentity[user_id] = self

		return self
	end
end

vRP.releaseIdentity = function(user_id)
	if (user_id) and cacheUserIdentity[user_id] then
		cacheUserIdentity[user_id] = nil
	end
end

--==============================================================================
-- IDENTITY FUNCTIONS
--==============================================================================

vRP.getUserIdentity = function(user_id)
	local PlayerIdentity = vRP.PlayerIdentity(user_id)
	if (PlayerIdentity) then return PlayerIdentity:getIdentity(); end;
end

vRP.getUserByRegistration = function(registration)
	if (not cacheIdentity[registration]) then cacheIdentity[registration] = exports.oxmysql:query_async('select * from user_characters where registration = ?', { registration })[1]; end;
	return cacheIdentity[registration]
end

vRP.getUserByPhone = function(phone)
	if (not cacheIdentity[phone]) then cacheIdentity[phone] = exports.oxmysql:query_async('select * from user_characters where phone = ?', { phone })[1]; end;
	return cacheIdentity[phone]
end	

vRP.updateUserIdentity = function(user_id, type, data)
	local PlayerIdentity = vRP.PlayerIdentity(user_id)
	if (PlayerIdentity) then PlayerIdentity:update(type, data); end;
end

vRP.resetIdentity = function(user_id)
	local PlayerIdentity = vRP.PlayerIdentity(user_id)
	if (PlayerIdentity) then
		local identity = PlayerIdentity:getIdentity()

		if (cacheIdentity[identity.registration]) then cacheIdentity[identity.registration] = nil; end;
		if (cacheIdentity[identity.phone]) then cacheIdentity[identity.phone] = nil; end;
	end

	if (cacheUserIdentity[user_id]) then cacheUserIdentity[user_id] = nil; end;
end

--==============================================================================
-- GENERATE FUNCTIONS
--==============================================================================

vRP.generateStringNumber = function(format)
	local abyte = string.byte('A')
	local zbyte = string.byte('0')
	local number = ''
	for i = 1, #format do
		local char = string.sub(format,i,i)
    	if char == 'D' then number = number..string.char(zbyte+math.random(0,9))
		elseif char == 'L' then number = number..string.char(abyte+math.random(0,25))
		else number = number..char end
	end
	return number
end

vRP.generateRegistrationNumber = function()
	local user_id, registration = nil, ''
	repeat
		registration = vRP.generateStringNumber('LLDDDDLL')
		user_id = vRP.getUserByRegistration(registration)
		Citizen.Wait(100)
	until (not user_id)
	return registration
end

vRP.generatePhoneNumber = function()
	local user_id, phone = nil, ''
	repeat
		phone = vRP.generateStringNumber('DDD-DDD')
		user_id = vRP.getUserByPhone(phone)
		Citizen.Wait(100)
	until (not user_id)
	return phone
end

vRP.generateUserRH = function()
	local bloods = { 'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-' }
	return bloods[math.random(#bloods)]
end