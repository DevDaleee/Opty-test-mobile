import 'package:finance/models/cash_flow_models.dart';
import 'package:flutter/material.dart';

class CashFlowProvider extends ChangeNotifier {
  List<dynamic> _cashFlow = [];

  Category getCategoryFromString(String categoryString) {
    switch (categoryString.toUpperCase()) {
      case 'Saúde':
        return Category.HEALTH;
      case 'Casa':
        return Category.HOUSING;
      case 'Investimentos':
        return Category.INVESTMENTS;
      case 'Comida':
        return Category.FOOD;
      case 'Entretenimento':
        return Category.INSURE;
      case 'Outro':
        return Category.OTHER;
      default:
        return Category.OTHER;
    }
  }

  // initialize(CashFlow data) {
  //   reason.text = data.reason.toString();
  //   description.text = data.description.toString();
  //   category = getCategoryFromString(data.category.toString());
  //   createdAt = data.createdAt!;
  //   isCashIn.text = data.isCashIn.toString();
  // }

  //Getters and Setters
  List get cashFlow => _cashFlow;

  set cashFlow(List cashFlow) {
    _cashFlow = cashFlow;
    notifyListeners();
  }
}
