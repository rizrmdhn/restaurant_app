import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/components/restaurant_card.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/provider/main.dart';

class RestaurantList extends StatelessWidget {
  const RestaurantList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ContextModel>(
      // check if the isFetching state is true or false
      builder: (context, value, child) => value.restaurantModel.isFetching
          ? const Center(child: CircularProgressIndicator())
          : value.restaurantModel.restaurants.isEmpty
              ? const Center(child: Text('Tidak ada data restoran'))
              : ListView.builder(
                  itemCount: value.restaurantModel.restaurants.length,
                  itemBuilder: (context, index) {
                    final Restaurant restaurant =
                        value.restaurantModel.restaurants[index];
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
