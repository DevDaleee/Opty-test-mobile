import 'package:finance/pages/boot_up_page.dart';
import 'package:finance/pages/auth/create_account_page.dart';
import 'package:finance/pages/flow/add_cashflow.dart';
import 'package:finance/pages/home/home_page.dart';
import 'package:finance/pages/auth/login_page.dart';
import 'package:flutter/material.dart';

final Map<String, Widget Function(BuildContext)> namedRoutes = {
  '/bootPage': (context) => const BootPage(),
  '/home': (context) => const HomePage(),
  '/login': (context) => const LoginPage(),
  '/create': (context) => const CreateAccountPage(),
  '/add-cashFlow': (context) => const AddCashFlow(),
};
