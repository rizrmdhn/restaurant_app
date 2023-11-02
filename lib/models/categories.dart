import 'dart:convert';

class Categories {
  String name;

  Categories({
    required this.name,
  });

  factory Categories.fromRawJson(String str) =>
      Categories.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
