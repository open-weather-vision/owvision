import 'package:injectable/injectable.dart';

import '../models/daemon_config.dart';

@singleton
/// Manages the daemon's `config.json`.
class ConfigService {
  final config = DaemonConfig.fromFileSync();
}
