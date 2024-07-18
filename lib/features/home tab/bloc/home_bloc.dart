import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<ToggleFavouriteRestuarant>(_onToggleFavouriteRestuarant);

    on<ToogleFavouriteFoodItem>(_onToogleFavouriteFoodItem);
  }

  void _onToggleFavouriteRestuarant(
    ToggleFavouriteRestuarant event,
    Emitter<HomeState> emit,
  ) async {
    final newFavoriteStatus = !event.currentFavoriteStatus;

    await FirebaseFirestore.instance
        .collection('restuarants')
        .doc(event.restaurantId)
        .update({
      'favourite': newFavoriteStatus,
    });

    emit(FavouriteRestuarantState(newFavoriteStatus));
  }

  void _onToogleFavouriteFoodItem(
    ToogleFavouriteFoodItem event,
    Emitter<HomeState> emit,
  ) async {
    final newFavoriteStatus = !event.currentFavoriteStatus;

    await FirebaseFirestore.instance
        .collection('restuarants')
        .doc(event.restaurantId)
        .collection('FoodItems')
        .doc(event.foodItemId)
        .update({
      'favourite': newFavoriteStatus,
    });

    emit(FavouriteFoodItemState(newFavoriteStatus));
  }

  // void _onToggleFavouriteRestuarant(
  //   ToggleFavouriteRestuarant event,
  //   Emitter<HomeState> emit,
  // ) async {
  //   try {
  //     // Fetch the current favorite status from Firestore
  //     DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
  //         .collection('restuarants')
  //         .doc(event.restaurantId)
  //         .get();

  //     if (docSnapshot.exists) {
  //       bool currentFavoriteStatus = docSnapshot['favourite'];
  //       final newFavoriteStatus = !currentFavoriteStatus;

  //       // Update Firestore with the new favorite status
  //       await FirebaseFirestore.instance
  //           .collection('restuarants')
  //           .doc(event.restaurantId)
  //           .update({
  //         'favourite': newFavoriteStatus,
  //       });

  //       // Emit the new state
  //       emit(FavouriteRestuarantState(newFavoriteStatus));
  //     } else {
  //       // Handle the case where the document does not exist
  //       emit(HomeErrorState('Restaurant not found'));
  //     }
  //   } catch (e) {
  //     // Handle any errors
  //     emit(HomeErrorState('Failed to toggle favorite status: $e'));
  //   }
  // }
}
