import 'package:flutter/material.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:http/http.dart' as http;

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Navigation {
  final RestaurantProvider restaurantProvider;

  Navigation(this.restaurantProvider);
// Instance member 'navigateToDetailScreen' can't be accessed using static access.
  void navigateToDetailScreen(route, String id) async {
    restaurantProvider.getRestaurantDetail(http.Client(), id);
    navigatorKey.currentState!.pushNamed(route);
  }

  void navigateToFavoriteScreen() {
    navigatorKey.currentState!.pushNamed('/favorite');
  }

  void navigateToOptionScreen() {
    navigatorKey.currentState!.pushNamed('/option');
  }
}
