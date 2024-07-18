import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class FavFoodItemsPage extends StatelessWidget {
  const FavFoodItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('restuarants').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'No Favorite Food Items!',
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((restuarantDoc) {
              return StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('restuarants')
                    .doc(restuarantDoc.id)
                    .collection('FoodItems')
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
                        'No Favorite Food Items!!!!!!!!!',
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  }

                  print(snapshot.requireData.docs.first.data());

                  return Container();
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
