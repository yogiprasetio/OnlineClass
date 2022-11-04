import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:todoapps/provider/preferences_provider.dart';
import 'package:todoapps/provider/scheduling_provider.dart';

class SettingsPage extends StatelessWidget {
  static const routeName = '/settings';
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<PreferencesProvider, SchedullingProvider>(
        builder: (context, PreferencesProvider, SchedullingProvider, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
        ),
        body: ListView(
          children: [
            Material(
              child: ListTile(
                title: const Text('Enable Notifications'),
                trailing: Switch.adaptive(
                  value: PreferencesProvider.isNotifEnabled,
                  onChanged: (value) async {
                    PreferencesProvider.enableNotif(value);
                  },
                ),
              ),
            )
          ],
        ), // This trailing comma makes auto-formatting nicer for build methods.
      );
    });
  }
}
