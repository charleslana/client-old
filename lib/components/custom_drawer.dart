import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../helpers/handler_error.dart';
import '../providers/user_character_provider.dart';
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
    final userCharacter = ref.read(userCharacterProvider);

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

    return SafeArea(
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(userCharacter.name),
              accountEmail: Text('Nv. ${userCharacter.level}'),
              currentAccountPicture: CircleAvatar(
                backgroundImage:
                    AssetImage(getCharacterImage(userCharacter.character.id)),
              ),
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: const Text('Trocar de personagem'),
              subtitle: const Text('Selecione outro personagem da conta'),
              onTap: logoutCharacter,
            ),
            ListTile(
              title: const Text('Fazer logout'),
              subtitle: const Text('Sair da conta'),
              onTap: logout,
            ),
          ],
        ),
      ),
    );
  }
}
