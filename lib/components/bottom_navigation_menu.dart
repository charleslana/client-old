import 'package:flutter/material.dart';

import '../data/images.dart';

class BottomNavigationMenu extends StatelessWidget {
  const BottomNavigationMenu({
    required this.scaffoldKey,
    this.currentIndex = 0,
    super.key,
  });

  final GlobalKey<ScaffoldState> scaffoldKey;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
      child: BottomNavigationBar(
        elevation: 0,
        backgroundColor: Colors.black.withOpacity(0.5),
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(menuIcon, width: 24),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(worldIcon, width: 24),
            label: 'Mundo',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(bagIcon, width: 24),
            label: 'Mochila',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(questIcon, width: 24),
            label: 'Missões',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(pvpIcon, width: 24),
            label: 'PVP',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(rankIcon, width: 24),
            label: 'Rank',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              scaffoldKey.currentState?.openDrawer();
              break;
            case 1:
              print('Search');
              break;
            default:
              print('Error');
          }
        },
      ),
    );
  }
}
