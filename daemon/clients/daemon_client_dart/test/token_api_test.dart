import 'package:test/test.dart';
import 'package:owvision_daemon_client_dart/owvision_daemon_client_dart.dart';


/// tests for TokenApi
void main() {
  final instance = OwvisionDaemonClientDart().getTokenApi();

  group(TokenApi, () {
    // Generates a new token. Only succeeds if you are authenticated using an admin token, or once using the init token `%12345678%`.
    //
    //Future<String> tokensGenerate(TokenRole role) async
    test('test tokensGenerate', () async {
      // TODO
    });

  });
}
