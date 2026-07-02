import 'dart:math';
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
  List<String> active;
  List<String> passive;

  Persona(this.name, this.hp, this.sp, this.active, this.passive) : maxHp = hp, maxSp = sp;

  void turn(){
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
    if (passive.contains('Regenerate 1')){
      hp += maxHp*(2/100).toInt();
    }
  }

  void cost(int cost, int type){
    switch (type){
      case 1:
        hp -= (maxHp * (cost / 100)).toInt();
      default:
        sp = max(0, sp - cost);
    }
  }

  bool accuracy(int accuracy, double opponentRate){
    if (Random().nextInt(100) + 1 <= min(100, accuracy*(rate/opponentRate))){
      return true;
    }
    return false;
  }

  void power(Persona target, int power, int type){
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
  }

  String skill(Persona target, String skill){
    Map<String, int> card = effect[skill]!;

    cost(card['Cost']!, card['Type']!);

    if (accuracy(card['Accuracy']!, target.rate)){
      power(target, card['Power']!, card['Type']!);
      return '$name casted $skill on ${target.name}';
    }
    return '$name casted $skill on ${target.name}, but it missed!';
  }

  String info(){
    return 'Name: $name, HP: $hp/$maxHp, SP: $sp/$maxSp, Attack: $attack ($attackCooldown), Defend: $defence ($defenceCooldown), Rate: $rate ($rateCooldown), Skills: $active';
  }
}

Map<String, Persona> characters = {
  'Yu': Persona('Izanagi', 100, 100, ['Zio', 'Cleave', 'Rakukaja'], []),
  'Yosuke': Persona('Jiraiya', 100, 100, ['Garu', 'Bash', 'Dia'], []),
  'Chie': Persona('Tomoe', 100, 100, ['Skewer', 'Tarukaja'], []),
  'Yukiko': Persona('Konohana Sakuya', 100, 100, ['Dia', 'Agi'], []), // Maragi, Me Patra 
  'Kanji': Persona('Take-Mikazuchi', 100, 100, ['Zionga', 'Rakukaja'], ['Regenerate 1']), // Mazio, Kill Rush
  'Teddie': Persona('Kintoki-Douji', 100, 100, ['Bufula'], []), // Mediarama, Energy Shower, Poison Skewer, Re Patra
  'Naoto': Persona('Sukuna-Hikona', 100, 100, ['Agidyne', 'Garudyne'], []) // Tempest Slash, Mudoon, Hamaon, Megidola, Deathbound
};