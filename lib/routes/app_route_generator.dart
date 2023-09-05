import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../pages/home_page.dart';
import '../pages/landing_page.dart';
import '../pages/login_page.dart';
import '../pages/not_found_page.dart';
import '../pages/splash_screen_page.dart';
import '../widget/auth_guard.dart';
import 'app_routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case splashScreenRoute:
      return _buildNoAnimationRoute(const SplashScreenPage(), settings);
    case landingRoute:
      return PageTransition(
        child: const LandingPage(),
        type: PageTransitionType.fade,
        settings: settings,
      );
    case loginRoute:
      return PageTransition(
        child: const LoginPage(),
        type: PageTransitionType.fade,
        settings: settings,
      );
    case homeRoute:
      return _buildNoAnimationRoute(
          const AuthGuard(child: HomePage()), settings);
    default:
      return _buildNoAnimationRoute(const NotFoundPage(), settings);
  }
}

PageRouteBuilder<dynamic> _buildNoAnimationRoute(
    Widget page, RouteSettings settings) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
    settings: settings,
  );
}
