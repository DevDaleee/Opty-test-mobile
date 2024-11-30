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
      ),
    );
  }
}
