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
    await Future<dynamic>.delayed(const Duration(seconds: 2)).then(
      (value) => replace(context, landingRoute),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Container(
          color: Colors.black,
          child: const Padding(
            padding: EdgeInsets.all(5),
            child: Center(
              child: SizedBox(
                width: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'CL GAMES',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'KesselBold',
                        fontSize: 40,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Apresenta',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
