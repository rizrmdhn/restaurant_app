import 'dart:isolate';
import 'dart:ui';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/main.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/utils/notification_helper.dart';
import 'package:timezone/data/latest.dart' as tzs;

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
    tzs.initializeTimeZones();
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback(dynamic dateTime) async {
    print('Alarm fired!');
    final NotificationHelper notificationHelper = NotificationHelper();
    var result = await http.get(
      Uri.parse('https://restaurant-api.dicoding.dev/list'),
    );

    if (result.statusCode == 200) {
      var restaruantResult = RestaurantResults.fromJson(
        json.decode(result.body),
      );

      await notificationHelper.showNotification(
        flutterLocalNotificationsPlugin,
        restaruantResult,
      );
    }
    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }

  Future<void> someTask() async {
    print('Updated data from the background isolate');
  }
}
