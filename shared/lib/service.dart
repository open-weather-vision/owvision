import 'dart:io';

import 'package:chalkdart/chalkdart.dart';

import 'utils.dart';

class SystemCtlService {
  final String name;

  SystemCtlService(this.name);

  static Future<SystemCtlService?> register({
    required String name,
    required String description,
    List<String> arguments = const ["init", "-t"],
  }) async {
    if (!Platform.isLinux) {
      throw UnsupportedError(
        'Registering service is not supported on ${Platform.operatingSystem}!',
      );
    }

    final user = Platform.environment['USER']!;
    final file = File("${getOwvisionHomeDirectory()}/$name.service");
    final exePath = Platform.resolvedExecutable;
    final argsString = arguments.join(' ');

    // 4. Inhalt der .service Datei definieren
    final serviceContent =
        '''
[Unit]
Description=$description
After=network.target

[Service]
Type=simple
User=$user
WorkingDirectory=/home/$user/.owvision
ExecStart=$exePath $argsString
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
          "⚠️ Already initialized! If you want to reinitialize run ${chalk.italic("owvi reset")} first.",
        );
        return null;
      }
      await runShellCommand('sudo', ['cp', file.path, serviceFilePath]);
      await runShellCommand('sudo', ['systemctl', 'daemon-reload']);
      await runShellCommand('sudo', ['systemctl', 'enable', name]);
      await runShellCommand('sudo', ['systemctl', 'start', name]);

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
    } on FileSystemException {
      print(
        chalk.red(
          '❌ Error: Access denied. Please run using ${chalk.bold("sudo")}.',
        ),
      );
      return null;
    } catch (e) {
      print(chalk.red('❌ Unknown error while starting service: $e'));
      return null;
    }
  }

  Future<void> remove() async {
    await runShellCommand("sudo", ["systemctl", "stop", name]);
    await runShellCommand("sudo", ["systemctl", "disable", name]);
    await runShellCommand("sudo", ["systemctl", "daemon-reload"]);
    await runShellCommand("sudo", ["rm", "/etc/systemd/system/$name.service"]);
  }
}
