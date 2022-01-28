import 'dart:math';

import 'models/bot.dart';
import 'utils/colors.dart';
import 'utils/utils.dart';

enum fightTactic {
  attack,
  parry,
  evade,
}

fight(Bot player, fightTactic playerTactic, Bot opponent) {
  bool playerInitiative = Random().nextBool();
  fightTactic opponentTactic = fightTactic.values[Random().nextInt(fightTactic.values.length)];

  damages(Bot attacker, Bot defender, [int dices = 2]) {
    int dicesTotal = 0;
    String rollMessage = Color.text('[', foreground: colors.brightBlack.index);
    for (int i = 0; i < dices; i++) {
      int roll = Utils.diceroll(attacker.stats.strength);
      dicesTotal += roll;
      if (i != 0) rollMessage += Color.text(' + ', foreground: colors.brightBlack.index);
      rollMessage += Color.text('${roll}', foreground: colors.yellow.index);
    }
    int total = attacker.stats.attack + dicesTotal;
    rollMessage += Color.text('] + ', foreground: colors.brightBlack.index) + Color.text('${attacker.stats.attack}', foreground: colors.red.index) + Color.text(' = ', foreground: colors.brightBlack.index) + Color.text('${total}', foreground: colors.yellow.index);
    print(rollMessage);
    print('${attacker.formatName} inflige ${Color.text('${total} dégâts', foreground: colors.yellow.index)} à ${defender.formatName} !');

    defender.stats.health -= total;
  }

  attack() {
    switch (opponentTactic) {
      case fightTactic.attack: 
        if (playerInitiative) {
          print('${player.formatName} attaque ${opponent.formatName} !');
          damages(player, opponent);
          print('${opponent.formatName} attaque ${player.formatName} !');
          damages(opponent, player);
        } else {
          print('${opponent.formatName} attaque ${player.formatName} !');
          damages(opponent, player);
          print('${player.formatName} attaque ${opponent.formatName} !');
          damages(player, opponent);
        } break;
      case fightTactic.parry: 
        print('${opponent.formatName} se défend !');
        print('${player.formatName} attaque ${opponent.formatName} mais ${opponent.formatName} se défend !');
        print('${opponent.formatName} risposte !');
        damages(opponent, player, 4);
        break;
      case fightTactic.evade:
        if (playerInitiative) {
          print('${player.formatName} attaque ${opponent.formatName} !');
          damages(player, opponent);
          print('${opponent.formatName} fais une attaque évasive sur ${player.formatName} !');
          damages(opponent, player, 1);
        } else {
          print('${opponent.formatName} fais une attaque évasive sur ${player.formatName} !');
          damages(opponent, player, 1);
          print('${player.formatName} attaque ${opponent.formatName} !');
          damages(player, opponent);
        }
        break;
      default:
    }
  }
  
  parry() {
    switch (opponentTactic) {
      case fightTactic.attack: 
        print('${player.formatName} se défend !');
        print('${opponent.formatName} attaque ${player.formatName} mais ${player.formatName} se défend !');
        print('${player.formatName} risposte !');
        damages(player, opponent, 4);
        break;
      case fightTactic.parry:
        print('${player.formatName} se défend !');
        print('${opponent.formatName} se défend aussi ...');
        print('rien ne se passe ...');
        break;
      case fightTactic.evade:
        print('${player.formatName} se défend !');
        print('${opponent.formatName} fais une attaque évasive sur ${player.formatName} !');
        print('${opponent.formatName} brise la garde de ${player.formatName} !');
        damages(opponent, player, 3);
        break;
    }
  }

  evade(){
    if (playerInitiative) {
      print('${player.formatName} fais une attaque évasive sur${opponent.formatName} !');
      damages(player, opponent, 1);
      print('${opponent.formatName} attaque  ${player.formatName} !');
      damages(opponent, player,);
    } else {
      print('${opponent.formatName} attaque ${player.formatName} !');
      damages(opponent, player);
      print('${player.formatName} fais une attaque évasive sur ${opponent.formatName} !');
      damages(player, opponent, 1);
    }
  }

  switch (playerTactic) {
    case fightTactic.attack: attack(); break;
    case fightTactic.parry: parry(); break;
    case fightTactic.evade: evade(); break;
    default:
    print('Erreur !');
  }
}