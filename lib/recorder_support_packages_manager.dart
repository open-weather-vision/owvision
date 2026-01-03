import 'package:owvision/utils.dart';

class RecorderSupportPackagesManager {
  /// Updates all recorder support packages to the current proto defintion.
  Future<void> update(String version) async {
    final nodeSupportPackage = NodePackage(
      "./recorder/support-packages/station-interface-ts",
    );
    await nodeSupportPackage.installDependencies();
    await nodeSupportPackage.setVersion(version);
    await nodeSupportPackage.runCommand("update");
  }
}
