config.waitStartThread = 10 -- Seconds
config.deathTimer = 300
config.spawn = vector4(362.4264, -590.7033, 28.65637, 246.6142)

config.extraDeath = function()
    TriggerEvent('hud_weapon:disable')
    TriggerEvent('radio:outServers')
    TriggerEvent('phone:playerDeath')
end