import 'dart:async';
import 'dart:io';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/components/navigation.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/provider/connectivity_provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/provider/scheduling_provider.dart';
import 'package:restaurant_app/screens/detail_screen.dart';
import 'package:restaurant_app/screens/favorite_screen.dart';
import 'package:restaurant_app/screens/home_screen.dart';
import 'package:restaurant_app/screens/option_screen.dart';
import 'package:restaurant_app/utils/background_service.dart';
import 'package:restaurant_app/utils/notification_helper.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  // Sqflite
  sqfliteFfiInit();

  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();

  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();

  service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RestaurantProvider()),
        ChangeNotifierProvider(create: (_) => SchedulingProvider()),
        ChangeNotifierProvider(create: (_) => ConnectivityProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<Restaurant> futureRestaurant;
  final NotificationHelper _notificationHelper = NotificationHelper();

  @override
  void initState() {
    super.initState();

    // Get Scheduling Option
    Provider.of<SchedulingProvider>(context, listen: false).getScheduling();

    // Notification
    _notificationHelper
        .configureSelectNotificationSubject(DetailScreen.routeName);

    // Connectivity
    Provider.of<ConnectivityProvider>(context, listen: false)
        .connectivitySubscription
        .resume();
  }

  @override
  void dispose() {
    Provider.of<ConnectivityProvider>(context, listen: false)
        .connectivitySubscription
        .cancel();
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      navigatorKey: navigatorKey,
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(
              connectionStatus: Provider.of<ConnectivityProvider>(context)
                  .connectionStatus
                  .toString(),
            ),
        DetailScreen.routeName: (context) => const DetailScreen(),
        FavoriteScreen.routeName: (context) => FavoriteScreen(
              connectionStatus: Provider.of<ConnectivityProvider>(context)
                  .connectionStatus
                  .toString(),
            ),
        OptionScreen.routeName: (context) => const OptionScreen(),
      },
    );
  }
}
