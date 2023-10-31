import 'package:restaurant_app/models/drinks.dart';
import 'package:restaurant_app/models/foods.dart';

class Menus {
  final List<Foods> foods;
  final List<Drinks> drinks;

  Menus({
    required this.foods,
    required this.drinks,
  });

  static fromJson(restaurant) {
    return Menus(
      foods: List<Foods>.from(
          restaurant['foods'].map((food) => Foods.fromJson(food))),
      drinks: List<Drinks>.from(
          restaurant['drinks'].map((drink) => Drinks.fromJson(drink))),
    );
  }
}
