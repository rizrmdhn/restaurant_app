import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/scheduling_provider.dart';

class OptionScreen extends StatelessWidget {
  static const routeName = '/option';

  const OptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SchedulingProvider>(
      builder: (context, SchedulingProvider provider, child) => Scaffold(
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
          ],
        ),
      ),
    );
  }
}
