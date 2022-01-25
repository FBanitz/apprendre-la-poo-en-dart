import 'dart:math';
import 'models/bot.dart';
import 'utils/colors.dart';
import 'utils/utils.dart';

turn(int turnCount, Bot player, Bot opponent) {
  final String headDashes = Color.text(Utils.dashes(7), foreground: colors.brightBlack.index);
  final String turnHeader = headDashes+ Color.text(' Tour $turnCount ', foreground: colors.green.index)+headDashes;
  print(turnHeader);

  // donne l'initiative au hasard, soit le joueur soit l'adversaire (celui qui a l'initiative attaque en premier)
  bool playerInitiative = Random().nextBool();
  if (playerInitiative) {
    print('${player.formatName} prends l\'initiative\n');
    player.attack(opponent);
    // si l'adversaire est mort, il ne peut plus attaquer
    if (opponent.stats.health > 0) {
      opponent.attack(player);
    } else {
      print('${opponent.formatName} est mort');
    }
  } else {
    print('${opponent.formatName} prends l\'initiative\n');
    opponent.attack(player);
    // si le joueur est mort, il ne peut plus attaquer
    if (player.stats.health > 0) {
      player.attack(opponent);
    } else {
      print('${player.formatName} est mort');
    }
  }
  // affiche la vie restante des deux personnages
  if(player.stats.health > 0 && opponent.stats.health > 0) print('\n[${player.formatName} : ${player.stats.health100}] - [${opponent.formatName} : ${opponent.stats.health100}]'); 
  print(Color.text(Utils.dashes(21+turnCount.toString().length), foreground: colors.brightBlack.index));
}