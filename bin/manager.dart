import 'package:shared/pretty_print.dart';
import 'package:owvision/cli/entry.dart';

void main(List<String> arguments) async {
  PrettyPrinter.outputFn = print;
  cliEntry(arguments);
}
