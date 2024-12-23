import 'package:finance/pages/boot_up_page.dart';
import 'package:finance/pages/auth/create_account_page.dart';
import 'package:finance/pages/charts/charts_hub.dart';
import 'package:finance/pages/flow/add_cashflow.dart';
import 'package:finance/pages/flow/details_cashflow.dart';
import 'package:finance/pages/flow/edit_cashflow.dart';
import 'package:finance/pages/home/home_page.dart';
import 'package:finance/pages/auth/login_page.dart';
import 'package:flutter/material.dart';

final Map<String, Widget Function(BuildContext)> namedRoutes = {
  '/bootPage': (context) => const BootPage(),
  '/home': (context) => const HomePage(),
  '/login': (context) => const LoginPage(),
  '/create': (context) => const CreateAccountPage(),
  '/add-cashFlow': (context) => const AddCashFlow(),
  '/charts': (context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (arguments == null || !arguments.containsKey('cashFlows')) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
        ),
        body: const Center(child: Text('Missing cashFlows argument.')),
      );
    }
    return Charts(cashFlows: arguments['cashFlows']);
  },
  '/edit-cashFlow': (context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (arguments == null || !arguments.containsKey('cashFlowId')) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
        ),
        body: const Center(child: Text('Missing cashFlowId argument.')),
      );
    }
    return EditCashFlow(cashFlowId: arguments['cashFlowId']);
  },
  '/detail-cashFlow': (context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (arguments == null || !arguments.containsKey('cashFlowId')) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
        ),
        body: const Center(child: Text('Missing cashFlowId argument.')),
      );
    }
    return DetailsCashFlow(cashFlowId: arguments['cashFlowId']);
  },
};
