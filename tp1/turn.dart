import 'fight.dart';
import 'models/bot.dart';
import 'utils/colors.dart';
import 'utils/utils.dart';

void turn(int turnCount, Bot player, Bot opponent, fightTactic playerTactic,) {
  final String headDashes = Color.text(Utils.dashes(7), foreground: colors.brightBlack.index);
  final String turnHeader = headDashes+Color.text(' Tour $turnCount ', foreground: colors.green.index)+headDashes;
  print(turnHeader);
  
  fight(player, playerTactic, opponent);

  // affiche la vie restante des deux personnages
  if(player.stats.health > 0 && opponent.stats.health > 0) print('\n[${player.formatName} : ${player.stats.health100}] - [${opponent.formatName} : ${opponent.stats.health100}]'); 
  print(Color.text(Utils.dashes(21+turnCount.toString().length), foreground: colors.brightBlack.index));
}