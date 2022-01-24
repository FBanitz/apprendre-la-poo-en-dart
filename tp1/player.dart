class Player {
  String name = "";
  int attack = 1;
  int health = 100;
  int xp = 0;

  int get level => xp ~/ 100;
  set level (int value) => xp = value * 100;

  void showStats(){
    print("--- Statistiques du joueur ---");
    print("Nom: $name");
    print("Attaque: $attack");
    print("Vie: $health");
    print("niveau: $level");
    print("Experience: $xp");
    print("-------------------");
  }
}