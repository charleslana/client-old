import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/images.dart';
import '../helpers/handler_error.dart';
import '../providers/user_character_provider.dart';
import '../providers/user_provider.dart';
import '../routes/app_routes.dart';
import '../services/user_character_service.dart';
import '../services/user_service.dart';
import '../utils/character_utils.dart';
import '../utils/utils.dart';

class CustomDrawer extends ConsumerWidget {
  CustomDrawer({super.key});

  final _userService = UserService();
  final _userCharacterService = UserCharacterService();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userCharacter = ref.watch(userCharacterProvider);
    final user = ref.watch(userProvider);

    void logout() {
      _userService.logout(ref).then((value) => replace(context, loginRoute));
    }

    Future<void> logoutCharacter() async {
      try {
        showLoading(context);
        await _userCharacterService.logout();
        if (context.mounted) {
          replace(context, characterChoiceRoute);
        }
      } on DioException catch (e) {
        if (context.mounted) {
          close(context);
          await getError(e, context);
        }
      }
    }

    return LayoutBuilder(builder: (context, constraints) {
      final drawerWidth = constraints.maxWidth;

      return SafeArea(
        child: Drawer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: drawerWidth,
                color: const Color(0xff392d5f),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      SizedBox(
                        width: drawerWidth * 0.6,
                        child: Stack(
                          children: [
                            Positioned(
                              top: 10,
                              left: 80,
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    width: drawerWidth * 0.35,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: const Color(0xff240f36),
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 2,
                                      ),
                                    ),
                                    child: Center(
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          userCharacter.name,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Container(
                                    width: drawerWidth * 0.35,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 2,
                                      ),
                                    ),
                                    child: Stack(
                                      children: [
                                        FractionallySizedBox(
                                          alignment: Alignment.centerLeft,
                                          widthFactor: 0.5,
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                bottomLeft: Radius.circular(10),
                                              ),
                                              color: Color(0xff716eb5),
                                            ),
                                          ),
                                        ),
                                        const Center(
                                          child: Text(
                                            '500/500',
                                            style: TextStyle(
                                              color: Colors.white,
                                              height: 1.2,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Container(
                                    width: drawerWidth * 0.35,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 2,
                                      ),
                                    ),
                                    child: Stack(
                                      children: [
                                        FractionallySizedBox(
                                          alignment: Alignment.centerLeft,
                                          widthFactor: 0.5,
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                bottomLeft: Radius.circular(10),
                                              ),
                                              color: Color(0xfff77776),
                                            ),
                                          ),
                                        ),
                                        const Center(
                                          child: Text(
                                            '500/500',
                                            style: TextStyle(
                                              color: Colors.white,
                                              height: 1.2,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Container(
                                    width: drawerWidth * 0.35,
                                    height: 15,
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 2,
                                      ),
                                    ),
                                    child: Stack(
                                      children: [
                                        FractionallySizedBox(
                                          alignment: Alignment.centerLeft,
                                          widthFactor: 1,
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                bottomLeft: Radius.circular(10),
                                              ),
                                              color: Color(0xffff8d24),
                                            ),
                                          ),
                                        ),
                                        const Center(
                                          child: Text(
                                            '100/100',
                                            style: TextStyle(
                                              color: Colors.white,
                                              height: 1.2,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(0),
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 2,
                                ),
                              ),
                              child: CircleAvatar(
                                backgroundColor: const Color(0xff1a1d28),
                                backgroundImage: AssetImage(
                                  getCharacterImage(userCharacter.character.id),
                                ), // Insira a imagem desejada
                              ),
                            ),
                            Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 2,
                                ),
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black.withOpacity(0.5),
                                ),
                                child: Center(
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      userCharacter.level.toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: drawerWidth * 0.1,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.grey,
                              width: 2,
                            ),
                          ),
                          child: CircleAvatar(
                            backgroundColor: const Color(0xff063e35),
                            backgroundImage: AssetImage(
                              getCharacterClassImage(
                                  userCharacter.character.id),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                color: const Color(0xff4b426d),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Wrap(
                      alignment: WrapAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 50,
                              child: Image.asset(goldIcon),
                            ),
                            Text(
                              decimalNumberFormat(userCharacter.gold),
                              style: const TextStyle(
                                color: Color(0xfffcec3e),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 50,
                              child: Image.asset(diamondIcon),
                            ),
                            Text(
                              decimalNumberFormat(user.diamond),
                              style: const TextStyle(
                                color: Color(0xff00ffff),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  children: [
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: const Text('Trocar de personagem'),
                      subtitle:
                          const Text('Selecione outro personagem da conta'),
                      onTap: logoutCharacter,
                    ),
                    ListTile(
                      leading: const Icon(Icons.exit_to_app),
                      title: const Text('Fazer logout'),
                      subtitle: const Text('Sair da conta'),
                      onTap: logout,
                    ),
                    ListTile(
                      leading: const Icon(Icons.list),
                      title: const Text('List'),
                      subtitle: const Text('Subtitle'),
                      onTap: logout,
                    ),
                    ListTile(
                      leading: const Icon(Icons.list),
                      title: const Text('List'),
                      subtitle: const Text('Subtitle'),
                      onTap: logout,
                    ),
                    ListTile(
                      leading: const Icon(Icons.list),
                      title: const Text('List'),
                      subtitle: const Text('Subtitle'),
                      onTap: logout,
                    ),
                    ListTile(
                      leading: const Icon(Icons.list),
                      title: const Text('List'),
                      subtitle: const Text('Subtitle'),
                      onTap: logout,
                    ),
                    ListTile(
                      leading: const Icon(Icons.list),
                      title: const Text('List'),
                      subtitle: const Text('Subtitle'),
                      onTap: logout,
                    ),
                    ListTile(
                      leading: const Icon(Icons.list),
                      title: const Text('List'),
                      subtitle: const Text('Subtitle'),
                      onTap: logout,
                    ),
                    ListTile(
                      leading: const Icon(Icons.list),
                      title: const Text('List'),
                      subtitle: const Text('Subtitle'),
                      onTap: logout,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
