// ignore_for_file: use_build_context_synchronously

import 'package:finance/components/buttons/custom_filled_button.dart';
import 'package:finance/components/buttons/custom_outlined_button.dart';
import 'package:finance/components/helper/sizes.dart';
import 'package:finance/components/helper/validation_mixin.dart';
import 'package:finance/data/usar_database.dart';
import 'package:finance/models/user_models.dart';
import 'package:finance/providers/user_provider.dart';
import 'package:finance/services/api/account.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with ValidationsMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isLoading = false;

  configUserData(BuildContext context) async {
    var userProfile =
        await AccountService.getUserByEmail(_emailController.text);
    var user = UserProfile.fromJson(userProfile.data);
    context.read<UserProvider>().user = user;

    if (user.email!.isNotEmpty) {
      await UserDatabase.update(user);

      initializeProviders(user);
      Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
    } else {
      Navigator.pushNamed(context, '/login');
    }
  }

  initializeProviders(UserProfile user) {
    context.read<UserProvider>().user = user;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(PaddingSizes.lg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logo/${Theme.of(context).brightness == Brightness.dark ? 'L' : 'D'}logo.png',
                scale: 7.5,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Text(
                'Olá, seja bem-vindo(a)!\nFaça seu login para continuar\n ou crie uma conta!',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.inverseSurface,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(hintText: 'Email'),
                      validator: (email) => combine(
                        [
                          () => isNotEmpty(email),
                          () => hasFiveChars(email),
                          () => validacaoEmail(email!),
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    TextFormField(
                      obscureText: true,
                      controller: _passwordController,
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(
                        hintText: 'Senha',
                      ),
                      validator: (senha) => combine(
                        [
                          () => isNotEmpty(senha),
                          () => hasFiveChars(senha),
                          () => validarSenha(senha!)
                        ],
                      ),
                    ),
                    // Align(
                    //   alignment: Alignment.centerRight,
                    //   child: TextButton(
                    //     onPressed: () {},
                    //     child: const Text(
                    //       'Esqueci a senha',
                    //       style: TextStyle(
                    //         fontSize: 14,
                    //         color: Color(0xff3F6784),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    CustomFilledButton(
                      onPressed: () async {
                        isLoading = true;
                        await AccountService.login(
                          _emailController.text,
                          _passwordController.text,
                        );
                        if (context.mounted) {
                          isLoading = false;
                          configUserData(context);
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/home', (_) => false);
                        }
                      },
                      isLoading: isLoading,
                      titulo: 'Entrar',
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    CustomOutlinedButton(
                      onPressed: () => Navigator.pushNamed(context, '/create'),
                      titulo: 'Cadastre-se',
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.2)
            ],
          ),
        ),
      ),
    );
  }
}
