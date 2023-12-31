import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/components/restaurant_card.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';

class FavoriteRestaurantList extends StatelessWidget {
  const FavoriteRestaurantList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantProvider>(
      // check if the isFetching state is true or false
      builder: (context, value, child) => value.favoriteData.isEmpty
          ? const Center(child: Text('Tidak data restoran favorit'))
          : ListView.builder(
              itemCount: value.favoriteData.length,
              itemBuilder: (context, index) {
                // find the restaurant data from the list of restaurants
                final Restaurant restaurant = value.restaurants.firstWhere(
                  (element) => element.id == value.favoriteData[index].id,
                );
                return RestaurantCard(
                  id: restaurant.id,
                  name: restaurant.name,
                  city: restaurant.city,
                  rating: restaurant.rating,
                  pictureId:
                      'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}',
                  restaurant: restaurant,
                );
              },
            ),
    );
  }
}
