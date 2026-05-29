import 'dart:io';

import 'daemon_rest_client_emitter.dart';
import 'recorder_support_packages_emitter.dart';
import 'package:chalkdart/chalk.dart';
import 'utils.dart';
import 'package:shared/pretty_print.dart';

/// Responsible for building and compiling all owvision components and syncing their versions. Used in the manager.py development cli and the CI workflow.
class WorkspaceBuilder {
  /// Builds all owvision components. Their version is set to the passed version.
  Future<void> build(String version) async {
    PrettyPrinter.output(
      Box([Text(chalk.green.bold("Syncing workspace packages..."))]),
    );

    // Change the workspaces packages version and run their build command
    final workspacePackage = DartPackage(".");
    final sharedPackage = DartPackage("./shared");
    final daemonPackage = DartPackage("./daemon");
    final recorderPackage = DartPackage("./recorder");
    final dashboardPackage = DartPackage("./dashboard");
    final builderPackage = DartPackage("./builder");

    await workspacePackage.setVersion(version);
    await sharedPackage.setVersion(version);
    await daemonPackage.setVersion(version);
    await recorderPackage.setVersion(version);
    await dashboardPackage.setVersion(version);
    await builderPackage.setVersion(version);

    await sharedPackage.runDerryCommand("build");
    await daemonPackage.runDerryCommand("build");
    await recorderPackage.runDerryCommand("build");

    // Emitting the daemon's generated clients
    await _updateRestApiSpecificationVersion(version);
    await DaemonRESTClientEmitter().emit(version);

    // Emitting the recorder's support packages
    await RecorderSupportPackagesEmitter().emit(version);

    print(chalk.green.bold("✅ Finished building version $version!"));
  }

  // Compiles all owvision binaries and outputs them to the build folder.
  Future<void> compile() async {
    print(chalk.green.bold("Compiling..."));
    final daemonPackage = DartPackage("./daemon");
    final recorderPackage = DartPackage("./recorder");
    await daemonPackage.compile("daemon", "owvi");
    print("✅ Compiled daemon (owvi)");
    await recorderPackage.compile("recorder", "owrec");
    print("✅ Compiled recorder (owrec)");
  }

  Future<void> clean() async {
    print(chalk.green.bold("Cleaning build files..."));
    final daemonPackage = DartPackage("./daemon");
    final recorderPackage = DartPackage("./recorder");
    final sharedPackage = DartPackage("./shared");
    await sharedPackage.runDerryCommand("clean");
    await daemonPackage.runDerryCommand("clean");
    await recorderPackage.runDerryCommand("clean");
    print(chalk.green.bold("✅ Finished cleaning!"));
  }

  Future<void> _updateRestApiSpecificationVersion(String version) async {
    final content = await File(
      "$daemonPath/specification/main.tsp",
    ).readAsString();
    await File("$daemonPath/specification/main.tsp").writeAsString(
      content.replaceFirst(RegExp(r'v1: "(.*)"'), "v1: \"$version\""),
    );
    print('✅ Updated specification version');
  }
}
