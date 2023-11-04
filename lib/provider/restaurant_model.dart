import 'package:flutter/material.dart';
import 'package:restaurant_app/database/main.dart';
import 'package:restaurant_app/models/detail_restaurant.dart';
import 'package:restaurant_app/models/favorite_data.dart';
import 'package:restaurant_app/models/menus.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';

class RestaurantModel extends ChangeNotifier {
  List<Restaurant> _restaurants = [];
  bool _isFetching = false;
  late DetailRestaurant _detailRestaurant;
  final List<FavoriteData> _favoriteData = [];

  List<FavoriteData> get favoriteData => _favoriteData;
  List<Restaurant> get restaurants => _restaurants;
  bool get isFetching => _isFetching;
  DetailRestaurant get detailRestaurant => _detailRestaurant;

  RestaurantModel() {
    // initialize detail restaurant
    getRestaurant(http.Client());
    getFavorite();
    initStateDetailRestaurant();
  }

  void initStateDetailRestaurant() {
    _detailRestaurant = DetailRestaurant(
      id: '',
      name: '',
      description: '',
      city: '',
      address: '',
      pictureId: '',
      categories: [],
      menus: Menus(foods: [], drinks: []),
      rating: 0.0,
      customerReviews: [],
    );
  }

  Future<List<Restaurant>> getRestaurant(http.Client client) async {
    setIsFetching(true);
    final response =
        await client.get(Uri.parse('https://restaurant-api.dicoding.dev/list'));
    notifyListeners();
    if (response.statusCode == 200) {
      final restaurant = jsonDecode(response.body);
      _restaurants = RestaurantResults.fromJson(restaurant).restaurants;
      notifyListeners();
      setIsFetching(false);
      return _restaurants;
    } else {
      setIsFetching(false);
      notifyListeners();
      throw Exception('Failed to load restaurant');
    }
  }

  Future<DetailRestaurant?> getRestaurantDetail(
    http.Client client,
    String id,
  ) async {
    // check if client is null use http

    setIsFetching(true);
    final response = await client
        .get(Uri.parse('https://restaurant-api.dicoding.dev/detail/$id'));
    notifyListeners();
    if (response.statusCode == 200) {
      final restaurant = jsonDecode(response.body);
      _detailRestaurant = DetailRestaurant.fromJson(restaurant['restaurant']);
      setIsFetching(false);
      notifyListeners();
      return _detailRestaurant;
    } else {
      setIsFetching(false);
      notifyListeners();
      throw Exception('Failed to load restaurant');
    }
  }

  Future<List<Restaurant>> searchRestaurantByName(
      http.Client client, String name) async {
    try {
      setIsFetching(true);
      final response = await client
          .get(Uri.parse('https://restaurant-api.dicoding.dev/search?q=$name'));
      notifyListeners();
      if (response.statusCode == 200) {
        final restaurant = jsonDecode(response.body);
        _restaurants = List<Restaurant>.from(
            restaurant['restaurants'].map((x) => Restaurant.fromJson(x)));
        setIsFetching(false);
        notifyListeners();
        return _restaurants;
      } else {
        setIsFetching(false);
        notifyListeners();
        throw Exception('Failed to load restaurant');
      }
    } catch (e) {
      setIsFetching(false);
      notifyListeners();
      throw Exception('Failed to load restaurant');
    }
  }

  void setIsFetching(bool fetching) {
    _isFetching = fetching;
    notifyListeners();
  }

  void getFavorite() async {
    final Database db = await database;
    final List<Map<String, dynamic>> results = await db.query('favorite');
    return _favoriteData.addAll(
      results.map((e) => FavoriteData.fromJson(e)).toList(),
    );
  }

  void addFavorite(String id) async {
    if (isFavorite(id)) {
      removeFavorite(id);
      return;
    }
    final Database db = await database;
    await db.insert(
      'favorite',
      {'id': id},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    _favoriteData.add(FavoriteData(id: id));
    notifyListeners();
  }

  void removeFavorite(String id) async {
    final Database db = await database;
    db.delete(
      'favorite',
      where: 'id = ?',
      whereArgs: [id],
    );
    _favoriteData.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void clearTable() async {
    final Database db = await database;
    db.delete('favorite');
    _favoriteData.clear();
    notifyListeners();
  }

  bool isFavorite(String? id) {
    return _favoriteData.any((element) => element.id == id);
  }
}
