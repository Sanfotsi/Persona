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
        String type = effect[skill]!['Type'] as String;

        if (Random().nextInt(100) + 1 <= accuracy){
            switch (type){
                case 'Magic':
                    sp -= cost;
                case 'Physical':
                    hp -= hp * (cost ~/ 100);
            }
            target.hp = max(0, target.hp - power);
            print('${this.name} casted ${skill} on ${target.name}');
        } else {
            print('${this.name} casted ${skill} on ${target.name}, but it missed!');
        }
    }

    void heal(Persona target, String skill){
        int power = healing[skill]!['Power'] as int;
        int cost = healing[skill]!['Cost'] as int;

        sp = max(0, sp - cost);
        target.hp = min(100, target.hp + power);
        print('${this.name} casted Dia on ${target.name}');
    }

    String info(){
        return ('Name: ${this.name}\nHP: ${this.hp.toString()}\nSP: ${this.sp.toString()}');
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
        '1': Persona('Magatsu-Izanagi', 100, 100, ['Garu', 'Bash']),
        '2': Persona('Magatsu-Izanagi', 100, 100, ['Bufu', 'Skewer']),
        '3': Persona('Magatsu-Izanagi', 100, 100, ['Agi', 'Cleave']),
    };

    while (characters['Yu']!.hp > 0 && opponents.values.any((opponent) => opponent.hp > 0)){
        for (var i in characters.values){
          print(i.info());
        }

        for (var i in opponents.values){
          print(i.info());
        }
        
        for (var i in characters.values){
            stdout.write('${i.name}: ');
            String move = stdin.readLineSync()!;
            switch (move){
                case 'Dia':
                    stdout.write('Target: ');
                    String target = stdin.readLineSync()!;
                    while (!characters.keys.contains(target)){
                        stdout.write('Target: ');
                        target = stdin.readLineSync()!;
                    };
                    i.heal(characters[target]!, 'Dia');
                default:
                    while (!i.skills.contains(move)){
                        stdout.write('Skill: ');
                        move = stdin.readLineSync()!;
                    };
                    stdout.write('Target: ');
                    String target = stdin.readLineSync()!;
                    while (!opponents.keys.contains(target)){
                        stdout.write('Target: ');
                        target = stdin.readLineSync()!;
                    };
                    i.skill(opponents[target]!, move);
            }
        }
        for (var i in opponents.values){
            switch (Random().nextInt(2)){
                case 0:
                    i.skill(characters[characters.keys.toList()[Random().nextInt(characters.keys.length)]]!, 'Garu');
                case 1:
                    i.heal(opponents[opponents.keys.toList()[Random().nextInt(opponents.keys.length)]]!, 'Dia');
            }
        }
    }
}