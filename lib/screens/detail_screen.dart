import 'package:flutter/material.dart';
import 'package:restaurant_app/models/restaurant.dart';

class DetailScreen extends StatelessWidget {
  static const routeName = '/detail';

  final Restaurant restaurant;

  const DetailScreen({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 200,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  restaurant.pictureId,
                  fit: BoxFit.cover,
                ),
                title: Text(
                  restaurant.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),
          ];
        },
        // scroll view
        body: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 10, right: 20, left: 20, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // title
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Text(
                      restaurant.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  // city
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      restaurant.city,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  // rating
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          restaurant.rating.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // description
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      restaurant.description,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  // menu
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Menu',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 100,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: restaurant.menus.foods.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey[200],
                                      ),
                                      constraints:
                                          const BoxConstraints(maxWidth: 150),
                                      margin: const EdgeInsets.only(right: 10),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.only(
                                                left: 15,
                                                right: 15,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Icon(
                                                    Icons.fastfood,
                                                    size: 50,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              restaurant
                                                  .menus.foods[index].name,
                                              style: const TextStyle(
                                                fontSize: 16,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: false,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 100,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: restaurant.menus.drinks.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey[200],
                                      ),
                                      width: 150,
                                      margin: const EdgeInsets.only(right: 10),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.only(
                                                left: 15,
                                                right: 15,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Icon(
                                                    Icons.fastfood,
                                                    size: 50,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              restaurant
                                                  .menus.drinks[index].name,
                                              style: const TextStyle(
                                                fontSize: 16,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: false,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
