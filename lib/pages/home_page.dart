import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth_provider.dart';
import '../routes/app_routes.dart';
import '../utils/utils.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void login() {
      navigate(context, loginRoute);
    }

    void logout() {
      ref.watch(authProvider.notifier).state = false;
      navigate(context, loginRoute);
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
