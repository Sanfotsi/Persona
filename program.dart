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

    List characters = [Yu, Yosuke, Chie, Yukiko];

    Persona opponent = Persona('Magatsu-Izanagi', 1000, 1000, ['Zio', 'Garu']);

    while (Yu.hp > 0 && opponent.hp > 0){
      for (var i in characters){
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
                i.magic(opponent, choice);
            case 'Physique':
                stdout.write('Skill: ');
                String choice = stdin.readLineSync()!;
                while (!i.skills.contains(choice)){
                  stdout.write('Skill: ');
                  choice = stdin.readLineSync()!;
                };
                i.physique(opponent, choice);
            case 'Heal':
                stdout.write('Target: ');
                String char = stdin.readLineSync()!;
                late Persona target;

                switch (char){
                  case 'Yu':
                    target = Yu;
                  case 'Yosuke':
                    target = Yosuke;
                  case 'Chie':
                    target = Chie;
                  case 'Yukiko':
                    target = Yukiko;
                }

                i.heal(target, 'Dia');
        }
      }

        switch (Random().nextInt(3)){
            case 0:
                opponent.magic(characters[Random().nextInt(characters.length)], opponent.skills[Random().nextInt((opponent.skills.length))]);
            case 1:
                opponent.physique(characters[Random().nextInt(characters.length)], opponent.skills[Random().nextInt((opponent.skills.length))]);
            case 2:
                opponent.heal(opponent, 'Dia');
        }

        for (var i in characters){
          print(i.info());
        }
        print(opponent.info());
    }
}