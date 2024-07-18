import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie/models/restuarant.dart';

class SearchPage extends StatefulWidget {
  static const String routeName = '/search';
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  void _updateSearchQuery(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();
    });
  }

  Stream<List<Restaurant>> _searchRestaurants() {
    if (_searchQuery.isEmpty) {
      return FirebaseFirestore.instance
          .collection('restuarants')
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => Restaurant.fromDocument(doc))
              .toList());
    } else {
      return FirebaseFirestore.instance
          .collectionGroup('FoodItems')
          .where('name', isEqualTo: _searchQuery)
          .snapshots()
          .asyncMap((snapshot) async {
        Set<String> restaurantIds =
            snapshot.docs.map((doc) => doc.reference.parent.parent!.id).toSet();

        List<Restaurant> restaurants = [];
        for (String restaurantId in restaurantIds) {
          DocumentSnapshot restaurantDoc = await FirebaseFirestore.instance
              .collection('restaurants')
              .doc(restaurantId)
              .get();

          if (restaurantDoc.exists) {
            restaurants.add(Restaurant.fromDocument(restaurantDoc));
          }
        }
        return restaurants;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Search for food...',
          ),
          onChanged: _updateSearchQuery,
        ),
      ),
      body: StreamBuilder<List<Restaurant>>(
        stream: _searchRestaurants(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No restaurants found.'));
          } else {
            final restaurants = snapshot.data!;
            return ListView.builder(
              itemCount: restaurants.length,
              itemBuilder: (context, index) {
                final restaurant = restaurants[index];
                return ListTile(
                  title: Text(restaurant.name),
                  subtitle: Text(restaurant.address),
                  leading: Image.network(restaurant.image),
                );
              },
            );
          }
        },
      ),
    );
  }
}
