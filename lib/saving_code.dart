// BlocBuilder<CartBloc, CartState>(
//                                     builder: (context, state) {
//                                       if (state is CartInitial) {
//                                         return const CircularProgressIndicator();
//                                       } else if (state is CartUpdated) {
//                                         final itemCount =
//                                             state.items[itemId] ?? 0;

//                                         return itemCount > 0
//                                             ? Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.center,
//                                                 children: [
//                                                   IconButton(
//                                                     icon: const Icon(
//                                                         Icons.remove),
//                                                     onPressed: () {
//                                                       BlocProvider.of<CartBloc>(
//                                                               context)
//                                                           .add(RemoveItemEvent(
//                                                         itemId,
//                                                         widget.restaurant.id,
//                                                       ));
//                                                     },
//                                                   ),
//                                                   Text(itemCount.toString()),
//                                                   IconButton(
//                                                     icon: const Icon(Icons.add),
//                                                     onPressed: () {
//                                                       BlocProvider.of<CartBloc>(
//                                                               context)
//                                                           .add(AddItemEvent(
//                                                         itemId,
//                                                         widget.restaurant.id,
//                                                       ));
//                                                     },
//                                                   ),
//                                                 ],
//                                               )
//                                             : const SizedBox.shrink();
//                                       } else {
//                                         return const Text(
//                                             'Something went wrong');
//                                       }
//                                     },
//                                   ),