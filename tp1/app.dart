import 'dart:math';

import 'player.dart';
import 'bot.dart';
import 'user_input.dart';

void main(){

  diceroll() {
    int dice = Random().nextInt(6) + 1;
    return dice;
  }

  startGame() {
    Bot enemy = Bot();
    Player player = Player();
    int turn = 0;

    player.name = readText('Quel est votre nom ?');
    print('Bienvenue dans le jeu ${player.name}');

    print('un bot se présente à vous et veut se battre');

    while (enemy.health > 0) {
      turn ++;
      readText('Apuillez sur Entrée pour lancer le dé');

      int dice1 = diceroll();
      print('${player.name} a obtenu un $dice1');

      int dice2 = diceroll();
      print('et un $dice2');

      int total = dice1 + dice2;
      print('${player.name} a infligé un total de $total dégats à l\'ennemi');

      enemy.health -= total;
      print('L\'ennemi a ${enemy.health}% de vie restants');

      print('Fin du tour $turn');
    }
    print('${player.name} a gagné en ${turn} tours!');
  }
  startGame();
}