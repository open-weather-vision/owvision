import 'dart:io';

import 'package:chalkdart/chalkdart.dart';
import 'package:shared/pretty_print.dart';
import 'package:owvision/utils.dart';

final daemonPath = File("./daemon").resolveSymbolicLinksSync();

class DaemonClientManager {
  /// Updates all daemon clients to fit the current REST API specification and sets their version to the passed value.
  Future<void> update(String version) async {
    final dir = Directory('$daemonPath/clients');
    if (await dir.exists()) {
      await Directory('$daemonPath/clients').delete(recursive: true);
    }
    await _compileTypespec();
    await _generateDartClient(version);
  }

  Future<void> _compileTypespec() async {
    PrettyPrinter.output(
      Box([Text(chalk.green.bold("Compiling typespec file..."))]),
    );
    final specification = NodePackage("$daemonPath/specification");
    await specification.installDependencies();
    await runShellCommand("npm", [
      "install",
      "-g",
      "@typespec/compiler",
    ], "$daemonPath/specification");
    await specification.runCommand("build");
  }

  Future<void> _generateDartClient(String version) async {
    PrettyPrinter.output(
      Box([Text(chalk.green.bold("Generating dart-dio client"))]),
    );
    await runShellCommand("npm", [
      "install",
      "-g",
      "@openapitools/openapi-generator-cli",
    ], "$daemonPath/specification");
    await runShellCommand("openapi-generator-cli", [
      "generate",
      "-i",
      "specification.yaml",
      "-g",
      "dart-dio",
      "-o",
      "../clients/daemon_client_dart",
      "--additional-properties=pubHomepage=https://open-weather-vision.github.io/owvision/,pubLibrary=daemonclient,pubName=owvision_daemon_client_dart,pubVersion=$version,serializationLibrary=json_serializable",
    ], "$daemonPath/specification");

    final generatedDartCient = DartPackage(
      "$daemonPath/clients/daemon_client_dart",
    );

    await generatedDartCient.updatePubspec((yaml) {
      yaml.update(["environment", "sdk"], "^3.9.2");
      yaml.update(['resolution'], "workspace");
    });

    await generatedDartCient.runDartCommand([
      "pub",
      "upgrade",
      "--major-versions",
    ]);

    await generatedDartCient.runDartCommand(["run", "build_runner", "build"]);
  }
}
