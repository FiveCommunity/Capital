config.production = {
    ['tecido'] = {
        ['blipText'] = 'PEGAR TECIDOS', ['progressBarText'] = 'Pegando os tecidos...',
        ['receiveItems'] = {
            ['tecidos'] = { ['min'] = 5, ['max'] = 10 }
        },
        ['duration'] = 5000, ['anim'] = 'mexer'
    },
    ['costurar'] = {
        ['blipText'] = 'COSTURAR O TECIDO', ['progressBarText'] = 'Costurando o tecido...',
        ['requireItems'] = {
            ['tecidos'] = { ['min'] = 5, ['max'] = 5 }
        },
        ['receiveItems'] = {
            ['roupa'] = { ['min'] = 1, ['max'] = 1 }
        },
        ['duration'] = 5000, ['anim'] = 'mexer'
    },
    ['empacotar_costureira'] = {
        ['blipText'] = 'EMPACOTAR A ROUPA', ['progressBarText'] = 'Empacotando...',
        ['requireItems'] = {
            ['roupa'] = { ['min'] = 1, ['max'] = 1 }
        },
        ['receiveItems'] = {
            ['caixaroupas'] = { ['min'] = 1, ['max'] = 1 }
        },
        ['duration'] = 5000, ['anim'] = 'mexer'
    },
    ['encomenda_entregador'] = {
        ['blipText'] = 'PEGAR A ENCOMENDA', ['progressBarText'] = 'Pegando a encomenda...',
        ['receiveItems'] = {
            ['encomendapostop'] = { ['min'] = 1, ['max'] = 1 }
        },
        ['duration'] = 5000, ['anim'] = 'mexer'
    },
    ['encomenda_carteiro'] = {
        ['blipText'] = 'PEGAR A ENCOMENDA', ['progressBarText'] = 'Pegando a encomenda...',
        ['receiveItems'] = {
            ['encomendagopostal'] = { ['min'] = 1, ['max'] = 1 }
        },
        ['duration'] = 5000, ['anim'] = 'mexer'
    },
    ['caixa_bebidas'] = {
        ['blipText'] = 'PEGAR CAIXA', ['progressBarText'] = 'Pegando a caixa...',
        ['receiveItems'] = {
            ['caixabebidas'] = { ['min'] = 1, ['max'] = 1 }
        },
        ['duration'] = 5000, ['anim'] = 'mexer'
    },
    ['botijao_vazio'] = {
        ['blipText'] = 'PEGAR BOTIJÃO VÁZIO', ['progressBarText'] = 'Pegando o botijão vázio...',
        ['receiveItems'] = {
            ['botijao-vazio'] = { ['min'] = 1, ['max'] = 1 }
        },
        ['duration'] = 5000, ['anim'] = 'verificar'
    },
    ['botijao_cheio'] = {
        ['blipText'] = 'ENCHER O BOTIJÃO', ['progressBarText'] = 'Enchendo o botijão...',
        ['requireItems'] = {
           ['botijao-vazio'] = { ['min'] = 1, ['max'] = 1 }
        },
        ['receiveItems'] = {
            ['botijao-cheio'] = { ['min'] = 1, ['max'] = 1 }
        },
        ['duration'] = 5000, ['anim'] = 'mexer'
    },
    ['ferramentas'] = {
        ['blipText'] = 'PEGAR FERRAMENTAS', ['progressBarText'] = 'Pegando as ferramentas...',
        ['receiveItems'] = {
            ['ferramentas'] = { ['min'] = 1, ['max'] = 1 }
        },
        ['duration'] = 5000, ['anim'] = 'mexer'
    },
}

config.locProduction = {
    ['Costureira'] = {
        { ['config'] = 'tecido', ['coord'] = vector4(715.09, -971.36, 30.4, 272.1259765625) },
        { ['config'] = 'costurar', ['coord'] = vector4(713.81, -960.03, 30.4, 175.74803161621) },
        { ['config'] = 'costurar', ['coord'] = vector4(716.36, -960.08, 30.4, 181.41732788086) },
        { ['config'] = 'costurar', ['coord'] = vector4(718.9, -960.07, 30.4, 175.74803161621) },
        { ['config'] = 'costurar', ['coord'] = vector4(718.92, -962.52, 30.4, 175.74803161621) },
        { ['config'] = 'costurar', ['coord'] = vector4(716.24, -962.38, 30.4, 170.07873535156) },
        { ['config'] = 'empacotar_costureira', ['coord'] = vector4(711.4, -969.53, 30.4, 87.874015808105) },
    },
    ['Entregador'] = {
        { ['config'] = 'encomenda_entregador', ['coord'] = vector4(1181.5, -3310.54, 6.03, 272.1259765625) },
        { ['config'] = 'encomenda_entregador', ['coord'] = vector4(1179.15, -3312.81, 6.03, 269.29135131836) },
        { ['config'] = 'encomenda_entregador', ['coord'] = vector4(1179.11, -3314.29, 6.03, 266.45669555664) },
        { ['config'] = 'encomenda_entregador', ['coord'] = vector4(1179.74, -3316.13, 6.03, 266.45669555664) }
    },
    ['Carteiro'] = {
        { ['config'] = 'encomenda_carteiro', ['coord'] = vector4(118.05, 101.99, 81.16, 342.99212646484) },
    },
    ['YellowJack'] = {
        { ['config'] = 'caixa_bebidas', ['coord'] = vector4(1985.29, 3048.83, 47.22, 150.23622131348) },
    },
    ['Gas'] = {
        { ['config'] = 'botijao_vazio', ['coord'] = vector4(922.66, 3646.41, 32.58, 87.874015808105) },
        { ['config'] = 'botijao_cheio', ['coord'] = vector4(906.6, 3661.52, 32.69, 184.25196838379) },
    },
    ['Eletricista'] = {
        { ['config'] = 'ferramentas', ['coord'] = vector4(728.71, 148.57, 80.76, 334.48818969727) },
    }
}