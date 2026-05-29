import 'package:shared/pretty_print.dart';
import '../lib/entry.dart';

void main(List<String> arguments) async {
  PrettyPrinter.outputFn = print;
  cliEntry(arguments);
}
