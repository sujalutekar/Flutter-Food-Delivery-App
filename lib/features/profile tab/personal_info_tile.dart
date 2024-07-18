import 'package:flutter/material.dart';

class PersonalInfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String trailingText;

  const PersonalInfoTile({
    super.key,
    required this.icon,
    required this.title,
    required this.trailingText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        // borderRadius: BorderRadius.circular(8),
        color: Colors.grey[200],
      ),
      child: Row(
        children: [
          Icon(icon, size: 22, color: Colors.black),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const Spacer(),
          Text(
            trailingText,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
