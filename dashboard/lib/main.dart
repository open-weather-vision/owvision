import 'package:dashboard/features/history/history_view.dart';
import 'package:dashboard/features/settings/settings_cubit.dart';
import 'package:dashboard/features/settings/settings_view.dart';
import 'package:dashboard/navigation_cubit.dart';
import 'package:dashboard/repositories/config_repository.dart';

import 'app_state_observer.dart';
import 'features/live/live_view.dart';
import 'repositories/daemon_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const seedColor = Color.fromARGB(255, 77, 169, 255);

void main() {
  Bloc.observer = const AppStateObserver();
  runApp(const DashboardApp());
}

class DashboardApp extends StatelessWidget {
  const DashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'owvision Dashboard',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: Brightness.light,
        ),
        fontFamily: 'Outfit',
      ),

      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: Brightness.dark,
        ),
        fontFamily: 'Outfit',
      ),

      themeMode: ThemeMode.light,
      home: RepositoryProvider(
        create: (ctx) => ConfigRepository(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(lazy: false, create: (context) => NavigationCubit()),
            BlocProvider(
              lazy: false,
              create: (context) =>
                  SettingsCubit(context.read<ConfigRepository>()),
            ),
          ],
          child: const HomePage(title: 'owvision Dashboard'),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final String title;

  const HomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NavigationCubit, int>(
        builder: (context, state) {
          late final Widget widget;
          if (state == 0) {
            widget = LiveView();
          } else if (state == 1) {
            widget = HistoryView();
          } else {
            widget = SettingsView();
          }
          return BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
              return RepositoryProvider(
                create: (ctx) => DaemonRepository(
                  configRepository: ctx.read<ConfigRepository>(),
                ),
                child: widget,
              );
            },
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<NavigationCubit, int>(
        builder: (context, state) {
          return NavigationBar(
            selectedIndex: state,
            onDestinationSelected: (int index) {
              context.read<NavigationCubit>().setIndex(index);
            },
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,

            destinations: const <Widget>[
              // Item 1
              NavigationDestination(icon: Icon(Icons.sensors), label: 'Live'),
              // Item 2
              NavigationDestination(
                icon: Icon(Icons.bar_chart),
                label: 'History',
              ),
              // Item 3
              NavigationDestination(
                icon: Icon(Icons.settings_outlined),
                selectedIcon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          );
        },
      ),
    );
  }
}
