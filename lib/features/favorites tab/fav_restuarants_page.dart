import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie/features/home%20tab/bloc/home_bloc.dart';
import 'package:foodie/features/home%20tab/widgets/restuarant_tile.dart';
import 'package:foodie/models/restuarant.dart';

class FavRestuarantPage extends StatelessWidget {
  const FavRestuarantPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 16, top: 16),
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
                    onPressed: () {
                      context.read<HomeBloc>().add(
                            ToggleFavouriteRestuarant(
                              restaurantId: singleRestuarant.id,
                              currentFavoriteStatus: singleRestuarant.favourite,
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
    );
  }
}
