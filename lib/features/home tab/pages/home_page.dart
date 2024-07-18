import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../authentication/bloc/auth_bloc.dart';
import '../../../models/restuarant.dart';
import '../agruments/restuarant_detail_arg.dart';
import '../bloc/home_bloc.dart';
import '../widgets/app_drawer.dart';
import '../widgets/cart_item_tile.dart';
import '../widgets/category_tile.dart';
import '../widgets/restuarant_tile.dart';
import '../widgets/search_bar.dart';
import './restuarant_detail_page.dart';
import './search_page.dart';

class HomePage extends StatelessWidget {
  static const String routeName = '/home';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text('Home Page'),
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthBloc>().add(AuthLogoutRequested());
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'What would you like\nto order',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  CustomSearchBar(onTap: () {
                    Navigator.of(context).pushNamed(SearchPage.routeName);
                  }),
                  const SizedBox(height: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        CategoryTile(
                          onTap: () {},
                          imageUrl:
                              'https://www.foodandwine.com/thmb/DI29Houjc_ccAtFKly0BbVsusHc=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/crispy-comte-cheesburgers-FT-RECIPE0921-6166c6552b7148e8a8561f7765ddf20b.jpg',
                          title: 'Burgers',
                          color: Colors.grey.shade300,
                        ),
                        CategoryTile(
                          onTap: () {},
                          imageUrl:
                              'https://i.pinimg.com/736x/e8/bb/fe/e8bbfef4616d2bbee9a9f0cd3f35ded5.jpg',
                          title: 'Desert',
                          color: Colors.grey.shade300,
                        ),
                        CategoryTile(
                          onTap: () {},
                          imageUrl:
                              'https://www.foodandwine.com/thmb/Wd4lBRZz3X_8qBr69UOu2m7I2iw=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/classic-cheese-pizza-FT-RECIPE0422-31a2c938fc2546c9a07b7011658cfd05.jpg',
                          title: 'Pizza',
                          color: Colors.grey.shade300,
                        ),
                        CategoryTile(
                          onTap: () {},
                          imageUrl:
                              'https://www.bitesbee.com/wp-content/uploads/2021/09/banner-3.jpg',
                          title: 'Desi',
                          color: Colors.grey.shade300,
                        ),
                        CategoryTile(
                          onTap: () {},
                          imageUrl:
                              'https://www.teacupsfull.com/cdn/shop/articles/Screenshot_2023-10-20_at_11.07.13_AM.png?v=1697780292',
                          title: 'Chai',
                          color: Colors.grey.shade300,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Featured Restaurants',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // displaying restaurant list from firebase firestore
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('restuarants')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: SizedBox(
                            height: 312,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: 5, // Display 5 shimmer items
                              itemBuilder: (context, index) {
                                return Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  width: 200,
                                  height: 300,
                                  color: Colors.white,
                                );
                              },
                            ),
                          ),
                        );
                      }
                      var data = snapshot.requireData.docs;

                      return SizedBox(
                        height: 312,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: data.length,
                          itemBuilder: (context, index) {
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

                            bool isFavourite = data[index]['favourite'];

                            return RestaurantTile(
                              restaurant: singleRestuarant,
                              onTap: () {
                                log('Clicked on ${data[index]['name']}');
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
                            );
                          },
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: CartItemTile(),
          ),
        ],
      ),
    );
  }
}
