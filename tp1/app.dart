import 'dart:math';

import 'player.dart';
import 'bot.dart';
import 'console.dart';

void main(){
  
  int diceroll() {
    int dice = Random().nextInt(6) + 1;
    return dice;
  }

  void game() {
    Bot enemy = Bot();
    Player player = Player();
    int turnCount = 0;

    void playerAttack(Player player, Bot enemy) {
      int dice1 = diceroll();
      int dice2 = diceroll();
      int subTotal = dice1 + dice2;
      int total = player.attack + subTotal;
      print('${player.name} a obtenu un $dice1 et un $dice2 qui font $subTotal, auquel on ajoute son attaque : ${player.attack}');
      print('${player.name} a infligé un total de $total dégats à ${enemy.name} !');

      enemy.health -= total;
      print('${enemy.name} a ${enemy.health}% de vie restants');
    }

    void enemyAttack(Player player, Bot enemy) {
      int dice1 = diceroll();
      int dice2 = diceroll();
      int subTotal = dice1 + dice2;
      int total = enemy.attack + subTotal;
      print('${enemy.name} a obtenu un $dice1 et un $dice2 qui font $subTotal, auquel on ajoute son attaque : ${enemy.attack}');
      print('${enemy.name} a infligé un total de $total dégats à ${player.name} !');

      player.health -= total;
      print('${player.name} a ${player.health}% de vie restants');
    }

    turn() {
      bool playerInitiative = Random().nextBool();
      turnCount ++;
      print('------------------');
      print('Tour $turnCount');
      if (playerInitiative) {
        print('${player.name} prends l\'initiative');
        playerAttack(player, enemy);
        if (enemy.health > 0) {
          enemyAttack(player, enemy);
        } else {
          print('${enemy.name} est mort');
        }
      } else {
        print('${enemy.name} prends l\'initiative');
        enemyAttack(player, enemy);
        if (player.health > 0) {
          playerAttack(player, enemy);
        } else {
          print('${player.name} est mort');
        }
      }
      if(player.health > 0 && enemy.health > 0) print('${player.name} : ${player.health}% - Ennemi : ${enemy.health}%'); 
      print('Fin du tour $turnCount');
      print('------------------');
    }

    cmd(String input, Player player, Bot enemy) {
      switch (input) {
        case 'ps':
        case 'player stats':
          player.showStats();
          return false;

        case 'es':
        case 'enemy stats':
          enemy.showStats();
          return false;

        case 'q':
        case 'quit':
          print('Au revoir !');
          return true;

        case 'h':
        case 'help':
          print('Commandes disponibles :');
          print('player stats, ps : Affiche les statistiques du joueur');
          print('enemy stats, es : Affiche les statistiques de l\'ennemi');
          print('quit, q : Quitte le jeu');
          print('help, h : Affiche les commandes disponibles');
          return false;

        case '': 
          turn();
          return false;
          
        default: 
          print('Commande inconnue');
          return false;
      }
    }

    player.name = readText('Quel est votre nom ?');
    print('Bienvenue dans le jeu ${player.name}');

    print('${enemy.name} se présente à vous et veut se battre');
    
    while (enemy.health > 0 && player.health > 0) {
      String cmdInput = readText('\nAppuyez sur Entrée pour lancer le tour, tapez "help" pour afficher les commandes disponibles');
      if (cmd(cmdInput, player, enemy) == true) break;
    }
    
    if (player.health <= 0 && enemy.health <= 0) {
      if (player.health <= 0) {
        print('${player.name} a perdu !');
      } else {
        print('${player.name} a gagné en ${turnCount} tours!');
      }
    }
  }
  game();
}