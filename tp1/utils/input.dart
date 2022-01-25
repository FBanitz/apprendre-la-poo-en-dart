import 'dart:io';

class Input{
  /// Pose la question et attend une réponse en String
  static String readText(String question) {
    print(question);
    return stdin.readLineSync() ?? '';
  }

  /// Pose la question et attend une réponse qui sera convertie en int
  static int readInt(String question) {
    int? typedValue;
    do {
      typedValue = int.tryParse(readText(question));
      if (typedValue == null) {
        print("Veuillez saisir un nombre entier valide.");
      }
    } while (typedValue == null);
    return typedValue;
  }

  /// Pose la question et attend une réponse qui sera convertie en double
  static double readDouble(String question) {
    double? typedValue;
    do {
      typedValue = double.tryParse(readText(question));
      if (typedValue == null) {
        print("Veuillez saisir un nombre réel valide.");
      }
    } while (typedValue == null);
    return typedValue;
  }
}
