import 'dart:io';

import 'package:chalkdart/chalkdart.dart';

import 'utils.dart';

class SystemCtlService {
  final String name;

  SystemCtlService(this.name);

  static Future<SystemCtlService> create({
    required String name,
    required String description,
    List<String> wants = const [],
    List<String> after = const [],
    List<String> arguments = const ["init", "-t"],
  }) async {
    if (!Platform.isLinux) {
      throw UnsupportedError(
        'Creating a service is not supported on ${Platform.operatingSystem}!',
      );
    }

    final user = Platform.environment['USER']!;
    final file = File("${getOwvisionHomeDirectory()}/$name.service");

    // 4. Inhalt der .service Datei definieren
    final serviceContent =
        '''
[Unit]
Description=$description
After=network.target
${wants.map((entry) => "Wants=$entry").join("\n")}
${after.map((entry) => "After=$entry").join("\n")}

[Service]
Type=simple
User=$user
WorkingDirectory=/home/$user/.owvision
ExecStart=${Platform.resolvedExecutable} ${arguments.join(' ')}
Restart=always
RestartSec=5
StandardOutput=journal
StandardError=journal

[Install]
WantedBy=multi-user.target
''';

    try {
      await file.writeAsString(serviceContent);
      final serviceFilePath = '/etc/systemd/system/$name.service';
      if (await File(serviceFilePath).exists()) {
        chalk.yellow(
          "⚠️ Already initialized! If you want to reinitialize run ${chalk.italic("reset")} first.",
        );
        return SystemCtlService(name);
      }
      await runShellCommand('sudo', [
        'cp',
        file.path,
        serviceFilePath,
      ], onCommandFail: FailAction.throwException);
      await runShellCommand('sudo', [
        'systemctl',
        'daemon-reload',
      ], onCommandFail: FailAction.throwException);
      await runShellCommand('sudo', [
        'systemctl',
        'enable',
        name,
      ], onCommandFail: FailAction.throwException);
      await runShellCommand('sudo', [
        'systemctl',
        'start',
        name,
      ], onCommandFail: FailAction.throwException);

      print(
        chalk.green.bold(
          '🚀 Registered and started service "$name" successfully!',
        ),
      );
      print(
        chalk.italic(
          '👉 Check status using: ${chalk.bold("systemctl status $name")}',
        ),
      );
      return SystemCtlService(name);
    } catch (e) {
      print(chalk.red('❌ Error: Failed to create service: $e'));
      exit(1);
    }
  }

  Future<bool> isActive() async {
    return await runShellCommand(
          "systemctl",
          ["is-active", name],
          forwardOutput: false,
          onCommandFail: FailAction.silent,
        ) ==
        0;
  }

  Future<bool> stop() async {
    final res = await runShellCommand(
      "sudo",
      ["systemctl", "stop", name],
      cwd: ".",
      onCommandFail: FailAction.silent,
    );
    return res == 0;
  }

  Future<bool> restart() async {
    final res = await runShellCommand(
      "sudo",
      ["systemctl", "restart", name],
      cwd: ".",
      onCommandFail: FailAction.silent,
    );
    return res == 0;
  }

  Future<String?> getExecutablePath() async {
    final result = await Process.run('systemctl', [
      'show',
      '-p',
      'ExecStart',
      name,
    ]);
    if (result.exitCode != 0) {
      return null;
    }
    final output = result.stdout.toString().trim();
    final regExp = RegExp(r'path=([^;\s]+)');
    final match = regExp.firstMatch(output);
    return match?.group(1);
  }

  Future<bool> start() async {
    final res = await runShellCommand(
      "sudo",
      ["systemctl", "start", name],
      cwd: ".",
      forwardOutput: false,
      onCommandFail: FailAction.silent,
    );
    return res == 0;
  }

  Future<bool> remove() async {
    try {
      await runShellCommand("sudo", [
        "systemctl",
        "stop",
        name,
      ], onCommandFail: FailAction.throwException);
      await runShellCommand("sudo", [
        "systemctl",
        "disable",
        name,
      ], onCommandFail: FailAction.throwException);
      await runShellCommand("sudo", [
        "systemctl",
        "daemon-reload",
      ], onCommandFail: FailAction.throwException);
      await runShellCommand("sudo", [
        "rm",
        "/etc/systemd/system/$name.service",
      ], onCommandFail: FailAction.throwException);
      return true;
    } catch (err) {
      print(
        chalk.yellow("⚠️ Failed to remove service ${chalk.bold(name)}: $err"),
      );
      return false;
    }
  }
}
