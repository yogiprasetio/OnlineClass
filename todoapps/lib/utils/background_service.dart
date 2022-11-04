import 'dart:isolate';
import 'dart:ui';

import 'package:todoapps/utils/notification_helper.dart';
import 'package:todoapps/provider/db_provider.dart';

import '../main.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;
  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(port.sendPort, _isolateName);
  }

  static Future<void> callback() async {
    print('Alarm mu Aktif');
    final NotificationHelper notificationHelper = NotificationHelper();
    final db = DbProvider();
    final todo = await db.getOldestTodo();
    print(todo);
    await notificationHelper.showNotification(
        flutterLocalNotificationsPlugin, todo);
    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}
