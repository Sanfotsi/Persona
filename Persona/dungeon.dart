import 'dart:io';

class Dungeon{
  List<List<String>> map;
  int x;
  int y;

  Dungeon(this.map) : x = 1, y = 1;

  List<List<String>> getMap(){
    return map;
  }
  int getAbscissa(){
    return x;
  }
  int getOrdinate(){
    return y;
  }
  void setAbscissa(int amount){
    x += amount;
  }
  void setOrdinate(int amount){
    y += amount;
  }
  void setCoordinate(int y, int x, String symbol){
    map[y][x] = symbol;
  }
}

int explore(Dungeon Castle){
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
        if ((map[y - 1][x]) != '-'){
          Castle.setOrdinate(-1);
        }
      case 's':
        if ((map[y + 1][x]) != '-'){
          Castle.setOrdinate(1);
        }
      case 'a':
        if ((map[y][x - 1]) != '-'){
          Castle.setAbscissa(-1);
        }
      case 'd':
        if ((map[y][x + 1]) != '-'){
          Castle.setAbscissa(1);
        }
    }

    x = Castle.getAbscissa();
    y = Castle.getOrdinate();

    if (map[y][x] == 'x'){
      print('A battle has ensued');
      return 1;
    }

    Castle.setCoordinate(y, x, 'o');
    return 0;
  }
}