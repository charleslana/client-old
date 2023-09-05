import 'package:flutter/material.dart';

import '../utils/utils.dart';

class UnauthenticatedPage extends StatelessWidget {
  const UnauthenticatedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Material(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Você não está autenticado'),
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: goToBack,
                child: Text('Voltar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
