import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/attribute_bar.dart';
import '../components/bottom_navigation_menu.dart';
import '../components/custom_drawer.dart';
import '../components/custom_shader_mask.dart';
import '../data/images.dart';
import '../enums/attribute_enum.dart';
import '../helpers/handler_error.dart';
import '../models/attribute.dart';
import '../models/attribute_status.dart';
import '../providers/user_character_provider.dart';
import '../services/user_character_service.dart';
import '../utils/character_utils.dart';
import '../utils/style_utils.dart';
import '../utils/utils.dart';
import '../widgets/button4_widget.dart';

class OverviewPage extends ConsumerWidget {
  OverviewPage({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _userCharacter = UserCharacterService();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userCharacter = ref.watch(userCharacterProvider);
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    Future<void> getProfile() async {
      try {
        final userCharacter = await _userCharacter.getProfile();
        _userCharacter.saveUserCharacter(ref, userCharacter);
      } catch (e) {
        print(e);
      }
    }

    Future<void> addAttribute(AttributeEnum? attribute, String point) async {
      if (formKey.currentState!.validate() && attribute != null) {
        try {
          showLoading(context);
          final parsePoint = int.parse(point);
          await _userCharacter.updateAttribute(
              Attribute(attribute: attribute, point: parsePoint));
          await getProfile();
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

    Future<void> showAttributeDialog() async {
      await showDialog<dynamic>(
        context: context,
        builder: (BuildContext context) {
          AttributeEnum? selectedAttribute;
          final pointController = TextEditingController(text: '0');

          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              insetPadding: const EdgeInsets.all(10),
              title: const Center(
                child: Text(
                  'Distribuir pontos',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              content: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Você possui ${decimalNumberFormat(userCharacter.point)} ponto(s) para distribuir',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      DropdownButtonFormField<AttributeEnum>(
                        value: selectedAttribute,
                        onChanged: (newValue) {
                          setState(() {
                            selectedAttribute = newValue;
                          });
                        },
                        items: [
                          const DropdownMenuItem<AttributeEnum>(
                            child: Text(
                              'Escolha um atributo',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          DropdownMenuItem<AttributeEnum>(
                            value: AttributeEnum.strength,
                            child: Text(
                              AttributeEnum.strength.label,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          DropdownMenuItem<AttributeEnum>(
                            value: AttributeEnum.intelligence,
                            child: Text(
                              AttributeEnum.intelligence.label,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          DropdownMenuItem<AttributeEnum>(
                            value: AttributeEnum.dexterity,
                            child: Text(
                              AttributeEnum.dexterity.label,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Selecione um atributo',
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        validator: (selectedValue) {
                          if (selectedValue == null) {
                            return 'Campo do atributo é obrigatório';
                          }
                          return null;
                        },
                        dropdownColor: Colors.black,
                        isExpanded: true,
                        elevation: 1,
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: pointController,
                        cursorColor: Colors.white,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Pontos',
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          hintText: '0',
                          hintStyle: TextStyle(color: Colors.white),
                          errorMaxLines: 2,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Campo do pontos do atributo é obrigatório';
                          }
                          final intValue = int.tryParse(value);
                          if (intValue == null) {
                            return 'O valor deve ser um número inteiro';
                          }
                          if (intValue < 1 || intValue > 999) {
                            return 'O valor deve ser entre 1 e 999';
                          }
                          if (intValue > userCharacter.point) {
                            return 'Não pode inserir um valor maior que o seu limite ${userCharacter.point}';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                            RegExp('[1-9][0-9]*'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      IconButton(
                        onPressed: () => addAttribute(
                            selectedAttribute, pointController.text),
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              backgroundColor: const Color(0xff131f2f),
              actions: [
                TextButton(
                  child: const Text('Fechar'),
                  onPressed: () => close(context),
                ),
              ],
            );
          });
        },
      );
    }

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
                          Column(
                            children: [
                              Text(
                                userCharacter.groupMember != null
                                    ? userCharacter.groupMember!.group.name
                                    : '--',
                                style: const TextStyle(
                                  color: Color(0xff6e7b8c),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
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
                                onPressed: () => showAlertDialog(
                                    context,
                                    '''
FOR - Aumenta o atributo de FORÇA dos personagens, garantindo os seguintes status:
HP; Ataque; Redução de Danos; Resistência à Queda; Ignorar Perfuração.\n
INT - Aumenta o atributo de INTELIGÊNCIA dos personagens, garantindo os seguintes status:
Ataque Mágico; Resistência à Taxa Crítica; Resistência aos Danos Críticos; Resistência à Técnica Amp; Resistência à Investida; Resistência ao Atordoamento.\n
DES - Aumenta o atributo de DESTREZA dos personagens, garantindo os seguintes status:
Precisão; Evasão; Bloqueio; Resistência à Imobilidade; Resistência à Queda.
                                    ''',
                                    'Atributos'),
                                icon: const Icon(
                                  Icons.info,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const Text(
                              'Atributos',
                              textAlign: TextAlign.center,
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
                      callback: showAttributeDialog,
                    ),
                    const Divider(),
                    const Text(
                      'Estatísticas',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 4,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                      childAspectRatio: 0.65,
                      padding: const EdgeInsets.only(top: 10),
                      children: [
                        _statisticsCard('Ataque físico', 0),
                        _statisticsCard('Ataque mágico', 0),
                        _statisticsCard('Defesa física', 0),
                        _statisticsCard('Defesa mágica', 0),
                        _statisticsCard('Amp. espada', 0),
                        _statisticsCard('Amp. mágico', 0),
                        _statisticsCard('Precisão', 0),
                        _statisticsCard('Dano crítico', 0),
                        _statisticsCard('Taxa crítica', 0),
                        _statisticsCard('Defesa', 0),
                        _statisticsCard('Evasão', 0),
                        _statisticsCard('Perfuração', 0),
                        _statisticsCard('Ignorar evasão', 0),
                        _statisticsCard('Dano adicional', 0),
                        _statisticsCard('Bloqueio', 0),
                        _statisticsCard('Resistência a taxa crítica', 0),
                        _statisticsCard('Resistência a dano crítico', 0),
                        _statisticsCard('Ignorar perfuração', 0),
                        _statisticsCard('Ignorar precisão', 0),
                        _statisticsCard('Resistência a técnica amp.', 0),
                        _statisticsCard('Redução de danos', 0),
                        _statisticsCard('Resistência à queda', 0),
                        _statisticsCard('Resistência a atordoamento', 0),
                        _statisticsCard('Resistência a imobilidade', 0),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationMenu(scaffoldKey: _scaffoldKey),
        drawer: CustomDrawer(),
      ),
    );
  }

  Widget _statisticsCard(String title, int value) {
    return Card(
      color: const Color(0xff1a2739),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: const BorderRadius.all(Radius.circular(3)),
                  border: Border.all(
                    color: Colors.black54,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        decimalNumberFormat(value),
                        style: const TextStyle(
                          height: 0,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
