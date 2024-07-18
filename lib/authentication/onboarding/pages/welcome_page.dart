import 'package:flutter/material.dart';
import 'package:foodie/theme/app_pallete.dart';
import 'package:foodie/authentication/onboarding/widgets/sign_in_button.dart';
import 'package:foodie/authentication/pages/login_page.dart';
import 'package:foodie/authentication/pages/sign_up_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Stack(
        children: [
          // background image
          Container(
            width: double.infinity,
            child: const Image(
              image: AssetImage('assets/images/food_bg_image.png'),
              fit: BoxFit.cover,
            ),
          ),

          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.7),
                  Colors.black.withOpacity(0.7),
                  Colors.black.withOpacity(0.6),
                  Colors.black.withOpacity(0.5),
                  Colors.black.withOpacity(0.2),
                  Colors.black.withOpacity(0.1),
                  Colors.black.withOpacity(0.025),
                ],
              ),
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.21),
              // welcome message
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: const TextSpan(
                        text: 'Welcome to\n',
                        style: TextStyle(
                            fontSize: 46,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(
                            text: 'Foodie',
                            style: TextStyle(
                              fontSize: 46,
                              color: AppPallete.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Your favorite foods delivered\nfast at your doorstep',
                      style: TextStyle(
                        fontSize: 16,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),

              // Authentication Buttons
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Expanded(
                          child: Divider(color: Colors.white),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            'sign in with',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Expanded(
                          child: Divider(color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Facebook and Google Sign In Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SignInButton(
                          assetName: 'assets/images/facebook.png',
                          title: 'FACEBOOK',
                          onPressed: () {
                            print('Clicked on Facebook');
                          },
                        ),
                        SignInButton(
                          assetName: 'assets/images/google.png',
                          title: 'GOOGLE',
                          onPressed: () {
                            print('Clicked on Google');
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Email and Password Sign In Button
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(SignUpPage.routeName);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(color: Colors.white),
                          color: Colors.black.withOpacity(0.35),
                        ),
                        child: const Center(
                          child: Text(
                            'Start with Email',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // already have an account
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account?',
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(width: 6),
                        InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(LoginPage.routeName);
                          },
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                              color: AppPallete.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          )
        ],
      ),
    );
  }
}
