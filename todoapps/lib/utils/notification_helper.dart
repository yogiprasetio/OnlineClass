import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

import '../common/navigation.dart';
import '../data/model/to_do.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper? _instance;
  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    // var initializeSettings = const AndroidInitializationSettings('app_icon');
    await flutterLocalNotificationsPlugin.initialize(
        const InitializationSettings(
            android: AndroidInitializationSettings('app_icon')),
        onDidReceiveBackgroundNotificationResponse: p);
  }

  static p(NotificationResponse details) async {
    final payload = details.payload;
    (payload != null)
        ? print("Notification Payload : ${payload}")
        : selectNotificationSubject.add(payload ?? 'empty payload');
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      Todo todo) async {
    var channelId = "1";
    var channelName = "Channel_01";
    var channelDescription = "Todo Info Channel";
    var androidPlatformSpecifics = AndroidNotificationDetails(
        channelId, channelName,
        channelDescription: channelDescription,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        styleInformation: const DefaultStyleInformation(true, true));

    var titleNotification = "<b> Todo Update Boss </b>";
    var titleTodo = todo.title;
    await flutterLocalNotificationsPlugin.show(
        0,
        titleNotification,
        titleNotification,
        NotificationDetails(android: androidPlatformSpecifics),
        payload: jsonEncode(todo.toMap()));
  }

  void configureSelectNotificationSubject(String route) {
    selectNotificationSubject.stream.listen((String payload) async {
      var data = Todo.fromMap(jsonDecode(payload));
      Navigation.intentWithData(route, data);
    });
  }
}
