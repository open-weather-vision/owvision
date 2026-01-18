import 'dart:io';

import 'package:owvision/utils.dart';
import 'package:shared/units/convert.dart';
import 'package:shared/models/sensor.dart';

class RecorderSupportPackagesManager {
  /// Updates all recorder support packages to the current proto defintion.
  Future<void> update(String version) async {
    final nodeSupportPackage = NodePackage(
      "./recorder/support-packages/station-interface-ts",
    );
    await nodeSupportPackage.installDependencies();
    await nodeSupportPackage.setVersion(version);
    await _updateUnitIds(nodeSupportPackage);
    await _updateSensorElements(nodeSupportPackage);
    await nodeSupportPackage.runCommand("update");
  }
}

Future<void> _updateUnitIds(NodePackage nodeSupportPackage) async {
  String result =
      "// Generated content - do not change\nexport enum UnitId {\n";
  for (final unit in Unit.units.values) {
    result += '    ${unit.group}_${unit.id} = "${unit.id}",\n';
  }
  result += "}\n";
  await File("${nodeSupportPackage.path}/src/unit_id.ts").writeAsString(result);
  print("✅ Updated unit ids (${nodeSupportPackage.name})");
}

Future<void> _updateSensorElements(NodePackage nodeSupportPackage) async {
  String result =
      "// Generated content - do not change\nexport enum SensorElement {\n";
  for (final element in SensorElement.values) {
    result += '    ${element.name} = "${element.name}",\n';
  }
  result += "}\n";
  await File(
    "${nodeSupportPackage.path}/src/sensor_element.ts",
  ).writeAsString(result);
  print("✅ Updated sensor elements (${nodeSupportPackage.name})");
}
