import 'dart:convert';

class Foods {
  String name;

  Foods({
    required this.name,
  });

  factory Foods.fromRawJson(String str) => Foods.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Foods.fromJson(Map<String, dynamic> json) => Foods(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
