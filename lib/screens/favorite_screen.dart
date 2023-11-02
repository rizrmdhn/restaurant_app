import 'package:flutter/material.dart';
import 'package:restaurant_app/components/favorite_restaurant_list.dart';

class FavoriteScreen extends StatelessWidget {
  static const routeName = '/favorite';

  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorite',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: const Center(
        child: FavoriteRestaurantList(),
      ),
    );
  }
}
