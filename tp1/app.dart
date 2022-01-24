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

    playerAttack(Player player, Bot enemy) {
      int dice1 = diceroll();
      int dice2 = diceroll();
      int subTotal = dice1 + dice2;
      int total = player.attack + subTotal;
      print('${player.name} a obtenu un $dice1 et un $dice2 qui font $subTotal, auquel on ajoute son attaque : ${player.attack}');
      print('${player.name} a infligé un total de $total dégats à l\'ennemi !');

      enemy.health -= total;
      print('L\'ennemi a ${enemy.health}% de vie restants');
    }

    enemyAttack(Player player, Bot enemy) {
      int dice1 = diceroll();
      int dice2 = diceroll();
      int subTotal = dice1 + dice2;
      int total = enemy.attack + subTotal;
      print('L\'ennemi a obtenu un $dice1 et un $dice2 qui font $subTotal, auquel on ajoute son attaque : ${enemy.attack}');
      print('L\'ennemi a infligé un total de $total dégats à ${player.name} !');

      player.health -= total;
      print('${player.name} a ${player.health}% de vie restants');
    }

    player.name = readText('Quel est votre nom ?');
    print('Bienvenue dans le jeu ${player.name}');

    print('un bot se présente à vous et veut se battre');

    while (enemy.health > 0 && player.health > 0) {
      readText('Apuillez sur Entrée pour lancer le tour');
      bool playerInitiative = Random().nextBool();
      turn ++;
      print('------------------');
      print('Tour $turn');
      if (playerInitiative) {
        print('${player.name} prends l\'initiative');
        playerAttack(player, enemy);
        if (enemy.health > 0) {
          enemyAttack(player, enemy);
        } else {
          print('L\'ennemi est mort');
        }
      } else {
        print('L\'ennemi prends l\'initiative');
        enemyAttack(player, enemy);
        if (player.health > 0) {
          playerAttack(player, enemy);
        } else {
          print('${player.name} est mort');
        }
      }
      if(player.health > 0 && enemy.health > 0) print('${player.name} : ${player.health}% - Ennemi : ${enemy.health}%'); 
      print('Fin du tour $turn');
      print('------------------');
    }

    if (player.health <= 0) {
      print('${player.name} a perdu !');
    } else {
      print('${player.name} a gagné en ${turn} tours!');
    }
  }
  startGame();
}