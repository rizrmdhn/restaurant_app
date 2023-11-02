import 'package:flutter/material.dart';
import 'package:restaurant_app/models/detail_restaurant.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/provider/detail_restaurant_model.dart';
import 'package:restaurant_app/provider/favorite_model.dart';
import 'package:restaurant_app/provider/restaurant_model.dart';

class ContextModel extends ChangeNotifier {
  final RestaurantModel _restaurantModel = RestaurantModel();
  RestaurantModel get restaurantModel => _restaurantModel;

  final DetailRestaurantModel _detailRestaurantModel = DetailRestaurantModel();
  DetailRestaurantModel get detailRestaurantModel => _detailRestaurantModel;

  final FavoriteModel _favoriteModel = FavoriteModel();
  FavoriteModel get favoriteModel => _favoriteModel;

  ContextModel() {
    _favoriteModel.getFavorite();
  }

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

  Future<List<Restaurant>> getFavorite() async {
    _favoriteModel.getFavorite();
    notifyListeners();
    return _favoriteModel.favoriteData;
  }

  void setIsFetching(bool value) {
    _restaurantModel.setIsFetching(value);
    notifyListeners();
  }

  void fetchingDetailRestaurant(bool value) {
    _detailRestaurantModel.fetchingDetailRestaurant(value);
    notifyListeners();
  }

  void addFavorite(Restaurant restaurant) {
    _favoriteModel.addFavorite(restaurant);
    notifyListeners();
  }

  void removeFavorite(String id) {
    _favoriteModel.removeFavorite(id);
    notifyListeners();
  }

  void clearTable() {
    _favoriteModel.clearTable();
    notifyListeners();
  }

  bool isFavorite(String id) {
    return _favoriteModel.isFavorite(id);
  }
}
