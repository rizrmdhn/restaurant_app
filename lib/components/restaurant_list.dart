import 'package:flutter/material.dart';
import 'package:restaurant_app/components/restaurant_card.dart';
import 'package:restaurant_app/models/restaurant.dart';

class RestaurantList extends StatelessWidget {
  const RestaurantList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: DefaultAssetBundle.of(context)
          .loadString('assets/local_restaurant.json'),
      builder: (context, snapshot) {
        final List<Restaurant> restaurants = parseRestaurant(snapshot.data);

        return ListView.builder(
          itemCount: restaurants.length,
          itemBuilder: (context, index) {
            final Restaurant restaurant = restaurants[index];
            return RestaurantCard(
              id: restaurant.id,
              name: restaurant.name,
              city: restaurant.city,
              rating: restaurant.rating,
              pictureId: restaurant.pictureId,
              restaurant: restaurant,
            );
          },
        );
      },
    );
  }
}
