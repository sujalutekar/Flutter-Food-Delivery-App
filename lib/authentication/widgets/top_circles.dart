import 'package:flutter/material.dart';

import 'package:foodie/theme/app_pallete.dart';

class TopCircles extends StatelessWidget {
  const TopCircles({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      height: 130,
      child: const Stack(
        children: [
          Positioned(
            top: -100,
            right: -100,
            child: CircleAvatar(
              radius: 100,
              backgroundColor: AppPallete.primaryColor,
            ),
          ),
          Positioned(
            top: -10,
            left: -50,
            child: CircleAvatar(
              radius: 50,
              backgroundColor: AppPallete.primaryColor,
            ),
          ),
          Positioned(
            top: -80,
            left: 5,
            child: CircleAvatar(
              radius: 80,
              backgroundColor: Color(0xffFFECE7),
            ),
          ),
        ],
      ),
    );
  }
}
