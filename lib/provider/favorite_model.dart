import 'package:flutter/material.dart';
import 'package:restaurant_app/database/main.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:sqflite/sqflite.dart';

class FavoriteData {
  final String id;

  FavoriteData({
    required this.id,
  });

  factory FavoriteData.fromJson(Map<String, dynamic> json) => FavoriteData(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}

class FavoriteModel extends ChangeNotifier {
  final List<Restaurant> _favoriteData = [];

  List<Restaurant> get favoriteData => _favoriteData;

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

  bool isFavorite(String id) {
    return _favoriteData.any((element) => element.id == id);
  }
}
