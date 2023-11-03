import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/components/restaurant_card.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/provider/restaurant_model.dart';

class RestaurantList extends StatelessWidget {
  const RestaurantList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantModel>(
      // check if the isFetching state is true or false
      builder: (context, value, child) => value.isFetching
          ? const Center(child: CircularProgressIndicator())
          : value.restaurants.isEmpty
              ? const Center(child: Text('Tidak ada data restoran'))
              : ListView.builder(
                  itemCount: value.restaurants.length,
                  itemBuilder: (context, index) {
                    final Restaurant restaurant = value.restaurants[index];
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
