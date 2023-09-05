import 'package:flutter/material.dart';

import '../routes/app_routes.dart';
import '../utils/utils.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    _redirectToLandingPage();
    super.initState();
  }

  Future<void> _redirectToLandingPage() async {
    await Future<dynamic>.delayed(const Duration(seconds: 3))
        .then((value) => replace(landingRoute));
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Material(
        child: Center(
          child: Text('CL Games Apresenta'),
        ),
      ),
    );
  }
}
