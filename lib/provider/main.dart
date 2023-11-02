import 'package:flutter/material.dart';
import 'package:restaurant_app/models/detail_restaurant.dart';
import 'package:restaurant_app/models/restaurant.dart';

class ContextModel extends ChangeNotifier {
  final RestaurantModel _restaurantModel = RestaurantModel();
  RestaurantModel get restaurantModel => _restaurantModel;

  final DetailRestaurantModel _detailRestaurantModel = DetailRestaurantModel();
  DetailRestaurantModel get detailRestaurantModel => _detailRestaurantModel;

  Future<List<Restaurant>> getRestaurant() async {
    await _restaurantModel.getRestaurant();
    notifyListeners();
    return _restaurantModel.restaurants;
  }

  Future<DetailRestaurant> getDetailRestaurant(String id) async {
    await _detailRestaurantModel.getDetailRestaurant(id);
    notifyListeners();
    return _detailRestaurantModel.detailRestaurant;
  }

  Future<List<Restaurant>> searchRestaurantByName(String query) async {
    await _restaurantModel.searchRestaurantByName(query);
    notifyListeners();
    return _restaurantModel.restaurants;
  }

  void setIsFetching(bool value) {
    _restaurantModel.setIsFetching(value);
    notifyListeners();
  }

  void fetchingDetailRestaurant(bool value) {
    _detailRestaurantModel.fetchingDetailRestaurant(value);
    notifyListeners();
  }
}
