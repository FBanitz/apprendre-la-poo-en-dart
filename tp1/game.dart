import 'dart:math';

import 'models/bot_names.dart';
import 'models/stats.dart';
import 'models/victory.dart';
import 'utils/cmd.dart';
import 'models/bot.dart';
import 'utils/colors.dart';
import 'utils/input.dart';

void game() {
  List<Victory> victories = [];

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
    print('${opponent.formatName}, ${Color.text('niveau ${opponent.stats.level}',foreground: colors.brightCyan.index)}, se présente à vous et veut se battre');
    
    // lis la commande de l'utilisateur et l'execute (lance le tour si vide)
    
    while (opponent.stats.health > 0 && player.stats.health > 0) {
      turnCount++;
      bool cmdValid = false;
      while (!cmdValid) {
        cmdValid = cmd(turnCount, player, opponent);
      }
    }

    // condition de victoire ou de défaite
    if (player.stats.health <= 0) {
      print('${player.formatName} a été détruit');
      int i = 0;
      victories.forEach((victory) {
        i++; 
        print('\nMatch $i : ${player.formatName} a vaincu ${victory.opponent.formatName} en ${victory.turnCount} tour${victory.turnCount > 1 ? 's' : ''}'); 
        if (victory.opponent.stats.health <= -500 || victory.turnCount <= 1) print(Color.text('---- Suspicious victory detected ----\n', foreground: 40)); else print('\n');
        victory.opponent.showStats(); 
      });
      print('\n${player.formatName} a perdu au ${i+1}${i>0?'eme':'er'} Match, Tour $turnCount, contre ${opponent.formatName}');
      // if (player.stats.health <= -500 || turnCount <= 1) print(Color.text('---- Suspicious defeat detected ----\n', foreground: 40)); else print('\n');
      opponent.showStats();
      break;
    } else {
      print('\n${player.formatName} a gagné en ${turnCount} tour${turnCount > 1 ? 's' : ''} !\n\n');
      victories.add(Victory(opponent: opponent, turnCount: turnCount));
      player.repair(show: true);
      player.getXp(opponent.xpDrop, show: true);
    }
  }
}