import 'package:dashboard/repositories/config_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ConfigStatus { initial, loading, success, failure }

class SettingsState {
  final ConfigStatus status;
  late final AppConfig config;

  SettingsState({this.status = ConfigStatus.initial, AppConfig? config}) {
    this.config = config ?? AppConfig();
  }

  SettingsState copyWith({ConfigStatus? status, AppConfig? config}) {
    return SettingsState(
      status: status ?? this.status,
      config: config ?? this.config,
    );
  }
}

class SettingsCubit extends Cubit<SettingsState> {
  final ConfigRepository _repository;

  SettingsCubit(this._repository) : super(SettingsState()) {
    _loadConfig();
  }

  Future<void> _loadConfig() async {
    emit(state.copyWith(status: ConfigStatus.loading));

    try {
      final config = await _repository.loadConfig();
      emit(state.copyWith(status: ConfigStatus.success, config: config));
    } catch (e) {
      emit(state.copyWith(status: ConfigStatus.failure));
    }
  }

  Future<void> saveConfig(
    String newUrl,
    String newToken,
    bool darkMode,
    Color themeColor,
  ) async {
    emit(state.copyWith(status: ConfigStatus.loading));

    try {
      final config = AppConfig(
        apiUrl: newUrl,
        apiToken: newToken,
        themeColor: themeColor,
        darkMode: darkMode,
      );
      await _repository.saveConfig(config);

      emit(state.copyWith(status: ConfigStatus.success, config: config));
    } catch (e) {
      emit(state.copyWith(status: ConfigStatus.failure));
    }
  }
}
