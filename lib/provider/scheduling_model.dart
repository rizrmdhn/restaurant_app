import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:restaurant_app/utils/background_service.dart';
import 'package:restaurant_app/utils/date_time_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SchedulingModel extends ChangeNotifier {
  bool _isScheduled = false;

  bool get isScheduled => _isScheduled;

  SchedulingModel() {
    getScheduling();
  }

  Future<bool> scheduledRestaurant(bool value) async {
    _isScheduled = value;
    if (_isScheduled) {
      print('Scheduling Restaurant Activated');
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool('scheduling', value);
      return await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      print('Scheduling Restaurant Canceled');
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool('scheduling', value);
      return await AndroidAlarmManager.cancel(1);
    }
  }

  Future<bool> getScheduling() async {
    final prefs = await SharedPreferences.getInstance();
    return _isScheduled = prefs.getBool('scheduling') ?? false;
  }
}
