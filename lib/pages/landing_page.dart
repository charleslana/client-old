import 'package:flutter/material.dart';

import '../routes/app_routes.dart';
import '../utils/utils.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    _redirectToLoginPage();
    super.initState();
  }

  Future<void> _redirectToLoginPage() async {
    await Future<dynamic>.delayed(const Duration(seconds: 1))
        .then((value) => replace(loginRoute));
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Material(
        child: Center(
          child: Text('Cabal RPG Online'),
        ),
      ),
    );
  }
}
