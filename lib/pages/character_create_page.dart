import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/images.dart';
import '../enums/gender_enum.dart';
import '../helpers/handler_error.dart';
import '../models/character.dart';
import '../models/create_character.dart';
import '../models/user_character.dart';
import '../providers/character_provider.dart';
import '../providers/user_character_provider.dart';
import '../services/user_character_service.dart';
import '../utils/character_utils.dart';
import '../utils/utils.dart';
import '../validators/create_character_validator.dart';
import '../widgets/button2_widget.dart';
import '../widgets/button3_widget.dart';

class CharacterCreatePage extends ConsumerStatefulWidget {
  const CharacterCreatePage({super.key});

  @override
  ConsumerState<CharacterCreatePage> createState() =>
      _CharacterCreatePageState();
}

class _CharacterCreatePageState extends ConsumerState<CharacterCreatePage> {
  late Character _characterSelected;
  List<Character> _characters = [];
  bool _isExpanded = false;
  GenderEnum _genderSelected = GenderEnum.male;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _userCharacterService = UserCharacterService();

  @override
  void initState() {
    _characters = ref.read(charactersProvider);
    _changeCharacterSelected(_characters.first);
    super.initState();
  }

  void _changeCharacterSelected(Character character) {
    setState(() {
      _characterSelected = character;
    });
  }

  Future<void> _createCharacter() async {
    if (_formKey.currentState!.validate()) {
      try {
        showLoading(context);
        final userCharacter =
            await _userCharacterService.create(CreateCharacter(
          characterId: _characterSelected.id,
          name: _nameController.text,
          gender: _genderSelected,
        ));
        final List<UserCharacter> updatedUserCharacters =
            List<UserCharacter>.from(ref.read(userCharactersProvider))
              ..add(userCharacter);
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
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final itemSize = screenWidth / _characters.length * 2.3;

    return SafeArea(
      child: Material(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(characterCreateBg),
              alignment: Alignment.bottomCenter,
              fit: BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Criar personagem',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                ),
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: itemSize * _characters.length,
                  height: itemSize,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: _characters.length,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                    ),
                    itemCount: _characters.length,
                    itemBuilder: (BuildContext context, int index) {
                      final character = _characters[index];

                      return InkWell(
                        onTap: () => _changeCharacterSelected(character),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(itemSize / 2),
                          child: Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(selectCharacterCreateBg),
                                fit: BoxFit.cover,
                                alignment: Alignment.bottomCenter,
                              ),
                            ),
                            child: SizedBox(
                              width: screenWidth / 10,
                              height: screenHeight / 10,
                              child: _characterSelected == character
                                  ? Image.asset(
                                      getCharacterImage(character.id),
                                      fit: BoxFit.contain,
                                      alignment: Alignment.bottomCenter,
                                    )
                                  : ColorFiltered(
                                      colorFilter: const ColorFilter.mode(
                                        Colors.grey,
                                        BlendMode.saturation,
                                      ),
                                      child: Image.asset(
                                        getCharacterImage(character.id),
                                        fit: BoxFit.contain,
                                        alignment: Alignment.bottomCenter,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Card(
                        child: ExpansionTile(
                          title: Text(_characterSelected.name),
                          onExpansionChanged: (expanded) {
                            setState(() {
                              _isExpanded = expanded;
                            });
                          },
                          initiallyExpanded: _isExpanded,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                _characterSelected.description ?? '',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              ListTile(
                                title: const Text('Gênero'),
                                contentPadding: const EdgeInsets.all(0),
                                subtitle: Row(
                                  children: [
                                    Radio<GenderEnum>(
                                      value: GenderEnum.male,
                                      groupValue: _genderSelected,
                                      onChanged: (value) {
                                        setState(() {
                                          _genderSelected = value!;
                                        });
                                      },
                                    ),
                                    const Text('Masculino'),
                                    Radio<GenderEnum>(
                                      value: GenderEnum.female,
                                      groupValue: _genderSelected,
                                      onChanged: (value) {
                                        setState(() {
                                          _genderSelected = value!;
                                        });
                                      },
                                    ),
                                    const Text('Feminino'),
                                  ],
                                ),
                              ),
                              Form(
                                key: _formKey,
                                child: ListTile(
                                  title: const Text('Nome'),
                                  contentPadding: const EdgeInsets.all(0),
                                  subtitle: TextFormField(
                                    controller: _nameController,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      errorMaxLines: 2,
                                    ),
                                    validator:
                                        CreateCharacterValidator.validateName,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        children: [
                          Button2Widget(
                            text: 'Cancelar',
                            callback: () => close(context),
                          ),
                          Button3Widget(
                            text: 'Cadastrar',
                            callback: _createCharacter,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
