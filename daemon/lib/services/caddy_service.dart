import 'package:chalkdart/chalk.dart';
import 'package:daemon/services/config_service.dart';
import 'package:shared/pretty_print.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/logger/logger.dart';

@singleton
/// Responsible for configuring `caddy` to forward https requests to http via reverse proxies.
class CaddyService {
  final ConfigService _configService;
  final dio = Dio(
    BaseOptions(
      baseUrl: 'http://127.0.0.1:2019',
      connectTimeout: Duration(seconds: 5),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  CaddyService(this._configService);

  /// Configures `caddy`.
  void tryToConfigure() async {
    final caddyConfig = _configService.config.generateCaddyConfig();
    var configured = false;
    while (!configured) {
      try {
        final response = await dio.post("/load", data: caddyConfig);

        if (response.statusCode == 200) {
          logger.info("Successfully configured caddy!");
          PrettyPrinter.output(
            Box([
              Text(
                "${chalk.underline("grpc")}: ${chalk.italic("${_configService.config.publicHostName}:${_configService.config.grpcPublicPort}")}",
              ),
              Text(
                "${chalk.underline("rest")}: ${chalk.italic("${_configService.config.publicHostName}:${_configService.config.restApiPublicPort}")}",
              ),
            ]),
          );
          configured = true;
        }
      } on DioException catch (e) {
        logger.severe("Failed to configure caddy: $e");
        logger.info("Trying again in 15 seconds...");
        await Future.delayed(Duration(seconds: 15));
      }
    }
  }
}
