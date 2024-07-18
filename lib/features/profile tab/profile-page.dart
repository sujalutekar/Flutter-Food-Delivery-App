import 'package:flutter/material.dart';
import 'package:foodie/features/profile%20tab/personal_info_tile.dart';
import 'package:foodie/theme/app_pallete.dart';

class ProfilePage extends StatelessWidget {
  static const routeName = '/profile-page';
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Profile Page'),
      // ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),

            // Profile Picture
            const Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(
                  'https://www.pngkey.com/png/full/114-1149878_setting-user-avatar-in-specific-size-without-breaking.png',
                ),
              ),
            ),
            const SizedBox(height: 16),

            // User Name and Active Since
            const Text(
              'Tony Stark',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            const Text('Active Since: 2024', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 24),

            // Personal Information and Edit Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Personal Information',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  InkWell(
                    onTap: () {
                      // Navigator.of(context).pushNamed(EditProfilePage.routeName);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.edit,
                            size: 18,
                            color: AppPallete.primaryColor,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Edit',
                            style: TextStyle(
                                color: AppPallete.primaryColor, fontSize: 18),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Personal Information Tiles
            const SizedBox(height: 16),
            const PersonalInfoTile(
              icon: Icons.mail,
              title: 'Email',
              trailingText: 'tonystark@gmail.com',
            ),
            const PersonalInfoTile(
              icon: Icons.location_on,
              title: 'Address',
              trailingText: 'California, USA',
            ),
          ],
        ),
      ),
    );
  }
}
