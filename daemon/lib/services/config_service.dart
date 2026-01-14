import 'package:injectable/injectable.dart';
import 'package:shared/models/daemon_config.dart';

@singleton
/// Manages the daemon's `config.json`.
class ConfigService {
  final config = DaemonConfig.fromFileSync();
}
