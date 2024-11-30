import 'package:flutter/material.dart';

class CashFlowProvider extends ChangeNotifier {
  List<dynamic> _cashFlow = [];

  //Getters and Setters
  List get cashFlow => _cashFlow;

  set cashFlow(List cashFlow) {
    _cashFlow = cashFlow;
    notifyListeners();
  }
}
