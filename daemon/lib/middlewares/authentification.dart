import 'dart:convert';

import 'package:daemon/locator.dart';
import 'package:daemon/services/token_service.dart';
import 'package:shared/logger/logger.dart';
import 'package:shared/models/error_response.dart';
import 'package:shared/models/token.dart';
import 'package:shared/models/token_role.dart';
import 'package:shelf/shelf.dart';

Middleware authMiddleware({required bool disabled}) {
  return (Handler innerHandler) {
    return (Request request) async {
      if (disabled) {
        return innerHandler(request);
      }

      final authHeader = request.headers['Authorization'];
      if (authHeader == null || !authHeader.startsWith('Bearer ')) {
        return Response.unauthorized(
          jsonEncode(
            ErrorResponse(ErrorCode.unauthorized, "Missing token!").toJson(),
          ),
        );
      }

      final plainToken = authHeader.substring(7);
      final tokenService = getIt<TokenService>();
      final token = await tokenService.getToken(token: plainToken);

      if (token == null) {
        logger.warning("Blocked user because of invalid token.");
        return Response.unauthorized(
          jsonEncode(
            ErrorResponse(ErrorCode.unauthorized, "Invalid token!").toJson(),
          ),
        );
      }
      final updatedRequest = request.change(context: {'token': token});
      return innerHandler(updatedRequest);
    };
  };
}

Middleware requireRole(List<TokenRole> roles) {
  return (Handler innerHandler) {
    return (Request request) {
      final token = request.context['token'] as Token?;

      if (token == null) {
        logger.warning("Blocked user because of invalid token.");
        return Response.unauthorized(
          jsonEncode(
            ErrorResponse(ErrorCode.unauthorized, 'Invalid token!').toJson(),
          ),
        );
      }

      if (token.role != TokenRole.admin && !roles.contains(token.role)) {
        logger.warning(
          "Blocked user because of token with not enough privileges.",
        );
        return Response.unauthorized(
          jsonEncode(
            ErrorResponse(
              ErrorCode.unauthorized,
              "Your token has not enough privileges!",
            ).toJson(),
          ),
        );
      }

      return innerHandler(request);
    };
  };
}
