local cooldown = {}
CreateCooldown = function(target, time)
    target = tostring(target)
    Citizen.CreateThread(function()
        cooldown[target] = time
        while (cooldown[target] > 0) do
            Citizen.Wait(1000)
            cooldown[target] = cooldown[target] - 1
        end
        cooldown[target] = nil
    end)
end
exports('CreateCooldown', CreateCooldown)

GetCooldown = function(target)
    return cooldown[target]
end
exports('GetCooldown', GetCooldown)

Citizen.CreateThread(function()
    print('^1[DB]^7 cleared phone_notifications')
    exports.oxmysql:execute_async('DELETE FROM phone_notifications')

    local time = os.date('*t')
    if (time) and (time.day == '29') then
        print('^1[DB]^7 cleared phone_photos')
        exports.oxmysql:execute_async('DELETE FROM phone_photos')
    end
end)

-- [ SKIN EXPIRADA ] --
vRP._prepare('capital_skins/delete_expired_skins', 'delete from skins_players WHERE owned_at < NOW() - INTERVAL 1 MONTH')
deleteExpiredSkins = function()
    print("^1[SKINS]^7 TODAS AS SKINS EXPIRADAS FORAM DELETADAS!")
    vRP.execute('capital_skins/delete_expired_skins')
end

Citizen.CreateThread(function()
    deleteExpiredSkins()
end)