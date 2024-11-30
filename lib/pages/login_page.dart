import 'package:finance/components/helper/regex.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    var textInputStyle = const TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w500,
      fontFamily: 'Poppins',
    );

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icons/${Theme.of(context).brightness == Brightness.dark ? 'light' : 'dark'}/iatrain_logo.png',
                    scale: 12,
                  ),
                  Text(
                    'Olá, Faça seu login para continuar \nou crie uma conta!',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.inverseSurface,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          style: textInputStyle.copyWith(
                            color: Theme.of(context).colorScheme.inverseSurface,
                          ),
                          decoration: const InputDecoration(hintText: 'Email'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, preecha esse campo';
                            } else if (!emailRegex.hasMatch(value)) {
                              return 'Informe um email válido';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          obscureText: true,
                          controller: _passwordController,
                          textInputAction: TextInputAction.done,
                          style: textInputStyle.copyWith(
                            color: Theme.of(context).colorScheme.inverseSurface,
                          ),
                          decoration: const InputDecoration(hintText: 'Senha'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, preecha esse campo';
                            }
                            return null;
                          },
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () => Navigator.of(context).pushNamed(
                              '/auth/reset-password',
                            ),
                            child: const Text(
                              'Esqueci a senha',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xff3F6784),
                              ),
                            ),
                          ),
                        ),
                        FilledButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                              Theme.of(context).colorScheme.onSecondary,
                            ),
                          ),
                          onPressed: () {},
                          child: _isLoading
                              ? const CircularProgressIndicator()
                              : Text('Entrar', style: textInputStyle),
                        ),
                        OutlinedButton(
                          onPressed: () => Navigator.pushNamed(
                              context, '/auth/create-account'),
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            side: BorderSide(
                              color: Theme.of(context)
                                  .colorScheme
                                  .inverseSurface
                                  .withOpacity(0.8),
                            ),
                          ),
                          child: Text(
                            'Cadastre-se',
                            style: textInputStyle.copyWith(
                              color:
                                  Theme.of(context).colorScheme.inverseSurface,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
