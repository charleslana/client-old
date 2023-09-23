import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/user_character_item_provider.dart';
import '../utils/item_utils.dart';
import '../utils/utils.dart';

class InventoryItem {
  InventoryItem(this.name);

  final String name;
}

class InventoryWidget extends ConsumerWidget {
  const InventoryWidget({required this.items, super.key});

  final List<InventoryItem> items;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userCharactersItems = ref.watch(userCharacterItemsProvider);
    print(userCharactersItems.length);
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
                  const SizedBox(height: 20),
                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 4,
                    children: [
                      if (itemCountWithoutItems < 0) ...[
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xff131f2f),
                            border: Border.all(
                              color: const Color(0xff6e7b8c),
                              width: 2,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Center(
                              child: Image.asset(
                                getItemImage(2),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ] else ...[
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xff131f2f),
                            border: Border.all(
                              color: const Color(0xff6e7b8c),
                              width: 2,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Center(
                              child: ColorFiltered(
                                colorFilter: const ColorFilter.mode(
                                  Color(0xff6e7b8c),
                                  BlendMode.srcATop,
                                ),
                                child: Image.asset(
                                  getItemImage(2),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
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
                        return Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xff131f2f),
                                border: Border.all(
                                  color: const Color(0xff6e7b8c),
                                  width: 2,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(2),
                                child: Center(
                                  child: Image.asset(
                                    getItemImage(1),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: Container(
                                width: 20,
                                height: 20,
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Center(
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      '1',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
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
                              textAlign: TextAlign.center,
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
