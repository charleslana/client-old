import 'package:routemaster/routemaster.dart';

import '../components/custom_page.dart';
import '../pages/home_page.dart';
import '../pages/landing_page.dart';
import '../pages/login_page.dart';
import '../pages/not_found_page.dart';
import '../pages/splash_screen_page.dart';
import '../widget/auth_guard.dart';
import 'app_routes.dart';

final routes = RouteMap(routes: {
  splashScreenRoute: (_) => const CustomPage(child: SplashScreenPage()),
  landingRoute: (_) => const CustomPage(child: LandingPage()),
  loginRoute: (_) => const CustomPage(child: LoginPage()),
  homeRoute: (_) => const CustomPage(child: AuthGuard(child: HomePage())),
}, onUnknownRoute: (_) => const CustomPage(child: NotFoundPage()));
