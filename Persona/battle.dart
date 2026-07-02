import 'dart:io';
import 'dart:math';
import 'persona.dart';
import 'skills.dart';
import 'dungeon.dart';

void main(){
  Map<String, Persona> party = {
    'Yu': characters['Yu']!
  };

  while (party.length < 4){
    print('Party: ${party.keys}');

    stdout.write('Select ${characters.keys}: ');
    String input = stdin.readLineSync()!;

    if (characters.keys.contains(input)){
      party[input] = characters[input]!;
    }
  }

  Dungeon Castle = yukikoCastle;

  loop:
  while (true){
    List<List<String>> map = Castle.getMap();
    int x = Castle.getAbscissa();
    int y = Castle.getOrdinate();

    for (var i in map){
      print(i.join(' '));
    }

    stdout.write('Move (w/a/s/d): ');
    String input = stdin.readLineSync()!;

    Castle.setCoordinate(y, x, '.');
    switch (input){
      case 'w':
        if ((map[y - 1][x]) != '#'){
          Castle.setOrdinate(-1);
        }
      case 'a':
        if ((map[y][x - 1]) != '#'){
          Castle.setAbscissa(-1);
        }
      case 's':
        if ((map[y + 1][x]) != '#'){
          Castle.setOrdinate(1);
        }
      case 'd':
        if ((map[y][x + 1]) != '#'){
          Castle.setAbscissa(1);
        }
    }

    x = Castle.getAbscissa();
    y = Castle.getOrdinate();

    game:
    if (map[y][x] == 'x'){
        Map<String, Persona> opponents = {
          '1': Persona('Shadow Jiraiya', 100, 100, ['Garu', 'Bash'], []),
          '2': Persona('Shadow Tomoe', 100, 100, ['Bufu', 'Skewer'], []),
          '3': Persona('Shadow Konohana Sakuya', 100, 100, ['Agi', 'Cleave'], []),
        };

      while (true){
        for (var i in party.values){
          if (i.hp == 0){
            continue;
          }

          i.turn();

          print(i.info());

          stdout.write('Skill ${i.active}: ');
          String move = stdin.readLineSync()!;
          while (!i.active.contains(move)){
              stdout.write('Skill: ');
              move = stdin.readLineSync()!;
          };

          Map<String, Persona> character = {};

          if (offensive.contains(effect[move]!['Type'])){
            character = Map.fromEntries(opponents.entries.where((opponent) => opponent.value.hp > 0));
          } else {
            character = Map.fromEntries(party.entries.where((character) => character.value.hp > 0));
          };
          stdout.write('Target ${character.keys}: ');
          String target = stdin.readLineSync()!;
          while (!character.keys.contains(target)){
            stdout.write('Target: ');
            target = stdin.readLineSync()!;
          }
          print(i.skill(character[target]!, move));
          print(character[target]!.info());
          if (opponents.values.every((opponent) => opponent.hp == 0)){
            Castle.setCoordinate(Castle.getOrdinate(), Castle.getAbscissa(), 'o');
            if (!Castle.getMap().any((coordinate) => coordinate.contains('x'))){
              for (var i in map){
                print(i.join(' '));
              }
              print('The Investigation Team won!');
              break loop;
            }
            break game;
          }
        }

        for (var i in opponents.values){
          if (i.hp == 0){
            continue;
          }

          i.turn();

          print(i.info());

          late Persona character;
          late String move;
          late Map<String, Persona> target;

          move = i.active[Random().nextInt(i.active.length)];
          
          if (offensive.contains(effect[move]!['Type'])){
            target = Map.fromEntries(party.entries.where((character) => character.value.hp > 0));
          } else {
            target = Map.fromEntries(opponents.entries.where((opponent) => opponent.value.hp > 0));
          }
          character = target[target.keys.toList()[Random().nextInt(target.keys.length)]]!;
          print(i.skill(character, move));
          print(character.info());
          if (party.values.every((character) => character.hp == 0) || party['Yu']!.hp == 0){
            for (var i in map){
              print(i.join(' '));
            }
            print('The Investigation Team was defeated!');
            break loop;
          }
        }
      }
    }
    Castle.setCoordinate(y, x, 'o');
  }
}