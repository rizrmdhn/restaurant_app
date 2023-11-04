import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/components/restaurant_list.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/screens/favorite_screen.dart';
import 'package:restaurant_app/screens/option_screen.dart';
import 'package:restaurant_app/utils/debouncer.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  final String? connectionStatus;

  const HomeScreen({super.key, this.connectionStatus});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final searchRestaurantController = TextEditingController();
  final debouncer = Debouncer();

  @override
  void dispose() {
    searchRestaurantController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantProvider>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Restaurant App',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  FavoriteScreen.routeName,
                );
              },
              icon: const Icon(Icons.favorite),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  OptionScreen.routeName,
                );
              },
              icon: const Icon(Icons.more_vert),
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(
                      top: 20,
                      left: 20,
                      right: 20,
                      bottom: 20,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Flex(
                          direction: Axis.vertical,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Restaurant',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                              ),
                            ),
                            Text(
                              'Recommendation Restaurant For You',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        // container for search bar
                        TextField(
                          controller: searchRestaurantController,
                          onChanged: (value) async {
                            if (value.isEmpty) {
                              // search restaurant by name
                              Provider.of<RestaurantProvider>(context,
                                      listen: false)
                                  .searchRestaurantByName(http.Client(), value);
                            } else {
                              // add timeout to prevent too many request
                              debouncer.run(() {
                                // search restaurant by name
                                Provider.of<RestaurantProvider>(context,
                                        listen: false)
                                    .searchRestaurantByName(
                                        http.Client(), value);
                              });
                            }
                          },
                          decoration: InputDecoration(
                            hintText: 'Search Restaurant',
                            suffixIcon: IconButton(
                              onPressed: () {
                                var name = searchRestaurantController.text;
                                if (name.isEmpty) {
                                  // alert dialog
                                  throw showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('Warning'),
                                      content: const Text(
                                        'Please input restaurant name',
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                                // search restaurant by name
                                Provider.of<RestaurantProvider>(context,
                                        listen: false)
                                    .searchRestaurantByName(
                                  http.Client(),
                                  name,
                                );
                              },
                              icon: const Icon(Icons.search),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: widget.connectionStatus == 'ConnectivityResult.none'
                  ? const Center(child: Text('No Internet Connection'))
                  : const RestaurantList(),
            ),
          ],
        ),
      ),
    );
  }
}
