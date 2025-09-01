config.texts = {
    ['setAttachs'] = '<b>Attachs</b> aplicado nos armamentos do arsenal com sucesso.',
    ['clearWeapons'] = 'Você efetuou uma <b>limpeza!</b>',
    ['giveWeapon'] = function(weapon, price)
        return weapon..' <b>equipado</b> com sucesso. Você gastou <b>R$'..vRP.format(price)..'</b>!'
    end,
    ['haveWeapon'] = 'Você já possui esse <b>armamento</b> em seu inventário.',
    ['haveItem'] = function(item)
        return 'Você já possui <b>'..item..'</b> em seu inventário.'
    end,
    ['haveKit'] = function(name)
        return 'Você já possui <b>itens</b> do kit <b>'..name..'</b> em seu inventário.'
    end,
    ['giveKit'] = function(name)
        return name..' <b>resgatado</b> com sucesso.'
    end,
    ['cooldown'] = function(seconds)
        return 'Aguarde <b>'..seconds..' segundos</b>.'
    end,
    ['getAmmoExtra'] = function(name, ammoExtra)
        return 'Você acabou de pegar <b>'..name..' munições</b> extras de <b>'..ammoExtra..'</b>.'
    end,
    ['maxAmmoExtra'] = function(ammoExtraMax, name)
        return 'Você já possui <b>'..ammoExtraMax..' munições</b> de <b>'..name..'</b>.'
    end,
    ['noBackpack'] = 'Você não tem <b>espaço</b> em sua mochila.'
}