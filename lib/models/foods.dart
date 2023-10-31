class Foods {
  final String name;

  Foods({
    required this.name,
  });

  static fromJson(food) {
    return Foods(
      name: food['name'],
    );
  }
}
