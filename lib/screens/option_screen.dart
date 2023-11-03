import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:restaurant_app/provider/scheduling_model.dart';
import 'package:restaurant_app/utils/background_service.dart';
import 'package:restaurant_app/utils/date_time_helper.dart';

class OptionScreen extends StatelessWidget {
  static const routeName = '/option';

  const OptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SchedulingModel>(
      builder: (context, SchedulingModel provider, child) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Option',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: ListView(
          children: [
            SwitchListTile(
              title: const Text('Notifikasi Restoran'),
              value: provider.isScheduled,
              onChanged: (value) async {
                provider.scheduledRestaurant(value);
              },
            ),
            IconButton(
                onPressed: () async {
                  DateTimeHelper.format();
                },
                icon: Icon(Icons.notifications)),
          ],
        ),
      ),
    );
  }
}
