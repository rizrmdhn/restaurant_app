import 'package:flutter/material.dart';
import 'package:restaurant_app/database/main.dart';
import 'package:restaurant_app/models/detail_restaurant.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';

class RestaurantModel extends ChangeNotifier {
  List<Restaurant> _restaurants = [];
  bool _isFetching = false;
  late DetailRestaurant _detailRestaurant;
  final List<Restaurant> _favoriteData = [];

  List<Restaurant> get favoriteData => _favoriteData;
  List<Restaurant> get restaurants => _restaurants;
  bool get isFetching => _isFetching;
  DetailRestaurant get detailRestaurant => _detailRestaurant;

  RestaurantModel() {
    // initialize detail restaurant

    getRestaurant();
  }

  Future<List<Restaurant>> getRestaurant() async {
    setIsFetching(true);
    final response =
        await http.get(Uri.parse('https://restaurant-api.dicoding.dev/list'));
    notifyListeners();
    if (response.statusCode == 200) {
      final restaurant = jsonDecode(response.body);
      _restaurants = List<Restaurant>.from(
          restaurant['restaurants'].map((x) => Restaurant.fromJson(x)));
      notifyListeners();
      setIsFetching(false);
      return _restaurants;
    } else {
      setIsFetching(false);
      notifyListeners();
      throw Exception('Failed to load restaurant');
    }
  }

  Future<DetailRestaurant?> getRestaurantDetail(String id) async {
    setIsFetching(true);
    final response = await http
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

  Future<List<Restaurant>> searchRestaurantByName(String name) async {
    try {
      setIsFetching(true);
      final response = await http
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
      results.map((res) => Restaurant.fromJson(res)).toList(),
    );
  }

  void addFavorite(Restaurant data) async {
    if (_favoriteData.any((element) => element.id == data.id)) {
      removeFavorite(data.id);
      return;
    }
    final Database db = await database;
    await db.insert(
      'favorite',
      data.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    _favoriteData.add(data);
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
