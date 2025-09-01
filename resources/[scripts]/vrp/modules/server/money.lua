--==============================================================================
-- CACHE MONEY
--==============================================================================
local cacheMoney = {}

vRP.PlayerMoney = function(user_id)
	if (user_id) then
		if (cacheMoney[user_id]) then return cacheMoney[user_id]; end;

		local self = { id = user_id, wallet = exports.oxmysql:query_async('select bank from user_moneys where user_id = ?', { user_id })[1] }

		if (not self.wallet) then
			self.wallet = { bank = 3000 }
			exports.oxmysql:insert_async('insert ignore into user_moneys (user_id, bank) values (?, ?)', { self.id, 3000 })
		end

		self.getMoney = function(_, type)
			local types = {
				['bank'] = function()
					return self.wallet.bank
				end,
				['all'] = function()
					return self.wallet.bank
				end
			}

			if (types[type]) then return types[type](); end;
		end

		self.setMoney = function(_, type, amount, other)
			if (amount) and amount >= 0 then
				local types = {
					['bank'] = function(amount)
						if (other) then
							self.wallet.bank = amount
						else
							self.wallet.bank = (self.wallet.bank+amount)
						end
						exports.oxmysql:update_async('update user_moneys set bank = ? where user_id = ?', { self.wallet.bank, self.id  })
					end,
				}

				if (types[type]) then types[type](amount); end;
			end
		end
		
		self.remMoney = function(_, type, amount)
			local types = {
				['bank'] = function(amount)
					self.wallet.bank = (self.wallet.bank-amount)
					exports.oxmysql:update_async('update user_moneys set bank = ? where user_id = ?', { self.wallet.bank, self.id  })
				end,
			}

			if (types[type]) then types[type](amount); end;
		end

		self.tryPayment = function(_, type, amount)
			if (amount) and amount >= 0 then
				local types = {
					['bank'] = function(amount)
						if (self.wallet.bank >= amount) then
							self:remMoney('bank', amount)
							return true
						end
						return false
					end,
					['full'] = function(amount)
						if (vRP.tryPayment(self.id, amount)) then
							return true
						else
							if (self.wallet.bank >= amount) then
								self:remMoney('bank', amount)
								return true
							end
						end
						return false
					end
				}

				if (types[type]) then return types[type](amount); end;
			end
		end

		self.tryWithdraw = function(_, amount)
			if (amount) and amount > 0 then
				if (self:tryPayment('bank', amount)) then
					vRP.giveMoney(self.id, amount)
					return true
				end
			end
			return false
		end

		self.tryDeposit = function(_, amount)
			if (amount) and amount > 0 then
				if (vRP.tryPayment(self.id, amount)) then
					self:setMoney('bank', amount)
					return true
				end
			end
			return false
		end

		cacheMoney[user_id] = self

		return self
	end
end

vRP.releaseMoney = function(user_id)
	if (user_id) and cacheMoney[user_id] then
		cacheMoney[user_id] = nil
	end
end

--==============================================================================
-- MONEY FUNCTIONS
--==============================================================================
vRP.getAllMoney = function(user_id)
	local value = 0
	local PlayerMoney = vRP.PlayerMoney(user_id)
	if (PlayerMoney) then
		value = (vRP.getInventoryItemAmount(user_id, 'reais')+PlayerMoney:getMoney('all'))
	end
	return value
end

vRP.getBankMoney = function(user_id)
	local PlayerMoney = vRP.PlayerMoney(user_id)
	if (PlayerMoney) then return PlayerMoney:getMoney('bank'); end;
end

vRP.giveBankMoney = function(user_id, value)
	local PlayerMoney = vRP.PlayerMoney(user_id)
	if (PlayerMoney) then PlayerMoney:setMoney('bank', value); end;
end

vRP.tryBankPayment = function(user_id, value)
	local PlayerMoney = vRP.PlayerMoney(user_id)
	if (PlayerMoney) then return PlayerMoney:tryPayment('bank', value); end;
end

vRP.setBankMoney = function(user_id, value)
	local PlayerMoney = vRP.PlayerMoney(user_id)
	if (PlayerMoney) then PlayerMoney:setMoney('bank', value, true); end;
end

vRP.getMoney = function(user_id) 
	local value = 0
	local playerInventory = vRP.PlayerInventory(user_id)
	if (playerInventory) then
		value = playerInventory:getItemAmount('reais')
	end
	return value
end

vRP.tryPayment = function(user_id, value) 
	if (value) and value > 0 then
		local playerInventory = vRP.PlayerInventory(user_id)
		if (playerInventory) then
			return playerInventory:tryGetItem('reais', value, nil, true)
		end
	end
	return false
end

vRP.giveMoney = function(user_id, value)
	if (value) and value > 0 then
		local playerInventory = vRP.PlayerInventory(user_id)
		if (playerInventory) then
			playerInventory:giveItem('reais', value, nil, nil, true)
		end
	end
end

vRP.tryWithdraw = function(user_id, value)
	local PlayerMoney = vRP.PlayerMoney(user_id)
	if (PlayerMoney) then return PlayerMoney:tryWithdraw(value); end;
end

vRP.tryDeposit = function(user_id, value)
	local PlayerMoney = vRP.PlayerMoney(user_id)
	if (PlayerMoney) then return PlayerMoney:tryDeposit(value); end;
end

vRP.tryFullPayment = function(user_id, value)
	local PlayerMoney = vRP.PlayerMoney(user_id)
	if (PlayerMoney) then return PlayerMoney:tryPayment('full', value); end;
end