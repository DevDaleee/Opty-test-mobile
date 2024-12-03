import 'package:finance/pages/flow/edit_cashflow.dart';
import 'package:finance/pages/routes.dart';
import 'package:finance/providers/providers.dart';
import 'package:finance/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/bootPage',
        theme: lightMode,
        darkTheme: darkMode,
        themeMode: ThemeMode.system,
        routes: namedRoutes,
        onGenerateRoute: (settings) {
          if (settings.name == '/edit-cashFlow') {
            final args = settings.arguments as Map<String, dynamic>?;
            if (args != null && args.containsKey('cashFlowId')) {
              return MaterialPageRoute(
                builder: (context) =>
                    EditCashFlow(cashFlowId: args['cashFlowId']),
              );
            }
            return MaterialPageRoute(
              builder: (context) => const Scaffold(
                body: Center(child: Text('Invalid or missing arguments.')),
              ),
            );
          }
          return null; // Let unknown routes fall through to `onUnknownRoute`.
        },
        onUnknownRoute: (settings) => MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(child: Text('Page not found.')),
          ),
        ),
      ),
    );
  }
}
