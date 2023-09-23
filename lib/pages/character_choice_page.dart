import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../components/custom_shader_mask.dart';
import '../data/images.dart';
import '../enums/role_group_enum.dart';
import '../helpers/handler_error.dart';
import '../models/user_character.dart';
import '../providers/user_character_provider.dart';
import '../providers/user_provider.dart';
import '../routes/app_routes.dart';
import '../services/user_character_item_service.dart';
import '../services/user_character_service.dart';
import '../services/user_service.dart';
import '../utils/character_utils.dart';
import '../utils/utils.dart';
import '../widgets/button1_widget.dart';
import '../widgets/button3_widget.dart';

class CharacterChoicePage extends ConsumerStatefulWidget {
  const CharacterChoicePage({super.key});

  @override
  ConsumerState<CharacterChoicePage> createState() =>
      _CharacterChoicePageState();
}

class _CharacterChoicePageState extends ConsumerState<CharacterChoicePage> {
  final _availableQuantity = 4;
  final _userService = UserService();
  final _userCharacterService = UserCharacterService();
  final _userCharacterItemService = UserCharacterItemService();

  void _logout() {
    _userService.logout(ref).then((value) => replace(context, loginRoute));
  }

  Future<void> _showCharacterDialog(UserCharacter userCharacter) async {
    final DateFormat formatter = DateFormat.yMMMd('pt');

    await showModalBottomSheet<dynamic>(
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      elevation: 0,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              top: 30,
              left: 20,
              right: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom + 30,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: userCharacter.level < 100 &&
                          userCharacter.groupMember?.role !=
                              RoleGroupEnum.leader
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.end,
                  children: [
                    if (userCharacter.level < 100 &&
                        userCharacter.groupMember?.role !=
                            RoleGroupEnum.leader) ...[
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                          onPressed: () => showConfirmationDialog(
                              context,
                              'Deseja realmente excluir o personagem? Está ação é irreversível',
                              () => _excluir(userCharacter.id)),
                        ),
                      ),
                    ],
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                        onPressed: () => close(context),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                Card(
                  elevation: 0,
                  margin: const EdgeInsets.only(bottom: 10),
                  color: Colors.black.withOpacity(0.3),
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Flexible(
                          child: Text(
                            'Nome',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          userCharacter.name,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 0,
                  margin: const EdgeInsets.only(bottom: 10),
                  color: Colors.black.withOpacity(0.3),
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Flexible(
                          child: Text(
                            'Nível',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          userCharacter.level.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 0,
                  margin: const EdgeInsets.only(bottom: 10),
                  color: Colors.black.withOpacity(0.3),
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Flexible(
                          child: Text(
                            'Classe',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          userCharacter.character.name,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 0,
                  margin: const EdgeInsets.only(bottom: 10),
                  color: Colors.black.withOpacity(0.3),
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Flexible(
                          child: Text(
                            'Data de criação',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          formatter.format(userCharacter.createdAt),
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Button3Widget(
                  text: 'Selecionar',
                  callback: () => _select(userCharacter),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _excluir(int id) async {
    try {
      showLoading(context);
      await _userCharacterService.delete(id);
      final List<UserCharacter> updatedUserCharacters =
          List<UserCharacter>.from(ref.read(userCharactersProvider))
            ..removeWhere((item) => item.id == id);
      _userCharacterService.saveUserCharacters(ref, updatedUserCharacters);
      if (context.mounted) {
        closeAll(context);
      }
    } on DioException catch (e) {
      if (context.mounted) {
        close(context);
        await getError(e, context);
      }
    }
  }

  Future<void> _select(UserCharacter userCharacter) async {
    try {
      showLoading(context);
      await _userCharacterService.select(ref, userCharacter);
      await _getUserCharacterItems();
      if (context.mounted) {
        replace(context, overviewRoute);
      }
    } on DioException catch (e) {
      if (context.mounted) {
        close(context);
        await getError(e, context);
      }
    }
  }

  Future<void> _getUserCharacterItems() async {
    try {
      await _userCharacterItemService.getAll(ref);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final user = ref.watch(userProvider);
    final userCharacters = ref.watch(userCharactersProvider);

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
                        if (index < userCharacters.length) {
                          final userCharacter = userCharacters[index];

                          return InkWell(
                            onTap: () => _showCharacterDialog(userCharacter),
                            child: Container(
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(selectCharacterBg),
                                  fit: BoxFit.contain,
                                ),
                              ),
                              child: Center(
                                child: SizedBox(
                                  width: screenWidth / 5,
                                  height: screenHeight / 5,
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Align(
                                        child: CustomShaderMask(
                                          image: getCharacterImage(
                                              userCharacter.character.id),
                                        ),
                                      ),
                                      Positioned(
                                        top: -10,
                                        left: -10,
                                        child: Container(
                                          width: screenWidth / 10,
                                          height: screenHeight / 10,
                                          decoration: const BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(levelIcon),
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              userCharacter.level.toString(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Container(
                                          width: screenWidth / 20,
                                          height: screenHeight / 20,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  getCharacterClassImage(
                                                      userCharacter
                                                          .character.id)),
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return InkWell(
                            onTap: () =>
                                navigate(context, characterCreateRoute),
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
                        }
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
