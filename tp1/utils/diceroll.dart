import 'dart:math';

int diceroll() {
  int dice = Random().nextInt(6) + 1;
  return dice;
}