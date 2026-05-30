import 'dart:io';

import 'package:chalkdart/chalkdart.dart';

import 'utils.dart';

class BackgroundService {
  final String name;

  BackgroundService(this.name);

  static Future<BackgroundService> create({
    required String name,
    required String description,
    List<String> wants = const [],
    List<String> after = const [],
    List<String> arguments = const ["init", "-t"],
    String? executablePath,
  }) async {
    if (Platform.isWindows) {
      return await _createWindows(
        name: name,
        description: description,
        wants: wants,
        after: after,
        arguments: arguments,
        executablePath: executablePath ?? Platform.resolvedExecutable,
      );
    } else if (Platform.isLinux) {
      return await _createLinux(
        name: name,
        description: description,
        wants: wants,
        after: after,
        arguments: arguments,
        executablePath: executablePath ?? Platform.resolvedExecutable,
      );
    } else {
      throw UnsupportedError(
        'Creating a service is not supported on ${Platform.operatingSystem}!',
      );
    }
  }

  static Future<BackgroundService> _createWindows({
    required String name,
    required String description,
    required List<String> wants,
    required List<String> after,
    required List<String> arguments,
    required String executablePath,
  }) async {
    try {
      await tryToInstallCommandUsingWinget(
        "nssm",
        "NSSM.NSSM",
        checkIfExists: true,
      );

      final checkExists = await runShellCommand(
        "nssm",
        ["status", name],
        forwardOutput: false,
        onCommandFail: FailAction.silent,
        preferWindowsPowerShell: true,
      );
      if (checkExists == 0) {
        print(
          chalk.yellow(
            "⚠️ Already initialized! If you want to reinitialize run ${chalk.italic("reset")} first.",
          ),
        );
        return BackgroundService(name);
      }

      await runShellCommand(
        "nssm",
        ["install", name, executablePath, ...arguments],
        onCommandFail: FailAction.throwException,
        preferWindowsPowerShell: true,
      );
      await runShellCommand(
        "nssm",
        ["set", name, "Description", description],
        onCommandFail: FailAction.throwException,
        preferWindowsPowerShell: true,
      );

      final String owvisionHome = getOwvisionHomeDirectory();
      await runShellCommand(
        "nssm",
        ["set", name, "AppDirectory", owvisionHome],
        onCommandFail: FailAction.throwException,
        preferWindowsPowerShell: true,
      );
      await runShellCommand(
        "nssm",
        ["set", name, "AppStdout", "$owvisionHome\\$name.log"],
        onCommandFail: FailAction.throwException,
        preferWindowsPowerShell: true,
      );
      await runShellCommand(
        "nssm",
        ["set", name, "AppStderr", "$owvisionHome\\$name-error.log"],
        onCommandFail: FailAction.throwException,
        preferWindowsPowerShell: true,
      );

      final deps = {...wants, ...after}
          .where((s) => s.isNotEmpty)
          .map((s) => s.replaceAll(".service", ""))
          .toSet();
      if (deps.isNotEmpty) {
        await runShellCommand(
          'nssm',
          ['set', name, 'DependOnService', ...deps],
          preferWindowsPowerShell: true,
          onCommandFail: FailAction.logWarning,
        );
      }

      await runShellCommand(
        "nssm",
        ["start", name],
        onCommandFail: FailAction.throwException,
        preferWindowsPowerShell: true,
      );

      print(
        chalk.green.bold(
          '✅ Registered and started service "$name" successfully!',
        ),
      );
      print(
        chalk.italic(
          '✅ Check status using: ${chalk.bold("nssm status $name")}',
        ),
      );
      return BackgroundService(name);
    } catch (e) {
      print(chalk.red('❌ Error: Failed to create Windows service: $e'));
      exit(1);
    }
  }

