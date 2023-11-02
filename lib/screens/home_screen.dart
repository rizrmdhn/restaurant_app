import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/components/restaurant_list.dart';
import 'package:restaurant_app/provider/main.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  final String? connectionStatus;

  const HomeScreen({Key? key, this.connectionStatus}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final searchRestaurantController = TextEditingController();

  @override
  void dispose() {
    searchRestaurantController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ContextModel>(
      builder: (context, value, child) => Scaffold(
        body: Column(
          children: <Widget>[
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(
                      top: 50,
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
                                          'Please input restaurant name'),
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
                                // set loading to true
                                context
                                    .read<ContextModel>()
                                    .setIsFetching(true);
                                // search restaurant by name
                                context
                                    .read<ContextModel>()
                                    .searchRestaurantByName(
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
