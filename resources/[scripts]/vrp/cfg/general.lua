config.prioritySteam = {
  ['110000142959ab4'] = 500, -- HEX (bagual)
  ['11000013c57048e'] = 500, -- HEX (paulinho)
  ['110000145d86c75'] = 500, -- HEX (nando)
  ['110000133b5da05'] = 500, -- HEX (delega)
}

config.maintenanceMode = false
config.maintenanceBypass = {
  ['110000142959ab4'] = true, -- HEX (bagual)
  ['11000013c57048e'] = true, -- HEX (paulinho)
  ['110000145d86c75'] = true, -- HEX (nando)
  ['1100001038894b8'] = true, -- HEX (RobinUdi)
  ['110000133b5da05'] = true, -- HEX (delega)
  ['11000013606A52F'] = true, -- HEX (universe)
  ['11000013C4C9B3E'] = true, -- HEX (universe)
  ['11000010e3a8136'] = true, -- HEX (universe)
}

config.language = {
  maintenance = function(name)
    return '\n\n['..cityInformations.name..']\n\nOlá '..name..', o servidor se encontra em manutenção nesse exato momento, volte mais tarde!\nMais informações em nosso discord: '..cityInformations.discord
  end,
  joining = function(name)
    return '\n\n['..cityInformations.name..']\n\nOlá '..name..', você está entrando na cidade...'
  end,
  connecting = function(name)
    return '\n\n['..cityInformations.name..']\n\nOlá '..name..', você está se conectando em nossa cidade...'
  end,
  connectingError = function(name)
    if not (name) then name = 'user' end;
    return '\n\n['..cityInformations.name..']\n\nOlá '..name..', não foi possível adicioná-lo na fila.\n\nNosso discord: '..cityInformations.discord
  end,
  error = function(name)
    return '\n\n['..cityInformations.name..']\n\nOlá '..name..', não foi possível identificar sua Social Club.'
  end,
  kick = function(name)
    return '\n\n['..cityInformations.name..']\n\nOlá '..name..', você foi expulso da fila'
  end,
  desconnect = function(name)
    if not (name) then name = 'user' end;
    return '\n\n['..cityInformations.name..']\n\nOlá '..name..', você foi desconectado por demorar demais na fila.'
  end,
  position = function(name, yourPosition, size)
    return '\n\n['..cityInformations.name..']\n\nOlá '..name..', você é o '..yourPosition..'/'..size..' da fila, aguarde a sua conexão...\n\nAdquira prioridade na fila para logar mais rápido em nossa loja: '..cityInformations.shop
  end,
  finalMessage = function(langaguePos)
    return langaguePos..'\nEvite punições, fique por dentro das regras de conduta.\nAtualizações frequentes, deixe a sua sugestão em nosso discord.\n\nNosso discord: '..cityInformations.discord
  end,
  steam = function(name)
    return '\n\n['..cityInformations.name..']\n\nOlá '..name..', não foi possível identificar sua Steam.'
  end
}