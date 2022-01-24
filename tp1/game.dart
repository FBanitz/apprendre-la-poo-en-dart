import 'dart:math';

import 'models/bot_names.dart';
import 'utils/cmd.dart';
import 'models/entity.dart';
import 'utils/input.dart';

void game() {
  // choisi un nom au bot aléatoirement
  Entity enemy = Entity() ..name = botNames[Random().nextInt(botNames.length)];
  Entity player = Entity();
  int turnCount = 0;
  
  // créé une ligne de tirets de la longueur souhaitée
  String dashes (int length) {
    String dashes = '';
    for (int i = 0; i < length; i++) {
      dashes += '-';
    }
    return dashes;
  }

  turn() {
    turnCount ++;
    String turnHeader = '------- Tour $turnCount -------';
    print(turnHeader);

    // donne l'initiative au hasard, soit le joueur soit l'ennemi (celui qui a l'initiative attaque en premier)
    bool playerInitiative = Random().nextBool();
    if (playerInitiative) {
      print('${player.name} prends l\'initiative\n');
      player.attack(enemy);
      // si l'ennemi est mort, il ne peut plus attaquer
      if (enemy.stats.health > 0) {
        enemy.attack(player);
      } else {
        print('${enemy.name} est mort');
      }
    } else {
      print('${enemy.name} prends l\'initiative\n');
      enemy.attack(player);
      // si le joueur est mort, il ne peut plus attaquer
      if (player.stats.health > 0) {
        player.attack(enemy);
      } else {
        print('${player.name} est mort');
      }
    }

    if(player.stats.health > 0 && enemy.stats.health > 0) print('\n[${player.name} : ${player.stats.health100}] - [Ennemi : ${enemy.stats.health100}]'); 
    print(dashes(turnHeader.length));
  }

  while (player.name.replaceAll(' ', '') == '') player.name = readText('Quel est votre nom ?');
  print('Bienvenue dans le jeu ${player.name}');

  print('${enemy.name} se présente à vous et veut se battre');
  
  late cmdReturn cmdOutput = cmdReturn.back;
  while (enemy.stats.health > 0 && player.stats.health > 0 && cmdOutput != cmdReturn.quit) {
    String cmdInput = readText('\nAppuyez sur Entrée pour lancer le tour, tapez "help" pour afficher les commandes disponibles');
    cmdOutput = cmd(cmdInput, player, enemy);
    switch (cmdOutput) {
      case cmdReturn.back : break;
      case cmdReturn.turn : turn(); break;
      default: break;
    }
  }
  
  if (player.stats.health <= 0 && enemy.stats.health <= 0) {
    if (player.stats.health <= 0) {
      print('${player.name} a perdu !');
    } else {
      print('${player.name} a gagné en ${turnCount} tours!');
    }
  }
}