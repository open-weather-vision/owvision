import 'package:dashboard/features/settings/settings_cubit.dart';
import 'package:dashboard/log.dart';
import 'package:dashboard/main.dart';
import 'package:dashboard/repositories/daemon_repository.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

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
  Color _themeColor = Colors.blue;

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
    _daemonServerUrlController.text = settings.config.apiUrl;
    _daemonApiTokenController.text = settings.config.apiToken;
    _darkMode = settings.config.darkMode;
    _themeColor = settings.config.themeColor;
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
      _themeColor,
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

  void _pickColor() {
    Color pickerColor = _themeColor;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: pickerColor,
            onColorChanged: (c) => pickerColor = c,
            paletteType: PaletteType.hueWheel,
            enableAlpha: false,
            displayThumbColor: false,
            labelTypes: [],
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('Choose'),
            onPressed: () {
              setState(() {
                _themeColor = pickerColor;
              });
              Navigator.of(context).pop();
            },
          ),
        ],
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
                  _settingsContainer(theme, [
                    TextField(
                      controller: _daemonServerUrlController,
                      decoration: InputDecoration(
                        labelText: 'Daemon server url',
                        hintText: 'https://your.server.ip.address:8080/',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    TextField(
                      obscureText: true,
                      controller: _daemonApiTokenController,

                      decoration: InputDecoration(
                        labelText: 'Daemon api token',
                        hintText: 'e56dbd67-b336-44f9-8807-9fcfe1c9b721',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    Opacity(
                      opacity: _testingConnection ? 0.5 : 1,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor:
                              theme.colorScheme.onSecondaryContainer,
                          foregroundColor: theme.colorScheme.secondaryContainer,
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
                  ], "Server Connection"),
                  _settingsContainer(theme, [
                    Container(
                      padding: EdgeInsets.fromLTRB(15, 5, 10, 5),
                      decoration: BoxDecoration(
                        color: theme.brightness == Brightness.light
                            ? Color.fromARGB(155, 255, 255, 255)
                            : Color.fromARGB(50, 0, 0, 0),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "Use dark theme",
                            style: TextStyle(fontSize: 17),
                          ),
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
                    Container(
                      padding: EdgeInsets.fromLTRB(15, 5, 10, 5),
                      decoration: BoxDecoration(
                        color: theme.brightness == Brightness.light
                            ? Color.fromARGB(155, 255, 255, 255)
                            : Color.fromARGB(50, 0, 0, 0),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          Text("Color", style: TextStyle(fontSize: 17)),
                          Spacer(),
                          GestureDetector(
                            onTap: _pickColor,
                            child: Container(
                              width: 50,
                              height: 35,
                              margin: EdgeInsets.all(7),
                              decoration: BoxDecoration(
                                color: _themeColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ], "Theme"),

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

  Widget _settingsContainer(
    ThemeData theme,
    List<Widget> children,
    String label,
  ) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: theme.colorScheme.secondaryContainer,
      ),
      child: Column(
        spacing: 15,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsGeometry.only(bottom: 5),
            child: Text(
              label,
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.w600),
            ),
          ),

          ...children,
        ],
      ),
    );
  }
}
