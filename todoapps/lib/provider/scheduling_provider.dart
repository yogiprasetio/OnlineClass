import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:todoapps/utils/background_service.dart';
import 'package:todoapps/utils/date_time_helper.dart';

class SchedullingProvider extends ChangeNotifier {
  bool _isSchecduled = false;
  bool get isScheduled => _isSchecduled;

  Future<bool> scheduledTodo(bool value) async {
    _isSchecduled = value;
    if (_isSchecduled) {
      print("Schedulling is Running");
      notifyListeners();
      return await AndroidAlarmManager.oneShot(
          const Duration(seconds: 5), 1, BackgroundService.callback,
          exact: true, wakeup: true);
      // return await AndroidAlarmManager.periodic(
      //     const Duration(seconds: 5), 1, BackgroundService.callback,
      //     startAt: DateTimeHelper.format(), exact: true, wakeup: true);
    } else {
      print("Canceled Schedulling");
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
