Config = {
  -- Quantas vezes por segundo a localização do jogador será atualizada em relação a música
  -- Não há motivo para esse número ser maior que 10
  refreshRate = 4,
  realism = true,
  realismIgnore = {
    [`amarokbr`] = true,
  },

  -- Volume máximo, é bom aumentar este valor quando muitos jogadores reclamarem de som baixo
  -- Valor mínimo 0, Valor máximo 1
  baseVolume = 1,

  -- Tecla utilizada para deixar a caixa de som no chão, ou pegar do chão
  dropRadioKey = 'g',

  -- Valor mínimo de vida que o jogador precisa ter para abrir a NUI
  minimumHealth = 101,

  -- A música vai parar de tocar se o jogador morrer?
  stopOnDeath = true,

  -- Lista de coordenadas de interiores onde o som será desabilitado (precisa ser dentro do interior)
  blockedInteriors = {
    --vector3(148.95, -1039.27, 29.37), -- Banco da praça
  },

  isWindowsOpen = function(vehicle)
    -- Exemplo da base creative network
    -- return Entity(vehicle).state.Windows
  end,

  -- Esta notify acontece quando o jogador não tem permissão
  -- bool == nil   (Jogador sem permissão)
  -- bool == true  (O jogador digitou /som on)
  -- bool == false (O jogador digitou /som off)
  notify = function(bool)
    if type(bool) == 'number' then
      TriggerEvent('Notify', 'sucesso', 'Volume atual: '..bool..'%')
    elseif bool == nil then
      TriggerEvent('Notify', 'negado', 'Você não tem permissão')
    elseif bool then
      TriggerEvent('Notify', 'sucesso', 'Status do som: Ligado')
    else
      TriggerEvent('Notify', 'negado', 'Status do som: Desligado')
    end
  end
}