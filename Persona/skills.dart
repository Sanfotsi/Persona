const Map<String, int> light = {
  'Power': 40,
  'Accuracy': 98,
  'Cost': 4,
  'Type': 0
};

const Map<String, int> medium = {
  'Power': 100,
  'Accuracy': 98,
  'Cost': 8,
  'Type': 0
};

const Map<String, int> heavy = {
  'Power': 160,
  'Accuracy': 98,
  'Cost': 12,
  'Type': 0
};

const Map<String, int> buff = {
  'Power': 0,
  'Accuracy': 100,
  'Cost': 12,
};

const Map<String, Map<String, int>> effect = {
  'Agi': light,
  'Bufu': light,
  'Zio': light,
  'Garu': light,
  'Zionga': medium,
  'Bash': {
    'Power': 60,
    'Accuracy': 100,
    'Cost': 6,
    'Type': 1
  },
  'Cleave': {
    'Power': 65,
    'Accuracy': 100,
    'Cost': 5,
    'Type': 1
  },
  'Skewer': {
    'Power': 70,
    'Accuracy': 85,
    'Cost': 5,
    'Type': 1
  },
  'Dia': {
    'Power': 40,
    'Accuracy': 100,
    'Cost': 3,
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