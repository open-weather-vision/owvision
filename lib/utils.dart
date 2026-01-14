import 'dart:convert';
import 'dart:io';
import 'package:yaml_edit/yaml_edit.dart';
import 'package:chalkdart/chalk.dart';
import 'package:path/path.dart';

Future<void> runShellCommand(
  String command,
  List<String> options,
  String cwd,
) async {
  final runCommand = await Process.start(
    command,
    options,
    runInShell: true,
    workingDirectory: cwd,
  );
  runCommand.stdout.transform(utf8.decoder).forEach((x) => print(chalk.dim(x)));
  runCommand.stderr.transform(utf8.decoder).forEach((x) => print(chalk.dim(x)));
  await runCommand.exitCode;
}

class DartPackage {
  final String path;
  late final String name;

  DartPackage(this.path) {
    name = basename(path);
  }

  Future<void> updatePubspec(void Function(YamlEditor editor) update) async {
    final file = File("$path/pubspec.yaml");
    if (!await file.exists()) {
      throw FileSystemException(
        'Failed to update pubspec version: File not found (${file.absolute.path})!',
        file.absolute.path,
      );
    }
    final content = await file.readAsString();
    final yamlEditor = YamlEditor(content);

    try {
      update(yamlEditor);
      await file.writeAsString(yamlEditor.toString());
      print('✅ Updated $name/pubspec.yaml');
    } catch (e) {
      print('❌ Failed to update $name/pubspec.yaml: $e');
      rethrow;
    }
  }

  Future<void> setVersion(String version) async {
    await updatePubspec((editor) {
      editor.update(['version'], version);
    });
  }

  Future<void> compile(String binary, String? name) async {
    name = name ?? binary;
    List<String> linuxArchs = ["arm64", "arm", "x64"];
    List<String> winArchs = ["x64"];
    final outFolder = Directory("$path/out/");
    if (await outFolder.exists()) {
      await outFolder.delete(recursive: true);
    }
    await outFolder.create(recursive: true);
    for (final arch in linuxArchs) {
      await runDartCommand([
        "compile",
        "exe",
        "--target-os=linux",
        "--target-arch=$arch",
        "--output=out/${name}_lin$arch",
        "bin/$binary.dart",
      ]);
      print("Created ${name}_lin$arch");
    }

    for (final arch in winArchs) {
      await runDartCommand([
        "compile",
        "exe",
        "--target-os=windows",
        "--target-arch=$arch",
        "--output=out/${name}_win$arch.exe",
        "bin/$binary.dart",
      ]);
      print("Created ${name}_win$arch.exe");
    }
  }

  Future<void> runDerryCommand(String command) async {
    print("ℹ️  Running derry command '$command' ($name)...");
    final runCommand = await Process.start(
      "derry",
      [command],
      runInShell: true,
      workingDirectory: path,
    );
    runCommand.stdout
        .transform(utf8.decoder)
        .forEach((x) => print(chalk.dim(x)));
    runCommand.stderr
        .transform(utf8.decoder)
        .forEach((x) => print(chalk.dim(x)));
    await runCommand.exitCode;
    print("✅ Run derry command '$command' ($name)");
  }

  Future<void> runDartCommand(List<String> options) async {
    print("ℹ️  Running dart command 'dart ${options.join(' ')}' ($name)...");
    final runCommand = await Process.start(
      "dart",
      options,
      runInShell: true,
      workingDirectory: path,
    );
    runCommand.stdout
        .transform(utf8.decoder)
        .forEach((x) => print(chalk.dim(x)));
    runCommand.stderr
        .transform(utf8.decoder)
        .forEach((x) => print(chalk.dim(x)));
    await runCommand.exitCode;
    print("✅ Run dart command 'dart ${options.join(' ')}' ($name)");
  }
}

class NodePackage {
  final String path;
  late final String name;

  NodePackage(this.path) {
    name = basename(path);
  }

  Future<void> updatePackageJson(
    void Function(Map<String, dynamic> json) update,
  ) async {
    final file = File("$path/package.json");
    print("ℹ️  Updating $name/package.json...");
    if (!await file.exists()) {
      throw Exception("package.json not found: ${file.absolute.path}");
    }

    try {
      final content = await file.readAsString();
      final Map<String, dynamic> jsonMap = jsonDecode(content);
      update(jsonMap);
      final encoder = JsonEncoder.withIndent('  ');
      final newContent = encoder.convert(jsonMap);
      await file.writeAsString('$newContent\n');

      print('✅ Updated $name/package.json!');
    } catch (e) {
      print('❌ Error while updating $name/package.json: $e');
      rethrow;
    }
  }

  Future<void> setVersion(String version) async {
    await updatePackageJson((json) {
      json['version'] = version;
    });
  }

  Future<void> installDependencies() async {
    print("ℹ️  Running 'npm install' ($name)...");
    final runCommand = await Process.start(
      "npm",
      ["install"],
      runInShell: true,
      workingDirectory: path,
    );
    runCommand.stdout
        .transform(utf8.decoder)
        .forEach((x) => print(chalk.dim(x)));
    runCommand.stderr
        .transform(utf8.decoder)
        .forEach((x) => print(chalk.dim(x)));
    await runCommand.exitCode;
    print("✅ Run npm install!");
  }

  Future<void> runCommand(String command) async {
    print("ℹ️  Running npm command '$command' ($name)...");
    final runCommand = await Process.start(
      "npm",
      ["run", command],
      runInShell: true,
      workingDirectory: path,
    );
    runCommand.stdout
        .transform(utf8.decoder)
        .forEach((x) => print(chalk.dim(x)));
    runCommand.stderr
        .transform(utf8.decoder)
        .forEach((x) => print(chalk.dim(x)));
    await runCommand.exitCode;
    print("✅ Run npm command '$command' ($name)!");
  }
}
