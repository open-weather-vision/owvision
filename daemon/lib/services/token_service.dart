import 'package:daemon/repositories/token_repository.dart';
import 'package:daemon/services/config_service.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/models/token.dart';
import 'package:shared/models/token_role.dart';

@singleton
class TokenService {
  final TokenRepository _tokenRepository;
  final ConfigService _configService;

  TokenService(this._tokenRepository, this._configService);

  Future<String> generateToken({required TokenRole role}) {
    return _tokenRepository.generateToken(role: role);
  }

  Future<bool> checkToken({required String token, required TokenRole role}) {
    return _tokenRepository.checkToken(role: role, token: token);
  }

  Future<Token?> getToken({required String token}) async {
    final result = await _tokenRepository.getToken(token: token);
    if (result != null &&
        !_configService.config.initialized &&
        result.role == TokenRole.initialize) {
      result.role = TokenRole.admin;
    }
    return result;
  }

  Future<void> insertInitializationTokenIfThereIsNone() async {
    await _tokenRepository.insertInitializationTokenIfThereIsNone();
  }
}
