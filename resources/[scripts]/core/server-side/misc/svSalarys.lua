local srv = {}
Tunnel.bindInterface('Salary', srv)

local salarys = {
    ----------------------------------
    -- VIPS
    ----------------------------------
    { name = '[VIP] Bronze', value = 500, perm = 'bronze.permissao' },
    { name = '[VIP] Prata', value = 750, perm = 'prata.permissao' },
    { name = '[VIP] Ouro', value = 1000, perm = 'ouro.permissao' },
    { name = '[VIP] Capital', value = 1250, perm = 'capital.permissao' },

    ----------------------------------
    -- Policia
    ----------------------------------
    { name = '[EXÉRCITO] Soldado 2° Classe', value = 2000, perm = '@Exercito.Soldado2' },
    { name = '[EXÉRCITO] Soldado 1° Classe', value = 2200, perm = '@Exercito.Soldado1' },
    { name = '[EXÉRCITO] Cabo', value = 2350, perm = '@Exercito.Cabo' },
    { name = '[EXÉRCITO] 3° Sargento', value = 2600, perm = '@Exercito.Sargento3' },
    { name = '[EXÉRCITO] 2° Sargento', value = 2750, perm = '@Exercito.Sargento2' },
    { name = '[EXÉRCITO] 1° Sargento', value = 2850, perm = '@Exercito.Sargento1' },
    { name = '[EXÉRCITO] Subtenente', value = 3000, perm = '@Exercito.SubTenente' },
    { name = '[EXÉRCITO] Aspirante', value = 3100, perm = '@Exercito.Aspirante' },
    { name = '[EXÉRCITO] 2° Tenente', value = 3200, perm = '@Exercito.Tenente2' },
    { name = '[EXÉRCITO] 1° Tenente', value = 3300, perm = '@Exercito.Tenente1' },
    { name = '[EXÉRCITO] Capitão', value = 3645, perm = '@Exercito.Capitao' },
    { name = '[EXÉRCITO] Major', value = 4050, perm = '@Exercito.Major' },
    { name = '[EXÉRCITO] Tenente-Coronel', value = 4500, perm = '@Exercito.TenenteCoronel' },
    { name = '[EXÉRCITO] Coronel', value = 5000, perm = '@Exercito.Coronel' },
    { name = '[EXÉRCITO] General', value = 5000, perm = '@Exercito.General' },

    { name = '[PMC] Soldado 2° Classe', value = 2000, perm = '@PMC.Soldado2' },
    { name = '[PMC] Soldado 1° Classe', value = 2200, perm = '@PMC.Soldado1' },
    { name = '[PMC] Cabo', value = 2350, perm = '@PMC.Cabo' },
    { name = '[PMC] 3° Sargento', value = 2600, perm = '@PMC.Sargento3' },
    { name = '[PMC] 2° Sargento', value = 2750, perm = '@PMC.Sargento2' },
    { name = '[PMC] 1° Sargento', value = 2850, perm = '@PMC.Sargento1' },
    { name = '[PMC] Subtenente', value = 3000, perm = '@PMC.SubTenente' },
    { name = '[PMC] Aspirante', value = 3100, perm = '@PMC.Aspirante' },
    { name = '[PMC] 2° Tenente', value = 3200, perm = '@PMC.Tenente2' },
    { name = '[PMC] 1° Tenente', value = 3300, perm = '@PMC.Tenente1' },
    { name = '[PMC] Capitão', value = 3645, perm = '@PMC.Capitao' },
    { name = '[PMC] Major', value = 4050, perm = '@PMC.Major' },
    { name = '[PMC] Tenente-Coronel', value = 4500, perm = '@PMC.TenenteCoronel' },
    { name = '[PMC] Coronel', value = 5000, perm = '@PMC.Coronel' },

    { name = '[PCP] Soldado 2° Classe', value = 2000, perm = '@PCP.Soldado2' },
    { name = '[PCP] Soldado 1° Classe', value = 2200, perm = '@PCP.Soldado1' },
    { name = '[PCP] Cabo', value = 2350, perm = '@PCP.Cabo' },
    { name = '[PCP] 3° Sargento', value = 2600, perm = '@PCP.Sargento3' },
    { name = '[PCP] 2° Sargento', value = 2750, perm = '@PCP.Sargento2' },
    { name = '[PCP] 1° Sargento', value = 2850, perm = '@PCP.Sargento1' },
    { name = '[PCP] Subtenente', value = 3000, perm = '@PCP.SubTenente' },
    { name = '[PCP] Aspirante', value = 3100, perm = '@PCP.Aspirante' },
    { name = '[PCP] 2° Tenente', value = 3200, perm = '@PCP.Tenente2' },
    { name = '[PCP] 1° Tenente', value = 3300, perm = '@PCP.Tenente1' },
    { name = '[PCP] Capitão', value = 3645, perm = '@PCP.Capitao' },
    { name = '[PCP] Major', value = 4050, perm = '@PCP.Major' },
    { name = '[PCP] Tenente-Coronel', value = 4500, perm = '@PCP.TenenteCoronel' },
    { name = '[PCP] Coronel', value = 5000, perm = '@PCP.Coronel' },

    { name = '[FT] Soldado 2° Classe', value = 2000, perm = '@FT.Soldado2' },
    { name = '[FT] Soldado 1° Classe', value = 2200, perm = '@FT.Soldado1' },
    { name = '[FT] Cabo', value = 2350, perm = '@FT.Cabo' },
    { name = '[FT] 3° Sargento', value = 2600, perm = '@FT.Sargento3' },
    { name = '[FT] 2° Sargento', value = 2750, perm = '@FT.Sargento2' },
    { name = '[FT] 1° Sargento', value = 2850, perm = '@FT.Sargento1' },
    { name = '[FT] Subtenente', value = 3000, perm = '@FT.SubTenente' },
    { name = '[FT] Aspirante', value = 3100, perm = '@FT.Aspirante' },
    { name = '[FT] 2° Tenente', value = 3200, perm = '@FT.Tenente2' },
    { name = '[FT] 1° Tenente', value = 3300, perm = '@FT.Tenente1' },
    { name = '[FT] Capitão', value = 3645, perm = '@FT.Capitao' },
    { name = '[FT] Major', value = 4050, perm = '@FT.Major' },
    { name = '[FT] Tenente-Coronel', value = 4500, perm = '@FT.TenenteCoronel' },
    { name = '[FT] Coronel', value = 5000, perm = '@FT.Coronel' },

    { name = '[GCC] Soldado 2° Classe', value = 2000, perm = '@GCC.Soldado2' },
    { name = '[GCC] Soldado 1° Classe', value = 2200, perm = '@GCC.Soldado1' },
    { name = '[GCC] Cabo', value = 2350, perm = '@GCC.Cabo' },
    { name = '[GCC] 3° Sargento', value = 2600, perm = '@GCC.Sargento3' },
    { name = '[GCC] 2° Sargento', value = 2750, perm = '@GCC.Sargento2' },
    { name = '[GCC] 1° Sargento', value = 2850, perm = '@GCC.Sargento1' },
    { name = '[GCC] Subtenente', value = 3000, perm = '@GCC.SubTenente' },
    { name = '[GCC] Aspirante', value = 3100, perm = '@GCC.Aspirante' },
    { name = '[GCC] 2° Tenente', value = 3200, perm = '@GCC.Tenente2' },
    { name = '[GCC] 1° Tenente', value = 3300, perm = '@GCC.Tenente1' },
    { name = '[GCC] Capitão', value = 3645, perm = '@GCC.Capitao' },
    { name = '[GCC] Major', value = 4050, perm = '@GCC.Major' },
    { name = '[GCC] Tenente-Coronel', value = 4500, perm = '@GCC.TenenteCoronel' },
    { name = '[GCC] Coronel', value = 5000, perm = '@GCC.Coronel' },

    { name = '[BAEP] Soldado 2° Classe', value = 2000, perm = '@BAEP.Soldado2' },
    { name = '[BAEP] Soldado 1° Classe', value = 2200, perm = '@BAEP.Soldado1' },
    { name = '[BAEP] Cabo', value = 2350, perm = '@BAEP.Cabo' },
    { name = '[BAEP] 3° Sargento', value = 2600, perm = '@BAEP.Sargento3' },
    { name = '[BAEP] 2° Sargento', value = 2750, perm = '@BAEP.Sargento2' },
    { name = '[BAEP] 1° Sargento', value = 2850, perm = '@BAEP.Sargento1' },
    { name = '[BAEP] Subtenente', value = 3000, perm = '@BAEP.SubTenente' },
    { name = '[BAEP] Aspirante', value = 3100, perm = '@BAEP.Aspirante' },
    { name = '[BAEP] 2° Tenente', value = 3200, perm = '@BAEP.Tenente2' },
    { name = '[BAEP] 1° Tenente', value = 3300, perm = '@BAEP.Tenente1' },
    { name = '[BAEP] Capitão', value = 3645, perm = '@BAEP.Capitao' },
    { name = '[BAEP] Major', value = 4050, perm = '@BAEP.Major' },
    { name = '[BAEP] Tenente-Coronel', value = 4500, perm = '@BAEP.TenenteCoronel' },
    { name = '[BAEP] Coronel', value = 5000, perm = '@BAEP.Coronel' },

    { name = '[Rota] Soldado 2° Classe', value = 1000, perm = '@Rota.Soldado2' },
    { name = '[Rota] Soldado 1° Classe', value = 1175, perm = '@Rota.Soldado1' },
    { name = '[Rota] Cabo', value = 1351, perm = '@Rota.Cabo' },
    { name = '[Rota] 3° Sargento', value = 1553, perm = '@Rota.Sargento3' },
    { name = '[Rota] 2° Sargento', value = 1786, perm = '@Rota.Sargento2' },
    { name = '[Rota] 1° Sargento', value = 2054, perm = '@Rota.Sargento1' },
    { name = '[Rota] Subtenente', value = 2362, perm = '@Rota.SubTenente' },
    { name = '[Rota] Aspirante', value = 2716, perm = '@Rota.Aspirante' },
    { name = '[Rota] 2° Tenente', value = 2750, perm = '@Rota.Tenente2' },
    { name = '[Rota] 1° Tenente', value = (3591 * 0.8), perm = '@Rota.Tenente1' },
    { name = '[Rota] Capitão', value = (4129 * 0.8), perm = '@Rota.Capitao' },
    { name = '[Rota] Major', value = (4748 * 0.8), perm = '@Rota.Major' },
    { name = '[Rota] Tenente-Coronel', value = (5460 * 0.8), perm = '@Rota.TenenteCoronel' },
    { name = '[Rota] Coronel', value = (6279 * 0.8), perm = '@Rota.Coronel' },

    { name = '[PC] Acadepol', value = 1500, perm = '@PC.Acadepol' },
    { name = '[PC] Agente 3° Classe', value = 2000, perm = '@PC.Agente3' },
    { name = '[PC] Agente 2° Classe', value = 2200, perm = '@PC.Agente2' },
    { name = '[PC] Agente 1° Classe', value = 2350, perm = '@PC.Agente1' },
    { name = '[PC] Agente Classe Especial', value = 2600, perm = '@PC.AgenteEspecial' },
    { name = '[PC] Deic', value = 2750, perm = '@PC.Deic' },
    { name = '[PC] Garra', value = 2750, perm = '@PC.Garra' },
    { name = '[PC] Escrivão', value = 3000, perm = '@PC.Escrivao' },
    { name = '[PC] Delegado Plantonista', value = 3500, perm = '@PC.DelegadoPlantonista' },
    { name = '[PC] Delegado DHPP', value = 4000, perm = '@PC.DelegadoDHPP' },
    { name = '[PC] Delegado Deic', value = 4000, perm = '@PC.DelegadoDeic' },
    { name = '[PC] Delegado Garra', value = 4000, perm = '@PC.DelegadoGarra' },
    { name = '[PC] Delegado Geral', value = 5000, perm = '@PC.DelegadoGeral' },

    { name = '[PRF] Agente 3° Classe', value = 2000, perm = '@PRF.Agente3' },
    { name = '[PRF] Agente 2° Classe', value = 2200, perm = '@PRF.Agente2' },
    { name = '[PRF] Agente 1° Classe', value = 2350, perm = '@PRF.Agente1' },
    { name = '[PRF] Agente Classe Especial', value = 2600, perm = '@PRF.AgenteEspecial' },
    { name = '[PRF] Chefe de Divisão', value = 2750, perm = '@PRF.ChefeDivisao' },
    { name = '[PRF] Chefe de Serviço', value = 3000, perm = '@PRF.ChefeServico' },
    { name = '[PRF] Chefe de Setor', value = 3200, perm = '@PRF.ChefeSetor' },
    { name = '[PRF] Chefe de Núcleo', value = 3350, perm = '@PRF.ChefeNucleo' },
    { name = '[PRF] Coordenador', value = 3500, perm = '@PRF.Coordenador' }, -- 2500
    { name = '[PRF] Coordenador Geral', value = 4050, perm = '@PRF.CoordenadorGeral' },
    { name = '[PRF] Diretor', value = 4500, perm = '@PRF.Diretor' },
    { name = '[PRF] Diretor Geral', value = 5000, perm = '@PRF.DiretorGeral' },
    
    ----------------------------------
    -- Hospital
    ----------------------------------
    { name = '[CUS] Estagiário', value = 1000, perm = '@CUS.Estagiario' },
    { name = '[CUS] Médico Residente', value = 1500, perm = '@CUS.Residente' },
    { name = '[CUS] Médico', value = 2500, perm = '@CUS.Medico' },
    { name = '[CUS] Vice-Diretor', value = 3000, perm = '@CUS.ViceDiretor' },
    { name = '[CUS] Diretora', value = 3500, perm = '@CUS.Diretor' },

    ----------------------------------
    -- Borracharia
    ----------------------------------
    { name = '[Borracharia] Auxiliar de mecânico', value = 500, perm = '@Borracharia.AuxMecanico' },
    { name = '[Borracharia] Mecânico', value = 1000, perm = '@Borracharia.Mecanico' },
    { name = '[Borracharia] Funileiro', value = 1000, perm = '@Borracharia.Funileiro' },
    { name = '[Borracharia] Gerente', value = 1200, perm = '@Borracharia.Gerente' },
    { name = '[Borracharia] Supervisor', value = 1200, perm = '@Borracharia.Supervisor' },
    { name = '[Borracharia] Gerente Geral', value = 1200, perm = '@Borracharia.GerenteGeral' },
    { name = '[Borracharia] Vice-Líder', value = 1500, perm = '@Borracharia.ViceLider' },
    { name = '[Borracharia] Líder', value = 2000, perm = '@Borracharia.Lider' },

    ----------------------------------
    -- Mecânica do Norte
    ----------------------------------
    { name = '[Mecanica do Norte] Auxiliar de mecânico', value = 500, perm = '@MecanicoNorte.AuxMecanico' },
    { name = '[Mecanica do Norte] Mecânico', value = 1000, perm = '@MecanicoNorte.Mecanico' },
    { name = '[Mecanica do Norte] Funileiro', value = 1000, perm = '@MecanicoNorte.Funileiro' },
    { name = '[Mecanica do Norte] Gerente', value = 1200, perm = '@MecanicoNorte.Gerente' },
    { name = '[Mecanica do Norte] Supervisor', value = 1200, perm = '@MecanicoNorte.Supervisor' },
    { name = '[Mecanica do Norte] Gerente Geral', value = 1200, perm = '@MecanicoNorte.GerenteGeral' },
    { name = '[Mecanica do Norte] Vice-Líder', value = 1500, perm = '@MecanicoNorte.ViceLider' },
    { name = '[Mecanica do Norte] Líder', value = 2000, perm = '@MecanicoNorte.Lider' },
    ----------------------------------
    -- Juridico 
    ----------------------------------
    { name = '[Tribunal] Estagiário', value = 1000, perm = '@Juridico.Estagiario' },
    { name = '[Tribunal] Advogado Jr', value = 1900, perm = '@Juridico.AdvogadoJunior' },
    { name = '[Tribunal] Advogado Pleno', value = 2000, perm = '@Juridico.AdvogadoPleno' },
    { name = '[Tribunal] Advogado Senior', value = 2100, perm = '@Juridico.AdvogadoSenior' },
    { name = '[Tribunal] Secretário Adjunto', value = 2500, perm = '@Juridico.SecretarioAdjunto' },
    { name = '[Tribunal] Secretário Geral', value = 3000, perm = '@Juridico.SecretarioGeral' },
    { name = '[Tribunal] Vice-Presidente', value = 3500, perm = '@Juridico.VicePresidente' },
    { name = '[Tribunal] Presidente', value = 4000, perm = '@Juridico.Presidente' },
    { name = '[Tribunal] Juiz', value = 5000, perm = '@Juridico.Juiz' },

    ----------------------------------
    -- Jornal 
    ----------------------------------
    { name = 'Jornal', value = 1250, perm = 'jornal.permissao' },
}

local giveSalary = function()
    for user_id, source in pairs(vRP.getUsers()) do
        if (user_id) and (source) then
            local totalValue, text = 0, '';
            
            for _, data in pairs(salarys) do    
                if (vRP.hasPermission(user_id, data.perm)) then
                    totalValue = (totalValue + data.value);

                    text = text..'<br> <b>'..data.name..' - R$'..data.value..',00</b>'
                end
            end
            
            if (totalValue > 0) then
                vRP.giveBankMoney(user_id, totalValue)
                exports['phone-bank']:createStatement(user_id, { title = 'Salário', content = 'Governo depositou seu salário', value = totalValue, type = 'received' })

                TriggerClientEvent('vrp_sounds:source', source, 'coins', 0.5)
                TriggerClientEvent('notify', source, 'importante', 'Salário', 'Folha de pagamento: <br>'..text, 30000)
            end
        end
    end
end

Citizen.CreateThread(function()
    while (true) do
        Citizen.Wait((30 * 60) * 1000)
        giveSalary()
    end
end)