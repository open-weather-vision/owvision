/// This installer downloads, installs, and updates the `owvi` background service.
/// It detects the target operating system (Windows or Linux), downloads the appropriate
/// pre-compiled binary from GitHub Releases, registers the `ow_daemon` service,
/// and adds the `.owvision` folder to the system's `PATH`.
///
/// Basic usage:
/// ```sh
/// dart run bin/installer.dart [--target 0.0.2]
/// ```
import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:chalkdart/chalkdart.dart';
import 'package:interact/interact.dart';
import 'package:shared/one_line_output.dart';
import 'package:shared/service.dart';
import 'package:shared/utils.dart';

const repoOwner = 'open-weather-vision';
const repoName = 'owvision';
const serviceName = 'ow_daemon';

/// Main entry point for the installer.
///
/// Steps executed:
/// 1. Ensures administrative privileges (on Windows).
/// 2. Parses arguments to determine the update target.
/// 3. Communicates with GitHub API to get release tags.
/// 4. Checks the existing local version against the remote one.
/// 5. Upgrades or installs the requested binary.
Future<void> main(List<String> args) async {
  await requireAdminOnWindows();

  final parser = ArgParser()
    ..addOption(
      'target',
      help:
          'Target version to install (e.g., v0.0.2). If omitted, latest is fetched.',
    )
    ..addFlag(
      'prerelease',
      help: 'Allow installing the latest prerelease.',
      negatable: false,
    )
    ..addFlag('help', abbr: 'h', negatable: false);

  final argResults = parser.parse(args);
  if (argResults['help']) {
    print(parser.usage);
    exit(0);
  }

  set_line('Fetching latest release...');
  String? targetVersion = argResults['target'];
  bool usePrerelease = argResults['prerelease'];

  String apiUrl = targetVersion != null
      ? 'https://api.github.com/repos/$repoOwner/$repoName/releases/tags/$targetVersion'
      : (usePrerelease
            ? 'https://api.github.com/repos/$repoOwner/$repoName/releases'
            : 'https://api.github.com/repos/$repoOwner/$repoName/releases/latest');

  final client = HttpClient();
  final request = await client.getUrl(Uri.parse(apiUrl));
  request.headers.add('User-Agent', 'owvision-installer');
  final response = await request.close();

  if (response.statusCode != 200) {
    set_line(
      chalk.red(
        'Failed to fetch release information. Status code: ${response.statusCode}',
      ),
    );
    exit(1);
  }

  final responseBody = await response.transform(utf8.decoder).join();
  final decoded = jsonDecode(responseBody);
  final Map<String, dynamic> releaseData = (decoded is List)
      ? decoded.first
      : decoded;

  final String releaseTag = releaseData['tag_name'].toString();
  final String releaseVersion = releaseTag.replaceFirst('v', '');

  final homeDir = getOwvisionHomeDirectory();
  final installDir = Directory(homeDir);

  String binaryName = 'owvi';
  String downloadName = 'owvi_linx64';

  if (Platform.isWindows) {
    binaryName = 'owvi.exe';
    downloadName = 'owvi_winx64.exe';
  } else if (Platform.isLinux) {
    binaryName = 'owvi';
    final arch = Platform.version.contains('arm') ? 'linarm64' : 'linx64';
    downloadName = 'owvi_$arch';
  } else {
    set_line(chalk.red('Unsupported OS!'));
    exit(1);
  }

  final binaryPath = '$homeDir${Platform.pathSeparator}$binaryName';
  final binaryFile = File(binaryPath);

  String? currentVersion;
  if (binaryFile.existsSync()) {
    try {
      final versionResult = await Process.run(binaryPath, ['--version']);
      if (versionResult.exitCode == 0) {
        currentVersion = versionResult.stdout.toString().trim();
      } else {
        currentVersion = "unknown";
      }
    } catch (e) {
      currentVersion = "unknown";
    }
  }

  if (currentVersion == null) {
    set_line('owvi is not installed yet, creating application folder...');
    if (!installDir.existsSync()) {
      installDir.createSync(recursive: true);
    }
    await installBinary(
      client,
      downloadName,
      binaryFile,
      releaseTag,
      releaseVersion,
    );
    await ensureInPath(homeDir, binaryPath, binaryName);

    set_line('Initializing owvi...');
    await runShellCommand(
      binaryPath,
      ['init'],
      interactive: true,
      onCommandFail: FailAction.exit,
    );
    clear_all();
    set_line(chalk.green('✅ Installed owvi@$releaseVersion!'));
  } else {
    set_line(
      'owvi@$currentVersion is currently installed, latest release is owvi@$releaseVersion.',
    );

    if (currentVersion == releaseVersion && targetVersion == null) {
      // Ensure path is set even if up to date, just in case user missed it before
      await ensureInPath(homeDir, binaryPath, binaryName);
      set_line(chalk.green('✅ owvi is up to date!'));
      exit(0);
    }

    final upgradeConf = Confirm(
      prompt: 'Do you want to upgrade?',
      defaultValue: true,
    ).interact();

    if (!upgradeConf) {
      set_line(chalk.yellow('Upgrade aborted.'));
      exit(0);
    }

    await installBinary(
      client,
      downloadName,
      binaryFile,
      releaseTag,
      releaseVersion,
    );
    await ensureInPath(homeDir, binaryPath, binaryName);
    set_line(chalk.green('✅ Upgraded owvi to version $releaseVersion!'));
  }
}

