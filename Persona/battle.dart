import 'dart:math';
import 'dart:io';
import 'skills.dart';

class Persona{
  String name;
  int hp;
  int sp;
  List<String> skills;

  Persona(this.name, this.hp, this.sp, this.skills);

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
          target.hp = min(100, target.hp + power);
          break;
        }
        print('${this.name} casted ${skill} on ${target.name}');
      } else {
        print('${this.name} casted ${skill} on ${target.name}, but it missed!');
      }
  }

  String info(){
    return ('Name: ${this.name}\nHP: ${this.hp.toString()}\nSP: ${this.sp.toString()}\nSkills: ${this.skills}');
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

  while (characters['Yu']!.hp > 0 || opponents.isNotEmpty){
    for (var i in characters.values){
      print(i.info());
      stdout.write('Skill: ');
      String move = stdin.readLineSync()!;
      while (!i.skills.contains(move)){
          stdout.write('Skill: ');
          move = stdin.readLineSync()!;
      };
      stdout.write('Target: ');
      String target = stdin.readLineSync()!;
      switch (effect[move]!['Type']){
        case 2:
          while (!characters.keys.contains(target)){
            stdout.write('Target: ');
            target = stdin.readLineSync()!;
          }
          i.skill(characters[target]!, move);
        default:
          while (!opponents.keys.contains(target)){
            stdout.write('Target: ');
            target = stdin.readLineSync()!;
          };
          i.skill(opponents[target]!, move);
          if (opponents[target]!.hp == 0){
            opponents.remove(target);
          }
        }
      }
      for (var i in opponents.values){
        print(i.info());
        late Persona target;
        late String move;
        int random = Random().nextInt(2);
        switch (random){
          case 0:
            target = characters[characters.keys.toList()[Random().nextInt(characters.keys.length)]]!;
            move = i.skills[Random().nextInt(i.skills.length)];
            i.skill(target, move);
            if (target.hp == 0){
              characters.remove(target);
            }
            break;
          case 1:
            target = opponents[opponents.keys.toList()[Random().nextInt(opponents.keys.length)]]!;
            move = 'Dia';
            i.skill(target, move);
            break;
        }
      }
  }
}