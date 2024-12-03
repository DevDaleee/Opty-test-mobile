// ignore_for_file: use_build_context_synchronously

import 'package:finance/components/custom_form_field.dart';
import 'package:flutter/material.dart';
import 'package:finance/components/buttons/custom_outlined_button.dart';
import 'package:finance/components/helper/regex.dart';
import 'package:finance/components/helper/sizes.dart';
import 'package:finance/components/tostification.dart';
import 'package:finance/services/api/account.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _submit() async {
    if (_isLoading) return;
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    Map<String, dynamic> res = await AccountService.createUser(
      _emailController.text,
      _passwordController.text,
      _nameController.text,
    );

    setState(() => _isLoading = false);

    if (res['success']) {
      showToast(context, res);
      Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);
    } else {
      showToast(context, res);
    }
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logo/${Theme.of(context).brightness == Brightness.dark ? 'L' : 'D'}logo.png',
                scale: 7.5,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Text(
                'Cadastre-se para ter melhor\ncontrole de sua vida financeira!',
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
                      enabled: true,
                      filled: true,
                      label: 'Nome',
                      controller: _nameController,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, preencha esse campo';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    CustomTextField(
                      enabled: true,
                      filled: true,
                      label: 'Email',
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, preencha esse campo';
                        } else if (!emailRegex.hasMatch(value)) {
                          return 'Informe um email válido';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    CustomTextField(
                      enabled: true,
                      filled: true,
                      label: 'Senha',
                      obscureText: true,
                      controller: _passwordController,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, preencha esse campo';
                        } else if (value.length < 4) {
                          return 'Informe uma senha maior e segura';
                        } else if (_passwordController.text !=
                            _confirmpasswordController.text) {
                          return 'As senhas não coincidem';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    CustomTextField(
                      enabled: true,
                      filled: true,
                      label: 'Confirme a senha',
                      obscureText: true,
                      controller: _confirmpasswordController,
                      textInputAction: TextInputAction.done,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, preencha esse campo';
                        } else if (value.length < 4) {
                          return 'Informe uma senha maior e segura';
                        } else if (_passwordController.text != value) {
                          return 'As senhas não coincidem';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    CustomOutlinedButton(
                      onPressed: _submit,
                      isLoading: _isLoading,
                      titulo: 'Cadastre-se',
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
