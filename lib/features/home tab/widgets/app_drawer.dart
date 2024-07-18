import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodie/features/home%20tab/app_drawer_pages/my_orders_page.dart';

import 'package:foodie/features/profile%20tab/profile-page.dart';
import 'package:shimmer/shimmer.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(
                      'https://www.pngkey.com/png/full/114-1149878_setting-user-avatar-in-specific-size-without-breaking.png',
                    ),
                  ),
                  const SizedBox(height: 16),

                  // name

                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 150,
                                height: 24,
                                color: Colors.grey[300],
                              ),
                              const SizedBox(height: 8),
                              Container(
                                width: 200,
                                height: 16,
                                color: Colors.grey[300],
                              ),
                            ],
                          ),
                        );
                      }
                      final user = snapshot.requireData;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user['name'],
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            user['email'],
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),

            // menu options

            menuTile(
              icon: Icons.person,
              title: 'My Profile',
              onTap: () {
                Navigator.of(context).pushNamed(ProfilePage.routeName);
              },
            ),
            menuTile(
              icon: Icons.list_alt_rounded,
              title: 'My Orders',
              onTap: () {
                Navigator.of(context).pushNamed(MyOrdersPage.routeName);
              },
            ),
            menuTile(
              icon: Icons.mail,
              title: 'Contact Us',
              onTap: () {},
            ),
            menuTile(
              icon: Icons.settings,
              title: 'Settings',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

Widget menuTile({
  required IconData icon,
  required String title,
  required VoidCallback onTap,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        size: 28,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}
