// ignore_for_file: use_build_context_synchronously

import 'package:finance/components/custom_form_field.dart';
import 'package:finance/models/cash_flow_models.dart';
import 'package:flutter/material.dart';
import 'package:finance/components/buttons/custom_filled_button.dart';
import 'package:finance/components/buttons/custom_outlined_button.dart';
import 'package:finance/components/helper/regex.dart';
import 'package:finance/components/helper/sizes.dart';
import 'package:finance/components/tostification.dart';
import 'package:finance/data/usar_database.dart';
import 'package:finance/models/user_models.dart';
import 'package:finance/providers/cash_flow_provider.dart';
import 'package:finance/providers/user_provider.dart';
import 'package:finance/services/api/account.dart';
import 'package:finance/services/api/cash_flow.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isLoading = false;

  Future<void> configUserData(BuildContext context) async {
    var response = await AccountService.getUserByEmail(_emailController.text);

    if (response['success'] && response['data'] != null) {
      var user = UserProfile.fromJson(response['data']);
      context.read<UserProvider>().user = user;
      if (user.email!.isNotEmpty) {
        await UserDatabase.update(user);
        await initializeProviders(context, user);

        Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
      } else {
        Navigator.pushNamed(context, '/login');
      }
    } else {
      showToast(
        context,
        {
          'statusCode': response['statusCode'],
          'message': response['message'] ?? 'Failed to retrieve user',
        },
      );
      Navigator.pushNamed(context, '/login');
    }
  }

  Future<void> initializeProviders(
      BuildContext context, UserProfile user) async {
    context.read<UserProvider>().user = user;

    List<dynamic> remoteCashFlows = await CashFlowService.getAllCashFlows();

    if (context.mounted) {
      CashFlowProvider provider = context.read<CashFlowProvider>();

      await provider.loadFromDatabase();

      List<CashFlow> mergedCashFlows = _mergeCashFlows(
        provider.cashFlow,
        remoteCashFlows.map((json) => CashFlow.fromJson(json)).toList(),
      );

      provider.cashFlow = mergedCashFlows;
      await provider.updateDatabase();
    }
  }

  List<CashFlow> _mergeCashFlows(
    List<dynamic> localCashFlows,
    List<CashFlow> remoteCashFlows,
  ) {
    List<CashFlow> local = localCashFlows.cast<CashFlow>();
    Map<String, CashFlow> combinedMap = {
      for (var cashFlow in local) cashFlow.id: cashFlow,
      for (var cashFlow in remoteCashFlows) cashFlow.id: cashFlow,
    };
    return combinedMap.values.toList();
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
                    CustomTextField(
                      filled: true,
                      label: 'Email',
                      borderColor: Theme.of(context)
                          .colorScheme
                          .inversePrimary
                          .withOpacity(0.2),
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, preecha esse campo';
                        } else if (!emailRegex.hasMatch(value)) {
                          return 'Informe um email válido';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    CustomTextField(
                      filled: true,
                      label: 'Senha',
                      borderColor: Theme.of(context)
                          .colorScheme
                          .inversePrimary
                          .withOpacity(0.2),
                      controller: _passwordController,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, preecha esse campo';
                        } else if (value.length < 4) {
                          return 'Informe uma senha maior e segura';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    CustomFilledButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          await AccountService.login(
                            _emailController.text,
                            _passwordController.text,
                          );
                          if (context.mounted) {
                            setState(() {
                              isLoading = false;
                            });
                            await configUserData(context);
                          }
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
              SizedBox(height: MediaQuery.of(context).size.height * 0.2),
            ],
          ),
        ),
      ),
    );
  }
}
