import 'package:dashboard/features/settings/settings_cubit.dart';
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
  }

  void _save() async {
    await context.read<SettingsCubit>().saveConfig(
      _daemonServerUrlController.text,
      _daemonApiTokenController.text,
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
                      autofocus: true,

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
    );
  }
}
