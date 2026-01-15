import 'package:dashboard/repositories/config_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ConfigStatus { initial, loading, success, failure }

class SettingsState {
  final ConfigStatus status;
  final String? apiUrl;
  final String? apiToken;

  const SettingsState({
    this.status = ConfigStatus.initial,
    this.apiUrl,
    this.apiToken,
  });

  SettingsState copyWith({
    ConfigStatus? status,
    String? apiUrl,
    String? apiToken,
    String? errorMessage,
  }) {
    return SettingsState(
      status: status ?? this.status,
      apiUrl: apiUrl ?? this.apiUrl,
      apiToken: apiToken ?? this.apiToken,
    );
  }
}

class SettingsCubit extends Cubit<SettingsState> {
  final ConfigRepository _repository;

  SettingsCubit(this._repository) : super(const SettingsState()) {
    _loadConfig();
  }

  Future<void> _loadConfig() async {
    emit(state.copyWith(status: ConfigStatus.loading));

    try {
      final config = await _repository.loadConfig();

      // 2. Erfolgszustand mit Daten setzen
      emit(
        state.copyWith(
          status: ConfigStatus.success,
          apiUrl: config.apiUrl,
          apiToken: config.apiToken,
        ),
      );
    } catch (e) {
      // 3. Fehlerzustand setzen
      emit(
        state.copyWith(
          status: ConfigStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> saveConfig(String newUrl, String newToken) async {
    emit(state.copyWith(status: ConfigStatus.loading));

    try {
      final config = AppConfig(apiUrl: newUrl, apiToken: newToken);
      await _repository.saveConfig(config);

      emit(
        state.copyWith(
          status: ConfigStatus.success,
          apiUrl: newUrl,
          apiToken: newToken,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ConfigStatus.failure,
          errorMessage: "Failed to save config: $e",
        ),
      );
    }
  }
}
