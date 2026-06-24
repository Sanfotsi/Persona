import "dart:math";
import "dart:io";
import "character.dart";
import "skills.dart";

class Persona{
    String name;
    int hp;
    int sp;

    Persona(this.name, this.hp, this.sp);

    void Skill(Persona target, String skill){
        int power = attribute[skill]!["Power"] as int;
        int accuracy = attribute[skill]!["Accuracy"] as int;
        int cost = attribute[skill]!["Cost"] as int;
        String type = attribute[skill]!["Type"] as String;

        if (Random().nextInt(100) + 1 <= accuracy){
            switch (type){
                case "Physical":
                    hp -= hp * (cost / 100).toInt();
                case "Magic":
                    sp -= cost;
            }
            target.hp = max(0, target.hp - power);
            print("${this.name} casted ${skill} on ${target.name}");
        } else {
            print("${this.name} casted ${skill} on ${target.name}, but it missed!");
        }
    }

    void Buff(){
        print("${this.name} casted Buff on itself");
    }

    void Healing(int power, int cost){
        this.sp = max(0, sp - cost);
        this.hp = min(100, hp + power);
        print("${this.name} casted Dia on itself");
    }

    void Info(){
        print("Name: ${this.name}\nHP: ${this.hp.toString()}\nSP: ${this.sp.toString()}");
    }
}

void main(){
    print("Character: [Yu || Yosuke || Chie || Yukiko || Kanji]");
    String select = stdin.readLineSync()!;
    Persona character = Persona(
        characters[select]![0] as String, 
        characters[select]![1] as int, 
        characters[select]![2] as int);
    
    Persona opponent = Persona("Magatsu-Izanagi", 100, 100);

    while (character.hp > 0 && opponent.hp > 0){
        print("Move: ${characters[select]![3]}");
        String move = stdin.readLineSync()!;
        switch (move){
            case "Healing":
                character.Healing(40, 3);
            case "Buff":
                character.Buff();
            default:
                character.Skill(opponent, move);
        }
        switch (Random().nextInt(2)){
            case 0:
                opponent.Skill(character, attribute.keys.elementAt(Random().nextInt((attribute.length))));
            case 1:
                opponent.Healing(40, 3);
        }
        character.Info();
        opponent.Info();
    }
}