part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class ToggleFavouriteRestuarant extends HomeEvent {
  final String restaurantId;
  final bool currentFavoriteStatus;

  ToggleFavouriteRestuarant({
    required this.restaurantId,
    required this.currentFavoriteStatus,
  });
}

class ToogleFavouriteFoodItem extends HomeEvent {
  final String restaurantId;
  final String foodItemId;
  final bool currentFavoriteStatus;

  ToogleFavouriteFoodItem({
    required this.restaurantId,
    required this.foodItemId,
    required this.currentFavoriteStatus,
  });
}
