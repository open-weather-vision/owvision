import 'package:chalkdart/chalk.dart';
import 'package:logging/logging.dart';

final logger = Logger.root
  ..onRecord.listen((record) {
    Chalk messagePen;
    Chalk levelPen;

    Chalk basePen;
    // Farbe basierend auf Level wählen
    if (record.level >= Level.SEVERE) {
      basePen = chalk.red;
    } else if (record.level >= Level.WARNING) {
      basePen = chalk.yellow;
    } else {
      basePen = chalk.green;
    }

    messagePen = basePen;
    levelPen = basePen.bold;

    // Den farbigen Log ausgeben
    print(
      "${levelPen("[${record.level}]")} ${chalk.gray.italic(record.time)}: ${messagePen(record.message)}",
    );
  });
