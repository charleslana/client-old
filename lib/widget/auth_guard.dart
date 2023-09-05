import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../pages/unauthenticated_page.dart';
import '../providers/auth_provider.dart';

class AuthGuard extends ConsumerWidget {
  const AuthGuard({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    if (auth) {
      return child;
    }
    return const UnauthenticatedPage();
  }
}
