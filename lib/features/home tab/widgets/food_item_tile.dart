import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:foodie/models/food_item.dart';
import 'package:foodie/theme/app_pallete.dart';

import '../bloc/cart_bloc.dart';

class FoodItemTile extends StatefulWidget {
  final String restaurantId;
  final FoodItem foodItem;
  final int trimWordsCount;
  final VoidCallback openModalBottomSheet;
  final String foodItemId;
  final String restaurantName;

  const FoodItemTile({
    super.key,
    required this.restaurantId,
    required this.foodItem,
    this.trimWordsCount = 14,
    required this.openModalBottomSheet,
    required this.foodItemId,
    required this.restaurantName,
  });

  @override
  State<FoodItemTile> createState() => _FoodItemTileState();
}

class _FoodItemTileState extends State<FoodItemTile> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final words = widget.foodItem.description.split(' ');
    final displayedText = isExpanded
        ? widget.foodItem.description
        : words.take(widget.trimWordsCount).join(' ') +
            (words.length > widget.trimWordsCount ? ' ...' : '');

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.55,
            child: InkWell(
              onTap: () {
                // _openModalBottmoSheet();
                // onpressed function for opening modal bottom sheet
                widget.openModalBottomSheet();
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // food name
                  Text(
                    widget.foodItem.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // food rating
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 18,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${widget.foodItem.rating}',
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // food price
                  Text(
                    '\$ ${widget.foodItem.price}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // food description
                  Text(
                    displayedText,
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                  if (words.length > widget.trimWordsCount)
                    InkWell(
                      onTap: () {
                        setState(() {
                          isExpanded = !isExpanded;
                        });
                      },
                      child: Text(
                        isExpanded ? 'Read less' : 'Read more',
                        style: const TextStyle(
                          color: AppPallete.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  // _openModalBottmoSheet();
                  // onpressed function for opening modal bottom sheet
                  widget.openModalBottomSheet();
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 4, top: 4),
                  height: 125,
                  width: MediaQuery.of(context).size.width * 0.3,
                  // width: 135,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(widget.foodItem.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  if (state is CartInitial) {
                    return const CircularProgressIndicator();
                  } else if (state is CartUpdated) {
                    final itemCount = state.items[widget.foodItemId] ?? 0;

                    return itemCount > 0
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () {
                                  BlocProvider.of<CartBloc>(context).add(
                                    RemoveItemEvent(
                                      widget.foodItemId,
                                      widget.restaurantId,
                                      widget.restaurantName,
                                    ),
                                  );
                                },
                              ),
                              Text(itemCount.toString()),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  BlocProvider.of<CartBloc>(context).add(
                                    AddItemEvent(
                                      widget.foodItemId,
                                      widget.restaurantId,
                                      widget.restaurantName,
                                    ),
                                  );
                                },
                              ),
                            ],
                          )
                        : ElevatedButton(
                            onPressed: () {
                              BlocProvider.of<CartBloc>(context)
                                  .add(AddItemEvent(
                                widget.foodItemId,
                                widget.restaurantId,
                                widget.restaurantName,
                              ));
                            },
                            child: const Text('Add to Cart'),
                          );
                  } else {
                    return const Text('Something went wrong');
                  }
                },
              ),

              // InkWell(
              //   onTap: () {
              //     // add to cart
              //   },
              //   child: Container(
              //     padding: const EdgeInsets.symmetric(
              //       horizontal: 12,
              //       vertical: 4,
              //     ),
              //     decoration: BoxDecoration(
              //       color: AppPallete.primaryColor,
              //       borderRadius: BorderRadius.circular(8),
              //     ),
              //     child: const Text(
              //       'Add to cart',
              //       style: TextStyle(
              //         color: Colors.white,
              //         fontWeight: FontWeight.w600,
              //         fontSize: 16,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
