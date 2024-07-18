part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

class AddItemEvent extends CartEvent {
  final String itemId;
  final String restaurantId;
  final String restaurantName;

  AddItemEvent(
    this.itemId,
    this.restaurantId,
    this.restaurantName,
  );
}

class RemoveItemEvent extends CartEvent {
  final String itemId;
  final String restaurantId;
  final String restaurantName;

  RemoveItemEvent(
    this.itemId,
    this.restaurantId,
    this.restaurantName,
  );
}

class GetItemLenghtInCart extends CartEvent {}
