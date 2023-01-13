import 'package:flutter/material.dart';
import 'package:restaurant_app/modal/data/restaurant.dart';
import 'package:restaurant_app/ui/detail_pages.dart';
import 'package:restaurant_app/ui/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        RestaurantListPage.routeName: (context) => const RestaurantListPage(),
        DetailScreen.routeName: (context) => DetailScreen(
              dataRestaurant: ModalRoute.of(context)?.settings.arguments
                  as RestaurantElement,
            ),
      },
    );
  }
}

class RestaurantListPage extends StatelessWidget {
  static const routeName = '/Restaurant_list';

  const RestaurantListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant App'),
      ),
      body: FutureBuilder<String>(
        future: DefaultAssetBundle.of(context)
            .loadString('assets/local_restaurant.json'),
        builder: (context, snapshot) {
          final List<RestaurantElement> restaurant =
              parseRestaurantElement(snapshot.data);
          return ListView.builder(
            itemCount: restaurant.length,
            itemBuilder: (context, index) {
              return _buildArticleItem(context, restaurant[index]);
            },
          );
        },
      ),
    );
  }

  Widget _buildArticleItem(BuildContext context, RestaurantElement restaurant) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      leading: Image.network(
        restaurant.pictureId,
        width: 100,
      ),
      title: Text(restaurant.name),
      subtitle: Text(restaurant.city),
      onTap: () {
        Navigator.pushNamed(context, DetailScreen.routeName,
            arguments: restaurant);
      },
    );
  }
}

// ListTile(
//       contentPadding:
//           const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//       leading: Image.network(
//         restaurant.pictureId,
//         width: 100,
//       ),
//       title: Text(restaurant.name),
//       subtitle: Text(restaurant.city),
//       onTap: () {
//         Navigator.pushNamed(context, DetailScreen.routeName,
//             arguments: restaurant);
//       },
//     );

    // return Scaffold(
    //   body: ListTile(
    //     title: Column(
    //       children: <Widget>[
    //         Container(
    //           child: Container(
    //             margin: EdgeInsets.only(top: 45, bottom: 15),
    //             padding: EdgeInsets.only(left: 20, right: 20),
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //                 Column(
    //                   children: [
    //                     Text('Restaurant App'),
    //                     Text('City'),
    //                   ],
    //                 ),
    //                 Container(
    //                   width: 45,
    //                   height: 45,
    //                   child: Icon(
    //                     Icons.search,
    //                     color: Colors.white,
    //                   ),
    //                   decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.circular(15),
    //                     color: Colors.blue,
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );