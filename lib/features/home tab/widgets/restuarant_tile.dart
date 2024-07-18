import 'package:flutter/material.dart';
import 'package:foodie/models/restuarant.dart';
import 'package:foodie/theme/app_pallete.dart';

class RestaurantTile extends StatelessWidget {
  final void Function()? onTap;
  final Restaurant restaurant;
  final void Function()? onPressed;
  final Widget icon;

  const RestaurantTile({
    this.onTap,
    required this.restaurant,
    required this.onPressed,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 270,
        padding: const EdgeInsets.only(bottom: 12),
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              offset: const Offset(1.0, 1.0),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16).copyWith(
                      bottomLeft: Radius.zero, bottomRight: Radius.zero),
                  child: Image(
                    height: 200,
                    width: double.infinity,
                    image: NetworkImage(
                      restaurant.image,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: const EdgeInsets.only(left: 8, top: 8),
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            restaurant.rating,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          const Text('(25+)')
                        ],
                      ),
                    )),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: onPressed,
                    icon: icon,
                    color: AppPallete.primaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                restaurant.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Row(
                children: [
                  Container(
                    child: const Row(
                      children: [
                        Icon(
                          Icons.delivery_dining,
                          color: AppPallete.primaryColor,
                        ),
                        SizedBox(width: 4),
                        Text('Free Delivery'),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    child: const Row(
                      children: [
                        Icon(
                          Icons.timelapse_rounded,
                          color: AppPallete.primaryColor,
                        ),
                        SizedBox(width: 4),
                        Text('10-15 mins'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Row(
                children: [
                  // Displaying tags
                  for (var tags in restaurant.tags)
                    Container(
                      padding: const EdgeInsets.all(6),
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey[300],
                      ),
                      child: Text(
                        tags,
                        style: const TextStyle(letterSpacing: 0.5),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 6),
          ],
        ),
      ),
    );
  }
}
