import 'dart:math';

import 'models/bot_names.dart';
import 'turn.dart';
import 'utils/cmd.dart';
import 'models/bot.dart';
import 'utils/colors.dart';
import 'utils/input.dart';

void game() {
  // choisi un nom a l'adversaire aléatoirement
  Bot player = Bot().. nameColor = colors.blue.index;
  Bot opponent = Bot() ..name = botNames[Random().nextInt(botNames.length)] .. nameColor = colors.red.index;
  opponent.getLevels(Random().nextInt(player.stats.level));
  int turnCount = 0;

  // demande au joueur un nom de robot
  while (player.name.replaceAll(' ', '') == '') player.name = Input.readText('Donnez un nom a votre robot : ');
  print('Bienvenue dans l\'arène  ${player.formatName} !');

  print('${opponent.formatName} se présente à vous et veut se battre');
  
  // lis la commande de l'utilisateur et l'execute (lance le tour si vide)
  late cmdReturn cmdOutput = cmdReturn.back;
  while (opponent.stats.health > 0 && player.stats.health > 0 && cmdOutput != cmdReturn.quit) {
    String cmdInput = Input.readText('\nAppuyez sur Entrée pour lancer le tour, tapez "help" pour afficher les commandes disponibles');
    cmdOutput = cmd(cmdInput, player, opponent);
    switch (cmdOutput) {
      case cmdReturn.back : break;
      case cmdReturn.turn : turnCount ++; turn(turnCount, player, opponent); break;
      case cmdReturn.win : opponent.stats.health = 0; break;
      default: break;
    }
  }

  // condition de victoire ou de défaite
  if (player.stats.health <= 0 || opponent.stats.health <= 0) {
    if (player.stats.health <= 0) {
      print('${player.formatName} a perdu !');
    } else {
      print('${player.formatName} a gagné en ${turnCount} tour${turnCount > 1 ? 's' : ''} !');
      player.getXp(opponent.xpDrop, show: true);
    }
  }
}