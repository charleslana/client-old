import 'package:flutter/material.dart';

import '../data/images.dart';
import '../widgets/inventory_widget.dart';

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
    final List<InventoryItem> items = [
      InventoryItem('Item 1'),
      InventoryItem('Item 2'),
    ];

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
              print('Mundo');
            case 2:
              showModalBottomSheet<dynamic>(
                backgroundColor: const Color(0xff131f2f),
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return InventoryWidget(items: items);
                },
              );
              break;
            default:
              print('Error');
          }
        },
      ),
    );
  }
}
