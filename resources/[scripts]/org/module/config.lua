config.roles = {
    ilegal = { full_permissions = {'Lider', 'ViceLider'}, half_permissions = 'Gerente' },
    
    pmc = { full_permissions = { 'Coronel', 'TenenteCoronel' }, half_permissions = {}  },    
    pcp = { full_permissions = { 'Coronel', 'TenenteCoronel' }, half_permissions = {}  },    
    corregedoria = { full_permissions = { 'Secretario' }, half_permissions = 'SecretarioAdjunto'  },    
    exercito = { full_permissions = { 'General', 'Coronel', 'TenenteCoronel' }, half_permissions = {}  },    
    ft = { full_permissions = { 'Coronel', 'TenenteCoronel' }, half_permissions = {}  },
    gcc = { full_permissions = { 'Coronel', 'TenenteCoronel' }, half_permissions = {}  },    
    rota = { full_permissions = { 'Coronel', 'TenenteCoronel' }, half_permissions = {}  },    
    pc = { full_permissions = { 'DelegadoGeral' }, half_permissions = {}  },    
    prf = { full_permissions = { 'DiretorGeral', 'Diretor' }, half_permissions = {}  },    

    cus = { full_permissions = { 'DiretorChefe', 'Diretor', 'ViceDiretor' }, half_permissions = {}  },    
    borracharia = { full_permissions = { 'Lider', 'ViceLider' }, half_permissions = {}  },
    restaurante = { full_permissions = { 'Dono', 'Socio' }, half_permissions = 'Gerente' },

    judiciario = { full_permissions = 'Presidente', half_permissions = { 'VicePresidente' }},
    jornal = { full_permissions = 'Diretor', half_permissions = { 'SecRedacao' }},
}

config.grades = {
    ilegal = {
        'Lider',
        'ViceLider',
        'Gerente',
        'Membro'
    },
    pmc = {
        'Coronel',
        'TenenteCoronel',
        'Major',
        'Capitao',
        'Tenente1',
        'Tenente2',
        'Aspirante',
        'SubTenente',
        'Sargento1',
        'Sargento2',
        'Sargento3',
        'Cabo',
        'Soldado1',
        'Soldado2',
    },
    pcp = {
        'Coronel',
        'TenenteCoronel',
        'Major',
        'Capitao',
        'Tenente1',
        'Tenente2',
        'Aspirante',
        'SubTenente',
        'Sargento1',
        'Sargento2',
        'Sargento3',
        'Cabo',
        'Soldado1',
        'Soldado2',
    },
    exercito = {
        'General',
        'Coronel',
        'TenenteCoronel',
        'Major',
        'Capitao',
        'Tenente1',
        'Tenente2',
        'Aspirante',
        'SubTenente',
        'Sargento1',
        'Sargento2',
        'Sargento3',
        'Cabo',
        'Soldado1',
        'Soldado2',
    },
    ft = {
        'Coronel',
        'TenenteCoronel',
        'Major',
        'Capitao',
        'Tenente1',
        'Tenente2',
        'Aspirante',
        'SubTenente',
        'Sargento1',
        'Sargento2',
        'Sargento3',
        'Cabo',
        'Soldado1',
        'Soldado2',
    },
    gcc = {
        'Coronel',
        'TenenteCoronel',
        'Major',
        'Capitao',
        'Tenente1',
        'Tenente2',
        'Aspirante',
        'SubTenente',
        'Sargento1',
        'Sargento2',
        'Sargento3',
        'Cabo',
        'Soldado1',
        'Soldado2',
    },
    rota = {
        'Coronel',
        'TenenteCoronel',
        'Major',
        'Capitao',
        'Tenente1',
        'Tenente2',
        'Aspirante',
        'SubTenente',
        'Sargento1',
        'Sargento2',
        'Sargento3',
        'Cabo',
        'Soldado1',
        'Soldado2',
    },
    pc = {
        'DelegadoGeral',
        'DelegadoGarra',
        'DelegadoDeic',
        'DelegadoDHPP',
        'DelegadoPlantonista',
        'Escrivao',
        'Garra',
        'Deic',
        'AgenteEspecial',
        'Agente1',
        'Agente2',
        'Agente3',
        'Acadepol',
    },
    prf = {
        'DiretorGeral',
        'Diretor',
        'CoordenadorGeral',
        'Coordenador',
        'ChefeNucleo',
        'ChefeSetor',
        'ChefeServico',
        'ChefeDivisao',
        'AgenteEspecial',
        'Agente1',
        'Agente2',
        'Agente3',  
    },
    cus         = {
        'DiretorChefe',
        'Diretor',
        'ViceDiretor',
        'Medico',
        'Residente',
        'Estagiario'
    },
    borracharia = {
        'Lider',
        'ViceLider',
        'Gerente',
        'Supervisor',
        'Funileiro',
        'Mecanico',
        'AuxMecanico',
    },
    restaurante  = {
        'Dono',
        'Socio',
        'Gerente',
        'Cozinheiro',
        'Atendente',
        'Entregador',
        'Novato',
    },
    judiciario = {
        'Presidente',
        'VicePresidente',
        'SecretarioGeral',
        'SecretarioAdjunto',
        'AdvogadoSenior',
        'AdvogadoPleno',
        'AdvogadoJunior',
        'Estagiario',
    },
    jornal = {
        'Diretor',
        'Camera',
        'SecRedacao',
        'ChefeReportagem',
        'Jornalista',
        'Equipe',
    },
    corregedoria = {
        'CorregedorAuxiliar',
        'Corregedor',
        'ViceCorregedor',
        'CorregedorGeral',
        'SecretarioAdjunto',
        'Secretario'
    }
}

