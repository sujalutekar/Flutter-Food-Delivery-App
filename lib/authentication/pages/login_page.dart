import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie/features/bottom_nav/bottom_nav_bar.dart';
import 'package:foodie/theme/app_pallete.dart';
import 'package:foodie/authentication/bloc/auth_bloc.dart';
import 'package:foodie/authentication/pages/sign_up_page.dart';
import 'package:foodie/authentication/widgets/auth_field..dart';
import 'package:foodie/authentication/widgets/custom_button.dart';
import 'package:foodie/authentication/widgets/fb_google_button.dart';
import 'package:foodie/authentication/widgets/top_circles.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login';

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
              builder: (context) {
                return const BottomNavBar();
              },
            ), (route) => false);
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.message,
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Stack(
            children: [
              const TopCircles(),
              Form(
                key: formKey,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16)
                      .copyWith(top: 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 20),
                      AuthField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        title: 'E-mail',
                        hintText: 'Your Email',
                      ),
                      const SizedBox(height: 20),
                      AuthField(
                        controller: passwordController,
                        title: 'Password',
                        hintText: 'Password',
                        obscureText: true,
                        textInputAction: TextInputAction.done,
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                        onPressed: () {
                          if (!formKey.currentState!.validate()) {
                            return;
                          }

                          final String email = emailController.text.trim();
                          final String password =
                              passwordController.text.trim();

                          context.read<AuthBloc>().add(
                                AuthLoginRequested(
                                  email: email,
                                  password: password,
                                ),
                              );

                          emailController.clear();
                          passwordController.clear();
                        },
                        title: 'LOGIN',
                      ),
                      const SizedBox(height: 20),

                      // already have an account
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Don\'t have an account?',
                            style: TextStyle(color: Colors.black),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushReplacementNamed(SignUpPage.routeName);
                            },
                            child: const Text(
                              ' Sign up',
                              style: TextStyle(
                                color: AppPallete.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),

                      // Sign up with Facebook and Google
                      Container(
                        child: Column(
                          children: [
                            const Row(
                              children: [
                                Expanded(
                                  child: Divider(color: Colors.black),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  child: Text(
                                    'Sign in with',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                Expanded(
                                  child: Divider(color: Colors.black),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),

                            // Facebook and Google Sign In Buttons
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                FBGoogleButton(
                                  assetName: 'assets/images/facebook.png',
                                  title: 'FACEBOOK',
                                  onPressed: () {
                                    print('Clicked on Facebook');
                                  },
                                ),
                                FBGoogleButton(
                                  assetName: 'assets/images/google.png',
                                  title: 'GOOGLE',
                                  onPressed: () {
                                    print('Clicked on Google');
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
