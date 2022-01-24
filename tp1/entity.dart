import 'stats.dart';
import 'diceroll.dart';

class Entity {
  String name = "";
  Stats stats = Stats();

  void showStats(){
    print("--- Statistiques de $name ---");
    print("Attaque: ${stats.attack}");
    print("Vie: ${stats.health}");
    print("niveau: ${stats.level}");
    print("Experience: ${stats.xp}");
    print("-----------------------------");
  }

  void attack (Entity enemy) {
    int dice1 = diceroll();
    int dice2 = diceroll();
    int subTotal = dice1 + dice2;
    int total = stats.attack + subTotal;
    print('${name} a obtenu un $dice1 et un $dice2 qui font $subTotal, auquel on ajoute son attaque : ${stats.attack} pour un total de $total dégats!');

    enemy.stats.health -= total;
  }
}