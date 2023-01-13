import 'package:flutter/material.dart';
import 'package:restaurant_app/modal/data/restaurant.dart';
import 'package:restaurant_app/searchTextStyle/smallText.dart';
import 'package:restaurant_app/style/style.dart';
import 'package:restaurant_app/searchTextStyle/bigText.dart';
import 'package:restaurant_app/ui/Icons_dan_Text.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:restaurant_app/ui/detail_pages.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            child: Container(
              margin: EdgeInsets.only(top: 45, bottom: 15),
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      BigText(
                        textBig: 'Indonesia',
                        color: searchColor,
                      ),
                      Row(
                        children: [
                          SmallText(
                            smallText: 'pilih resto',
                            color: Colors.black45,
                          ),
                          Icon(Icons.arrow_drop_down_rounded)
                        ],
                      ),
                    ],
                  ),
                  Center(
                    child: Container(
                      width: 45,
                      height: 45,
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: searchColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: HomeFoodBody(),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeFoodBody extends StatefulWidget {
  const HomeFoodBody({super.key});

  @override
  State<HomeFoodBody> createState() => _HomeFoodBodyState();
}

class _HomeFoodBodyState extends State<HomeFoodBody> {
  PageController halamanKontrol = PageController(viewportFraction: 0.85);
  var _hitungPageValue = 0.0;
  double _scalaFaktor = 0.8;
  double _tinggi = 220;
  // late List<RestaurantElement> restaurantList = [];
  late int _itemSlideActive = 0;

  @override
  void initState() {
    super.initState();
    halamanKontrol.addListener(() {
      setState(() {
        _hitungPageValue = halamanKontrol.page!;
      });
    });
  }

  @override
  void dispose() {
    halamanKontrol.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // color: Colors.redAccent,
          height: 320,
          child: FutureBuilder<String>(
            future: DefaultAssetBundle.of(context)
                .loadString('assets/local_restaurant.json'),
            builder: (context, snapshot) {
              final List<RestaurantElement> restaurant =
                  parseRestaurantElement(snapshot.data);
              return PageView.builder(
                  controller: halamanKontrol,
                  itemCount: restaurant.length,
                  itemBuilder: (context, position) {
                    return _buildPageFoodItem(
                        context, restaurant[position], position);
                  });
            },
          ),
        ),
        new DotsIndicator(
          dotsCount: 10,
          position: _hitungPageValue,
          decorator: DotsDecorator(
            activeColor: Colors.blue,
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          margin: EdgeInsets.only(left: 10),
          child: Row(
            children: <Widget>[
              BigText(textBig: 'Populer'),
              SizedBox(
                width: 10,
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
                child: SmallText(smallText: 'This Food'),
              ),
            ],
          ),
        ),
        FutureBuilder<String>(
            future: DefaultAssetBundle.of(context)
                .loadString('assets/local_restaurant.json'),
            builder: (context, snapshot) {
              final List<RestaurantElement> restaurantKu =
                  parseRestaurantElement(snapshot.data);
              return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: restaurantKu.length,
                  itemBuilder: ((context, index) {
                    return ListPagesFood(context, restaurantKu[index]);
                  }));
            }),
      ],
    );
  }

  Container ListPagesFood(
      BuildContext context, RestaurantElement restaurantku) {
    var index = 0;
    return Container(
      margin: EdgeInsets.only(left: 15, right: 10, bottom: 8),
      child: Row(
        children: <Widget>[
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(restaurantku.pictureId),
                )),
          ),
          Expanded(
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15),
                  bottomRight: Radius.circular(10),
                ),
                color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    BigText(textBig: restaurantku.menus.foods[index].name),
                    SizedBox(
                      height: 7,
                    ),
                    SmallText(smallText: 'This is delicius food'),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 1,
                        ),
                        IconsAndTextHomePage(
                            DataIcon: Icons.location_on,
                            text: restaurantku.city,
                            iconColor: searchColor),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageFoodItem(
      BuildContext context, RestaurantElement restaurant, int position) {
    Matrix4 matrik = new Matrix4.identity();
    if (position == _hitungPageValue.floor()) {
      var scale = 1 - (_hitungPageValue - position) * (1 - _scalaFaktor);
      var transisi = _tinggi * (1 - scale) / 2;
      matrik = Matrix4.diagonal3Values(1, scale, 1)
        ..setTranslationRaw(0, transisi, 0);
    } else if (position == _hitungPageValue.floor() + 1) {
      var scale =
          _scalaFaktor + (_hitungPageValue - position + 1) * (1 - _scalaFaktor);
      var transisi = _tinggi * (1 - scale) / 2;
      matrik = Matrix4.diagonal3Values(1, scale, 1);
      matrik = Matrix4.diagonal3Values(1, scale, 1)
        ..setTranslationRaw(0, transisi, 0);
    } else if (position == _hitungPageValue.floor() - 1) {
      var scale = 1 - (_hitungPageValue - position) * (1 - _scalaFaktor);
      var transisi = _tinggi * (1 - scale) / 2;
      matrik = Matrix4.diagonal3Values(1, scale, 1);
      matrik = Matrix4.diagonal3Values(1, scale, 1)
        ..setTranslationRaw(0, transisi, 0);
    } else {
      var scalaHitung = 0.8;
      matrik = Matrix4.diagonal3Values(1, scalaHitung, 1)
        ..setTranslationRaw(0, _tinggi * (1 - _scalaFaktor) / 2, 1);
    }
    return InkWell(
      child: Transform(
        transform: matrik,
        child: Stack(
          children: <Widget>[
            Container(
              height: 220,
              margin: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: position.isEven ? Color(0xff69c5df) : Color(0xFF9294cc),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    restaurant.pictureId,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 130,
                margin: EdgeInsets.only(left: 30, right: 30, bottom: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFe8e8e8),
                      blurRadius: 5.0,
                      offset: Offset(5, 8),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-5, 0),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(5, 0),
                    ),
                  ],
                ),
                child: Container(
                  padding: EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BigText(textBig: restaurant.name),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Wrap(
                            children: List.generate(5, (index) {
                              return Icon(
                                Icons.star,
                                color: searchColor,
                                size: 15,
                              );
                            }),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SmallText(
                            smallText: restaurant.rating.toString(),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SmallText(
                            smallText: '1287',
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SmallText(
                            smallText: 'Populer',
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 1,
                          ),
                          IconsAndTextHomePage(
                              DataIcon: Icons.location_on,
                              text: restaurant.city,
                              iconColor: searchColor),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, DetailScreen.routeName,
            arguments: restaurant);
      },
    );
  }
}
