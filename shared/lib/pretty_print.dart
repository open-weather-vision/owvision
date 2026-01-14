import 'package:shared/logger/logger.dart';
import 'package:string_width/string_width.dart';

class PrettyPrinter {
  static void Function(String) outputFn = logger.info;

  static void output(PrettyPrinterComponent component) {
    List<String> lines = component.render().split("\n");
    for (final line in lines) {
      outputFn(line);
    }
  }

  static int visibleLength(String input) {
    final ansiRegex = RegExp(r'\x1B\[[0-9;]*m');
    final stripped = input.replaceAll(ansiRegex, '');
    return stripped.length;
  }
}

abstract class PrettyPrinterComponent {
  String render();
}

class Text extends PrettyPrinterComponent {
  final String text;

  Text(this.text);

  @override
  String render() {
    return text;
  }
}

extension VisibleWidthExtension on String {
  int get visibleWidth {
    return stringWidth(this);
  }
}

class Box extends PrettyPrinterComponent {
  List<PrettyPrinterComponent> lines;
  int horizontalPad;
  int verticalPad;

  Box(this.lines, {this.verticalPad = 0, this.horizontalPad = 3});

  @override
  String render() {
    List<String> linesRendered = lines.map((l) => l.render()).toList();
    int maxWidth = linesRendered
        .map((l) => l.visibleWidth)
        .reduce((max, l) => l > max ? max : l);
    int width = maxWidth + horizontalPad * 2 + 2;
    String result = "";
    result += "┌${"─" * (width - 2)}┐\n";
    result += "│${" " * (width - 2)}│\n" * verticalPad;
    for (final line in linesRendered) {
      final space = width - line.visibleWidth - 2;
      final spaceLeft = space ~/ 2;
      final spaceRight = space - spaceLeft;
      result += "│${" " * spaceLeft}$line${" " * spaceRight}│\n";
    }
    result += "│${" " * (width - 2)}│\n" * verticalPad;
    result += "└${"─" * (width - 2)}┘";
    return result;
  }
}