config.facs = {
    ['Juridico'] = {
        vagas = 500,
        serviceCheck = 'active',
        grades = config.grades.judiciario,
        roles = config.roles.judiciario
    },
    ['PRF'] = {
        vagas = 500,
        serviceCheck = 'active',
        grades = config.grades.prf,
        roles = config.roles.prf
    },
    ['PC'] = {
        vagas = 50,
        serviceCheck = 'active',
        grades = config.grades.pc,
        roles = config.roles.pc
    },
    ['Rota'] = {
        vagas = 500,
        serviceCheck = 'active',
        grades = config.grades.rota,
        roles = config.roles.rota
    },
    ['FT'] = {
        vagas = 500,
        serviceCheck = 'active',
        grades = config.grades.ft,
        roles = config.roles.ft
    },
    ['BAEP'] = {
        vagas = 500,
        serviceCheck = 'active',
        grades = config.grades.ft,
        roles = config.roles.ft
    },
    ['PMC'] = {
        vagas = 500,
        serviceCheck = 'active',
        grades = config.grades.pmc,
        roles = config.roles.pmc
    },
    ['PCP'] = {
        vagas = 500,
        serviceCheck = 'active',
        grades = config.grades.pmc,
        roles = config.roles.pmc
    },
    ['Corregedoria'] = {
        vagas = 500,
        serviceCheck = 'active',
        grades = config.grades.corregedoria,
        roles = config.roles.corregedoria
    },
    ['Exercito'] = {
        vagas = 500,
        serviceCheck = 'active',
        grades = config.grades.exercito,
        roles = config.roles.exercito
    },
    ['GCC'] = {
        vagas = 500,
        serviceCheck = 'active',
        grades = config.grades.gcc,
        roles = config.roles.gcc
    },
    ['Jornal'] = {
        vagas = 100,
        serviceCheck = 'active',
        grades = config.grades.jornal,
        roles = config.roles.jornal
    },
    ['Mptv'] = {
        vagas = 100,
        serviceCheck = 'active',
        grades = config.grades.jornal,
        roles = config.roles.jornal
    },
    ['SafadassoJornal'] = {
        vagas = 100,
        serviceCheck = 'active',
        grades = config.grades.jornal,
        roles = config.roles.jornal
    },
    ['CUS'] = {
        vagas = 200,
        serviceCheck = 'active',
        grades = config.grades.cus,
        roles = config.roles.cus
    },
    ['Borracharia'] = {
        vagas = 50,
        serviceCheck = 'active',
        grades = config.grades.borracharia,
        roles = config.roles.borracharia
    },
    ['Bracho'] = {
        vagas = 50,
        serviceCheck = 'active',
        grades = config.grades.borracharia,
        roles = config.roles.borracharia
    },
    ['Laricas'] = {
        vagas = 500,
        serviceCheck = 'online',
        grades = config.grades.restaurante,
        roles = config.roles.restaurante
    },
    ['KafeComMel'] = {
        vagas = 50,
        serviceCheck = 'online',
        grades = config.grades.restaurante,
        roles = config.roles.restaurante
    },
    ['Grotorante'] = {
        vagas = 500,
        serviceCheck = 'online',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Galaxy'] = {
        vagas = 45,
        serviceCheck = 'online',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['MorroMina'] = {
        vagas = 45,
        serviceCheck = 'online',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Dende'] = {
        vagas = 45,
        serviceCheck = 'online',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Chineses'] = {
        vagas = 45,
        serviceCheck = 'online',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['FavelaBarragem'] = {
        vagas = 45,
        serviceCheck = 'online',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Palhacos'] = {
        vagas = 45,
        serviceCheck = 'online',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Medelin'] = {
        vagas = 45,
        serviceCheck = 'online',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Hydra'] = {
        vagas = 45,
        serviceCheck = 'online',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['CaixaDagua'] = {
        vagas = 45,
        serviceCheck = 'online',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Fazenda'] = {
        vagas = 45,
        serviceCheck = 'online',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Chineses'] = {
        vagas = 45,
        serviceCheck = 'online',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Venezza'] = {
        vagas = 45,
        serviceCheck = 'online',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['MotoClub'] = {
        vagas = 45,
        serviceCheck = 'online',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['OsVeio'] = {
        vagas = 45,
        serviceCheck = 'online',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Blackout'] = {
        vagas = 45,
        serviceCheck = 'online',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Sindicato'] = {
        vagas = 45,
        serviceCheck = 'online',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['LosPraca'] = {
        vagas = 45,
        serviceCheck = 'online',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Phoenix'] = {
        vagas = 45,
        serviceCheck = 'online',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['CDD'] = {
        vagas = 45,
        serviceCheck = 'online',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Legiao'] = {
        vagas = 45,
        serviceCheck = 'online',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Boiadeiras'] = {
        vagas = 45,
        serviceCheck = 'online',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Cupim'] = {
        vagas = 45,
        serviceCheck = 'online',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Penha'] = {
        vagas = 45,
        serviceCheck = 'online',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Mantem'] = {
        vagas = 45,
        serviceCheck = 'online',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Ghost'] = {
        vagas = 45,
        serviceCheck = 'online',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Ciringa'] = {
        vagas = 45,
        serviceCheck = 'online',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Dinastia'] = {
        vagas = 45,
        serviceCheck = 'online',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Bennys'] = {
        vagas = 45,
        serviceCheck = 'online',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['BennysTunner'] = {
        vagas = 45,
        serviceCheck = 'online',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['OsCrias'] = {
        vagas = 45,
        serviceCheck = 'active',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['ComandoNorte'] = {
        vagas = 45,
        serviceCheck = 'active',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Olimpo'] = {
        vagas = 45,
        serviceCheck = 'active',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Ordem'] = {
        vagas = 45,
        serviceCheck = 'active',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['MDS'] = {
        vagas = 45,
        serviceCheck = 'active',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Turano'] = {
        vagas = 45,
        serviceCheck = 'active',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Reciclagem'] = {
        vagas = 45,
        serviceCheck = 'active',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Triade'] = {
        vagas = 45,
        serviceCheck = 'active',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['BandoDosGauchos'] = {
        vagas = 45,
        serviceCheck = 'active',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Juramento'] = {
        vagas = 45,
        serviceCheck = 'active',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Underdogs'] = {
        vagas = 45,
        serviceCheck = 'active',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Irmandade'] = {
        vagas = 45,
        serviceCheck = 'active',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['CartelNPN'] = {
        vagas = 45,
        serviceCheck = 'active',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Bahamas'] = {
        vagas = 45,
        serviceCheck = 'active',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['K10'] = {
        vagas = 45,
        serviceCheck = 'active',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['LaFronteira'] = {
        vagas = 45,
        serviceCheck = 'active',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Aztecas'] = {
        vagas = 45,
        serviceCheck = 'active',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Comitiva'] = {
        vagas = 45,
        serviceCheck = 'active',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['TheFusion'] = {
        vagas = 45,
        serviceCheck = 'active',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Caos'] = {
        vagas = 45,
        serviceCheck = 'active',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['CosaNostra'] = {
        vagas = 45,
        serviceCheck = 'active',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Ratoeira'] = {
        vagas = 45,
        serviceCheck = 'active',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Dende'] = {
        vagas = 45,
        serviceCheck = 'active',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Wanana'] = {
        vagas = 45,
        serviceCheck = 'active',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Helipa'] = {
        vagas = 45,
        serviceCheck = 'active',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['NovaEra'] = {
        vagas = 45,
        serviceCheck = 'active',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Mare'] = {
        vagas = 45,
        serviceCheck = 'active',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['DubaiGang'] = {
        vagas = 45,
        serviceCheck = 'active',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Tropical'] = {
        vagas = 45,
        serviceCheck = 'active',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Bras'] = {
        vagas = 45,
        serviceCheck = 'active',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['MonteCristo'] = {
        vagas = 45,
        serviceCheck = 'active',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Fundao'] = {
        vagas = 45,
        serviceCheck = 'active',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Umbrella'] = {
        vagas = 45,
        serviceCheck = 'active',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
    ['Ima'] = {
        vagas = 45,
        serviceCheck = 'active',
        grades = config.grades.ilegal,
        roles = config.roles.ilegal
    },
}

configFacs = config.facs