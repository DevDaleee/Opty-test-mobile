import 'package:finance/models/user_models.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  UserProfile? _user;

  void refresh() {
    notifyListeners();
  }

  // initializeFsStepsProvider(BuildContext context, UserProfile user) {
  //   context.read<UserProfileProvider>().user = user;
  //   context.read<FsBodyDataProvider>().initialize(user.bodyData!);
  //   context.read<FsObjectivesProvider>().initialize(user.workoutData!);
  //   context.read<FsTrainingDaysProvider>().initialize(user.workoutData!);
  //   context.read<FsPhysicalTestProvider>().initialize(user.workoutData!);
  // }

  //Getters and setters
  UserProfile? get user => _user;

  set user(UserProfile? user) {
    _user = user;
    notifyListeners();
  }
}
