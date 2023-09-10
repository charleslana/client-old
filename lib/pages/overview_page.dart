import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/bottom_navigation_menu.dart';
import '../components/custom_drawer.dart';

class OverviewPage extends ConsumerWidget {
  OverviewPage({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.blue,
        body: const Center(
          child: Text(
            'Text',
            style: TextStyle(color: Colors.white),
          ),
        ),
        bottomNavigationBar: BottomNavigationMenu(scaffoldKey: _scaffoldKey),
        drawer: CustomDrawer(),
      ),
    );
  }
}
