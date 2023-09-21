import 'package:flutter/material.dart';

import '../utils/utils.dart';

class InventoryItem {
  InventoryItem(this.name);

  final String name;
}

class InventoryWidget extends StatelessWidget {
  const InventoryWidget({required this.items, super.key});

  final List<InventoryItem> items;

  @override
  Widget build(BuildContext context) {
    final itemCountWithItems = items.length;
    final itemCountWithoutItems = 48 - itemCountWithItems;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Container(
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  width: 2,
                  color: Colors.white,
                ),
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
                onPressed: () => close(context),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    'Equipado',
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 10,
                    ),
                    child: Divider(
                      color: Colors.white.withOpacity(0.5),
                      height: 2,
                    ),
                  ),
                  const Text(
                    'Inventário',
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 6,
                    ),
                    itemCount: itemCountWithItems + itemCountWithoutItems,
                    itemBuilder: (BuildContext context, int index) {
                      if (index < itemCountWithItems) {
                        return Container(
                          decoration: BoxDecoration(
                            color: const Color(0xff131f2f),
                            border: Border.all(
                              color: const Color(0xff6e7b8c),
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              items[index].name,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      } else {
                        final itemNumber = itemCountWithItems - 1 + index;
                        return Container(
                          decoration: BoxDecoration(
                            color: const Color(0xff131f2f),
                            border: Border.all(
                              color: const Color(0xff6e7b8c),
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              itemNumber.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
