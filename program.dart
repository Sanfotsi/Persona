import 'dart:math';
import 'dart:io';
import 'skills.dart';

class Persona{
    String name;
    int hp;
    int sp;
    List<String> skills;

    Persona(this.name, this.hp, this.sp, this.skills);

    void magic(Persona target, String skill){
        int power = magical[skill]!['Power'] as int;
        int accuracy = magical[skill]!['Accuracy'] as int;
        int cost = magical[skill]!['Cost'] as int;

        if (Random().nextInt(100) + 1 <= accuracy){
            sp -= cost;
            target.hp = max(0, target.hp - power);
            print('${this.name} casted ${skill} on ${target.name}');
        } else {
            print('${this.name} casted ${skill} on ${target.name}, but it missed!');
        }
    }

    void physique(Persona target, String skill){
        int power = physical[skill]!['Power'] as int;
        int accuracy = physical[skill]!['Accuracy'] as int;
        int cost = physical[skill]!['Cost'] as int;

        if (Random().nextInt(100) + 1 <= accuracy){
            hp -= hp * (cost ~/ 100);
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
    Persona Yu = Persona('Izanagi', 100, 100, ['Zio', 'Cleave']);
    Persona Yosuke = Persona('Jiraiya', 100, 100, ['Garu', 'Bash', 'Dia']);
    Persona Chie = Persona('Tomoe', 100, 100, ['Skewer']);
    Persona Yukiko = Persona('Konohana Sakuya', 100, 100, ['Dia', 'Agi']);

    Map<String, Persona> characters = {
        'Yu': Yu,
        'Yosuke': Yosuke,
        'Chie': Chie,
        'Yukiko': Yukiko 
    };

    Persona opponent1 = Persona('Magatsu-Izanagi', 100, 1000, ['Zio', 'Cleave', 'Dia']);
    Persona opponent2 = Persona('Magatsu-Izanagi', 100, 1000, ['Garu', 'Bash', 'Dia']);
    Persona opponent3 = Persona('Magatsu-Izanagi', 100, 1000, ['Bufu', 'Skewer', 'Dia']);

    Map<String, Persona> opponents = {
        'opponent1': opponent1,
        'opponent2': opponent2,
        'opponent3': opponent3
    };

    while (Yu.hp > 0 && opponents.values.any((opponent) => opponent.hp > 0)){
        for (var i in characters.values){
            stdout.write('${i.name}: ');
            String move = stdin.readLineSync()!;
            switch (move){
                case 'Magic':
                    stdout.write('Skill: ');
                    String choice = stdin.readLineSync()!;
                    while (!i.skills.contains(choice)){
                        stdout.write('Skill: ');
                        choice = stdin.readLineSync()!;
                    };
                    stdout.write('Target: ');
                    String target = stdin.readLineSync()!;
                    while (!opponents.keys.contains(target)){
                        stdout.write('Target: ');
                        target = stdin.readLineSync()!;
                    };
                    i.magic(opponents[target]!, choice);
                case 'Physique':
                    stdout.write('Skill: ');
                    String choice = stdin.readLineSync()!;
                    while (!i.skills.contains(choice)){
                        stdout.write('Skill: ');
                        choice = stdin.readLineSync()!;
                    };
                    stdout.write('Target: ');
                    String target = stdin.readLineSync()!;
                    while (!opponents.keys.contains(target)){
                        stdout.write('Target: ');
                        target = stdin.readLineSync()!;
                    };
                    i.physique(opponents[target]!, choice);
                case 'Heal':
                    stdout.write('Target: ');
                    String target = stdin.readLineSync()!;
                    while (!characters.keys.contains(target)){
                        stdout.write('Target: ');
                        target = stdin.readLineSync()!;
                    };
                    i.heal(characters[target]!, 'Dia');
            }
        }
        for (var i in opponents.values){
            switch (Random().nextInt(3)){
                case 0:
                    i.magic(characters[characters.keys.toList()[Random().nextInt(characters.keys.length)]]!, 'Garu');
                case 1:
                    i.physique(characters[characters.keys.toList()[Random().nextInt(characters.keys.length)]]!, 'Bash');
                case 2:
                    i.heal(opponents[opponents.keys.toList()[Random().nextInt(opponents.keys.length)]]!, 'Dia');
            }
        }

        for (var i in characters.values){
          print(i.info());
        }

        for (var i in opponents.values){
          print(i.info());
        }
    }
}