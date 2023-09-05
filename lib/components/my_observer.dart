import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

class MyObserver extends RoutemasterObserver {
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    print('Popped a route');
  }

  @override
  void didChangeRoute(RouteData routeData, Page<dynamic> page) {
    print('New route: ${routeData.path}');
  }
}
