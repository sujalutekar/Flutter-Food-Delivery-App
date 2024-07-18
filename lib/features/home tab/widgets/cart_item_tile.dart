import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cart_bloc.dart';

// todo
// add pageview for cart tile
// add the whole restuarant into firebase

class CartItemTile extends StatefulWidget {
  const CartItemTile({super.key});

  @override
  State<CartItemTile> createState() => _CartItemTileState();
}

class _CartItemTileState extends State<CartItemTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6)
          .copyWith(left: 9),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            blurRadius: 2,
            spreadRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is TotalCartLength) {
            return state.totalLength > 0
                ? StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('orders')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection('cartItems')
                        .snapshots(),
                    builder: (context, snapshot) {
                      print(snapshot.requireData.docs.first['restaurantName']);
                      var data = snapshot.requireData.docs;

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: Text('An error occurred'),
                        );
                      } else if (!snapshot.hasData ||
                          snapshot.data!.docs.isEmpty) {
                        return const Center(
                          child: Text('No data found'),
                        );
                      }

                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(
                              'https://www.pngkey.com/png/full/114-1149878_setting-user-avatar-in-specific-size-without-breaking.png',
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                data.first['restaurantName'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                '5 items',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey.shade700),
                              ),
                            ],
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.red.shade500,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                'View Cart',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.close_rounded,
                              size: 18,
                            ),
                          ),
                        ],
                      );
                    },
                  )
                : const Text('No items in cart');
          } else {
            return const Text('Something went wrong');
          }
        },
      ),
    );
  }
}
