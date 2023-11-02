import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/components/restaurant_card.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/provider/main.dart';

class FavoriteRestaurantList extends StatelessWidget {
  const FavoriteRestaurantList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ContextModel>(
      // check if the isFetching state is true or false
      builder: (context, value, child) =>
          value.favoriteModel.favoriteData.isEmpty
              ? const Center(child: Text('Tidak data restoran favorit'))
              : ListView.builder(
                  itemCount: value.favoriteModel.favoriteData.length,
                  itemBuilder: (context, index) {
                    final Restaurant restaurant =
                        value.favoriteModel.favoriteData[index];
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
