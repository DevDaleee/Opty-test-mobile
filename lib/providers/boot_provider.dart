import 'package:finance/data/usar_database.dart';
import 'package:finance/models/cash_flow_models.dart';
import 'package:finance/models/user_models.dart';
import 'package:finance/providers/cash_flow_provider.dart';
import 'package:finance/providers/user_provider.dart';
import 'package:finance/services/api/account.dart';
import 'package:finance/services/api/cash_flow.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BootProvider extends ChangeNotifier {
  Future<String> routeForInitialize(BuildContext context) async {
    await UserDatabase.initialize();
    await Future.delayed(const Duration(seconds: 2));
    var user = await UserDatabase.get();

    if (context.mounted) {
      if (user != null) {
        var updatedUser = await AccountService.getCurrentUser();
        if (context.mounted) {
          if (updatedUser['status_code'] == 200) {
            await reconfigUserData(context, updatedUser['data']);
          } else {
            _initializeProviders(context, user);
          }
        }
        return '/home';
      }
    }
    return '/login';
  }

  Future<void> reconfigUserData(
      BuildContext context, Map<String, dynamic> userJson) async {
    var user = UserProfile.fromJson(userJson);
    await UserDatabase.update(user);

    if (context.mounted) {
      _initializeProviders(context, user);
    }
    debugPrint('User data updated');
  }

  void _initializeProviders(BuildContext context, UserProfile user) async {
    context.read<UserProvider>().user = user;
    List<dynamic> cashFlowsData = await CashFlowService.getAllCashFlows();

    if (context.mounted) {
      context.read<CashFlowProvider>().cashFlow = cashFlowsData.map((json) {
        return CashFlow.fromJson(json);
      }).toList();
    }
  }
}
