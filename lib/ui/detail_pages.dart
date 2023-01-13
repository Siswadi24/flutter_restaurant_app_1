import 'package:flutter/material.dart';
import 'package:restaurant_app/modal/data/restaurant.dart';
import 'package:restaurant_app/style/style.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DetailScreen extends StatelessWidget {
  static const routeName = '/Restaurant_detail';

  final RestaurantElement dataRestaurant;

  const DetailScreen({Key? key, required this.dataRestaurant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              leading: IconButton(
                icon: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(10)),
                  child: Image.asset(
                    'assets/icons/back2.png',
                    color: grey2,
                  ),
                  // SvgPicture
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              backgroundColor: primary,
              expandedHeight: MediaQuery.of(context).size.height * 0.4,
              flexibleSpace: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                child: Stack(
                  children: [
                    Align(
                      child: Container(
                        width: double.infinity,
                        height: 450,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(dataRestaurant.pictureId),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 20,
                        color: Colors.transparent,
                        child: Column(
                          children: [
                            Container(
                              height: 20,
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30),
                                  )),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  InfoDetailRestaurant(dataRestaurant: dataRestaurant),
                  DetailPagesRestaurant(dataRestaurant: dataRestaurant),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DetailPagesRestaurant extends StatefulWidget {
  final RestaurantElement dataRestaurant;

  const DetailPagesRestaurant({Key? key, required this.dataRestaurant})
      : super(key: key);

  @override
  State<DetailPagesRestaurant> createState() => _DetailPagesRestaurantState();
}

class _DetailPagesRestaurantState extends State<DetailPagesRestaurant> {
  late int _activeTabView = 0;
  List<Widget> listTabView = [];

  @override
  void initState() {
    listTabView = [
      DescribeContentDetail(
        describeDetail: widget.dataRestaurant.description,
      ),
      ContentMenuDetailFoods(
        contentMenuFoods: widget.dataRestaurant.menus.foods,
      ),
      ContentMenuDetailDrinks(
        contentMenuDrinks: widget.dataRestaurant.menus.drinks,
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 28,
            child: DefaultTabController(
              length: 3,
              child: TabBar(
                isScrollable: true,
                indicatorPadding: const EdgeInsets.only(left: 32, right: 32),
                unselectedLabelColor: grey1,
                indicatorColor: primary,
                labelColor: primary,
                labelStyle: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                unselectedLabelStyle: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                onTap: (index) {
                  setState(() {
                    _activeTabView = index;
                  });
                },
                tabs: [
                  Tab(
                    child: Text(
                      'Deskripsi',
                      style: Theme.of(context)
                          .textTheme
                          .button
                          ?.copyWith(color: dark),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Makanan',
                      style: Theme.of(context)
                          .textTheme
                          .button
                          ?.copyWith(color: dark),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Minuman',
                      style: Theme.of(context)
                          .textTheme
                          .button
                          ?.copyWith(color: dark),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          listTabView.isNotEmpty
              ? listTabView[_activeTabView]
              : Text('LOADING...')
        ],
      ),
    );
  }
}

class DescribeContentDetail extends StatelessWidget {
  final String describeDetail;

  const DescribeContentDetail({Key? key, required this.describeDetail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 16,
      ),
      child: Text(describeDetail),
    );
  }
}

class ContentMenuDetailFoods extends StatelessWidget {
  final List<Drink> contentMenuFoods;
  const ContentMenuDetailFoods({Key? key, required this.contentMenuFoods})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Wrap(
        spacing: 5,
        children: contentMenuFoods
            .map(
              (valueRestaurant) => ChoiceChip(
                disabledColor: Colors.grey[200],
                side: BorderSide.none,
                labelStyle: Theme.of(context)
                    .textTheme
                    .button!
                    .copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                selected: false,
                label: Text(
                  valueRestaurant.name,
                  style: TextStyle(
                    color: Colors.orange[800],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class ContentMenuDetailDrinks extends StatelessWidget {
  final List<Drink> contentMenuDrinks;

  const ContentMenuDetailDrinks({Key? key, required this.contentMenuDrinks})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Wrap(
        spacing: 6,
        children: contentMenuDrinks
            .map(
              (value) => ChoiceChip(
                disabledColor: Colors.grey[300],
                side: BorderSide.none,
                labelStyle: Theme.of(context)
                    .textTheme
                    .button!
                    .copyWith(fontSize: 12, fontWeight: FontWeight.w400),
                selected: false,
                label: Text(
                  value.name,
                  style: TextStyle(
                    color: Colors.green[900],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class InfoDetailRestaurant extends StatelessWidget {
  final RestaurantElement dataRestaurant;

  const InfoDetailRestaurant({Key? key, required this.dataRestaurant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(dataRestaurant.name,
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(fontWeight: FontWeight.w700)),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  RatingBar(
                      initialRating: dataRestaurant.rating,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 15,
                      ratingWidget: RatingWidget(
                        empty: const Icon(
                          Icons.star_border,
                          color: grey1,
                        ),
                        full: const Icon(
                          Icons.star,
                          color: orange,
                        ),
                        half: const Icon(
                          Icons.star_half,
                          color: orange,
                        ),
                      ),
                      onRatingUpdate: ((value) {})),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(dataRestaurant.rating.toString()),
                ],
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/map.svg',
                    color: grey1,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    dataRestaurant.city,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
