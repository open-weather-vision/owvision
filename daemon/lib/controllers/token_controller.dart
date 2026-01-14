import 'dart:convert';

import 'package:daemon/services/config_service.dart';
import 'package:daemon/services/token_service.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/logger/logger.dart';
import 'package:shared/models/error_response.dart';
import 'package:shared/models/token_role.dart';
import 'package:shelf/shelf.dart';

@singleton
class TokenController {
  final TokenService _tokenService;
  final ConfigService _configService;

  TokenController(this._tokenService, this._configService);

  Future<Response> generate(Request request) async {
    String? requestedRole = request.url.queryParameters['role'];

    if (requestedRole == null) {
      return Response.badRequest(
        body: jsonEncode(
          ErrorResponse(
            ErrorCode.badRequest,
            "You have to specify a valid token role.",
          ),
        ),
      );
    }

    late final TokenRole role;

    try {
      role = TokenRole.values.byName(requestedRole);
    } catch (e) {
      return Response.badRequest(
        body: jsonEncode(
          ErrorResponse(
            ErrorCode.badRequest,
            "You have to specify a valid token role.",
          ),
        ),
      );
    }

    late final String? token;
    if (!_configService.config.initialized) {
      _configService.config.initialized = true;
      await _configService.config.saveToFile();
      token = await _tokenService.generateToken(role: TokenRole.admin);
      if (token != null) {
        logger.info("Successfully initialized daemon!");
      }
    } else {
      token = await _tokenService.generateToken(role: role);
      if (token != null) {
        logger.info("Successfully generated $role token!");
      }
    }

    if (token == null) {
      return Response.internalServerError(
        body: jsonEncode(
          ErrorResponse(ErrorCode.internalError, "Failed to generate token!"),
        ),
      );
    }

    return Response.ok(jsonEncode(token));
  }
}
