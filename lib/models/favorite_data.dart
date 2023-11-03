class FavoriteData {
  String id;

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
