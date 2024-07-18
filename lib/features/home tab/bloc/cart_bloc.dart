// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String userId =
      FirebaseAuth.instance.currentUser!.uid; // Replace with actual user UID

  CartBloc() : super(CartInitial()) {
    _initializeCart();

    on<AddItemEvent>((event, emit) async {
      await _updateCartItemCount(
          event.itemId, 1, event.restaurantId, event.restaurantName);
      emit(CartUpdated(await _getItems()));
    });

    on<RemoveItemEvent>((event, emit) async {
      await _updateCartItemCount(
          event.itemId, -1, event.restaurantId, event.restaurantName);
      emit(CartUpdated(await _getItems()));
    });

    on<GetItemLenghtInCart>((event, emit) async {
      await _isItemInCart();
      emit(TotalCartLength(await _isItemInCart()));
    });
  }

  Future<void> _initializeCart() async {
    final collection =
        _firestore.collection('orders').doc(userId).collection('cartItems');
    final snapshot = await collection.get();
    if (snapshot.docs.isEmpty) {
      emit(CartUpdated(const {}));
    } else {
      emit(CartUpdated(await _getItems()));
    }
  }

  Future<Map<String, int>> _getItems() async {
    final snapshot = await _firestore
        .collection('orders')
        .doc(userId)
        .collection('cartItems')
        .get();
    return {for (var doc in snapshot.docs) doc.id: doc.data()['itemCount']};
  }

  Future<void> _updateCartItemCount(String itemId, int change,
      String restuarantId, String restuarantName) async {
    final userIdDoc =
        FirebaseFirestore.instance.collection('orders').doc(userId);
    userIdDoc.set({
      'Timestamp': FieldValue.serverTimestamp(),
    });

    final doc = _firestore
        .collection('orders')
        .doc(userId)
        .collection('cartItems')
        .doc(itemId);
    final snapshot = await doc.get();
    final currentCount =
        snapshot.exists ? snapshot.data()!['itemCount'] ?? 0 : 0;
    final newCount = (currentCount + change).clamp(0, double.infinity).toInt();

    if (newCount > 0) {
      await doc.set({
        'itemCount': newCount,
        'itemId': itemId,
        'restaurantId': restuarantId,
        'restaurantName': restuarantName,
      });
    } else {
      await doc.delete();
    }
  }

  Future<int> _isItemInCart() async {
    final snapshot = await _firestore
        .collection('orders')
        .doc(userId)
        .collection('cartItems')
        .get();
    print('SNAPSHOT LENGTH: ${snapshot.docs.length}');
    return snapshot.docs.length;
  }

  // Future<void> clearCart() async {
  //   final collection =
  //       _firestore.collection('orders').doc(userId).collection('cartItems');
  //   final snapshot = await collection.get();
  //   for (var doc in snapshot.docs) {
  //     await doc.reference.delete();
  //   }
  //   emit(CartUpdated(const {}));
  // }
}
