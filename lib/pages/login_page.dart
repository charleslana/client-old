import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/images.dart';
import '../helpers/handler_error.dart';
import '../models/auth.dart';
import '../models/register.dart';
import '../providers/user_provider.dart';
import '../routes/app_routes.dart';
import '../services/character_service.dart';
import '../services/user_character_service.dart';
import '../services/user_service.dart';
import '../utils/style_utils.dart';
import '../utils/utils.dart';
import '../validators/login_validator.dart';
import '../validators/register_validator.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmationController = TextEditingController();
  final _nameController = TextEditingController();
  final _user = UserService();
  final _userCharacter = UserCharacterService();
  final _character = CharacterService();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _autoLogin();
    });
    super.initState();
  }

  Future<void> _autoLogin() async {
    try {
      showLoading(context);
      final auth = await _user.getAuth();
      _emailController.text = auth.email;
      _passwordController.text = auth.password;
      await _login();
    } catch (e) {
      if (context.mounted) {
        close(context);
      }
    }
  }

  Future<void> _showStartDialog() async {
    await showModalBottomSheet<dynamic>(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 30,
          ),
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: [
              OutlinedButton(
                onPressed: () async {
                  await _showRegisterDialog();
                },
                child: const Text('Cadastrar uma nova conta'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await _showLoginDialog();
                },
                child: const Text('Entrar'),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _showRegisterDialog() async {
    await showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        bool obscureText = true;
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                top: 30,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 30,
              ),
              child: Form(
                key: _registerFormKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        const Text('Cadastrar uma nova conta!'),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(width: 2),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => close(context),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Informe o e-mail',
                        errorMaxLines: 2,
                      ),
                      validator: RegisterValidator.validateEmail,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: 'Informe a senha',
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                        ),
                        errorMaxLines: 2,
                      ),
                      obscureText: obscureText,
                      validator: RegisterValidator.validatePassword,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _passwordConfirmationController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Confirme a senha',
                        errorMaxLines: 2,
                      ),
                      obscureText: obscureText,
                      validator: (value) =>
                          RegisterValidator.validatePasswordConfirmation(
                              _passwordController.text, value),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Informe o nome',
                        errorMaxLines: 2,
                      ),
                      validator: RegisterValidator.validateName,
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _register,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: const Text('Cadastrar'),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }

  Future<void> _showLoginDialog() async {
    await showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        bool obscureText = true;

        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                top: 30,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 30,
              ),
              child: Form(
                key: _loginFormKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        const Text('Faça login na sua conta!'),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(width: 2),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => close(context),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Informe o e-mail',
                      ),
                      validator: LoginValidator.validateEmail,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: 'Informe a senha',
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                        ),
                      ),
                      obscureText: obscureText,
                      validator: LoginValidator.validatePassword,
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
                        await _formLogin();
                      },
                      child: const Text('Entrar'),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }

  Future<void> _formLogin() async {
    if (_loginFormKey.currentState!.validate()) {
      showLoading(context);
      await _login();
    }
  }

  Future<void> _login() async {
    try {
      final auth = Auth(
        email: _emailController.text,
        password: _passwordController.text,
      );
      final token = await _user.auth(auth);
      await _user.saveAuth(auth, token, ref);
      await _getData();
    } on DioException catch (e) {
      if (context.mounted) {
        close(context);
        await getError(e, context);
      }
    }
  }

  Future<void> _register() async {
    if (_registerFormKey.currentState!.validate()) {
      try {
        showLoading(context);
        await _user.create(Register(
          email: _emailController.text,
          password: _passwordController.text,
          passwordConfirmation: _passwordConfirmationController.text,
          name: _nameController.text,
        ));
        await _login();
      } on DioException catch (e) {
        if (context.mounted) {
          close(context);
          await getError(e, context);
        }
      }
    }
  }

  Future<void> _getData() async {
    await _getUserCharacters();
    await _getUserProfile();
    await _geCharacters();
    if (context.mounted) {
      replace(context, characterChoiceRoute);
    }
  }

  Future<void> _getUserCharacters() async {
    try {
      await _userCharacter.getAll(ref);
    } catch (e) {
      print(e);
    }
  }

  Future<void> _getUserProfile() async {
    try {
      final user = await _user.getProfile();
      ref.read(userProvider.notifier).state = user;
    } catch (e) {
      print(e);
    }
  }

  Future<void> _geCharacters() async {
    try {
      final characters = await _character.getAll();
      _character.saveCharacters(ref, characters);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: InkWell(
          onTap: _showStartDialog,
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(loginBg),
                alignment: Alignment.bottomCenter,
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Center(
                child: IgnorePointer(
                  child: AnimatedTextKit(
                    animatedTexts: [
                      FadeAnimatedText(
                        'Toque na tela para começar',
                        textStyle: TextStyle(
                          color: Colors.white,
                          shadows: shadows,
                        ),
                        textAlign: TextAlign.center,
                        fadeInEnd: 0.3,
                        fadeOutBegin: 0.4,
                      ),
                    ],
                    repeatForever: true,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
