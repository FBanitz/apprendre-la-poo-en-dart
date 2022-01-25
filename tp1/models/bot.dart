import 'dart:math';
import '../utils/colors.dart';
import '../utils/utils.dart';
import 'stats.dart';

class Bot {
  String name = "";
  int nameColor = colors.white.index;
  String get formatName => Color.text(name, foreground: nameColor, bold: true);
  Stats stats = Stats();
  int get xpDrop => stats.level * (Random().nextInt(10)+ 15);

  void showStats(){
    String headDashLine = Color.text(Utils.dashes(3), foreground: colors.brightBlack.index);
    print(headDashLine+" Statistiques de $formatName "+headDashLine);
    print("Attaque: ${stats.attack}");
    print("Vie: ${stats.health}/${stats.maxHealth}");
    print("niveau: ${stats.level}");
    print("Experience: ${stats.xp}");
    String footDashLine = Color.text(Utils.dashes(name.length + 24), foreground: colors.brightBlack.index);
    print(footDashLine);
  }

  void attack (Bot opponent) {
    int dice1 = Utils.diceroll();
    int dice2 = Utils.diceroll();
    int subTotal = dice1 + dice2;
    int total = stats.attack + subTotal;
    print('${formatName} a obtenu un $dice1 et un $dice2 qui font $subTotal, auquel on ajoute son attaque : ${stats.attack} pour un total de ${Color.text('$total dégats',foreground : colors.yellow.index)} !');

    opponent.stats.health -= total;
  }

  void getXp (int xp, {bool show = false}) {
    stats.xp += xp;
    int neededXp = stats.level * 50;
    if (show) {
      print('$formatName a gagné ${Color.text('$xp XP',foreground : colors.green.index)} !');
    }
    while (stats.xp >= neededXp) {
      stats.xp -= neededXp;
      levelUp(show: show);
    }
    if (show) {
      print('\nPlus que ${Color.text('${neededXp - stats.xp} XP',foreground : colors.green.index)} nécessaires pour passer au ${Color.text('niveau ${stats.level + 1}' ,foreground : colors.brightCyan.index)} !');
    }
  }

  void getLevels (int levels, {bool show = false}) {
    for (int i = 0; i < levels; i++) levelUp(show: show);
  }

  void levelUp ({bool show = false}) {
    stats.level += 1;
    int obtainedHealth = Random().nextInt(3) * 5 + 5;
    int obtainedAttack = Random().nextInt(3) + 1;

    if (show) {
      print('\n${formatName} passe au ${Color.text('niveau ${stats.level}',foreground: colors.brightCyan.index)} !');
      print(Color.text('|', foreground: colors.yellow.index)+Color.text('Santé Max + $obtainedHealth', foreground: colors.green.index)+ ' ('+Color.text('${stats.health}', foreground: colors.green.index)+' => '+Color.text('${stats.health + obtainedHealth}', foreground: colors.green.index) +')');
      print(Color.text('|', foreground: colors.yellow.index)+Color.text('Attaque + $obtainedAttack', foreground: colors.red.index)+ ' ('+Color.text('${stats.attack}', foreground: colors.red.index)+' => '+Color.text('${stats.attack + obtainedAttack}', foreground: colors.red.index) +')');
    }
    stats.health += obtainedHealth;
    stats.maxHealth += obtainedHealth;
    stats.attack += obtainedAttack;
  }
}