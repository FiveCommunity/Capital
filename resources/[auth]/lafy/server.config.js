module.exports = {

  // Se você quiser configurar uma permissão para cada modo, utilize o formato abaixo:
  // permission: { radio: "permissao.jbl", bluetooth: "permissao.bluetooth" },
  // Para deixar sem permissão coloque "nil.permissao"

  permission: ["Spotify","Music"],

  command: "som",
  prop: "rojo_jblboombox",

  // Distância máxima (em metros) entre o jogador e o veículo/caixa de som
  // Se essa distância for excedida, a música irá parar de tocar
  maxDistance: Infinity,

  dj: [
    { // Bahamas
      table: [-1378.6, -628.89, 30.63],
      speaker: [-1378.6, -628.89, 30.63],
      range: 50,
      volume: 100,
      permission: ["Admin"],
    },
    { // Favela: Igreja (-1625.43,-253.45,52.76)
      table: [-1775.45, -132.34, 88.66],
      speaker: [-1775.45, -132.34, 88.66],
      range: 50,
      volume: 100,
      permission: ["Admin"],
    },
    { // Favela: Barragem (1210.75,-289.7,68.31)
      table: [1266.11, -137.55, 84.57],
      speaker: [1266.11, -137.55, 84.57],
      range: 50,
      volume: 100,
      permission: ["Admin"],
    },
    { // Favela: Helipa (1287.1,-709.49,64.03)
      table: [1353.13, -794.79, 87.3],
      speaker: [1353.13, -794.79, 87.3],
      range: 50,
      volume: 100,
      permission: ["Admin"],
    },
    { // Favela: Porto (1351.68,-2576.21,47.95)
      table: [1342.59, -2496.46, 56.7],
      speaker: [1342.59, -2496.46, 56.7],
      range: 50,
      volume: 100,
      permission: ["Admin"],
    },
    { // Favela: Esgoto (1180.92,-1047.46,42.68)
      table: [1177.73, -1007.43, 49.39],
      speaker: [1177.73, -1007.43, 49.39],
      range: 50,
      volume: 100,
      permission: ["Admin"],
    },
  ],

  range: {
    // Todos os números podem ser substituidos por [range, volume]
    // ex: [48, 100] -> 48 metros com 100% de volume
    // Por padrão, o script entende que um número sozinho é o alcance em metros, e o volume será 100%
    vehicle: {
      "*": 48, // Padrão (48 metros & 100% de volume)
    },

    // radio é a JBL, quando a música tocar fora de um veículo
    radio: [20, 50], // (20 metros & 50% de volume)
  },
  blacklist: ["spawn_do_veiculo"],
  allowBluetoothOnBikes: false,
}
