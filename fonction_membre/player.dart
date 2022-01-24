class Player {
  String name = "";
  int score = 0;

  void sayHello() => print("Bonjour je m'appelle $name, et voici mon score : $score");

  int get level => score ~/ 100;
  set level (int value) => score = value * 100;
}