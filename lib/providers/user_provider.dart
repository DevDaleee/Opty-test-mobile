import 'package:finance/data/usar_database.dart';
import 'package:finance/models/user_models.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  UserProfile? _user;

  
  void getProfile() async {
    _user = await UserDatabase.get();
  }

  //Getters and setters
  UserProfile? get user => _user;

  set user(UserProfile? user) {
    _user = user;
    notifyListeners();
  }
}
