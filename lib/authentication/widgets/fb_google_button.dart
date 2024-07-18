import 'package:flutter/material.dart';

class FBGoogleButton extends StatelessWidget {
  final String assetName;
  final String title;
  final void Function()? onPressed;

  const FBGoogleButton({
    super.key,
    required this.assetName,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(28),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image(
              height: 20,
              width: 20,
              image: AssetImage(assetName),
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 6),
            Text(
              title,
              style: const TextStyle(
                letterSpacing: 1,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
