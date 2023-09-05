import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth_provider.dart';
import '../routes/app_routes.dart';
import '../utils/utils.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool auth = ref.watch(authProvider);

    void getAuth() {
      auth = ref.watch(authProvider);
    }

    void home() {
      navigate(homeRoute);
    }

    void enable() {
      ref.read(authProvider.notifier).state = true;
      showToast(context, 'Rota habilitada');
      getAuth();
    }

    void disable() {
      ref.read(authProvider.notifier).state = false;
      showToast(context, 'Rota desabilitada');
      getAuth();
    }

    return SafeArea(
      child: Material(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('LoginPage, auth: $auth'),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: home,
                child: const Text('Home'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: enable,
                child: const Text('Enable route'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: disable,
                child: const Text('Disable route'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => navigate('/error'),
                child: const Text('Error route'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
