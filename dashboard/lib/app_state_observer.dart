import 'package:flutter_bloc/flutter_bloc.dart';

class AppStateObserver extends BlocObserver {
  const AppStateObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    // ignore: avoid_print
    print("${bloc.runtimeType} $change");
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    // ignore: avoid_print
    print("${bloc.runtimeType}: $error");
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    super.onClose(bloc);
    print("${bloc.runtimeType}: closed");
  }
}
