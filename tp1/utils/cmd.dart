

import '../models/entity.dart';

enum cmdReturn {
  turn,
  quit,
  back
}

cmdReturn cmd(String input, Entity player, Entity enemy) {

  stats(String parameter) {
    switch (parameter) {
      case 'p':
      case 'player': player.showStats(); break;
      case 'e':
      case 'enemy': enemy.showStats(); break;
      case '': print('Usage : stats [player, p | enemy, e]'); break;
      default: print('paramètre inconnu'); break;
    }
  }

  sayBye(){
    print('Au revoir !');
  }

  help(){
    print('Commandes disponibles :');
    print('stats, s [player, p | enemy, e] : affiche les stats du personnage');
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

    case '': return cmdReturn.turn;

    default: print('Commande inconnue'); return cmdReturn.back;
  }
}
