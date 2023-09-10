import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../pages/character_choice_page.dart';
import '../pages/character_create_page.dart';
import '../pages/landing_page.dart';
import '../pages/login_page.dart';
import '../pages/not_found_page.dart';
import '../pages/overview_page.dart';
import '../pages/splash_screen_page.dart';
import '../widgets/auth_guard.dart';
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
    case characterChoiceRoute:
      return PageTransition(
        child: const AuthGuard(
          child: CharacterChoicePage(),
        ),
        type: PageTransitionType.fade,
        settings: settings,
      );
    case characterCreateRoute:
      return PageTransition(
        child: const AuthGuard(
          child: CharacterCreatePage(),
        ),
        type: PageTransitionType.fade,
        settings: settings,
      );
    case overviewRoute:
      return PageTransition(
        child: AuthGuard(
          child: OverviewPage(),
        ),
        type: PageTransitionType.fade,
        settings: settings,
      );
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
