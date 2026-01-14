import 'dart:math';

import 'package:fixnum/fixnum.dart';
import 'package:recorder/utils/create_daemon_client.dart';
import 'package:shared/grpc/recorder.pbgrpc.dart';
import 'package:shared/logger/logger.dart';

Future<bool> pingDaemon({int maxTries = 10}) async {
  final random = Random();
  final client = createDaemonClient();
  for (int i = 0; i < maxTries; i++) {
    try {
      await client.ping(
        PingMessage(randomId: Int64(random.nextInt(4294967296))),
      );
      return true;
    } catch (e) {
      logger.warning("Failed to ping daemon: $e");
      await Future.delayed(Duration(seconds: 10));
    }
  }
  return false;
}
