import 'package:grpc/grpc.dart';
import 'package:recorder/cli/entry.dart';
import 'package:shared/grpc/recorder.pbgrpc.dart';
import 'package:shared/logger/logger.dart';

DaemonServiceClient createDaemonClient() {
  final channel = ClientChannel(
    recorderConfig.daemonGrpcHost,
    port: recorderConfig.daemonGrpcPort,
    options: ChannelOptions(
      credentials: ChannelCredentials.secure(
        onBadCertificate: (certificate, host) {
          logger.warning(
            "Daemon certificate is self signed and couldn't be verified. Current recorderConfiguration ${recorderConfig.trustSelfSignedCertificate ? "allows this. Continuing!" : "forbids this. Cancelling!"}",
          );
          return recorderConfig.trustSelfSignedCertificate;
        },
      ),
    ),
  );
  return DaemonServiceClient(
    channel,
    options: CallOptions(
      metadata: {'authorization': 'Bearer ${recorderConfig.daemonGrpcToken}'},
    ),
  );
}