/// Ensures that the installation directory is available globally in the shell environment.
///
/// On Windows, it modifies the User `PATH` environment variable permanently.
/// On Linux, it creates a fast symbolic link into `/usr/local/bin`.
Future<void> ensureInPath(
  String homeDir,
  String binaryPath,
  String binaryName,
) async {
  if (Platform.isWindows) {
    try {
      final getPathResult = await Process.run('powershell', [
        '-NoProfile',
        '-Command',
        '[Environment]::GetEnvironmentVariable("Path", "User")',
      ]);
      final currentPath = getPathResult.stdout.toString().trim();

      if (!currentPath.split(';').contains(homeDir)) {
        set_line(chalk.dim('Adding $homeDir to your User PATH...'));
        final newPath = currentPath.isEmpty ? homeDir : '$currentPath;$homeDir';
        await Process.run('powershell', [
          '-NoProfile',
          '-Command',
          '[Environment]::SetEnvironmentVariable("Path", "$newPath", "User")',
        ]);
        set_line(
          chalk.yellow(
            '⚠️  Please restart your terminal to apply the PATH changes!',
          ),
        );
      }
    } catch (e) {
      set_line(
        chalk.yellow(
          '⚠️  Could not update User PATH automatically. Please add $homeDir to your PATH.',
        ),
      );
    }
  } else if (Platform.isLinux) {
    final linkPath = '/usr/local/bin/$binaryName';
    try {
      set_line(chalk.dim('Symlinking $binaryName to $linkPath...'));
      await runShellCommand(
        'sudo',
        ['ln', '-sf', binaryPath, linkPath],
        onCommandFail: FailAction.logWarning,
        forwardOutput: false,
      );
    } catch (e) {
      set_line(
        chalk.yellow(
          '⚠️  Failed to create symlink. You might need to add $homeDir to your PATH manually.',
        ),
      );
    }
  }
}

/// Downloads the binary from the GitHub release and writes it to the local machine.
///
/// Ensures minimal downtime by:
/// 1. Stopping the background service first via NSSM / Systemd.
/// 2. Downloading into a `.tmp` file to prevent corrupted binaries from network failures.
/// 3. Backing up the old binary into `.bak`.
/// 4. Validating Linux `+x` execution permissions.
/// 5. Restarting the background service automatically.
Future<void> installBinary(
  HttpClient client,
  String downloadName,
  File binaryFile,
  String releaseTag,
  String releaseVersion,
) async {
  String downloadUrl =
      'https://github.com/$repoOwner/$repoName/releases/download/$releaseTag/$downloadName';
  set_line('Downloading owvi@$releaseVersion...');

  final service = BackgroundService(serviceName);
  var serviceRestartRequired = false;

  if (binaryFile.existsSync()) {
    if (await service.isActive()) {
      set_line('Stopping background service for upgrade...');
      serviceRestartRequired = await service.stop(silent: true);
    }
  }

  try {
    set_line('Moving binary to installation folder...');
    final fileRequest = await client.getUrl(Uri.parse(downloadUrl));
    final fileResponse = await fileRequest.close();

    if (fileResponse.statusCode != 200 && fileResponse.statusCode != 302) {
      set_line(chalk.red('Failed to download binary from $downloadUrl'));
      exit(1);
    }

    final tempPath = '${binaryFile.path}.tmp';
    final tempFile = File(tempPath);
    await fileResponse.pipe(tempFile.openWrite());

    if (binaryFile.existsSync()) {
      final backupPath = '${binaryFile.path}.bak';
      final backupFile = File(backupPath);
      if (backupFile.existsSync()) backupFile.deleteSync();
      binaryFile.renameSync(backupPath);
    }

    tempFile.renameSync(binaryFile.path);

    if (Platform.isLinux || Platform.isMacOS) {
      await Process.run('chmod', ['+x', binaryFile.path]);
    }
  } catch (e) {
    set_line(chalk.red('Failed to install! $e'));
    exit(1);
  }

  if (serviceRestartRequired) {
    set_line('Starting owvi...');
    await service.start(silent: true);
  }
}
