import 'package:finance/components/helper/sizes.dart';
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
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(backgroundColor: Theme.of(context).colorScheme.primary),
      ),
      body: Consumer<BootProvider>(
        builder: (context, provider, _) => FutureBuilder(
          future: provider.routeForInitialize(context),
          builder: (context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logo/Llogo.png',
                    scale: 8,
                  ),
                  const SizedBox(height: SpaceSizes.xxl),
                  const Center(child: CircularProgressIndicator()),
                ],
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
