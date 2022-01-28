import '../fight.dart';
import '../models/bot.dart';
import '../turn.dart';
import 'colors.dart';
import 'input.dart';


bool cmd(int turnCount, Bot player, Bot opponent) {

  String input = Input.readText('\nTapez attack, parry ou evade pour lancer le tour et utiliser la tactique correspondante, tapez "help" pour afficher les commandes disponibles');

  void stats(String parameter) {
    switch (parameter) {
      case 'p':
      case 'player': player.showStats(); break;
      case 'o':
      case 'opponent': opponent.showStats(); break;
      case '': print('Usage : stats [player, p | opponent, o]'); break;
      default: print(Color.text('Paramètre inconnu', foreground: colors.yellow.index,)); break;
    }
  }

  void sayBye(){
    print('Au revoir !');
  }

  void help(){
    print('Commandes disponibles :');
    print('stats, s [player, p | opponent, o] : affiche les stats du personnage');
    print('quit, q : Quitte le jeu');
    print('help, h : Affiche les commandes disponibles');
  }

  List<String> cmd = input.toLowerCase().split(' ');

  switch (cmd[0]) {
    case 's':
    case 'stats': stats(cmd.length >=2 ? cmd[1] : ''); return false;

    case 'q':
    case 'quit': sayBye(); player.stats.health = 0; return true;

    case 'h':
    case 'help': help(); return false;

    case 'a': 
    case 'attack': turn(turnCount, player, opponent, fightTactic.attack); return true;

    case 'p':
    case 'parry': turn(turnCount, player, opponent, fightTactic.parry); return true;
    
    case 'e':
    case 'evade': turn(turnCount, player, opponent, fightTactic.evade); return true;
    
    // commande secrète pour débogage uniquement ;)
    case 'dw':
    case 'debugwin': 
      print(Color.text('\n- ', foreground: 40)+Color.text('Executing totaly-not-cheating ODC3K (Orbitary Debug Cannon 3000)',background: 40)+Color.text(' -\n', foreground: 40)); 
      while(opponent.stats.health > 0) opponent.stats.health -= 10000; return true;

    default: print(Color.text('Commande inconnue', foreground: colors.yellow.index)); return false;
  }
}