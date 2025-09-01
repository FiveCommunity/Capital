exports('hasPermission', function(source, permission)
  if GetResourceState('vrp') == 'started' then
    if vRP == nil then
      load(LoadResourceFile('vrp', 'lib/Utils.lua'))()
      local Proxy = module('lib/Proxy')
      vRP = Proxy.getInterface('vRP')
    end

    local user_id = vRP.getUserId(source) or vRP.Passport(source)
    if user_id then
      if permission == 'nil.permissao' then
        return true
      end
      return (
        vRP.hasPermission(user_id, permission) or vRP.HasPermission(user_id, permission) or vRP.hasGroup(user_id, permission) or vRP.HasGroup(user_id, permission)
      )
    end
  elseif GetResourceState('nyo_modules') == 'started' then
    local user_id = exports.nyo_modules:getCharId(source)
    return exports.nyo_modules:hasPermission(user_id, permission)
  end
  return false
end)
