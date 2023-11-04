import 'dart:convert';
import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant_app/components/navigation.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/models/restaurant_notifiaction.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:rxdart/subjects.dart';
import 'package:restaurant_app/utils/received_notification.dart';

final selectNotificationSubject = BehaviorSubject<String>();
final didReceiveLocalNotificationSubject =
    BehaviorSubject<ReceivedNotification>();

class NotificationHelper {
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = const DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        final payload = details.payload;
        if (payload != null) {
          print('notification payload: $payload');
        }
        selectNotificationSubject.add(payload ?? 'empty payload');
      },
    );
  }

  Future<void> showNotification(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    RestaurantResults restaurant,
  ) async {
    var channelId = "1";
    var channelName = "channel_01";
    var channelDescription = "restaurant channel";

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      styleInformation: const DefaultStyleInformation(true, true),
    );

    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
    var random = Random();
    var titleNotification = "<b>Restaurant</b>";
    var randomItem = random.nextInt(restaurant.restaurants.length);
    var titleNews = restaurant.restaurants[randomItem].name;

    await flutterLocalNotificationsPlugin.show(
      0,
      titleNotification,
      titleNews,
      platformChannelSpecifics,
      payload: json.encode(
        restaurant.restaurants[randomItem].toJson(),
      ),
    );
  }

  void configureSelectNotificationSubject(String route) {
    final RestaurantProvider restaurantProvider = RestaurantProvider();
    final Navigation navigation = Navigation(restaurantProvider);
    selectNotificationSubject.stream.listen(
      (String payload) async {
        var data = RestaurantNotification.fromJson(json.decode(payload));
        var restaurantNotification = data;
        navigation.navigateToDetailScreen(route, restaurantNotification.id);
      },
    );
  }
}
