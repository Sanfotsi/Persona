import 'dart:math';
import 'dart:io';
import 'skills.dart';

class Persona{
  String name;
  int maxHp;
  int maxSp;
  int hp;
  int sp;
  double attack = 1;
  double defence = 1;
  double rate = 1;
  int attackCooldown = 0;
  int defenceCooldown = 0;
  int rateCooldown = 0;
  List<String> skills;

  Persona(this.name, this.hp, this.sp, this.skills) : maxHp = hp, maxSp = sp;

  void skill(Persona target, String skill){
    int power = effect[skill]!['Power'] as int;
    int accuracy = effect[skill]!['Accuracy'] as int;
    int cost = effect[skill]!['Cost'] as int;
    int type = effect[skill]!['Type'] as int;

    attackCooldown = max(0, attackCooldown - 1);
    defenceCooldown = max(0, defenceCooldown - 1);
    rateCooldown = max(0, rateCooldown - 1);

    if (attackCooldown == 0){
      attack = 1;
    }
    if (defenceCooldown == 0){
      defence = 1;
    }
    if (rateCooldown == 0){
      rate = 1;
    }

    if (type == 1){
      hp -= (maxHp * (cost / 100)).toInt();
    } else {
      sp = max(0, sp - cost);
    }

    if (Random().nextInt(100) + 1 <= min(100, accuracy*(rate/target.rate))){
      switch (type){
        case 0:
        case 1:
          target.hp = max(0, (target.hp - (power*(attack/target.defence))).floor());
          break;
        case 2:
          target.hp = min(target.maxHp, target.hp + power);
          break;
        case 3:
          target.attack = 3/2;
          target.attackCooldown = 3;
          break;
        case 4:
          target.defence = 3/2;
          target.defenceCooldown = 3;
          break;
        case 5:
          target.rate = 3/2;
          target.rateCooldown = 3;
          break;
        case 6:
          target.attack = 2/3;
          target.attackCooldown = 3;
          break;
        case 7:
          target.defence = 2/3;
          target.defenceCooldown = 3;
          break;
        case 8:
          target.rate = 2/3;
          target.rateCooldown = 3;
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
    'Yu': Persona('Izanagi', 100, 100, ['Zio', 'Cleave', 'Rakukaja']),
    'Yosuke': Persona('Jiraiya', 100, 100, ['Garu', 'Bash', 'Dia']),
    'Chie': Persona('Tomoe', 100, 100, ['Skewer', 'Tarukaja']),
    'Yukiko': Persona('Konohana Sakuya', 100, 100, ['Dia', 'Agi']), // Maragi, Me Patra 
    'Kanji': Persona('Take-Mikazuchi', 100, 100, ['Zionga', 'Rakukaja']) //Mazio, Kill Rush, Regenerate 1
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
        case 0:
        case 1:
        case 6:
        case 7:
        case 8:
          possible = Map.fromEntries(opponents.entries.where((opponent) => opponent.value.hp > 0));
          break;
        case 2:
        case 3:
        case 4:
        case 5:
          possible = Map.fromEntries(characters.entries.where((character) => character.value.hp > 0));
          break;
      };
      while (!possible.keys.contains(target)){
        stdout.write('Target: ');
        target = stdin.readLineSync()!;
      }
      i.skill(possible[target]!, move);
      print(possible[target]!.info());
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
          case 0:
          case 1:
          case 6:
          case 7:
          case 8:
            target = Map.fromEntries(characters.entries.where((character) => character.value.hp > 0));
            break;
          case 2:
          case 3:
          case 4:
          case 5:
            target = Map.fromEntries(opponents.entries.where((opponent) => opponent.value.hp > 0));
            break;
        }
        possible = target[target.keys.toList()[Random().nextInt(target.keys.length)]]!;
        i.skill(possible, move);
        print(possible.info());
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