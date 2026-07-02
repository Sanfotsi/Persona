import 'dart:io';
import 'battle.dart';

Map<String, Persona> available = {
  'Yu': Persona('Izanagi', 100, 100, ['Zio', 'Cleave', 'Rakukaja']),
  'Yosuke': Persona('Jiraiya', 100, 100, ['Garu', 'Bash', 'Dia']),
  'Chie': Persona('Tomoe', 100, 100, ['Skewer', 'Tarukaja']),
  'Yukiko': Persona('Konohana Sakuya', 100, 100, ['Dia', 'Agi']), // Maragi, Me Patra 
  'Kanji': Persona('Take-Mikazuchi', 100, 100, ['Zionga', 'Rakukaja']) //Mazio, Kill Rush, Regenerate 1
};

Map<String, Persona> select(){
  Map<String, Persona> party = {
    'Yu': Persona('Izanagi', 100, 100, ['Zio', 'Cleave', 'Rakukaja'])
  };

  while (party.length < 4){
    stdout.write('Select: ');
    String input = stdin.readLineSync()!;

    if (available.keys.contains(input)){
      party[input] = available[input]!;
    }

    print(party);
  }

  return party;
}