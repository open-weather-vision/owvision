import 'dart:io';

import 'daemon_client_manager.dart';
import 'recorder_support_packages_manager.dart';
import 'package:chalkdart/chalk.dart';
import 'utils.dart';
import 'package:shared/pretty_print.dart';

class WorkspaceManager {
  Future<void> update(String version) async {
    PrettyPrinter.output(
      Box([Text(chalk.green.bold("Syncing workspace packages..."))]),
    );

    // Change the workspaces packages version and run their build command
    final workspacePackage = DartPackage(".");
    final sharedPackage = DartPackage("./shared");
    final daemonPackage = DartPackage("./daemon");
    final recorderPackage = DartPackage("./recorder");

    await workspacePackage.setVersion(version);
    await sharedPackage.setVersion(version);
    await daemonPackage.setVersion(version);
    await recorderPackage.setVersion(version);

    await sharedPackage.runDerryCommand("build");
    await daemonPackage.runDerryCommand("build");
    await recorderPackage.runDerryCommand("build");

    // Building the daemon's generated clients
    await _updateRestApiSpecificationVersion(version);
    await DaemonClientManager().update(version);

    // Updating the recorder's support packages
    await RecorderSupportPackagesManager().update(version);

    print(chalk.green.bold("✅ Finished building version $version!"));
  }

  Future<void> compile() async {
    print(chalk.green.bold("Compiling..."));
    final daemonPackage = DartPackage("./daemon");
    final recorderPackage = DartPackage("./recorder");
    await daemonPackage.compile("daemon", "owvi");
    print("✅ Compiled daemon (owvi)");
    await recorderPackage.compile("recorder", "owrec");
    print("✅ Compiled recorder (owrec)");
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
