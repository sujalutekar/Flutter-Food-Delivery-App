part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

class CartInitial extends CartState {}

class CartUpdated extends CartState {
  final Map<String, int> items;

  CartUpdated(this.items);
}

class TotalCartLength extends CartState {
  final int totalLength;

  TotalCartLength(this.totalLength);
}
