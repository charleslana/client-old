import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../config/version.dart';
import '../data/images.dart';
import '../helpers/handler_error.dart';
import '../routes/app_routes.dart';
import '../services/public_service.dart';
import '../utils/utils.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool isLoading = true;

  final publicService = PublicService();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkVersion();
    });
    super.initState();
  }

  Future<void> _checkVersion() async {
    try {
      final getVersion = await publicService.getVersion();
      if (getVersion == null && getVersion != version) {
        _hideLoading();
        _showDialog();
        return;
      }
      await _redirectToLoginPage();
    } on DioException catch (e) {
      if (context.mounted) {
        getError(e, context);
      }
    }
  }

  Future<void> _redirectToLoginPage() async {
    _hideLoading();
    await Future<dynamic>.delayed(const Duration(milliseconds: 200))
        .then((value) => replace(context, loginRoute));
  }

  void _showDialog() {
    showDialog<dynamic>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: const AlertDialog(
            content: Text(
                'Nova versão disponível, verifique na loja de sua aplicação.'),
            actions: [
              TextButton(
                onPressed: SystemNavigator.pop,
                child: Text('Sair'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _hideLoading() {
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    return SafeArea(
      child: Material(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(landingBg),
              alignment: Alignment.bottomCenter,
              fit: BoxFit.cover,
            ),
            color: Color(0xff131f2f),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Cabal',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'CabalFont',
                                fontSize: 50,
                              ),
                            ),
                            Text(
                              'RPG ONLINE',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'GameStation',
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isLoading) ...[
                        const Column(
                          children: [
                            Text(
                              'Aguarde...',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: 5),
                            LinearProgressIndicator(),
                          ],
                        ),
                      ]
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'CL Games ${now.year}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                    const Text(
                      'v.$version',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
