import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/models/detail_restaurant.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'fetch_restaurant_test.mocks.dart';

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks([http.Client])
void main() {
  sqfliteFfiInit();

  databaseFactory = databaseFactoryFfi;
  group('fetch restaurants', () {
    test(
        'returns a list of restaurants if the http call completes successfully',
        () async {
      final client = MockClient();
      final restaurantProvider = RestaurantProvider();

      var dummyResponse = '''
      {
        "error": false,
        "message": "success",
        "count": 20,
        "restaurants": [
          {
            "id": "rqdv5juczeskfw1e867",
            "name": "Melting Pot",
            "description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
            "pictureId": "14",
            "city": "Medan",
            "rating": 4.2
          },
          {
            "id": "s1knt6za9kkfw1e867",
            "name": "Kafe Kita",
            "description": "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,",
            "pictureId": "25",
            "city": "Gorontalo",
            "rating": 4
          }
        ]
      }
      ''';

      when(client.get(Uri.parse('https://restaurant-api.dicoding.dev/list')))
          .thenAnswer((_) async => http.Response(dummyResponse, 200));

      expect(
        restaurantProvider.getRestaurant(client),
        isA<Future<List<Restaurant>>>(),
      );
    });
  });

  group("fetch restaurant details", () {
    test(
        'returns a list of restaurants if the http call completes successfully',
        () async {
      final client = MockClient();
      final restaurantProvider = RestaurantProvider();

      var dummyResponse = '''
      {
  "error": false,
  "message": "success",
  "restaurant": {
    "id": "rqdv5juczeskfw1e867",
    "name": "Melting Pot",
    "description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
    "city": "Medan",
    "address": "Jln. Pandeglang no 19",
    "pictureId": "14",
    "categories": [
      {
        "name": "Italia"
      },
      {
        "name": "Modern"
      }
    ],
    "menus": {
      "foods": [
        {
          "name": "Paket rosemary"
        },
        {
          "name": "Toastie salmon"
        },
        {
          "name": "Bebek crepes"
        },
        {
          "name": "Salad lengkeng"
        }
      ],
      "drinks": [
        {
          "name": "Es krim"
        },
        {
          "name": "Sirup"
        },
        {
          "name": "Jus apel"
        },
        {
          "name": "Jus jeruk"
        },
        {
          "name": "Coklat panas"
        },
        {
          "name": "Air"
        },
        {
          "name": "Es kopi"
        },
        {
          "name": "Jus alpukat"
        },
        {
          "name": "Jus mangga"
        },
        {
          "name": "Teh manis"
        },
        {
          "name": "Kopi espresso"
        },
        {
          "name": "Minuman soda"
        },
        {
          "name": "Jus tomat"
        }
      ]
    },
    "rating": 4.2,
    "customerReviews": [
      {
        "name": "Ahmad",
        "review": "Tidak rekomendasi untuk pelajar!",
        "date": "13 November 2019"
      },
      {
        "name": "dzikryy",
        "review": "bla bla bla",
        "date": "3 November 2023"
      },
      {
        "name": "halo",
        "review": "tes",
        "date": "3 November 2023"
      },
      {
        "name": "halo",
        "review": "aundwnixxnjsjwnxisnxnsicnsinciencieciexniwnxiwnixwnxiwnxiw is xks xinwkxienciwnxiwmxwocmwkcnwlnlwnclwncoencowncowncow",
        "date": "3 November 2023"
      },
      {
        "name": "halo",
        "review": "bk",
        "date": "3 November 2023"
      },
      {
        "name": "halo",
        "review": "ks",
        "date": "3 November 2023"
      },
      {
        "name": "halo",
        "review": "xjs",
        "date": "3 November 2023"
      },
      {
        "name": "aku",
        "review": "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
        "date": "3 November 2023"
      },
      {
        "name": "ghjk",
        "review": "aaa",
        "date": "3 November 2023"
      },
      {
        "name": "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadddddddddddddd",
        "review": "asssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss",
        "date": "3 November 2023"
      },
      {
        "name": "asdfasdf",
        "review": "asdfasdfasdfasfdasdfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff",
        "date": "3 November 2023"
      },
      {
        "name": "asad",
        "review": "asdf asdf werwes  sd sg dfg dfg dfgdfgdf dfgdg werw sdfs cvvxvvc",
        "date": "3 November 2023"
      },
      {
        "name": "Riana",
        "review": "tempatnya nyaman",
        "date": "3 November 2023"
      },
      {
        "name": "test",
        "review": "test",
        "date": "3 November 2023"
      },
      {
        "name": "p",
        "review": "p",
        "date": "3 November 2023"
      },
      {
        "name": "tes",
        "review": "Lorem ipsum dolor sit amet consectetur adipisicing elit. Fugiat, et odio. Veniam nemo iste perspiciatis omnis! Dolores nihil dignissimos veniam corporis. Quia ratione eos incidunt ducimus facere ab omnis et ipsum! Recusandae excepturi, ratione sapiente possimus a eos earum molestiae harum, illo obcaecati quibusdam reprehenderit dolores! Cupiditate reprehenderit earum eos at animi ipsa eius reiciendis cumque dolor repellendus laboriosam accusantium sunt nam ratione fugit, quis odit inventore, expedita eligendi ab. Nisi ut excepturi ea praesentium nobis debitis beatae corrupti, tempore quos cupiditate, nostrum quis omnis eius placeat a unde, officiis inventore quod facere? Aliquam velit cum ex quia tenetur fugiat.",
        "date": "3 November 2023"
      },
      {
        "name": "A",
        "review": "A",
        "date": "3 November 2023"
      },
      {
        "name": "test",
        "review": "test",
        "date": "3 November 2023"
      },
      {
        "name": "test",
        "review": "test",
        "date": "3 November 2023"
      },
      {
        "name": "test",
        "review": "test",
        "date": "3 November 2023"
      }
    ]
  }
}
      ''';

      when(client.get(Uri.parse(
              'https://restaurant-api.dicoding.dev/detail/rqdv5juczeskfw1e867')))
          .thenAnswer((_) async => http.Response(dummyResponse, 200));

      expect(
        restaurantProvider.getRestaurantDetail(client, 'rqdv5juczeskfw1e867'),
        isA<Future<DetailRestaurant?>>(),
      );
    });
  });

  group('search restaurant by name', () {
    test(
        'returns a list of restaurants if the http call completes successfully',
        () async {
      final client = MockClient();
      final restaurantProvider = RestaurantProvider();

      var dummyResponse = '''
      {
  "error": false,
  "founded": 1,
  "restaurants": [
    {
      "id": "s1knt6za9kkfw1e867",
      "name": "Kafe Kita",
      "description": "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,",
      "pictureId": "25",
      "city": "Gorontalo",
      "rating": 4
    }
  ]
}
      ''';
      when(client.get(Uri.parse(
              'https://restaurant-api.dicoding.dev/search?q=Kafe Kita')))
          .thenAnswer((_) async => http.Response(dummyResponse, 200));

      expect(
        restaurantProvider.searchRestaurantByName(client, 'Kafe Kita'),
        isA<Future<List<Restaurant>>>(),
      );
    });
  });
}
