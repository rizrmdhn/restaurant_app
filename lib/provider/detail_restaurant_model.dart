import 'package:flutter/material.dart';
import 'package:restaurant_app/models/detail_restaurant.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DetailRestaurantModel extends ChangeNotifier {
  late DetailRestaurant _detailRestaurant;
  bool _isDetailRestaurantFetching = false;

  DetailRestaurant get detailRestaurant => _detailRestaurant;
  bool get isDetailRestaurantFetching => _isDetailRestaurantFetching;

  Future<DetailRestaurant> getDetailRestaurant(String id) async {
    fetchingDetailRestaurant(true);
    final response = await http
        .get(Uri.parse('https://restaurant-api.dicoding.dev/detail/$id'));

    if (response.statusCode == 200) {
      final restaurant = jsonDecode(response.body);
      _detailRestaurant = DetailRestaurant.fromJson(restaurant['restaurant']);
      notifyListeners();
      fetchingDetailRestaurant(false);
      return _detailRestaurant;
    } else {
      fetchingDetailRestaurant(false);
      throw Exception('Failed to load restaurant');
    }
  }

  void fetchingDetailRestaurant(bool fetching) {
    _isDetailRestaurantFetching = fetching;
    notifyListeners();
  }
}
