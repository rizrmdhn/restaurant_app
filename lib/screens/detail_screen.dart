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
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  restaurant.pictureId,
                  fit: BoxFit.cover,
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
                  // // rating
                  // Container(
                  //   margin: const EdgeInsets.only(bottom: 10),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       const Icon(
                  //         Icons.star,
                  //         color: Colors.yellow,
                  //       ),
                  //       Text(
                  //         restaurant.rating.toString(),
                  //         style: const TextStyle(
                  //           fontSize: 16,
                  //           color: Colors.grey,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
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
                        // rounded border
                        SizedBox(
                          height: 100,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: restaurant.menus.foods.length,
                            itemBuilder: (context, index) {
                              return Container(
                                width: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey[200],
                                ),
                                margin: const EdgeInsets.only(right: 10),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      // make icon align end
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
                                        restaurant.menus.foods[index].name,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 150,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: restaurant.menus.drinks.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.only(right: 10),
                                child: Column(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 10),
                                      child: Icon(
                                        Icons.fastfood,
                                        size: 50,
                                      ),
                                    ),
                                    Text(
                                      restaurant.menus.drinks[index].name,
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
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
