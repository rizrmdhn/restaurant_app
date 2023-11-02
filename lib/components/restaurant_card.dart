import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/provider/main.dart';
import 'package:restaurant_app/screens/detail_screen.dart';

class RestaurantCard extends StatelessWidget {
  final String id;
  final String name;
  final String city;
  final double rating;
  final String pictureId;
  final Restaurant restaurant;

  const RestaurantCard({
    Key? key,
    required this.id,
    required this.name,
    required this.city,
    required this.rating,
    required this.pictureId,
    required this.restaurant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ContextModel>(
      builder: (context, value, child) {
        return InkWell(
          onTap: () {
            context.read<ContextModel>().getDetailRestaurant(id);
            Navigator.pushNamed(
              context,
              DetailScreen.routeName,
              arguments: restaurant,
            );
          },
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(10),
              ),
              Row(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      pictureId,
                      height: 95,
                      width: 125,
                      fit: BoxFit.fill,
                      errorBuilder: (ctx, error, _) =>
                          const Center(child: Icon(Icons.error)),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin:
                            const EdgeInsets.only(left: 10, top: 10, right: 5),
                        padding: const EdgeInsets.all(3),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Text(
                          name,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            left: 10, bottom: 5, right: 5),
                        padding: const EdgeInsets.all(3),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              size: 12,
                              color: Colors.red,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              city,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            left: 10, top: 10, bottom: 5, right: 5),
                        padding: const EdgeInsets.all(3),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.star,
                              size: 12,
                              color: Colors.yellow,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              rating.toString(),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
