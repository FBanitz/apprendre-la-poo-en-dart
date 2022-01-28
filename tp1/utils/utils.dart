import 'dart:math';

class Utils {
  /// lance un dé
  static int diceroll([int faces = 6]) {
    int dice = Random().nextInt(faces) + 1;
    return dice;
  }
  
  /// créé une ligne de tirets de la longueur souhaitée
  static String dashes (int length) {
    String dashes = '';
    for (int i = 0; i < length; i++) {
      dashes += '-';
    }
    return dashes;
  }
}