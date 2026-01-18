import 'dart:convert';

import 'package:daemon/locator.dart';
import 'package:daemon/services/token_service.dart';
import 'package:shared/logger/logger.dart';
import 'package:shared/models/token_role.dart';
import 'package:shelf/shelf.dart';

import '../models/error_response.dart';
import '../models/token.dart';

Middleware authMiddleware({required bool disabled}) {
  return (Handler innerHandler) {
    return (Request request) async {
      if (disabled) {
        return innerHandler(request);
      }

      String? authHeader = request.headers['Authorization']?.trim();

      // Web socket authentication hack
      if (authHeader == null &&
          request.headers['Sec-WebSocket-Protocol'] != null) {
        logger.info("Authenticating via sec web socket protocol...");
        final entries = request.headers['Sec-WebSocket-Protocol']!
            .split(",")
            .map((e) => e.trim());
        for (final entry in entries) {
          if (entry.startsWith("auth.bearer.")) {
            authHeader = entry.substring(12);
          }
        }
      } else if (authHeader != null && authHeader.startsWith('Bearer ')) {
        authHeader = authHeader.substring(7);
      } else {
        authHeader = null;
      }

      if (authHeader == null) {
        return Response.unauthorized(
          jsonEncode(
            ErrorResponse(ErrorCode.unauthorized, "Missing token!").toJson(),
          ),
        );
      }

      final tokenService = getIt<TokenService>();
      final token = await tokenService.getToken(token: authHeader);

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
