const Map<String, int> light = {
  'Cost': 4,
  'Accuracy': 98,
  'Power': 40,
  'Multiplier': 1,
  'Type': 0
};

const Map<String, int> medium = {
  'Cost': 8,
  'Accuracy': 98,
  'Power': 100,
  'Multiplier': 1,
  'Type': 0
};

const Map<String, int> heavy = {
  'Cost': 12,
  'Accuracy': 98,
  'Power': 160,
  'Multiplier': 1,
  'Type': 0
};

const Map<String, int> instantkillHigh = {
  'Cost': 15,
  'Accuracy': 60,
  'Power': 9999,
  'Multiplier': 1,
  'Type': 1
};

const Map<String, int> buff = {
  'Cost': 12,
  'Accuracy': 100,
  'Power': 0,
  'Multiplier': 1
};

const Map<String, Map<String, int>> effect = {
  'Agi': light,
  'Bufu': light,
  'Zio': light,
  'Garu': light,
  'Bufula': medium,
  'Zionga': medium,
  'Agidyne': heavy,
  'Garudyne': heavy,
  'Hamaon': instantkillHigh,
  'Mudoon': instantkillHigh,
  'Bash': {
    'Cost': 6,
    'Accuracy': 100,
    'Power': 60,
    'Multiplier': 1,
    'Type': 1
  },
  'Cleave': {
    'Cost': 5,
    'Accuracy': 100,
    'Power': 65,
    'Multiplier': 1,
    'Type': 1
  },
  'Skewer': {
    'Cost': 5,
    'Accuracy': 85,
    'Power': 70,
    'Multiplier': 1,
    'Type': 1
  },
  'Kill Rush': {
    'Cost': 10,
    'Accuracy': 90,
    'Power': 100,
    'Multiplier': 3,
    'Type': 1
  },
  'Tempest Slash': {
    'Cost': 15,
    'Accuracy': 85,
    'Power': 180,
    'Multiplier': 2,
    'Type': 1
  },
  'Dia': {
    'Cost': 3,
    'Accuracy': 100,
    'Power': 40,
    'Type': 2
  },
  'Tarukaja': {
    ...buff,
    'Type': 3
  },
  'Rakukaja': {
    ...buff,
    'Type': 4
  },
  'Sukukaja': {
    ...buff,
    'Type': 5
  },
  'Tarunda': {
    ...buff,
    'Type': 6
  },
  'Rakunda': {
    ...buff,
    'Type': 7
  },
  'Sukunda': {
    ...buff,
    'Type': 8
  },
};

// 0: Magical
// 1: Physical
// 2: Healing
// 3: Attack buff
// 4: Defence buff
// 5: Hit/evasion rate buff
// 6: Attack debuff
// 7: Defence debuff
// 8: Hit/evasion rate debuff