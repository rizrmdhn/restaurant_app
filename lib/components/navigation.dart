import 'package:flutter/material.dart';
import 'package:restaurant_app/provider/restaurant_model.dart';
import 'package:http/http.dart' as http;

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Navigation {
  final RestaurantModel restaurantModel;

  Navigation(this.restaurantModel);
// Instance member 'navigateToDetailScreen' can't be accessed using static access.
  void navigateToDetailScreen(route, String id) async {
    restaurantModel.getRestaurantDetail(http.Client(), id);
    navigatorKey.currentState!.pushNamed(route);
  }

  void navigateToFavoriteScreen() {
    navigatorKey.currentState!.pushNamed('/favorite');
  }

  void navigateToOptionScreen() {
    navigatorKey.currentState!.pushNamed('/option');
  }
}
