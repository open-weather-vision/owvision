import 'dart:io';

import 'package:daemon/middlewares/authentification.dart';
import 'package:daemon/middlewares/default_headers.dart';
import 'package:daemon/routers/app_router.dart';
import 'package:daemon/services/config_service.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/logger/logger.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_limiter/shelf_limiter.dart';

@singleton
/// Manages the daemon's rest api.
class RestApiService {
  final AppRouter _router;
  final ConfigService _configService;

  RestApiService(this._router, this._configService);

  /// Starts the server on the configured port.
  Future<void> start() async {
    final handler = Pipeline()
        .addMiddleware(logRequests())
        .addMiddleware(
          shelfLimiter(
            RateLimiterOptions(
              maxRequests: 15,
              windowSize: const Duration(minutes: 1),
              onRateLimitExceeded: (request) {
                logger.warning("Blocked user because of too many requests!");

                return Response(
                  429,
                  body: "Too many requests, please try again later.",
                );
              },
            ),
          ),
        )
        .addMiddleware(defaultHeaders())
        .addMiddleware(authMiddleware(disabled: false))
        .addHandler(_router.router);

    final server = await io.serve(
      handler,
      InternetAddress.loopbackIPv4,
      _configService.config.restApiLocalPort,
    );
    logger.info("REST API running on http://127.0.0.1:${server.port}");
  }
}
