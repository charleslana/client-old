import 'package:flutter/material.dart';

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
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
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
