import '../models/bot.dart';
import 'colors.dart';

enum cmdReturn {
  turn,
  quit,
  back,
  win
}

cmdReturn cmd(String input, Bot player, Bot opponent) {

  stats(String parameter) {
    switch (parameter) {
      case 'p':
      case 'player': player.showStats(); break;
      case 'e':
      case 'opponent': opponent.showStats(); break;
      case '': print('Usage : stats [player, p | opponent, e]'); break;
      default: print(Color.text('Paramètre inconnu', foreground: colors.yellow.index,)); break;
    }
  }

  sayBye(){
    print('Au revoir !');
  }

  help(){
    print('Commandes disponibles :');
    print('stats, s [player, p | opponent, e] : affiche les stats du personnage');
    print('quit, q : Quitte le jeu');
    print('help, h : Affiche les commandes disponibles');
  }

  List<String> cmd = input.toLowerCase().split(' ');
  switch (cmd[0]) {
    case 's':
    case 'stats': stats(cmd.length >=2 ? cmd[1] : ''); return cmdReturn.back;

    case 'q':
    case 'quit': sayBye(); return cmdReturn.quit;

    case 'h':
    case 'help': help(); return cmdReturn.back;

    // commande secrète pour débogage uniquement ;)
    case 'dw':
    case 'debugwin': 
      print(Color.text('\n- ', foreground: 40)+Color.text('Executing totaly-not-cheating ODC3K (Orbitary Debug Cannon 3000)',background: 40)+Color.text(' -\n', foreground: 40)); 
      return cmdReturn.win;

    case '': return cmdReturn.turn;

    default: print(Color.text('Commande inconnue', foreground: colors.yellow.index)); return cmdReturn.back;
  }
}
