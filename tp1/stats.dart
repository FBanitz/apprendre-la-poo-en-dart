class Stats {
  int attack = 1;
  int maxHealth = 100;
  int health = 100;
  int xp = 0;

  int get level => xp ~/ 100;
  set level (int value) => xp = value * 100;
  
  String get health100 => (health / maxHealth * 100).round().toString() + '%'; 
}