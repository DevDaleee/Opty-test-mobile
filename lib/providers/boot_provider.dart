import 'package:finance/data/usar_database.dart';
import 'package:finance/models/user_models.dart';
import 'package:finance/providers/user_provider.dart';
import 'package:finance/services/api/account.dart';
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
            reconfigUserData(context, updatedUser['data']);
          } else {
            _initializeProviders(context, user);
          }
        }
        return '/home';
      }
    }
    return '/login';
  }

  reconfigUserData(BuildContext context, Map<String, dynamic> userJson) async {
    var user = UserProfile.fromJson(userJson);
    await UserDatabase.update(user);
    if (context.mounted) {
      _initializeProviders(context, user);
    }
    debugPrint('User data updated');
  }

  _initializeProviders(BuildContext context, UserProfile user) {
    context.read<UserProvider>().user = user;
  }
}
