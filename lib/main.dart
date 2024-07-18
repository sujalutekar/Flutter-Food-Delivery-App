import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie/authentication/bloc/auth_bloc.dart';
import 'package:foodie/authentication/onboarding/pages/splash_page.dart';
import 'package:foodie/authentication/pages/login_page.dart';
import 'package:foodie/authentication/pages/sign_up_page.dart';
import 'package:foodie/features/home%20tab/agruments/restuarant_detail_arg.dart';
import 'package:foodie/features/home%20tab/app_drawer_pages/my_orders_page.dart';
import 'package:foodie/features/home%20tab/bloc/cart_bloc.dart';
import 'package:foodie/features/home%20tab/bloc/home_bloc.dart';
import 'package:foodie/features/home%20tab/pages/restuarant_detail_page.dart';
import 'package:foodie/features/profile%20tab/profile-page.dart';
import 'package:foodie/firebase_options.dart';
import 'package:foodie/features/home%20tab/pages/home_page.dart';
import 'package:foodie/features/home%20tab/pages/search_page.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(FirebaseAuth.instance),
        ),
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(),
        ),
        BlocProvider(
          create: (context) => CartBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Foodie',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme:
              GoogleFonts.sofiaSansTextTheme(Theme.of(context).textTheme),
        ),
        home: const SplashPage(),
        onGenerateRoute: (settings) {
          if (settings.name == RestuarantDetailPage.routeName) {
            final args = settings.arguments as RestuarantDetailArguments;
            return MaterialPageRoute(
              builder: (context) {
                return RestuarantDetailPage(
                  restaurant: args.restaurant,
                );
              },
            );
          }
          return null;
        },
        routes: {
          LoginPage.routeName: (context) => const LoginPage(),
          SignUpPage.routeName: (context) => const SignUpPage(),
          HomePage.routeName: (context) => const HomePage(),
          SearchPage.routeName: (context) => const SearchPage(),
          ProfilePage.routeName: (context) => const ProfilePage(),
          MyOrdersPage.routeName: (context) => const MyOrdersPage(),
        },
      ),
    );
  }
}
