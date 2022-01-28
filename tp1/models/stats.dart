class Stats {
  int attack = 1;
  int strength = 6;
  int maxHealth = 100;
  int health = 100;
  int xp = 0;

  int level = 1;
  
  String get health100 => (health / maxHealth * 100).round().toString() + '%';

}