import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:foodie/authentication/onboarding/pages/welcome_page.dart';
import 'package:foodie/features/bottom_nav/bottom_nav_bar.dart';
import 'package:lottie/lottie.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Expanded(
            child: LottieBuilder.asset(
              "assets/Lottie/Animation - 1716968266302.json",
            ),
          ),
          const Text(
            'FOODIE',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      splashIconSize: 250,
      nextScreen: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('An error occurred'),
            );
          } else if (snapshot.hasData) {
            return const BottomNavBar();
          } else {
            return const WelcomePage();
          }
        },
      ),
    );
  }
}
