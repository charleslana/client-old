import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../enums/item_equipment_type_enum.dart';
import '../enums/item_type_enum.dart';
import '../models/user_character_item.dart';
import '../providers/user_character_item_provider.dart';
import '../utils/item_utils.dart';
import '../utils/utils.dart';

class InventoryItem {
  InventoryItem(this.name);

  final String name;
}

class InventoryWidget extends ConsumerWidget {
  const InventoryWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userCharactersItems = ref.watch(userCharacterItemsProvider);
    final unequippedItems = userCharactersItems
        .where(
            (element) => element.equipped == null || element.equipped == false)
        .toList();
    final equippedItems = userCharactersItems
        .where((element) => element.equipped == true)
        .toList();
    final itemCountWithItems = unequippedItems.length;
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
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 4,
                    children: [
                      _getItemSlot(equippedItems, ItemEquipmentTypeEnum.weapon),
                      _getItemSlot(equippedItems, ItemEquipmentTypeEnum.chest),
                      _getItemSlot(
                          equippedItems, ItemEquipmentTypeEnum.earring),
                      _getItemSlot(equippedItems, ItemEquipmentTypeEnum.glove),
                      _getItemSlot(equippedItems, ItemEquipmentTypeEnum.head),
                      _getItemSlot(
                          equippedItems, ItemEquipmentTypeEnum.necklace),
                      _getItemSlot(equippedItems, ItemEquipmentTypeEnum.ring),
                      _getItemSlot(equippedItems, ItemEquipmentTypeEnum.shoe),
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
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 6,
                    ),
                    itemCount: itemCountWithItems + itemCountWithoutItems,
                    itemBuilder: (BuildContext context, int index) {
                      if (index < itemCountWithItems) {
                        final userCharacterItem = unequippedItems[index];

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
                                    getItemImage(userCharacterItem.item.id),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                            if (userCharacterItem.item.type !=
                                ItemTypeEnum.equipment) ...[
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
                                  child: Center(
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        userCharacterItem.quantity.toString(),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ],
                        );
                      } else {
                        final itemNumber = 1 + index;
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

  Widget _getItemSlot(List<UserCharacterItem> equippedItems,
      ItemEquipmentTypeEnum equipmentType) {
    if (equippedItems
        .where((element) => element.item.equipmentType == equipmentType)
        .isNotEmpty) {
      return Container(
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
              getItemImage(1),
              fit: BoxFit.contain,
            ),
          ),
        ),
      );
    }
    return Container(
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
              getItemImage(1),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
