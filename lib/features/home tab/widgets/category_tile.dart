import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {
  final String title;
  final String imageUrl;
  final Color color;

  final void Function()? onTap;

  const CategoryTile({
    super.key,
    required this.onTap,
    required this.title,
    required this.imageUrl,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: Container(
          padding: const EdgeInsets.all(8).copyWith(bottom: 14, top: 10),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(
                  imageUrl,
                ),
                radius: 24,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
