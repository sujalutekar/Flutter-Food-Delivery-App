import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie/features/home%20tab/bloc/cart_bloc.dart';
import 'package:foodie/features/home%20tab/bloc/home_bloc.dart';
import 'package:foodie/features/home%20tab/widgets/cart_item_tile.dart';
import 'package:foodie/features/home%20tab/widgets/food_item_tile.dart';
import 'package:foodie/models/food_item.dart';
import 'package:foodie/models/restuarant.dart';
import 'package:foodie/theme/app_pallete.dart';

class RestuarantDetailPage extends StatefulWidget {
  static const String routeName = '/restuarant-detail';
  final Restaurant restaurant;

  const RestuarantDetailPage({super.key, required this.restaurant});

  @override
  State<RestuarantDetailPage> createState() => _RestuarantDetailPageState();
}

class _RestuarantDetailPageState extends State<RestuarantDetailPage> {
  Future<void> _showModalBottomSheet() {
    return showModalBottomSheet(
      showDragHandle: true,
      backgroundColor: Colors.grey.shade200,
      context: context,
      builder: (context) {
        return SizedBox(
          height: 190,
          width: double.infinity,
          child: Column(
            children: [
              const SizedBox(height: 16),

              // restuarant name
              Text(
                widget.restaurant.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 16),

              // restuarant phone number and address
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rating: ${widget.restaurant.rating}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Phone number: ${widget.restaurant.phone}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Address: ${widget.restaurant.address}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  Future<void> openModalBottmoSheetForFoodItem(
    FoodItem singleFoodItem,
    String restaurantId,
    String itemId,
  ) {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      showDragHandle: true,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(12),
                ),
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 12),
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const SizedBox(height: 16),
                    Container(
                      height: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: NetworkImage(singleFoodItem.image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(
                            singleFoodItem.name,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('restuarants')
                              .doc(restaurantId)
                              .collection('FoodItems')
                              .doc(singleFoodItem.id)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            bool isFoodItemFavourite =
                                snapshot.requireData['favourite'];

                            return IconButton(
                              onPressed: () {
                                context.read<HomeBloc>().add(
                                      ToogleFavouriteFoodItem(
                                        restaurantId: restaurantId,
                                        foodItemId: singleFoodItem.id,
                                        currentFavoriteStatus:
                                            isFoodItemFavourite,
                                      ),
                                    );
                              },
                              icon: Icon(
                                isFoodItemFavourite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: AppPallete.primaryColor,
                                size: 26,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 18,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${singleFoodItem.rating}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      singleFoodItem.description,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppPallete.primaryColor),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: BlocBuilder<CartBloc, CartState>(
                        builder: (context, state) {
                          if (state is CartInitial) {
                            return const CircularProgressIndicator();
                          } else if (state is CartUpdated) {
                            final itemCount = state.items[itemId] ?? 0;

                            return itemCount > 0
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.remove),
                                        onPressed: () {
                                          BlocProvider.of<CartBloc>(context)
                                              .add(RemoveItemEvent(
                                            itemId,
                                            restaurantId,
                                            widget.restaurant.name,
                                          ));
                                        },
                                      ),
                                      Text(itemCount.toString()),
                                      IconButton(
                                        icon: const Icon(Icons.add),
                                        onPressed: () {
                                          BlocProvider.of<CartBloc>(context)
                                              .add(AddItemEvent(
                                            itemId,
                                            restaurantId,
                                            widget.restaurant.name,
                                          ));
                                        },
                                      ),
                                    ],
                                  )
                                : const SizedBox.shrink();
                          } else {
                            return const Text('Something went wrong');
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          context.read<CartBloc>().add(
                                AddItemEvent(
                                  itemId,
                                  restaurantId,
                                  widget.restaurant.name,
                                ),
                              );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppPallete.primaryColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          child: const Text(
                            'Add to cart',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('restuarants')
                .doc(widget.restaurant.id)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              var data = snapshot.requireData;

              return IconButton(
                onPressed: () {
                  log('Clicked on favorite icon');
                  context.read<HomeBloc>().add(
                        ToggleFavouriteRestuarant(
                          restaurantId: widget.restaurant.id,
                          currentFavoriteStatus: data['favourite'],
                        ),
                      );
                },
                icon: Icon(
                  data['favourite']
                      ? Icons.favorite_rounded
                      : Icons.favorite_border_rounded,
                ),
                color: AppPallete.primaryColor,
              );
            },
          ),
          IconButton(
            onPressed: _showModalBottomSheet,
            icon: const Icon(Icons.more_vert_rounded),
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    // restuarant namme
                    Text(
                      widget.restaurant.name,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // restuarant openinig hours
                    Text(
                      widget.restaurant.hours,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // restuarant rating
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppPallete.primaryColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            widget.restaurant.rating,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          '25 ratings',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Favourite food items

                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('restuarants')
                          .doc(widget.restaurant.id)
                          .collection('FoodItems')
                          .where('favourite', isEqualTo: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        var data = snapshot.requireData.docs;

                        return Column(
                          children: [
                            data.isNotEmpty
                                ? const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Your Favourites',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                : const SizedBox.shrink(),
                            const SizedBox(height: 8),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: ListTile(
                                    onTap: () {
                                      openModalBottmoSheetForFoodItem(
                                        FoodItem(
                                          id: data[index]['id'],
                                          name: data[index]['name'],
                                          image: data[index]['image'],
                                          price: data[index]['price'],
                                          rating: data[index]['rating'],
                                          description: data[index]
                                              ['description'],
                                          favourite: data[index]['favourite'],
                                        ),
                                        widget.restaurant.id,
                                        data[index]['id'], // food item id
                                      );
                                    },
                                    tileColor: Colors.grey.shade100,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    leading: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              data[index]['image']),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      data[index]['name'],
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text(
                                      '${data[index]['price']}',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    trailing: BlocBuilder<CartBloc, CartState>(
                                      builder: (context, state) {
                                        if (state is CartInitial) {
                                          return const CircularProgressIndicator();
                                        } else if (state is CartUpdated) {
                                          final itemCount =
                                              state.items[data[index]['id']] ??
                                                  0;

                                          return Container(
                                            decoration: BoxDecoration(
                                              color: AppPallete.primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 0,
                                              vertical: 0,
                                            ),
                                            child: itemCount > 0
                                                ? Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      IconButton(
                                                        icon: const Icon(
                                                          Icons.remove,
                                                          size: 14,
                                                        ),
                                                        onPressed: () {
                                                          BlocProvider.of<
                                                                      CartBloc>(
                                                                  context)
                                                              .add(
                                                            RemoveItemEvent(
                                                              data[index]['id'],
                                                              widget.restaurant
                                                                  .id,
                                                              widget.restaurant
                                                                  .name,
                                                            ),
                                                          );
                                                        },
                                                        color: Colors.white,
                                                      ),
                                                      Text(
                                                        itemCount.toString(),
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                      IconButton(
                                                        icon: const Icon(
                                                          Icons.add,
                                                          size: 14,
                                                        ),
                                                        onPressed: () {
                                                          BlocProvider.of<
                                                                      CartBloc>(
                                                                  context)
                                                              .add(
                                                            AddItemEvent(
                                                              data[index]['id'],
                                                              widget.restaurant
                                                                  .id,
                                                              widget.restaurant
                                                                  .name,
                                                            ),
                                                          );
                                                        },
                                                        color: Colors.white,
                                                      ),
                                                    ],
                                                  )
                                                : InkWell(
                                                    onTap: () {
                                                      context
                                                          .read<CartBloc>()
                                                          .add(
                                                            AddItemEvent(
                                                              data[index]['id'],
                                                              widget.restaurant
                                                                  .id,
                                                              widget.restaurant
                                                                  .name,
                                                            ),
                                                          );
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: AppPallete
                                                            .primaryColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 14,
                                                        vertical: 8,
                                                      ),
                                                      child: const Text(
                                                        'Add',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                          );
                                        } else {
                                          return const Text(
                                              'Somethinig went wrong');
                                        }
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      },
                    ),

                    const SizedBox(height: 16),

                    // Recommended for you

                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Recommended for you',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    // all food item from firestore
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('restuarants')
                          .doc(widget.restaurant.id)
                          .collection('FoodItems')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        // print(snapshot.data!.docs.first.data());
                        var data = snapshot.data!.docs;

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            // single food item object
                            FoodItem singleFoodItem = FoodItem(
                              id: data[index]['id'],
                              name: data[index]['name'],
                              image: data[index]['image'],
                              price: data[index]['price'],
                              rating: data[index]['rating'],
                              description: data[index]['description'],
                              favourite: data[index]['favourite'],
                            );

                            return FoodItemTile(
                              foodItemId: singleFoodItem.id,
                              restaurantId: widget.restaurant.id,
                              foodItem: singleFoodItem,
                              openModalBottomSheet: () =>
                                  openModalBottmoSheetForFoodItem(
                                singleFoodItem, widget.restaurant.id,
                                data[index]['id'], // food item id
                              ),
                              restaurantName: widget.restaurant.name,
                            );
                          },
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: CartItemTile(),
          ),
        ],
      ),
    );
  }
}
