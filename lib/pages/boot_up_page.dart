import 'package:finance/providers/boot_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BootPage extends StatefulWidget {
  const BootPage({super.key});

  @override
  State<BootPage> createState() => _BootPageState();
}

class _BootPageState extends State<BootPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Consumer<BootProvider>(
        builder: (context, provider, _) => FutureBuilder(
          future: provider.routeForInitialize(context),
          builder: (context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Image.asset(
                  'assets/logo/${Theme.of(context).brightness == Brightness.dark ? 'L' : 'D'}logo.png',
                  scale: 8,
                ),
              );
            } else {
              WidgetsBinding.instance.addPostFrameCallback(
                (_) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    snapshot.data ?? '/login',
                    (_) => false,
                  );
                },
              );
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
