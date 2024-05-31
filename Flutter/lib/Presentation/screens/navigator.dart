import 'package:flutter/material.dart';
import 'package:flutter_application_1/Presentation/screens/AdminPageTransfer.dart';
import 'package:flutter_application_1/Presentation/screens/ExpandedBooking.dart';
import 'package:flutter_application_1/Presentation/screens/HomePage.dart';
import 'package:flutter_application_1/Presentation/screens/about.dart';
import 'package:flutter_application_1/Presentation/screens/bookings.dart';
import 'package:flutter_application_1/Presentation/screens/edit_profile_page.dart';
import 'package:flutter_application_1/Presentation/screens/intro.dart';
import 'package:flutter_application_1/Presentation/screens/main_reserve.dart';
import 'package:flutter_application_1/domain/bookingsClass.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'forgot_password.dart';
import 'login_page.dart';
import 'reset_password.dart';
import 'signup_page.dart';

import "package:go_router/go_router.dart";

void main() {
  runApp(const ProviderScope(child: Nav()));
}

final _gorouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const Intro(),
    ),
    GoRoute(
      name: "signup",
      path: '/signup',
      builder: (context, state) => const SignupPage(),
    ),
    GoRoute(
      name: "login",
      path: '/login',
      builder: (context, state) => LoginPage(),
    ),
    GoRoute(
        name: "home",
        path: '/home',
        builder: (context, state) {
          final int currentIndex =
              int.parse(state.uri.queryParameters['index']!);
          // print(currentIndex);

          return HomePage(index: currentIndex);
        }),
    GoRoute(
      name: "forgotPassword",
      path: '/forgotPassword',
      builder: (context, state) => const ForgotPasswordPage(),
    ),
    GoRoute(
      name: "resetPassword",
      path: '/resetPassword',
      builder: (context, state) => const ResetPasswordPage(),
    ),
    GoRoute(
      name: "editProfile",
      path: '/editProfile',
      builder: (context, state) => EditProfilePage(),
    ),
    GoRoute(
      name: "adminPageTransfer",
      path: '/adminPageTransfer',
      builder: (context, state) => AdminPageTransfer(),
    ),
    GoRoute(
      name: "about",
      path: '/about',
      builder: (context, state) => const AboutPage(),
    ),
    GoRoute(
      name: "bookings",
      path: '/bookings',
      builder: (context, state) => const Bookings(),
    ),
    GoRoute(
      path: '/detail',
      name: 'detail',
      builder: (context, state) {
        ReservedTable sample =
            state.extra as ReservedTable; // -> casting is important
        return ExpandedBooking(arguments: sample);
      },
    ),
    GoRoute(
      name: "mainReserve",
      path: '/mainReserve',
      builder: (context, state) {
        final Map<String, String> result = state.extra as Map<String, String>;
        print(result);

        return MainReserve(
          data: result["data"]!,
          create: result["create"]!,
          tableNumber: result["tableNumber"]!,
          checkTime: result["checkTime"]!,
        );
      },
    ),
  ],
);

class Nav extends StatelessWidget {
  const Nav({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Intro Page',
      routerConfig: _gorouter,
    );
  }
}
