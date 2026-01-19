import 'package:dashboard/features/settings/settings_cubit.dart';
import 'package:dashboard/log.dart';
import 'package:dashboard/repositories/daemon_repository.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SettingsState();
  }
}

class _SettingsState extends State<SettingsView> {
  final _daemonServerUrlController = TextEditingController();
  final _daemonApiTokenController = TextEditingController();
  var _darkMode = false;
  var _testingConnection = false;

  @override
  void dispose() {
    _daemonServerUrlController.dispose();
    _daemonApiTokenController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    final settings = context.read<SettingsCubit>().state;
    _daemonServerUrlController.text = settings.apiUrl ?? "";
    _daemonApiTokenController.text = settings.apiToken ?? "";
    _darkMode = settings.darkMode ?? false;
  }

  void _testConnection() async {
    setState(() {
      _testingConnection = true;
    });
    final repo = context.read<DaemonRepository>();
    final config = await repo.currentConfig;
    repo.recreateClient(
      _daemonServerUrlController.text,
      _daemonApiTokenController.text,
    );
    try {
      await repo.getStations();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Connection is stable!'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating, // Lässt die Bar "schweben"
          duration: Duration(seconds: 2),
          showCloseIcon: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    } catch (e) {
      Log.warn(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Failed to reach daemon!'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating, // Lässt die Bar "schweben"
          duration: Duration(seconds: 2),
          showCloseIcon: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
    repo.recreateClient(config.apiUrl, config.apiToken);
    setState(() {
      _testingConnection = false;
    });
  }

  void _save() async {
    await context.read<SettingsCubit>().saveConfig(
      _daemonServerUrlController.text,
      _daemonApiTokenController.text,
      _darkMode,
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Saved!'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating, // Lässt die Bar "schweben"
        duration: Duration(seconds: 2),
        showCloseIcon: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: CustomScrollView(
        physics: ClampingScrollPhysics(),
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: EdgeInsetsGeometry.all(20),
              child: Column(
                spacing: 20,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.onPrimary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                    child: Row(
                      spacing: 15,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(Icons.dns, size: 30),
                        Expanded(
                          child: TextField(
                            controller: _daemonServerUrlController,
                            decoration: InputDecoration(
                              labelText: 'Daemon server url',
                              hintText: 'https://your.server.ip.address:8080/',
                              border: InputBorder.none,
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: theme.colorScheme.primary,
                                  width: 1.0,
                                ),
                              ),
                              filled: false,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.onPrimary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                    child: Row(
                      spacing: 15,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(Icons.key, size: 30),
                        Expanded(
                          child: TextField(
                            obscureText: true,
                            controller: _daemonApiTokenController,
                            decoration: InputDecoration(
                              labelText: 'Daemon api token',

                              hintText: 'e56dbd67-b336-44f9-8807-9fcfe1c9b721',
                              border: InputBorder.none,
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: theme.colorScheme.primary,
                                  width: 1.0,
                                ),
                              ),
                              filled: false,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Opacity(
                    opacity: _testingConnection ? 0.5 : 1,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.primaryContainer,
                        foregroundColor: theme.colorScheme.onPrimaryContainer,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        minimumSize: Size.fromHeight(60),
                      ),
                      icon: Icon(Icons.sensors, size: 18),
                      onPressed: _testingConnection ? null : _testConnection,

                      label: Text(
                        _testingConnection
                            ? "Connecting..."
                            : "Test connection",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  Divider(),
                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.onPrimary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.color_lens),
                        SizedBox(width: 15),
                        Text("Use dark theme", style: TextStyle(fontSize: 17)),
                        Spacer(),
                        Switch(
                          value: _darkMode,
                          onChanged: (value) => {
                            setState(() {
                              _darkMode = value;
                            }),
                          },
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        theme.colorScheme.primary,
                      ),
                      foregroundColor: WidgetStatePropertyAll(
                        theme.colorScheme.onPrimary,
                      ),

                      minimumSize: WidgetStatePropertyAll(Size.fromHeight(60)),
                    ),
                    icon: Icon(Icons.save, size: 20),
                    onPressed: _save,
                    label: Text("Save", style: TextStyle(fontSize: 18)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
