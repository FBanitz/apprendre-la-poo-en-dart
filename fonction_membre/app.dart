import 'player.dart';

void main(){
  final j1 = Player()..name = 'Ian' .. score = 120;
  j1.sayHello();

  final j2 = Player()..name = 'Poppy' .. score = 100;
  j2.sayHello();
}