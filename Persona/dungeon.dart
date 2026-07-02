class Dungeon{
  List<List<String>> map;
  int y;
  int x;

  Dungeon(this.map, this.y, this.x);

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

Dungeon yukikoCastle = Dungeon(
  [['#', '#', '#', '#', '#', '#'],
   ['#', '.', '.', 'x', '.', '#'],
   ['#', 'x', '.', '#', '.', '#'],
   ['#', '#', '.', '#', '.', '#'],
   ['#', 'o', '.', '#', 'x', '#'],
   ['#', '#', '#', '#', '#', '#']],
   4, 1
);