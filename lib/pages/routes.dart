import 'package:finance/pages/boot_up_page.dart';
import 'package:finance/pages/home_page.dart';
import 'package:finance/pages/login_page.dart';
import 'package:flutter/material.dart';

final Map<String, Widget Function(BuildContext)> namedRoutes = {
  '/bootPage': (context) => const BootPage(),
  '/home': (context) => const HomePage(),
  '/login': (context) => const LoginPage(),
};
