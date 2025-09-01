local groups = {}
AddEventHandler('onResourceStart', function(resourceName)
  	if ('setgroup' == resourceName) then 
		groups = exports.setgroup:GetGroups()
		print('^1[GB Groups]^7 Grupos criados!')
	end
end)

local users = config.users

--==============================================================================
-- CACHE GROUPS
--==============================================================================
local cacheGroups = {}

vRP.PlayerGroups = function(user_id)
    if (user_id) then
        if (cacheGroups[user_id]) then return cacheGroups[user_id]; end;

        local self = { id = user_id, groups = nil, permissions = nil }

        --[ REGISTERS ]======================================================

        self.groups = {}
        self.permissions = {}

        local query = exports.oxmysql:query_async('select * from user_groups where user_id = ?', { self.id })
        for _, data in pairs(query) do
            self.groups[data.group_id] = { grade = data.grade_id, expire = data.expire, active = (data.active == 1) }
        end
        
        self.update = function()
            self.permissions = {}
            
            for group, data in pairs(self.groups) do
                local g = groups[group]
                if (g) then
                    for _, perm in pairs(g) do
                        if (type(perm) == 'string') then
    
                            if (not self.permissions[perm]) then
                                self.permissions[perm] = {}
                            end
                            
                            if (data.active) then
                                table.insert(self.permissions[perm], group)
                            end

                        end
                    end
                end
            end
        end 
        
        self:update()

        --===============================================================

        local updatePermission = function(bool, group)
            local g = groups[group]
            if (g) then
                for _, perm in pairs(g) do
                    if (type(perm) == 'string') then
                        self.permissions[perm] = ((bool == true) and group or bool)
                    end
                end
            end
        end

        self.getGroups = function()
            return self.groups
        end

        self.hasGroup = function(_, group)
            if (self.groups[group]) then
                return true, self.groups[group].grade
            end
            return false
        end

        self.hasActive = function(_, group)
            return self.groups[group].active
        end

        self.setActive = function(_, group, active)
            self.groups[group].active = active
            
            self:update()

            exports.oxmysql:update_async('update user_groups set active = ? where user_id = ? and group_id = ?', { active, self.id, group })
            return true
        end

        self.groupByType = function(_, gtype)
            for group, data in pairs(self.groups) do
                local g = groups[group]
                if (g) and (g.information) then
                    if (g.information.groupType) and (g.information.groupType == gtype) then
                        return group, data
                    end
                end
            end
            return false
        end

        self.addGroup = function(_, group, grade)
            local hasGroup, hasGrade = self:hasGroup(group)
            if (not hasGroup) then
                local g = groups[group]
                if (g) then
                    if (not grade) then grade = (g.information.grades_default or group); end;

                    self.groups[group] = { grade = grade, active = true, expire = 0 }

                    if (g.information) and (g.information.groupType) then
                        for grp, data in pairs(self.groups) do
                            if (group ~= grp) then
                                local _g = groups[grp]
                                if (_g) and (_g.information) then
                                    if (_g.information.groupType == g.information.groupType) then
                                        self:remGroup(grp)
                                    end
                                end
                            end
                        end
                    end

                    self:update()

                    exports.oxmysql:insert_async('insert ignore into user_groups (user_id, group_id, grade_id, active) values (?, ?, ?, ?)', { self.id, group, grade, true })

                    TriggerEvent('group:event', 'joinned', { user_id = self.id, group = group, grade = grade, type = (g.information.groupType or '') })
                    return true
                end
            else
                if (grade) and (grade ~= hasGrade) then
                    self.groups[group].grade = grade
                    
                    exports.oxmysql:update_async('update user_groups set grade_id = ? where user_id = ? and group_id = ?', { grade, self.id, group })

                    TriggerEvent('group:event', 'update', { user_id = self.id, group = group, grade = grade })
                    return true
                end
            end
            return false
        end

        self.remGroup = function(_, group)
            local hasGroup = self:hasGroup(group)
            if (hasGroup) then

                self.groups[group] = nil

                self:update()
                
                exports.oxmysql:execute_async('delete from user_groups where user_id = ? and group_id = ?', { self.id, group })

                TriggerEvent('group:event', 'leave', { user_id = self.id, group = group })
            end
            return true
        end

        self.hasPerm = function(_, perm)
            --[[
                COMANDOS:
                    'policia.permissao' (SE TIVER A PERMISSAO, ATIVO)
                    ~ | '~policia.permissao' (SE TIVER A PERMISSAO)
                    + | '+Policia.Tenente' (CARGO MAIOR OU IGUAL A TENENTE, ATIVO )
                    > | '>Policia.Tenente' (CARGO MAIOR OU IGUAL A TENENTE, ATIVO/INATIVO )
                    @ | '@Policia.Tenente' (CARGO IGUAL A TENENTE, ATIVO )
            ]]
            local chars = {
                -- "+Policia.Tenente"
                ['+'] = function(split)
                    if (#split == 2) then
                        local paramGroup, paramGrade = split[1], split[2]
                        local g = groups[paramGroup]
                        if (g) and (g.information) and (g.information.grades) then
                            local targetLevel = g.information.grades[paramGrade].level
                            local inGroup, inGrade = self:hasGroup(paramGroup)
                            if (inGroup) and self:hasActive(paramGroup) then
                                local currLevel = g.information.grades[inGrade].level
                                return (currLevel >= targetLevel)
                            end
                        end
                    end
                    return false
                end,

                -- ">Policia.Tenente"
                ['>'] = function(split)
                    if (#split == 2) then
                        local paramGroup, paramGrade = split[1], split[2]
                        local g = groups[paramGroup]
                        if (g) and (g.information) and (g.information.grades) then
                            local targetLevel = g.information.grades[paramGrade].level
                            local inGroup, inGrade = self:hasGroup(paramGroup)
                            if (inGroup) then
                                local currLevel = g.information.grades[inGrade].level
                                return (currLevel >= targetLevel)
                            end
                        end
                    end
                    return false
                end,

                -- "@Policia.Tenente"
                ['@'] = function(split)
                    if (#split == 2) then
                        local paramGroup, paramGrade = split[1], split[2]
                        local g = groups[paramGroup]
                        if (g) then
                            local inGroup, inGrade = self:hasGroup(paramGroup)
                            if (inGroup) and (inGrade == paramGrade) then
                                return self:hasActive(paramGroup)
                            end
                        end
                    end
                    return false
                end,

                -- "~policia.permissao"
                ['~'] = function(split, perm, permsub)
                    if (self.permissions[permsub]) then
                        return true
                    end
                    return false
                end,

                ['other'] = function(split, perm)
                    if (self.permissions[perm]) then
                        return (#self.permissions[perm] > 0)
                    end
                    return false
                end
            }


            local char = string.sub(perm, 1, 1)
            local typeChar = ((not chars[char]) and 'other' or char)
            local perm_subbed = string.sub(perm, 2, string.len(perm))
            local split = splitString(perm_subbed, '.')

            if (chars[typeChar]) then return chars[typeChar](split, perm, perm_subbed); end;
            return false
        end

        self.addUserTemporaryGroup = function(_, group, days)
            self:addGroup(group)

            local expire = os.time()
            if (self.groups[group].expire > 0) then
                expire = self.groups[group].expire
            end

            local newExpire = (expire + (days * 24 * 3600))
            self.groups[group].expire = newExpire

            exports.oxmysql:update_async('update user_groups set expire = ? where user_id = ? and group_id = ?', { newExpire, self.id, group })
        end

        cacheGroups[user_id] = self

        return self
    end
end

vRP.releaseGroups = function(user_id)
    if (user_id) and cacheGroups[user_id] then
        cacheGroups[user_id] = nil
    end
end

--==============================================================================
-- GROUP FUNCTIONS
--==============================================================================

vRP.getGroups = function() return groups; end;

vRP.getGroupTitle = function(group, grade)
	local g = groups[group]
	if (g) and (g.information) then
		if (grade) then
			if (g.information.grades) and (g.information.grades[grade].title) then
				return g.information.grades[grade].title
			end
		end

		if (g.information.title) then
			return g.information.title
		end
	end
	return group
end

vRP.getGroupType = function(group)
	local g = groups[group]
	if (g) and (g.information and g.information.groupType) then
		return g.information.groupType
	end
	return false
end

vRP.isGroupWithGrades = function(group, retGrades)
	local g = groups[group]
	if (g) and (g.information) then
		if (g.information.grades) then
			if (retGrades) then
				return g.information.grades, g.information.grades_default
			end
			return true
		end
	end
	return false
end

vRP.getUserGroups = function(user_id)
	local PlayerGroups = vRP.PlayerGroups(user_id)
	if (PlayerGroups) then return PlayerGroups:getGroups(); end;
end

vRP.hasGroup = function(user_id, group)
	local PlayerGroups = vRP.PlayerGroups(user_id)
	if (PlayerGroups) then return PlayerGroups:hasGroup(group); end;
end

vRP.getUserGroupByType = function(user_id, gtype)
	local PlayerGroups = vRP.PlayerGroups(user_id)
	if (PlayerGroups) then return PlayerGroups:groupByType(gtype); end;
end

vRP.hasGroupActive = function(user_id, group)
	local PlayerGroups = vRP.PlayerGroups(user_id)
	if (PlayerGroups) then return PlayerGroups:hasActive(group); end;
end

vRP.setGroupActive = function(user_id, group, active)
	local PlayerGroups = vRP.PlayerGroups(user_id)
	if (PlayerGroups) then return PlayerGroups:setActive(group, active); end;
end

vRP.addUserGroup = function(user_id, group, grade)
	local PlayerGroups = vRP.PlayerGroups(user_id)
	if (PlayerGroups) then return PlayerGroups:addGroup(group, grade); end;
end

vRP.addTemporaryGroup = function(user_id, group, days)
	local PlayerGroups = vRP.PlayerGroups(user_id)
	if (PlayerGroups) then return PlayerGroups:addUserTemporaryGroup(group, days); end;
end

vRP.removeUserGroup = function(user_id, group)
	local PlayerGroups = vRP.PlayerGroups(user_id)
	if (PlayerGroups) then return PlayerGroups:remGroup(group); end;
end

vRP.hasPermission = function(user_id, perm)
	local PlayerGroups = vRP.PlayerGroups(user_id)
    if (PlayerGroups) then return PlayerGroups:hasPerm(perm); end;
end

vRP.getUsersByPermission = function(perm)
    local cb = {}
    for id, _ in pairs(cacheUsers.user_source) do
        local PlayerGroups = vRP.PlayerGroups(id)
        if (PlayerGroups) then
            if (PlayerGroups:hasPerm(perm)) then
                table.insert(cb, id)
            end
        end
    end
    return cb
end

vRP.checkPermissions = function(user_id, permission)
	local PlayerGroups = vRP.PlayerGroups(user_id)
	if (PlayerGroups) then
		if (permission) then
			if (type(permission) == 'table') then
				for _, perm in pairs (permission) do
					if (PlayerGroups:hasPerm(perm)) then
						return true
					end
				end
				return false
			end
			return PlayerGroups:hasPerm(permission)
		end
	end
	return true
end

AddEventHandler('playerSpawn', function(user_id, source, firstSpawn)
	local PlayerGroups = vRP.PlayerGroups(user_id)
	if (PlayerGroups) then
		
		if (firstSpawn) then
			local user = users[user_id]
			if (user) then
				for group, grade in pairs(user) do
					PlayerGroups:addGroup(group, grade)
				end
			end
		end

		for group, data in pairs(PlayerGroups.groups) do
			local expires = tonumber(data.expire)
			if (expires) and (expires > 0) then
				if (os.time() > expires) then
					PlayerGroups:remGroup(group)
					TriggerClientEvent('notify', source, 'importante', 'Grupo', 'O seu grupo <b>'..vRP.getGroupTitle(group)..'</b> expirou!', 15000)
				else
					TriggerClientEvent('notify', source, 'importante', 'Grupo', 'O seu grupo <b>'..vRP.getGroupTitle(group)..'</b> expira <b>'..os.date('%d/%m/%Y', expires)..'</b>.', 15000)
				end
			end
		end

	end
end)

Citizen.CreateThread(function()
	local query = exports.oxmysql:query_async('select * from user_groups')
	for _, data in pairs(query) do
		local expires = tonumber(data.expire)
		if (expires) and (expires > 0) then
			if (os.time() > expires) then
				vRP.removeUserGroup(data.user_id, data.group_id)

				print('^1[LOJA VIP]:^7 O VIP ^1'..data.group_id..'^7 DO USER_ID ^1'..data.user_id..'^7 EXPIROU.')
			end
		end
	end
end)