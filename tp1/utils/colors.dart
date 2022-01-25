// https://en.wikipedia.org/wiki/ANSI_escape_code#3-bit_and_4-bit

// for testing purposes
void main() {
  print(Color.text('Text', foreground: colors.black.index, background: 40,));
}

enum colors {
  black,
  red,
  green,
  yellow,
  blue,
  magenta,
  cyan,
  white,
  brightBlack,
  brightRed,
  brightGreen,
  brightYellow,
  brightBlue,
  brightMagenta,
  brightCyan,
  brightWhite,
}

class Color{
  /// transforme le texte pour lui donner la couleur et la mis en forme demandée dans le terminal
  static String text(String text,{ int foreground = 0, int background = 0, bool bold = false, bool italic = false , bool underline = false,}) {
    final String ansi = '\x1b[';
    final String reset = ansi +'0m';
    final String foregroundString = ansi+'38;5;${foreground}m';
    final String backgroundString = background == 0 ? '' : ansi+'48;5;${background}m';
    String boldString = bold ? ansi+'1m' : '';
    String italicString = italic ? ansi+'3m' : '';
    String underlineString = underline ? ansi+'4m' : '';
    return foregroundString + backgroundString + boldString + italicString + underlineString + text + reset;
  }
}