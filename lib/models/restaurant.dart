import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Restaurant {
  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  factory Restaurant.fromRawJson(String str) =>
      Restaurant.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
      };
}

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

  void setIsFetching(bool fetching) {
    _isFetching = fetching;
    notifyListeners();
  }
}
