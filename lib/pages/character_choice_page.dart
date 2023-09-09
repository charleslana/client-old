import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/images.dart';
import '../models/user_character.dart';
import '../providers/user_character_provider.dart';
import '../providers/user_provider.dart';
import '../routes/app_routes.dart';
import '../services/user_service.dart';
import '../utils/utils.dart';
import '../widgets/button1_widget.dart';

class CharacterChoicePage extends ConsumerStatefulWidget {
  const CharacterChoicePage({super.key});

  @override
  ConsumerState<CharacterChoicePage> createState() =>
      _CharacterChoicePageState();
}

class _CharacterChoicePageState extends ConsumerState<CharacterChoicePage> {
  final _maxQuantity = 4;
  int _availableQuantity = 4;
  final _userService = UserService();

  List<UserCharacter> _userCharacters = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getUserCharacters();
    });
    super.initState();
  }

  void _getUserCharacters() {
    setState(() {
      _userCharacters = ref.watch(userCharactersProvider);
      // _availableQuantity = _maxQuantity - _userCharacters.length;
    });
  }

  void _logout() {
    _userService.logout(ref).then((value) => replace(context, loginRoute));
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final user = ref.watch(userProvider);

    return SafeArea(
      child: Material(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(characterChoiceBg),
              alignment: Alignment.bottomCenter,
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Bem vindo ${user.name}, selecione um personagem',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                      ),
                      itemCount: _availableQuantity,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () => navigate(context, characterCreateRoute),
                          child: Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(selectCharacterBg),
                                fit: BoxFit.contain,
                              ),
                            ),
                            child: Center(
                              child: SizedBox(
                                width: screenWidth / 10,
                                height: screenHeight / 10,
                                child: Image.asset(
                                  plusWhiteIcon,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Button1Widget(
                    text: 'Deslogar',
                    callback: _logout,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
