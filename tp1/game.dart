import 'dart:math';

import 'models/bot_names.dart';
import 'models/stats.dart';
import 'models/victory.dart';
import 'turn.dart';
import 'utils/cmd.dart';
import 'models/bot.dart';
import 'utils/colors.dart';
import 'utils/input.dart';

void game() {
  List<Victory> victories = [];
  late cmdReturn cmdOutput = cmdReturn.back;

  String _name = "";
  // demande au joueur un nom de robot
  while (_name.replaceAll(' ', '') == '') _name = Input.readText('Donnez un nom a votre robot : ');
  Bot player = Bot(name: _name, nameColor: colors.blue.index, stats: Stats());
  print('Bienvenue dans l\'arène ${player.formatName} !');

  while (true) {
    int turnCount = 0;
    // choisi un nom a l'adversaire aléatoirement
    Bot opponent = Bot(name: botNames[Random().nextInt(botNames.length)], nameColor: colors.red.index, stats: Stats(),);
    opponent.getLevels(Random().nextInt(player.stats.level));
    print('${opponent.formatName} se présente à vous et veut se battre');
    
    // lis la commande de l'utilisateur et l'execute (lance le tour si vide)
    
    while (opponent.stats.health > 0 && player.stats.health > 0 && cmdOutput != cmdReturn.quit) {
      String cmdInput = Input.readText('\nAppuyez sur Entrée pour lancer le tour, tapez "help" pour afficher les commandes disponibles');
      cmdOutput = cmd(cmdInput, player, opponent);
      switch (cmdOutput) {
        case cmdReturn.back : break;
        case cmdReturn.turn : turnCount++; turn(turnCount, player, opponent); break;
        case cmdReturn.win : opponent.stats.health = 0; break;
        default: break;
      }
    }

    // condition de victoire ou de défaite
    if (player.stats.health <= 0 || opponent.stats.health <= 0) {
      if (player.stats.health <= 0) {
        int i = 0;
        victories.forEach((victory) {i++; print('\nMatch $i : ${player.formatName} a vaincu ${victory.opponent.formatName} en ${victory.turnCount} tours\n'); victory.opponent.showStats(); });
        cmdOutput = cmdReturn.quit;
        print('\n${player.formatName} a perdu au ${i+1}${i>0?'eme':'er'} Match contre ${opponent.formatName}\n');
        opponent.showStats();
        break;
      } else {
        print('\n${player.formatName} a gagné en ${turnCount} tour${turnCount > 1 ? 's' : ''} !');
        victories.add(Victory(opponent: opponent, turnCount: turnCount));
        player.repair(show: true);
        player.getXp(opponent.xpDrop, show: true);
      }
    }
    if (cmdOutput == cmdReturn.quit) break;
  }
}