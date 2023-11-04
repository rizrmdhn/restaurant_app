import 'package:flutter/material.dart';
import 'package:restaurant_app/components/favorite_restaurant_list.dart';

class FavoriteScreen extends StatelessWidget {
  static const routeName = '/favorite';
  final String? connectionStatus;

  const FavoriteScreen({super.key, this.connectionStatus});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorite',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: connectionStatus == 'ConnectivityResult.none'
          ? const Center(
              child: Text('No Internet Connection'),
            )
          : const FavoriteRestaurantList(),
    );
  }
}
