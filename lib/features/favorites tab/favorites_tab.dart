import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie/models/restuarant.dart';

import '../home tab/agruments/restuarant_detail_arg.dart';
import '../home tab/bloc/home_bloc.dart';
import '../home tab/pages/restuarant_detail_page.dart';
import '../home tab/widgets/restuarant_tile.dart';

class FavoritesTab extends StatefulWidget {
  const FavoritesTab({super.key});

  @override
  State<FavoritesTab> createState() => _FavoritesTabState();
}

TabBar get _tabBar => const TabBar(
      tabs: [
        Tab(
          child: Text('Food Items'),
        ),
        Tab(
          child: Text('Restaurants'),
        ),
      ],
    );

class _FavoritesTabState extends State<FavoritesTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('restuarants')
                .where('favourite', isEqualTo: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text(
                    'No Favorite Restuarants!',
                    style: TextStyle(fontSize: 18),
                  ),
                );
              }

              var data = snapshot.requireData.docs;

              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  // check if the restaurant is favourite
                  bool isFavourite = data[index]['favourite'];

                  // single restaurant object
                  Restaurant singleRestuarant = Restaurant(
                    id: data[index]['id'],
                    name: data[index]['name'],
                    address: data[index]['address'],
                    phone: data[index]['phone'],
                    image: data[index]['image'],
                    description: data[index]['description'],
                    rating: data[index]['rating'],
                    hours: data[index]['hours'],
                    price: data[index]['price'],
                    tags: data[index]['tags'],
                    favourite: data[index]['favourite'],
                  );

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: RestaurantTile(
                      restaurant: singleRestuarant,
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          RestuarantDetailPage.routeName,
                          arguments: RestuarantDetailArguments(
                            restaurant: singleRestuarant,
                          ),
                        );
                      },
                      onPressed: () {
                        context.read<HomeBloc>().add(
                              ToggleFavouriteRestuarant(
                                restaurantId: singleRestuarant.id,
                                currentFavoriteStatus:
                                    singleRestuarant.favourite,
                              ),
                            );
                      },
                      icon: isFavourite
                          ? const Icon(Icons.favorite)
                          : const Icon(Icons.favorite_border),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
