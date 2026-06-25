const Map<String, int> light = {
  'Power': 40,
  'Accuracy': 98,
  'Cost': 4,
  'Type': 0
};

const Map<String, int> medium = {
  'Power': 100,
  'Accuracy': 98,
  'Cost': 8
};

const Map<String, int> heavy = {
  'Power': 160,
  'Accuracy': 98,
  'Cost': 12
};

const Map<String, int> severe = {
  'Power': 200,
  'Accuracy': 98,
  'Cost': 48
};

const Map<String, Map<String, int>> effect = {
  'Agi': light,
  'Bufu': light,
  'Zio': light,
  'Garu': light,
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
  }
};

// 0: Magical
// 1: Physical
// 2: Healing