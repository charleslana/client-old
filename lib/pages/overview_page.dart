import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/attribute_bar.dart';
import '../components/bottom_navigation_menu.dart';
import '../components/custom_drawer.dart';
import '../components/custom_shader_mask.dart';
import '../data/images.dart';
import '../models/attribute_status.dart';
import '../providers/user_character_provider.dart';
import '../utils/character_utils.dart';
import '../utils/style_utils.dart';
import '../widgets/button4_widget.dart';

class OverviewPage extends ConsumerWidget {
  OverviewPage({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userCharacter = ref.read(userCharacterProvider);

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: const Color(0xff131f2f),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              backgroundColor: const Color(0xff131f2f),
              elevation: 0,
              expandedHeight: 200,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
                title: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    userCharacter.name,
                    style: TextStyle(
                      shadows: shadows,
                    ),
                  ),
                ),
                background: CustomShaderMask(
                  image: getCharacterPortrait(userCharacter.character.id),
                  alignment: Alignment.topCenter,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              sliver: SliverToBoxAdapter(
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Wrap(
                        children: [
                          Container(
                            width: 80,
                            height: 100,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(levelIcon2),
                                alignment: Alignment.bottomCenter,
                                fit: BoxFit.contain,
                              ),
                            ),
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  top: -20,
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          userCharacter.level.toString(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 30,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  width: 20,
                                  child: Image.asset(
                                    getCharacterClassImage(
                                        userCharacter.character.id),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 5),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userCharacter.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Button4Widget(
                                text: 'Editar',
                                callback: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: double.infinity,
                      child: Wrap(
                        alignment: WrapAlignment.spaceAround,
                        children: [
                          const Column(
                            children: [
                              Text(
                                'GROUP',
                                style: TextStyle(
                                  color: Color(0xff6e7b8c),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'guilda',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                getGender(userCharacter.gender),
                                style: const TextStyle(
                                  color: Color(0xff6e7b8c),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                'gênero',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                          const Column(
                            children: [
                              Text(
                                '100',
                                style: TextStyle(
                                  color: Color(0xff6e7b8c),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'poder',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Card(
                      margin: const EdgeInsets.all(0),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      color: const Color(0xff1a2739),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.info,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const Text(
                              'Atributos',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            AttributeBar(
                              attributeStatus: AttributeStatus(
                                icon: Icons.person,
                                attribute: 'FOR',
                                value: userCharacter.strength,
                                baseValue: userCharacter.strength,
                                attributes: [
                                  userCharacter.strength,
                                  userCharacter.intelligence,
                                  userCharacter.dexterity,
                                ],
                              ),
                            ),
                            AttributeBar(
                              attributeStatus: AttributeStatus(
                                icon: Icons.person,
                                attribute: 'INT',
                                value: userCharacter.intelligence,
                                baseValue: userCharacter.intelligence,
                                attributes: [
                                  userCharacter.strength,
                                  userCharacter.intelligence,
                                  userCharacter.dexterity,
                                ],
                              ),
                            ),
                            AttributeBar(
                              attributeStatus: AttributeStatus(
                                icon: Icons.person,
                                attribute: 'DES',
                                value: userCharacter.dexterity,
                                baseValue: userCharacter.dexterity,
                                attributes: [
                                  userCharacter.strength,
                                  userCharacter.intelligence,
                                  userCharacter.dexterity,
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Button4Widget(
                      text: 'Treinar',
                      callback: () => {},
                    ),
                  ],
                ),
                // child: Text(
                //   '\nScrollable body:\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\nUt enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.\nDuis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                //   style: TextStyle(
                //     fontSize: 30,
                //     color: Colors.white,
                //   ),
                // ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationMenu(scaffoldKey: _scaffoldKey),
        drawer: CustomDrawer(),
      ),
    );
  }
}
