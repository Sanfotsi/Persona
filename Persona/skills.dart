enum Type{
  magical, 
  physical, 
  healing, 
  attackBuff, 
  defenceBuff, 
  rateBuff,
  attackDebuff,
  defenceDebuff,
  rateDebuff
}

late List<int> offensive = [
  Type.magical.index, 
  Type.physical.index, 
  Type.attackDebuff.index,
  Type.defenceDebuff.index,
  Type.rateDebuff.index
];

late List<int> defensive = [
  Type.healing.index,
  Type.attackBuff.index,
  Type.defenceBuff.index,
  Type.rateBuff.index
];

late Map<String, int> light = {
  'Cost': 4,
  'Accuracy': 98,
  'Power': 40,
  'Multiplier': 1,
  'Type': Type.magical.index
};

late Map<String, int> medium = {
  'Cost': 8,
  'Accuracy': 98,
  'Power': 100,
  'Multiplier': 1,
  'Type': Type.magical.index
};

late Map<String, int> heavy = {
  'Cost': 12,
  'Accuracy': 98,
  'Power': 160,
  'Multiplier': 1,
  'Type': Type.magical.index
};

late Map<String, int> instantkillHigh = {
  'Cost': 15,
  'Accuracy': 60,
  'Power': 9999,
  'Multiplier': 1,
  'Type': Type.physical.index
};

late Map<String, int> buff = {
  'Cost': 12,
  'Accuracy': 100,
  'Power': 0,
  'Multiplier': 1
};

late Map<String, Map<String, int>> effect = {
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
    'Type': Type.physical.index
  },
  'Cleave': {
    'Cost': 5,
    'Accuracy': 100,
    'Power': 65,
    'Multiplier': 1,
    'Type': Type.physical.index
  },
  'Skewer': {
    'Cost': 5,
    'Accuracy': 85,
    'Power': 70,
    'Multiplier': 1,
    'Type': Type.physical.index
  },
  'Kill Rush': {
    'Cost': 10,
    'Accuracy': 90,
    'Power': 100,
    'Multiplier': 3,
    'Type': Type.physical.index
  },
  'Tempest Slash': {
    'Cost': 15,
    'Accuracy': 85,
    'Power': 180,
    'Multiplier': 2,
    'Type': Type.physical.index
  },
  'Dia': {
    'Cost': 3,
    'Accuracy': 100,
    'Power': 40,
    'Multiplier': 1,
    'Type': Type.healing.index
  },
  'Tarukaja': {
    ...buff,
    'Type': Type.attackBuff.index
  },
  'Rakukaja': {
    ...buff,
    'Type': Type.defenceBuff.index
  },
  'Sukukaja': {
    ...buff,
    'Type': Type.rateBuff.index
  },
  'Tarunda': {
    ...buff,
    'Type': Type.attackDebuff.index
  },
  'Rakunda': {
    ...buff,
    'Type': Type.defenceDebuff.index
  },
  'Sukunda': {
    ...buff,
    'Type': Type.rateDebuff.index
  },
};