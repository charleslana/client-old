import 'package:flutter/material.dart';

import '../routes/app_routes.dart';
import '../utils/utils.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('NotFound'),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () => replace(context, loginRoute),
                child: const Text('Voltar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
