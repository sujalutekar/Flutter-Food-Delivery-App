import 'package:flutter/material.dart';
import 'package:foodie/theme/app_pallete.dart';

class MyOrderTile extends StatelessWidget {
  final String orderStatus;

  const MyOrderTile({super.key, required this.orderStatus});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              print('Clicled');
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 30,
                  child: Icon(Icons.fastfood),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Restuarant Name
                    const Text(
                      'Restuarant Name',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    // Order Items
                    Text(
                      '2 Items',
                      style:
                          TextStyle(fontSize: 16, color: Colors.grey.shade700),
                    ),

                    // Order Status
                    const SizedBox(height: 10),
                    Text(
                      orderStatus,
                      style: const TextStyle(
                        color: AppPallete.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
