import 'dart:math';
import 'dart:io';
import 'skills.dart';

class Persona{
  String name;
  int maxHp;
  int maxSp;
  int hp;
  int sp;
  List<String> skills;

  Persona(this.name, this.hp, this.sp, this.skills) : maxHp = hp, maxSp = sp;

  void skill(Persona target, String skill){
    int power = effect[skill]!['Power'] as int;
    int accuracy = effect[skill]!['Accuracy'] as int;
    int cost = effect[skill]!['Cost'] as int;
    int type = effect[skill]!['Type'] as int;

    if (Random().nextInt(100) + 1 <= accuracy){
      switch (type){
        case 0:
          sp -= cost;
          target.hp = max(0, target.hp - power);
          break;
        case 1:
          hp -= (hp * (cost / 100)).toInt();
          target.hp = max(0, target.hp - power);
          break;
        case 2:
          sp = max(0, sp - cost);
          target.hp = min(target.maxHp, target.hp + power);
          break;
        }
        print('$name casted $skill on ${target.name}');
      } else {
        print('$name casted $skill on ${target.name}, but it missed!');
      }
  }

  String info(){
    return ('Name: $name\nHP: $hp/$maxHp\nSP: $sp/$maxSp\nSkills: $skills');
  }
}

void main(){
  Map<String, Persona> characters = {
    'Yu': Persona('Izanagi', 100, 100, ['Zio', 'Cleave']),
    'Yosuke': Persona('Jiraiya', 100, 100, ['Garu', 'Bash', 'Dia']),
    'Chie': Persona('Tomoe', 100, 100, ['Skewer']),
    'Yukiko': Persona('Konohana Sakuya', 100, 100, ['Dia', 'Agi']) 
  };

  Map<String, Persona> opponents = {
    '1': Persona('Shadow Jiraiya', 100, 100, ['Garu', 'Bash']),
    '2': Persona('Shadow Tomoe', 100, 100, ['Bufu', 'Skewer']),
    '3': Persona('Shadow Konohana Sakuya', 100, 100, ['Agi', 'Cleave']),
  };

  game:
  while (true){
    for (var i in characters.values){
      if (i.hp == 0){
        continue;
      }

      print(i.info());

      stdout.write('Skill: ');
      String move = stdin.readLineSync()!;
      while (!i.skills.contains(move)){
          stdout.write('Skill: ');
          move = stdin.readLineSync()!;
      };

      stdout.write('Target: ');
      String target = stdin.readLineSync()!;
      Map<String, Persona> possible = {};
      switch (effect[move]!['Type']){
        case 2:
          possible = Map.fromEntries(characters.entries.where((character) => character.value.hp > 0));
          break;
        default:
          possible = Map.fromEntries(opponents.entries.where((opponent) => opponent.value.hp > 0));
          break;
      };
      while (!possible.keys.contains(target)){
        stdout.write('Target: ');
        target = stdin.readLineSync()!;
      }
      i.skill(possible[target]!, move);
      if (opponents.values.every((opponent) => opponent.hp == 0)){
        break game;
      }
    }

      for (var i in opponents.values){
        if (i.hp == 0){
          continue;
        }      

        print(i.info());

        late Map<String, Persona> target;
        late String move;
        late Persona possible;

        move = i.skills[Random().nextInt(i.skills.length)];
        
        switch (effect[move]!['Type']){
          case 2:
            target = Map.fromEntries(opponents.entries.where((opponent) => opponent.value.hp > 0));
            break;
          default:
            target = Map.fromEntries(characters.entries.where((character) => character.value.hp > 0));
            break;
        }
        possible = target[target.keys.toList()[Random().nextInt(target.keys.length)]]!;
        i.skill(possible, move);
        if (characters.values.every((character) => character.hp == 0)){
          break game;
        }
      }
  }
  if (characters['Yu']!.hp > 0) {
    print('The Investigation Team won!');
  } else {
    print('The Investigation Team was defeated!');
  }
}