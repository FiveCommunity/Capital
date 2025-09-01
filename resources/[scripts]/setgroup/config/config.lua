config = {}

config.groups = {
	['Staff'] = {
		information = {
			title = 'Capital Staff',
			groupType = 'staff',
			grades = {
				['Suporte'] = { title = 'Suporte', level = 1 },
				['Moderador'] = { title = 'Moderador', level = 2 },
				['Administrador'] = { title = 'Administrador', level = 3 },
				['Manager'] = { title = 'Manager', level = 4 },
				['COO'] = { title = 'COO', level = 5 },
				['CEO'] = { title = 'CEO', level = 6 }
			}
		},
		'staff.permissao',
		'noclip.permissao',
		'polpar.permissao',
		'dv.permissao',
		'player.blips',
		'player.noclip',
		'player.teleport',
		'player.secret',
		'player.spec',
		'spec.permissao', -- acesso ao /spec id (tela outros jogadores)
		'player.wall',  -- acesso ao /wall (ver todos jogadores, id, vida, colete etc.)
		'mqcu.permissao', -- acesso ao /mqcu (deletar props/npcs/veiculos)
	},

	['Ticket'] = {
		information = {
			title = 'Ticket',
		},
		'ticket.permissao'
	},

	['Porte'] = {
		information = {
			title = 'Porte de Arma',
		},
		'porte.permissao'
	},

	['Radar'] = {
		information = {
			title = 'Radar',
		},
		'radar.permissao'
	},

	-- [Poderes] --

	['Sobrenatural'] = {
		information = {
			title = 'Sobrenatural',
			groupType = 'supernatural',
			grades = {
				['VampireSlayer'] = { title = 'Vampire Slayer', level = 1 },
				['ReiPaulo'] = { title = 'Rei Paulo', level = 1 },
			}
		},
		'supernatural.permissao'
	},
	['SobrenaturalEquipes'] = {
		information = {
			title = 'Sobrenatural Equipes',
			groupType = 'supernaturalequipes',
			grades = {
				['Luz'] = { title = 'Luz', level = 1 },
				['Escuridao'] = { title = 'Escuridão', level = 1 },
			}
		},
		'supernatural.permissao'
	},
	['CasteloReiPaulo'] = {
		information = {
			title = 'Castelo Rei Paulo',
			groupType = 'qgsobrenatural',
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
			}
		},
		'casteloreipaulo.permissao'
	},

	['Streamer'] = {
		information = {
			title = 'Streamer',
		},
		'streamer.permissao'
	},

	['PowerAvada'] = {
		information = {
			title = 'PowerAvada',
		},
		'poweravada.permissao'
	},
	['PowerExpelliarmus'] = {
		information = {
			title = 'PowerExpelliarmus',
		},
		'powerexpelliarmus.permissao'
	},
	['PowerTranslobo'] = {
		information = {
			title = 'PowerTranslobo',
		},
		'powertranslobo.permissao'
	},
	['PowerTranspig'] = {
		information = {
			title = 'PowerTranspig',
		},
		'powertranspig.permissao'
	},

	['PowerDarkness'] = {
		information = {
			title = 'PowerDarkness',
		},
		'powerdarkness.permissao'
	},

	['PowerAvadaImune'] = {
		information = {
			title = 'PowerAvadaImune',
		},
		'poweravadaimune.permissao'
	},

	['PowerMoon'] = {
		information = {
			title = 'PowerMoon',
		},
		'powermoon.permissao'
	},

	['PowerMoonImune'] = {
		information = {
			title = 'PowerMoonImune',
		},
		'powermoonimune.permissao'
	},

	['PowerCrucio'] = {
		information = {
			title = 'PowerCrucio',
		},
		'powercrucio.permissao'
	},

	['PowerCrucioImune'] = {
		information = {
			title = 'PowerCrucioImune',
		},
		'powercrucioimune.permissao'
	},

	['PowerThunder'] = {
		information = {
			title = 'PowerThunder',
		},
		'powerthunder.permissao'
	},

	['PowerThunderImune'] = {
		information = {
			title = 'PowerThunderImune',
		},
		'powerthunderimune.permissao'
	},

	['PowerMirage'] = {
		information = {
			title = 'PowerMirage',
		},
		'powermirage.permissao'
	},

	['PowerIncendios'] = {
		information = {
			title = 'PowerIncendios',
		},
		'powerincendios.permissao'
	},

	['PowerIncendiosImune'] = {
		information = {
			title = 'PowerIncendiosImune',
		},
		'powerincendiosimune.permissao'
	},

	['PowerHidrojato'] = {
		information = {
			title = 'PowerHidrojato',
		},
		'powerhidrojato.permissao'
	},

	['PowerIncarcerous'] = {
		information = {
			title = 'PowerIncarcerous',
		},
		'powerincarcerous.permissao'
	},

	['PowerHidrojatoImune'] = {
		information = {
			title = 'PowerHidrojatoImune',
		},
		'powerhidrojatoimune.permissao'
	},

	['PowerAcidWater'] = {
		information = {
			title = 'PowerAcidWater',
		},
		'poweracidwater.permissao'
	},

	['PowerSleep'] = {
		information = {
			title = 'PowerSleep',
		},
		'powersleep.permissao'
	},
	['PowerPetrificus'] = {
		information = {
			title = 'PowerPetrificus',
		},
		'powerpetrificus.permissao'
	},
	['PowerLostark'] = {
		information = {
			title = 'PowerLostark',
		},
		'powerlostark.permissao'
	},
	['PowerLeviosa'] = {
		information = {
			title = 'PowerLeviosa',
		},
		'powerleviosa.permissao'
	},
	['PowerLeviosaImune'] = {
		information = {
			title = 'PowerLeviosaImune',
		},
		'powerleviosaimune.permissao'
	},
	['PowerBeijo'] = {
		information = {
			title = 'PowerBeijo',
		},
		'powerbeijo.permissao'
	},
	['PowerGlacius'] = {
		information = {
			title = 'PowerGlacius',
		},
		'powerglacius.permissao'
	},
	['PowerGlaciusImune'] = {
		information = {
			title = 'PowerGlaciusImune',
		},
		'powerglaciusimune.permissao'
	},
	-- --

	['TabletCorrida'] = {
		information = {
			title = 'Tablet Corrida',
		},
		'tabletcorrida.permissao'
	},

	['Cajado'] = {
		information = {
			title = 'Cajado',
		},
		'cajado.permissao'
	},

	['VipBronze'] = {
		information = {
			title = 'VIP Bronze',
		},
		'bronze.permissao',
		'vip.permissao',
		'taxgarage.permissao',
		'taxdrive.permissao'
	},

	['VipPrata'] = {
		information = {
			title = 'VIP Prata',
		},
		'prata.permissao',
		'vip.permissao',
		'taxgarage.permissao',
		'taxdrive.permissao'
	},

	['VipOuro'] = {
		information = {
			title = 'VIP Ouro',
		},
		'ouro.permissao',
		'vip.permissao',
		'taxgarage.permissao',
		'taxdrive.permissao'
	},

	['VipCapital'] = {
		information = {
			title = 'VIP Capital',
		},
		'capital.permissao',
		'vip.permissao',
		'taxgarage.permissao',
		'taxdrive.permissao'
	},

	--[[
	
	['VipDiamante'] = {
		information = {
			title = 'VIP Diamante',
		},
		'diamante.permissao',
		'vip.permissao',
		'mochila.permissao'
	},

	['VipEsmeralda'] = {
		information = {
			title = 'VIP Esmeralda',
		},
		'esmeralda.permissao',
		'vip.permissao',
		'attachs2.permissao',
		'mochila.permissao'
	},

	['VipTopazio'] = {
		information = {
			title = 'VIP Topázio',
		},
		'topazio.permissao',
		'vip.permissao',
		'attachs2.permissao',
		'mochila.permissao'
	},

	['VipBabilonia'] = {
		information = {
			title = 'VIP Babilônia',
		},
		'babilonia.permissao',
		'vip.permissao',
		'attachs2.permissao',
		'mochila.permissao'
	},

	['VipSafira'] = {
		information = {
			title = 'VIP Safira',
		},
		'safira.permissao',
		'vip.permissao',
		'mochila.permissao'
	},

	['VipRubi'] = {
		information = {
			title = 'VIP Rubi',
		},
		'rubi.permissao',
		'vip.permissao',
		'mochila.permissao'
	},
	
	['VipAmetista'] = {
		information = {
			title = 'VIP Ametista',
		},
		'ametista.permissao',
		'vip.permissao',
		'mochila.permissao'
	},

	['VipArmas'] = {
		information = {
			title = 'Vip Armas',
		},
		'attachs2.permissao',
		'attachs.permissao'
	},
	]]

	['KeepSlot'] = {
		information = {
			title = 'Manter Slots',
		},
		'keepslot.permissao'
	},

	['Slots05'] = {
		information = {
			title = '5 Slots Adicionais',
		},
		'keepslot.permissao'
	},

	['Slots10'] = {
		information = {
			title = '10 Slots Adicionais',
		},
		'keepslot.permissao'
	},

	['Slots30'] = {
		information = {
			title = '30 Slots Adicionais',
		},
		'keepslot.permissao'
	},

	['Instagram'] = {
		information = {
			title = 'Verificado',
		},
		'instagram.permissao'
	},

	['Cam'] = {
		information = {
			title = 'Cam',
		},
		'cam.permissao'
	},

	['Spotify'] = {
		information = {
			title = 'Spotify',
		},
		'player.som'
	},

	['BennysBagual'] = {
		information = {
			title = 'BennysBagual',
		},
		'bennys.permissao',
	},

	['OAC'] = {
		information = { title = 'OAC' },
		'oac.permissao'
	},

	['Cacador'] = {
		information = { title = 'Caçador' },
		'cacador.permissao'
	},

	['Taxista'] = {
		information = { title = 'Taxista' },
		'taxista.permissao'
	},

	--==================================================================================================================
	['Bennys'] = {
		information = {
			title = 'Bennys',
			groupType = 'fac',
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'bennys.permissao',
		'ilegal.permissao'
	},

	['BennysTunner'] = {
		information = {
			title = 'Bennys Tunner',
			groupType = 'fac',
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'bennystunner.permissao',
		'ilegal.permissao'
	},

	['FavelaBarragem'] = {
		information = {
			title = 'Talibã',
			groupType = 'fac',
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'barragem.permissao',
		'ilegal.permissao'
	},

	['Palhacos'] = {
		information = {
			title = 'Palhaços',
			groupType = 'fac',
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'palhacos.permissao',
		'municao.permissao',
		'ilegal.permissao'
	},

	['CaixaDagua'] = {
		information = {
			title = 'Fav Caixa Dágua',
			groupType = 'fac',
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'agua.permissao',
		'balinha.permissao',
		'droga.permissao',
		'ilegal.permissao'
	},

	['Fazenda'] = {
		information = {
			title = 'Fazenda',
			groupType = 'fac',
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'fazenda.permissao',
		'droga.permissao',
		'ilegal.permissao'
	},

	['Chineses'] = {
		information = {
			title = 'Chineses',
			groupType = 'fac',
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'chines.permissao',
		'armabranca.permissao',
		'ilegal.permissao'
	},

	['MotoClub'] = {
		information = {
			title = 'Moto Club',
			groupType = 'fac',
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'motoclub.permissao',
		'colete.permissao',
		'ilegal.permissao'
	},

	['Reciclagem'] = {
		information = {
			title = 'Reciclagem',
			groupType = 'fac',
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'reciclagem.permissao',
		'ilegal.permissao'
	},

	['Triade'] = {
		information = {
			title = 'Triade',
			groupType = 'fac',
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'triade.permissao',
		'ilegal.permissao'
	},

	['BandoDosGauchos'] = {
		information = {
			title = 'Bando Dos Gauchos',
			groupType = 'fac',
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'bandodosgauchos.permissao',
		'ilegal.permissao'
	},


	['Juramento'] = {
		information = {
			title = 'Juramento',
			groupType = 'fac',
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'juramento.permissao',
		'ilegal.permissao'
	},

	['Ghost'] = {
		information = {
			title = 'Ghost',
			groupType = 'fac',
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'ghost.permissao',
		'comida.permissao',
		'ilegal.permissao'
	},

	['OsVeio'] = {
		information = {
			title = 'Os Véio',
			groupType = 'fac',
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'osveio.permissao',
		'ilegal.permissao'
	},
	['MDS'] = {
		information = {
			title = 'Morro da Serpente',
			groupType = 'fac',
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'mds.permissao',
		'ilegal.permissao'
	},

	['Blackout'] = {
		information = {
			title = 'Gaúchos',
			groupType = 'fac',
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'blackout.permissao',
		'contrabando.permissao',
		'ilegal.permissao'
	},

	['CDD'] = {
		information = {
			title = 'CDD',
			groupType = 'fac',
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'cdd.permissao',
		'contrabando.permissao',
		'ilegal.permissao'
	},
	['Sindicato'] = {
		information = {
			title = 'Sindicato',
			groupType = 'fac',
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'sindicato.permissao',
		'ilegal.permissao'
	},
	['Umbrella'] = {
		information = {
			title = 'Umbrella',
			groupType = 'fac',
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'umbrella.permissao',
		'ilegal.permissao'
	},
	['Phoenix'] = {
		information = {
			title = 'Phoenix',
			groupType = 'fac',
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'phoenix.permissao',
		'ilegal.permissao'
	},
	['LosPraca'] = {
		information = {
			title = 'Los Praça',
			groupType = 'fac',
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'lospraca.permissao',
		'ilegal.permissao'
	},

	['Mantem'] = {
		information = {
			title = 'Mantém',
			groupType = 'fac',
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'mantem.permissao',
		'droga.permissao',
		'ilegal.permissao'
	},

	['OsCrias'] = {
		information = {
			title = 'Os Crias',
			groupType = 'fac',
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'oscrias.permissao',
		'droga.permissao',
		'ilegal.permissao'
	},

	['Legiao'] = {
		information = {
			title = 'Legiao',
			groupType = 'fac',
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'legiao.permissao',
		'ilegal.permissao'
	},

	['Boiadeiras'] = {
		information = {
			title = 'Boiadeiras',
			groupType = 'fac',
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'boiadeiras.permissao',
		'ilegal.permissao'
	},

	['Cupim'] = {
		information = {
			title = 'Cupim de Ferro',
			groupType = 'fac',
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'cupim.permissao',
		'contrabando.permissao',
		'ilegal.permissao'
	},

	['Ciringa'] = {
		information = {
			title = 'Ciringa',
			groupType = 'fac',
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'ciringa.permissao',
		-- 'contrabando.permissao',
		'ilegal.permissao'
	},

	['Penha'] = {
		information = {
			title = 'Penha',
			groupType = 'fac',
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'penha.permissao',
		'ilegal.permissao'
	},

	['Dinastia'] = {
		information = {
			title = 'Dinastia',
			groupType = 'fac',
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'droga.permissao',
		'dinastia.permissao',
		'ilegal.permissao'
	},

	['ComandoNorte'] = {
		information = {
			title = 'Comando Norte',
			groupType = 'fac',
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'comandonorte.permissao',
		'ilegal.permissao'
	},

	['Olimpo'] = {
		information = {
			title = 'Olimpo',
			groupType = 'fac',
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'olimpo.permissao',
		'colete.permissao',
		'ilegal.permissao'
	},

	['Ordem'] = {
		information = {
			title = 'Ordem',
			groupType = 'fac',
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'ordem.permissao',
		'ilegal.permissao'
	},


	['Medelin'] = {
		information = {
			title = 'Medelin',
			groupType = 'fac',
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'medelin.permissao',
		'colete.permissao',
		'ilegal.permissao'
	},

	['Hydra'] = {
		information = {
			title = 'Hydra',
			groupType = 'fac',
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'hydra.permissao',
		'colete.permissao',
		'ilegal.permissao'
	},

	['IMA'] = {
		information = {
			title = 'I.M.A',
			groupType = 'fac',
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'ima.permissao',
		'ilegal.permissao'
	},

	['Observatório'] = {
		information = {
			title = 'Observatório',
			groupType = 'fac',
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'observatorio.permissao',
		'ilegal.permissao'
	},

	['Turano'] = {
		information = {
			title = 'Tony Country',
			groupType = 'fac',
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'turano.permissao',
		'ilegal.permissao'
	},

	--==================================================================================================================

	['Jornal'] = {
		information = {
			title = 'Jornal',
			groupType = 'job',
			grades = {
				["Equipe"] = { title = "Equipe Reporter", level = 1 },
				["Jornalista"] = { title = "Jornalista", level = 2 },
				["ChefeReportagem"] = { title = "Chefe Reportagem", level = 3 },
				["SecRedacao"] = { title = "Sec. Redação", level = 4 },
				["Camera"] = { title = "Câmera", level = 5 },
				["Diretor"] = { title = "Diretor(a)", level = 6 },
			},
			grades_default = 'Novato',
		},
		'mptv.permissao',
		'telasco.permissao',
		'mptv.permissao',
		'dv.permissao',
		'jornal.permissao'
	},

	['Mptv'] = {
		information = {
			title = 'Mptv',
			groupType = 'job',
			grades = {
				["Equipe"] = { title = "Equipe Reporter", level = 1 },
				["Jornalista"] = { title = "Jornalista", level = 2 },
				["ChefeReportagem"] = { title = "Chefe Reportagem", level = 3 },
				["SecRedacao"] = { title = "Sec. Redação", level = 4 },
				["Camera"] = { title = "Câmera", level = 5 },
				["Diretor"] = { title = "Diretor(a)", level = 6 },
			},
			grades_default = 'Novato',
		},
		'mptv.permissao',
		'noclip.permissao',
		'dv.permissao',
		'mptv.permissao',
		'jornal.permissao'
	},

	['SafadassoJornal'] = {
		information = {
			title = 'Safadasso Jornal',
			groupType = 'job',
			grades = {
				["Equipe"] = { title = "Equipe Reporter", level = 1 },
				["Jornalista"] = { title = "Jornalista", level = 2 },
				["ChefeReportagem"] = { title = "Chefe Reportagem", level = 3 },
				["SecRedacao"] = { title = "Sec. Redação", level = 4 },
				["Camera"] = { title = "Câmera", level = 5 },
				["Diretor"] = { title = "Diretor(a)", level = 6 },
			},
			grades_default = 'Novato',
		},
		'safadasso.permissao',
		'jornal.permissao',
		'noclip.permissao',
		'dv.permissao'
	},

	['Gravacao'] = {
		information = {
			title = 'Gravação',
		},
		'dv.permissao',
		'gravacao.permissao',
	},

	['Laricas'] = {
		information = {
			title = 'Laricas',
			groupType = 'job',
			grades = {
				['Novato'] = { title = 'Novato', level = 1 },
				['Entregador'] = { title = 'Entregador', level = 2 },
				['Atendente'] = { title = 'Atendente', level = 3 },
				['Cozinheiro'] = { title = 'Cozinheiro', level = 4 },
				['Gerente'] = { title = 'Gerente', level = 5 },
				['Socio'] = { title = 'Sócio', level = 6 },
				['Dono'] = { title = 'Dono', level = 7 },
			},
			grades_default = 'Novato',
		},
		'laricas.permissao'
	},
	['Grotorante'] = {
		information = {
			title = 'RedClub',
			groupType = 'job',
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'grotorante.permissao',
	},

	['MorroMina'] = {
		information = {
			title = 'Morro-Mina',
			groupType = 'fac',
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'morromina.permissao',
		'ilegal.permissao'
	},

	['Galaxy'] = {
		information = {
			title = 'Galaxy',
			groupType = 'fac',
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'galaxy.permissao',
		'ilegal.permissao',
		'balinha.permissao'
	},

	['Underdogs'] = {
		information = {
			title = 'Underdogs',
			groupType = 'fac',
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'underdogs.permissao',
		'ilegal.permissao'
	},

	['Irmandade'] = {
		information = {
			title = 'Irmandade',
			groupType = 'fac',
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'irmandade.permissao',
		'colete.permissao',
		'ilegal.permissao'
	},

	['CartelNPN'] = {
		information = {
			title = 'NPN',
			groupType = 'fac',
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'cartelnpn.permissao',
		'ilegal.permissao'
	},

	['Bahamas'] = {
		information = {
			title = 'Bahamas',
			groupType = 'fac',
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'bahamas.permissao',
		'ilegal.permissao'
	},

	['K10'] = {
		information = {
			title = 'K-10',
			groupType = 'fac',
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'k10.permissao',
		'ilegal.permissao'
	},

	['LaFronteira'] = {
		information = {
			title = 'La Fronteira',
			groupType = 'fac',
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'lafronteira.permissao',
		'ilegal.permissao'
	},

	['Aztecas'] = {
		information = {
			title = 'Aztecas',
			groupType = 'fac',
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'aztecas.permissao',
		'ilegal.permissao'
	},

	['Comitiva'] = {
		information = {
			title = 'Comitiva',
			groupType = 'fac',
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'comitiva.permissao',
		'ilegal.permissao'
	},
	['TheFusion'] = {
		information = {
			title = 'The Fusion',
			groupType = 'fac',
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'thefusion.permissao',
		'ilegal.permissao'
	},
	['Caos'] = {
		information = {
			title = 'Caos',
			groupType = 'fac',
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'caos.permissao',
		'ilegal.permissao'
	},
	['CosaNostra'] = {
		information = {
			title = 'Cosa Nostra',
			groupType = 'fac',
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'cosanostra.permissao',
		'ilegal.permissao'
	},
	['Ratoeira'] = {
		information = {
			title = 'Ratoeira',
			groupType = 'fac',
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'ratoeira.permissao',
		'ilegal.permissao'
	},
	['Dende'] = {
		information = {
			title = 'Dende',
			groupType = 'fac',
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'dende.permissao',
		'ilegal.permissao'
	},
	['Wanana'] = {
		information = {
			title = 'Wanana',
			groupType = 'fac',
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'wanana.permissao',
		'ilegal.permissao'
	},
	['Helipa'] = {
		information = {
			title = 'Helipa',
			groupType = 'fac',
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'helipa.permissao',
		'ilegal.permissao'
	},
	['NovaEra'] = {
		information = {
			title = 'NovaEra',
			groupType = 'fac',
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'novaera.permissao',
		'ilegal.permissao'
	},

	['Venezza'] = {
		information = {
			title = 'Venezza',
			groupType = 'fac',
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'venezza.permissao',
		'ilegal.permissao'
	},

	['Mare'] = {
		information = {
			title = 'Mare',
			groupType = 'fac',
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'mare.permissao',
		'ilegal.permissao'
	},

	['DubaiGang'] = {
		information = {
			title = 'Dubai Gang',
			groupType = 'fac',
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'dubaigang.permissao',
		'ilegal.permissao'
	},

	['KafeComMel'] = {
		information = {
			title = 'KafeComMel',
			groupType = 'job',
			grades = {
				['Novato'] = { title = 'Novato', level = 1 },
				['Entregador'] = { title = 'Entregador', level = 2 },
				['Atendente'] = { title = 'Atendente', level = 3 },
				['Cozinheiro'] = { title = 'Cozinheiro', level = 4 },
				['Gerente'] = { title = 'Gerente', level = 5 },
				['Socio'] = { title = 'Sócio', level = 6 },
				['Dono'] = { title = 'Dono', level = 7 },
			},
			grades_default = 'Novato',
		},
		'melgual.permissao'
	},

	['Tropical'] = {
		information = {
			title = 'Tropical',
			groupType = 'fac',
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'tropical.permissao',
		'ilegal.permissao'
	},

	['Bras'] = {
		information = {
			title = 'Bras',
			groupType = 'fac',
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'bras.permissao',
		'ilegal.permissao'
	},

	['MonteCristo'] = {
		information = {
			title = 'MonteCristo',
			groupType = 'fac',
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'montecristo.permissao',
		'ilegal.permissao'
	},

	['Fundao'] = {
		information = {
			title = 'Fundao',
			groupType = 'fac',
			grades = {
				['Membro'] = { title = 'Membro', level = 1 },
				['Gerente'] = { title = 'Gerente', level = 2 },
				['ViceLider'] = { title = 'Vice-Líder', level = 3 },
				['Lider'] = { title = 'Líder', level = 4 },
			},
			grades_default = 'Membro',
		},
		'fundao.permissao',
		'ilegal.permissao'
	},

	['Borracharia'] = {
		information = {
			title = 'Borracharia do Tião',
			groupType = 'job',
			grades = {
				['AuxMecanico'] = { title = 'Auxiliar de mecânico', level = 1 },
				['Mecanico'] = { title = 'Mecânico', level = 2 },
				['Funileiro'] = { title = 'Funileiro', level = 3 },
				['Gerente'] = { title = 'Gerente', level = 4 },
				['Supervisor'] = { title = 'Supervisor', level = 5 },
				['GerenteGeral'] = { title = 'Gerente Geral', level = 6 },
				['ViceLider'] = { title = 'Vice-Líder', level = 7 },
				['Lider'] = { title = 'Líder', level = 8 },
			},
			grades_default = 'AuxMecanico',
		},
		'mecanica.permissao',
		'mecanico.permissao',
		'player.blips'
	},

	['MecanicoNorte'] = {
		information = {
			title = 'Mecânica Norte',
			groupType = 'job',
			grades = {
				['AuxMecanico'] = { title = 'Auxiliar de mecânico', level = 1 },
				['Mecanico'] = { title = 'Mecânico', level = 2 },
				['Funileiro'] = { title = 'Funileiro', level = 3 },
				['Gerente'] = { title = 'Gerente', level = 4 },
				['Supervisor'] = { title = 'Supervisor', level = 5 },
				['GerenteGeral'] = { title = 'Gerente Geral', level = 6 },
				['ViceLider'] = { title = 'Vice-Líder', level = 7 },
				['Lider'] = { title = 'Líder', level = 8 },
			},
			grades_default = 'AuxMecanico',
		},
		'mecanica.permissao',
		'mecanico.permissao',
		'player.blips'
	},

	['Bracho'] = {
		information = {
			title = 'Mecânica Bracho',
			groupType = 'job',
			grades = {
				['AuxMecanico'] = { title = 'Auxiliar de mecânico', level = 1 },
				['Mecanico'] = { title = 'Mecânico', level = 2 },
				['Funileiro'] = { title = 'Funileiro', level = 3 },
				['Gerente'] = { title = 'Gerente', level = 4 },
				['Supervisor'] = { title = 'Supervisor', level = 5 },
				['GerenteGeral'] = { title = 'Gerente Geral', level = 6 },
				['ViceLider'] = { title = 'Vice-Líder', level = 7 },
				['Lider'] = { title = 'Líder', level = 8 },
			},
			grades_default = 'AuxMecanico',
		},
		'bracho.permissao',
		'mecanico.permissao'
	},

	['CUS'] = {
		information = {
			title = 'C.U.S',
			groupType = 'job',
			grades = {
				['Estagiario'] = { title = 'Estagiário', level = 1 },
				['Residente'] = { title = 'Médico Residente', level = 2 },
				['Medico'] = { title = 'Médico', level = 3 },
				['ViceDiretor'] = { title = 'Vice-Diretor', level = 4 },
				['Diretor'] = { title = 'Diretor', level = 5 },
				['DiretorChefe'] = { title = 'Diretor Chefe', level = 6 },
			},
			grades_default = 'Estagiario',
		},
		'hospital.permissao',
		'player.blips',
		'polpar.permissao'
	},

	['Juridico'] = {
		information = {
			title = 'Jurídico',
			groupType = 'job',
			grades = {
				['Estagiario'] = { title = 'Estagiário', level = 1 },
				['AdvogadoJunior'] = { title = 'Advogado Jr', level = 2 },
				['AdvogadoPleno'] = { title = 'Advogado Pleno', level = 3 },
				['AdvogadoSenior'] = { title = 'Advogado Senior', level = 4 },
				['SecretarioAdjunto'] = { title = 'Secretário Adjunto', level = 5 },
				['SecretarioGeral'] = { title = 'Secretário Geral', level = 6 },
				['VicePresidente'] = { title = 'Vice-Presidente', level = 7 },
				['Presidente'] = { title = 'Presidente', level = 8 },
			},
			grades_default = 'Estagiario',
		},
		'juridico.permissao'
	},

	['PMC'] = {
		information = {
			title = 'PM Capital',
			groupType = 'job',
			grades = {
				['Soldado2'] = { title = 'Soldado 2° Classe', level = 1 },
				['Soldado1'] = { title = 'Soldado 1° Classe', level = 2 },
				['Cabo'] = { title = 'Cabo', level = 3 },

				['Sargento3'] = { title = '3° Sargento', level = 4 },
				['Sargento2'] = { title = '2° Sargento', level = 5 },
				['Sargento1'] = { title = '1° Sargento', level = 6 },
				['SubTenente'] = { title = 'Subtenente', level = 7 },

				['Aspirante'] = { title = 'Aspirante a Oficial', level = 8 },
				['Tenente2'] = { title = '2° Tenente', level = 9 },
				['Tenente1'] = { title = '1° Tenente', level = 10 },

				['Capitao'] = { title = 'Capitão', level = 11 },
				['Major'] = { title = 'Major', level = 12 },
				['TenenteCoronel'] = { title = 'Tenente-Coronel', level = 13 },
				['Coronel'] = { title = 'Coronel', level = 14 },
			},
			grades_default = 'Soldado2',
		},
		'pmc.permissao',
		'policia.permissao',
		'player.blips',
		'polpar.permissao'
	},

	['PCP'] = {
		information = {
			title = 'Policia Cidade Perfeita',
			groupType = 'job',
			grades = {
				['Soldado2'] = { title = 'Soldado 2° Classe', level = 1 },
				['Soldado1'] = { title = 'Soldado 1° Classe', level = 2 },
				['Cabo'] = { title = 'Cabo', level = 3 },

				['Sargento3'] = { title = '3° Sargento', level = 4 },
				['Sargento2'] = { title = '2° Sargento', level = 5 },
				['Sargento1'] = { title = '1° Sargento', level = 6 },
				['SubTenente'] = { title = 'Subtenente', level = 7 },

				['Aspirante'] = { title = 'Aspirante a Oficial', level = 8 },
				['Tenente2'] = { title = '2° Tenente', level = 9 },
				['Tenente1'] = { title = '1° Tenente', level = 10 },

				['Capitao'] = { title = 'Capitão', level = 11 },
				['Major'] = { title = 'Major', level = 12 },
				['TenenteCoronel'] = { title = 'Tenente-Coronel', level = 13 },
				['Coronel'] = { title = 'Coronel', level = 14 },
			},
			grades_default = 'Soldado2',
		},
		'pcp.permissao',
		'policia.permissao',
		'player.blips',
		'polpar.permissao'
	},

	['Corregedoria'] = {
		information = {
			title = 'Corregedoria',
			groupType = 'job',
			grades = {
				['CorregedorAuxiliar'] = { title = 'Corregedor Auxiliar', level = 1 },
				['Corregedor'] = { title = 'Corregedor', level = 2 },
				['ViceCorregedor'] = { title = 'Vice Corregedor', level = 3 },
				['CorregedorGeral'] = { title = 'Corregedor Geral', level = 4 },
				['SecretarioAdjunto'] = { title = 'Secretario Adjunto', level = 5 },
				['Secretario'] = { title = 'Secretario', level = 6 },
			},
			grades_default = 'CorregedorAuxiliar',
		},
		'policia.permissao',
	},

	['FT'] = {
		information = {
			title = 'Força Tática',
			groupType = 'job',
			grades = {
				['Soldado2'] = { title = 'Soldado 2° Classe', level = 1 },
				['Soldado1'] = { title = 'Soldado 1° Classe', level = 2 },
				['Cabo'] = { title = 'Cabo', level = 3 },

				['Sargento3'] = { title = '3° Sargento', level = 4 },
				['Sargento2'] = { title = '2° Sargento', level = 5 },
				['Sargento1'] = { title = '1° Sargento', level = 6 },
				['SubTenente'] = { title = 'Subtenente', level = 7 },

				['Aspirante'] = { title = 'Aspirante a Oficial', level = 8 },
				['Tenente2'] = { title = '2° Tenente', level = 9 },
				['Tenente1'] = { title = '1° Tenente', level = 10 },

				['Capitao'] = { title = 'Capitão', level = 11 },
				['Major'] = { title = 'Major', level = 12 },
				['TenenteCoronel'] = { title = 'Tenente-Coronel', level = 13 },
				['Coronel'] = { title = 'Coronel', level = 14 },
			},
			grades_default = 'Soldado2',
		},
		'ft.permissao',
		'policia.permissao',
		'player.blips',
		'polpar.permissao'
	},

	['BAEP'] = {
		information = {
			title = 'BAEP',
			groupType = 'job',
			grades = {
				['Soldado2'] = { title = 'Soldado 2° Classe', level = 1 },
				['Soldado1'] = { title = 'Soldado 1° Classe', level = 2 },
				['Cabo'] = { title = 'Cabo', level = 3 },

				['Sargento3'] = { title = '3° Sargento', level = 4 },
				['Sargento2'] = { title = '2° Sargento', level = 5 },
				['Sargento1'] = { title = '1° Sargento', level = 6 },
				['SubTenente'] = { title = 'Subtenente', level = 7 },

				['Aspirante'] = { title = 'Aspirante a Oficial', level = 8 },
				['Tenente2'] = { title = '2° Tenente', level = 9 },
				['Tenente1'] = { title = '1° Tenente', level = 10 },

				['Capitao'] = { title = 'Capitão', level = 11 },
				['Major'] = { title = 'Major', level = 12 },
				['TenenteCoronel'] = { title = 'Tenente-Coronel', level = 13 },
				['Coronel'] = { title = 'Coronel', level = 14 },
			},
			grades_default = 'Soldado2',
		},
		'baep.permissao',
		'policia.permissao',
		'player.blips',
		'polpar.permissao'
	},

	['GCC'] = {
		information = {
			title = 'GCC',
			groupType = 'job',
			grades = {
				['Soldado2'] = { title = 'Soldado 2° Classe', level = 1 },
				['Soldado1'] = { title = 'Soldado 1° Classe', level = 2 },
				['Cabo'] = { title = 'Cabo', level = 3 },

				['Sargento3'] = { title = '3° Sargento', level = 4 },
				['Sargento2'] = { title = '2° Sargento', level = 5 },
				['Sargento1'] = { title = '1° Sargento', level = 6 },
				['SubTenente'] = { title = 'Subtenente', level = 7 },

				['Aspirante'] = { title = 'Aspirante a Oficial', level = 8 },
				['Tenente2'] = { title = '2° Tenente', level = 9 },
				['Tenente1'] = { title = '1° Tenente', level = 10 },

				['Capitao'] = { title = 'Capitão', level = 11 },
				['Major'] = { title = 'Major', level = 12 },
				['TenenteCoronel'] = { title = 'Tenente-Coronel', level = 13 },
				['Coronel'] = { title = 'Coronel', level = 14 },
			},
			grades_default = 'Soldado2',
		},
		'gcc.permissao',
		'policia.permissao',
		'player.blips',
		'polpar.permissao'
	},

	['Rota'] = {
		information = {
			title = 'Rota',
			groupType = 'job',
			grades = {
				['Soldado2'] = { title = 'Soldado 2° Classe', level = 1 },
				['Soldado1'] = { title = 'Soldado 1° Classe', level = 2 },
				['Cabo'] = { title = 'Cabo', level = 3 },

				['Sargento3'] = { title = '3° Sargento', level = 4 },
				['Sargento2'] = { title = '2° Sargento', level = 5 },
				['Sargento1'] = { title = '1° Sargento', level = 6 },
				['SubTenente'] = { title = 'Subtenente', level = 7 },

				['Aspirante'] = { title = 'Aspirante a Oficial', level = 8 },
				['Tenente2'] = { title = '2° Tenente', level = 9 },
				['Tenente1'] = { title = '1° Tenente', level = 10 },

				['Capitao'] = { title = 'Capitão', level = 11 },
				['Major'] = { title = 'Major', level = 12 },
				['TenenteCoronel'] = { title = 'Tenente-Coronel', level = 13 },
				['Coronel'] = { title = 'Coronel', level = 14 },
			},
			grades_default = 'Soldado2',
		},
		'rota.permissao',
		'policia.permissao',
		'player.blips',
		'polpar.permissao'
	},

	['Exercito'] = {
		information = {
			title = 'Exército',
			groupType = 'job',
			grades = {
				['Soldado2'] = { title = 'Soldado 2° Classe', level = 1 },
				['Soldado1'] = { title = 'Soldado 1° Classe', level = 2 },
				['Cabo'] = { title = 'Cabo', level = 3 },

				['Sargento3'] = { title = '3° Sargento', level = 4 },
				['Sargento2'] = { title = '2° Sargento', level = 5 },
				['Sargento1'] = { title = '1° Sargento', level = 6 },
				['SubTenente'] = { title = 'Subtenente', level = 7 },

				['Aspirante'] = { title = 'Aspirante a Oficial', level = 8 },
				['Tenente2'] = { title = '2° Tenente', level = 9 },
				['Tenente1'] = { title = '1° Tenente', level = 10 },

				['Capitao'] = { title = 'Capitão', level = 11 },
				['Major'] = { title = 'Major', level = 12 },
				['TenenteCoronel'] = { title = 'Tenente-Coronel', level = 13 },
				['Coronel'] = { title = 'Coronel', level = 14 },
				['General'] = { title = 'General', level = 15 },
			},
			grades_default = 'Soldado2',
		},
		'exercito.permissao',
		'policia.permissao',
		'player.blips',
		'polpar.permissao'
	},

	['PC'] = {
		information = {
			title = 'Policia Civil',
			groupType = 'job',
			grades = {
				['Acadepol'] = { title = 'Acadepol', level = 1 },

				['Agente3'] = { title = 'Agente 3° Classe', level = 2 },
				['Agente2'] = { title = 'Agente 2° Classe', level = 3 },
				['Agente1'] = { title = 'Agente 1° Classe', level = 4 },
				['AgenteEspecial'] = { title = 'Agente Classe Especial', level = 5 },

				['Deic'] = { title = 'Deic', level = 6 },
				['Garra'] = { title = 'Garra', level = 7 },

				['Escrivao'] = { title = 'Escrivão', level = 8 },

				['DelegadoPlantonista'] = { title = 'Delegado Plantonista', level = 9 },
				['DelegadoDHPP'] = { title = 'Delegado DHPP', level = 10 },
				['DelegadoDeic'] = { title = 'Delegado Deic', level = 11 },
				['DelegadoGarra'] = { title = 'Delegado Garra', level = 12 },
				['DelegadoGeral'] = { title = 'Delegado Geral', level = 13 },
			},
			grades_default = 'Acadepol',
		},
		'civil.permissao',
		'deic.permissao',
		'policia.permissao',
		'player.blips',
		'polpar.permissao'
	},

	['PRF'] = {
		information = {
			title = 'Policia Rodoviária Federal',
			groupType = 'job',
			grades = {
				['Agente3'] = { title = 'Agente 3° Classe', level = 1 },
				['Agente2'] = { title = 'Agente 2° Classe', level = 2 },
				['Agente1'] = { title = 'Agente 1° Classe', level = 3 },
				['AgenteEspecial'] = { title = 'Agente Classe Especial', level = 4 },

				['ChefeDivisao'] = { title = 'Chefe de Divisão', level = 5 },
				['ChefeServico'] = { title = 'Chefe de Serviço', level = 6 },
				['ChefeSessao'] = { title = 'Chefe de Sessão', level = 7 },
				['ChefeSetor'] = { title = 'Chefe de Setor', level = 8 },
				['ChefeNucleo'] = { title = 'Chefe de Núcleo', level = 9 },

				['Coordenador'] = { title = 'Coordenador', level = 10 },
				['CoordenadorGeral'] = { title = 'Coordenador Geral', level = 11 },

				['Diretor'] = { title = 'Diretor', level = 12 },
				['DiretorGeral'] = { title = 'Diretor Geral', level = 13 },
			},
			grades_default = 'Agente3',
		},
		'prf.permissao',
		'policia.permissao',
		'player.blips',
		'polpar.permissao'
	},

	--==================================================================================================================

	['LB'] = {
		information = {
			title = 'Libras',
		},
		'libras.permissao',
	},
}

Tunnel = module('vrp', 'lib/Tunnel')
Proxy = module('vrp', 'lib/Proxy')
vRP = Proxy.getInterface('vRP')
