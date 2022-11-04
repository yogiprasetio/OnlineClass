import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;

  PreferencesHelper({required this.sharedPreferences});

  static const notifEnabled = 'NOTIF_ENABLED';

  Future<bool> get isNotifEnabled async {
    final prefs = await sharedPreferences;
    return prefs.getBool(notifEnabled) ?? false;
  }

  void setNotifEnabled(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(notifEnabled, value);
  }
}
