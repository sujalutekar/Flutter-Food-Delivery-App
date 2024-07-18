part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

class FavouriteRestuarantState extends HomeState {
  final bool isRestaurantFavourite;

  FavouriteRestuarantState(this.isRestaurantFavourite);
}

class FavouriteFoodItemState extends HomeState {
  final bool isFoodFavourite;

  FavouriteFoodItemState(this.isFoodFavourite);
}

class HomeErrorState extends HomeState {
  final String message;

  HomeErrorState(this.message);
}
