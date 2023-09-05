import 'package:client/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app.dart';
import '../routes/app_routes.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void login() {
      routemaster.push(loginRoute);
    }

    void logout() {
      ref.watch(authProvider.notifier).state = false;
      routemaster.push(loginRoute);
    }

    return SafeArea(
      child: Material(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('HomePage'),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: login,
                child: const Text('Login'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: logout,
                child: const Text('Deslogar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