  static Future<BackgroundService> _createLinux({
    required String name,
    required String description,
    required List<String> wants,
    required List<String> after,
    required List<String> arguments,
    required String executablePath,
  }) async {
    final user = Platform.environment['USER']!;
    final file = File("${getOwvisionHomeDirectory()}/$name.service");

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
ExecStart=$executablePath ${arguments.join(' ')}
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
        print(
          chalk.yellow(
            "⚠️  Already initialized! If you want to reinitialize run ${chalk.italic("reset")} first.",
          ),
        );
        return BackgroundService(name);
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
          '✅ Registered and started service "$name" successfully!',
        ),
      );
      print(
        chalk.italic(
          '✅ Check status using: ${chalk.bold("systemctl status $name")}',
        ),
      );
      return BackgroundService(name);
    } catch (e) {
      print(chalk.red('❌ Error: Failed to create service: $e'));
      exit(1);
    }
  }

  Future<bool> isActive() async {
    if (Platform.isWindows) {
      return await runShellCommand(
            "nssm",
            ["status", name],
            forwardOutput: false,
            onCommandFail: FailAction.silent,
            preferWindowsPowerShell: true,
          ) ==
          0;
    }
    return await runShellCommand(
          "systemctl",
          ["is-active", name],
          forwardOutput: false,
          onCommandFail: FailAction.silent,
        ) ==
        0;
  }

  Future<bool> stop({bool silent = false}) async {
    if (Platform.isWindows) {
      return await runShellCommand(
            "nssm",
            ["stop", name],
            onCommandFail: silent
                ? FailAction.silent
                : FailAction.throwException,
            preferWindowsPowerShell: true,
            forwardOutput: !silent,
          ) ==
          0;
    }
    final res = await runShellCommand(
      "sudo",
      ["systemctl", "stop", name],
      cwd: ".",
      onCommandFail: silent ? FailAction.silent : FailAction.throwException,
      forwardOutput: !silent,
    );
    return res == 0;
  }

  Future<bool> restart({bool silent = false}) async {
    if (Platform.isWindows) {
      return await runShellCommand(
            "nssm",
            ["restart", name],
            onCommandFail: silent
                ? FailAction.silent
                : FailAction.throwException,
            preferWindowsPowerShell: true,
            forwardOutput: !silent,
          ) ==
          0;
    }
    final res = await runShellCommand(
      "sudo",
      ["systemctl", "restart", name],
      cwd: ".",
      onCommandFail: silent ? FailAction.silent : FailAction.throwException,
      forwardOutput: !silent,
    );
    return res == 0;
  }

  Future<String?> getExecutablePath() async {
    if (Platform.isWindows) return null;
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

  Future<bool> start({bool silent = false}) async {
    if (Platform.isWindows) {
      return await runShellCommand(
            "nssm",
            ["start", name],
            onCommandFail: silent
                ? FailAction.silent
                : FailAction.throwException,
            preferWindowsPowerShell: true,
            forwardOutput: !silent,
          ) ==
          0;
    }
    final res = await runShellCommand(
      "sudo",
      ["systemctl", "start", name],
      cwd: ".",
      forwardOutput: !silent,
      onCommandFail: silent ? FailAction.silent : FailAction.throwException,
    );
    return res == 0;
  }

  Future<bool> remove({bool silent = false}) async {
    if (!await isActive()) {
      print(
        chalk.yellow(
          "⚠️  Service ${chalk.bold(name)} is not installed. Skipping removal.",
        ),
      );
      return true;
    }

    if (Platform.isWindows) {
      try {
        await runShellCommand(
          "nssm",
          ["stop", name],
          onCommandFail: silent ? FailAction.silent : FailAction.throwException,
          preferWindowsPowerShell: true,
          forwardOutput: !silent,
        );
        await runShellCommand(
          "nssm",
          ["remove", name, "confirm"],
          onCommandFail: silent ? FailAction.silent : FailAction.throwException,
          preferWindowsPowerShell: true,
          forwardOutput: !silent,
        );
        return true;
      } catch (err) {
        print(
          chalk.yellow(
            "⚠️  Failed to remove service ${chalk.bold(name)}: $err",
          ),
        );
        return false;
      }
    } else if (Platform.isLinux) {
      try {
        await runShellCommand(
          "sudo",
          ["systemctl", "stop", name],
          onCommandFail: silent ? FailAction.silent : FailAction.throwException,
          forwardOutput: !silent,
        );
        await runShellCommand(
          "sudo",
          ["systemctl", "disable", name],
          onCommandFail: silent ? FailAction.silent : FailAction.throwException,
          forwardOutput: !silent,
        );
        await runShellCommand(
          "sudo",
          ["systemctl", "daemon-reload"],
          onCommandFail: silent ? FailAction.silent : FailAction.throwException,
          forwardOutput: !silent,
        );
        await runShellCommand(
          "sudo",
          ["rm", "/etc/systemd/system/$name.service"],
          onCommandFail: silent ? FailAction.silent : FailAction.throwException,
          forwardOutput: !silent,
        );
        return true;
      } catch (err) {
        print(
          chalk.yellow(
            "⚠️  Failed to remove service ${chalk.bold(name)}: $err",
          ),
        );
        return false;
      }
    }
    return false;
  }
}
