import 'dart:convert';

class Drinks {
  String name;

  Drinks({
    required this.name,
  });

  factory Drinks.fromRawJson(String str) => Drinks.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Drinks.fromJson(Map<String, dynamic> json) => Drinks(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
