import 'package:flutter/material.dart';
import 'package:restaurant_app/models/categories.dart';
import 'package:restaurant_app/models/customer_review.dart';
import 'package:restaurant_app/models/menus.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DetailRestaurant {
  String id;
  String name;
  String description;
  String city;
  String address;
  String pictureId;
  List<Categories> categories;
  Menus menus;
  double rating;
  List<CustomerReview> customerReviews;

  DetailRestaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.pictureId,
    required this.categories,
    required this.menus,
    required this.rating,
    required this.customerReviews,
  });

  factory DetailRestaurant.fromRawJson(String str) =>
      DetailRestaurant.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DetailRestaurant.fromJson(Map<String, dynamic> json) =>
      DetailRestaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        city: json["city"],
        address: json["address"],
        pictureId: json["pictureId"],
        categories: List<Categories>.from(
            json["categories"].map((x) => Categories.fromJson(x))),
        menus: Menus.fromJson(json["menus"]),
        rating: json["rating"]?.toDouble(),
        customerReviews: List<CustomerReview>.from(
            json["customerReviews"].map((x) => CustomerReview.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "city": city,
        "address": address,
        "pictureId": pictureId,
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "menus": menus.toJson(),
        "rating": rating,
        "customerReviews":
            List<dynamic>.from(customerReviews.map((x) => x.toJson())),
      };
}

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
