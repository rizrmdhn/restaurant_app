import 'package:flutter/material.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RestaurantModel extends ChangeNotifier {
  late List<Restaurant> _restaurants;
  bool _isFetching = false;

  List<Restaurant> get restaurants => _restaurants;
  bool get isFetching => _isFetching;

  Future<List<Restaurant>> getRestaurant() async {
    setIsFetching(true);
    final response =
        await http.get(Uri.parse('https://restaurant-api.dicoding.dev/list'));

    if (response.statusCode == 200) {
      final restaurant = jsonDecode(response.body);
      _restaurants = List<Restaurant>.from(
          restaurant['restaurants'].map((x) => Restaurant.fromJson(x)));
      notifyListeners();
      setIsFetching(false);
      return _restaurants;
    } else {
      setIsFetching(false);
      throw Exception('Failed to load restaurant');
    }
  }

  Future<List<Restaurant>> searchRestaurantByName(String name) async {
    setIsFetching(true);
    notifyListeners();
    final response = await http
        .get(Uri.parse('https://restaurant-api.dicoding.dev/search?q=$name'));

    if (response.statusCode == 200) {
      final restaurant = jsonDecode(response.body);
      _restaurants = List<Restaurant>.from(
          restaurant['restaurants'].map((x) => Restaurant.fromJson(x)));
      // add delay to make sure the loading indicator is showing
      setIsFetching(false);
      notifyListeners();
      return _restaurants;
    } else {
      setIsFetching(false);
      throw Exception('Failed to load restaurant');
    }
  }

  void setIsFetching(bool fetching) {
    _isFetching = fetching;
    notifyListeners();
  }
}
