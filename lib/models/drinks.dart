class Drinks {
  final String name;

  Drinks({
    required this.name,
  });

  static fromJson(drink) {
    return Drinks(
      name: drink['name'],
    );
  }
}
