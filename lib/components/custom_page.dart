import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

class CustomPage extends TransitionBuilderPage<void> {
  const CustomPage({required Widget child}) : super(child: child);

  @override
  PageTransition buildPushTransition(BuildContext context) {
    return PageTransition.none;
  }

  @override
  PageTransition buildPopTransition(BuildContext context) {
    return PageTransition.none;
  }
}
