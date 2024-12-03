import 'dart:convert';
import 'package:finance/models/cash_flow_models.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CashFlowProvider extends ChangeNotifier {
  List<dynamic> _cashFlow = [];
  List<dynamic> _filteredCashFlow = [];
  double totalBalance = 0.00;
  double cashIn = 0.00;
  double cashOut = 0.00;
  int lenght = 0;
  final List<bool> _selectedFilterValues = [false, false, false, true, false];
  int _selectedFilterIndex = 3;
  Category pickedCategory = Category.FOOD;
  bool? isCashIn = true;

  List<dynamic> get cashFlow => _cashFlow;
  List<dynamic> get filteredCashFlow => _filteredCashFlow;
  int get selectedFilterIndex => _selectedFilterIndex;

  set cashFlow(List<dynamic> cashFlows) {
    _cashFlow = cashFlows;
    totalBalance = _calculateTotalBalance();
    _cashInAndCashOut();
    updateDatabase();
    filter(2);
    notifyListeners();
  }

  void toggleIsCashIn() {
    isCashIn = !isCashIn!;
    notifyListeners();
  }

  void removeCashFlowById(String cashFlowId) {
    _cashFlow.removeWhere((flow) => flow.id == cashFlowId);
    _filteredCashFlow = _cashFlow;
    notifyListeners();
  }

  void addCashFlow(CashFlow newCashFlow) {
    _cashFlow.add(newCashFlow);
    _filteredCashFlow = _cashFlow;
    notifyListeners();
  }

  Future<void> loadFromDatabase() async {
    final prefs = await SharedPreferences.getInstance();
    String? cashFlowJson = prefs.getString('cashFlow_data');

    if (cashFlowJson != null) {
      List<dynamic> cashFlowList = jsonDecode(cashFlowJson);
      _cashFlow = cashFlowList.map((item) => CashFlow.fromJson(item)).toList();
    } else {
      _cashFlow = [];
    }

    totalBalance = _calculateTotalBalance();
    _cashInAndCashOut();
    notifyListeners();
  }

  Future<void> updateDatabase() async {
    final prefs = await SharedPreferences.getInstance();
    String cashFlowJson =
        jsonEncode(_cashFlow.map((item) => item.toJson()).toList());
    await prefs.setString('cashFlow_data', cashFlowJson);
  }

  void updateCategoryChoosed(String value) {
    pickedCategory = getCategoryFromString(value);
    notifyListeners();
  }

  void _cashInAndCashOut() {
    cashIn = 0.0;
    cashOut = 0.0;
    lenght = 0;

    for (var element in _cashFlow) {
      if (element.isCashIn! == true) {
        cashIn += element.amount!;
      } else {
        cashOut += element.amount!;
      }
      lenght++;
    }
  }

  double _calculateTotalBalance() {
    return _cashFlow.fold(0.0, (sum, item) {
      if (item is CashFlow) {
        return item.isCashIn! ? sum + item.amount! : sum - item.amount!;
      } else {
        debugPrint('Item ignorado no cálculo: $item');
        return sum;
      }
    });
  }

  void filter(int filterIndex) {
    for (int i = 0; i < _selectedFilterValues.length; i++) {
      _selectedFilterValues[i] = i == filterIndex;
    }
    _selectedFilterIndex = filterIndex;

    switch (filterIndex) {
      case 0: // Somente entradas
        _filteredCashFlow =
            _cashFlow.where((value) => value.isCashIn == true).toList();
        break;

      case 1: // Somente saídas
        _filteredCashFlow =
            _cashFlow.where((value) => value.isCashIn == false).toList();
        break;

      case 2: // Ordenado por proximidade da data
        _filteredCashFlow =
            _cashFlow.where((value) => value.createdAt != null).toList()
              ..sort((a, b) {
                return a.createdAt!
                    .difference(DateTime.now())
                    .compareTo(b.createdAt!.difference(DateTime.now()).abs());
              });
        break;

      case 3: // Ordenado por data mais distante
        _filteredCashFlow =
            _cashFlow.where((value) => value.createdAt != null).toList()
              ..sort((a, b) {
                return b.createdAt!
                    .difference(DateTime.now())
                    .compareTo(a.createdAt!.difference(DateTime.now()));
              });
        break;

      default:
        _filteredCashFlow = _cashFlow;
    }
    notifyListeners();
  }

  String getSelectedFilter(int selectedFilterIndex) {
    switch (selectedFilterIndex) {
      case 0:
        return 'Somente Entradas';
      case 1:
        return 'Somente Saídas';
      case 2:
        return 'Mais Recente';
      case 3:
        return 'Mais Antigo';
      default:
        return 'Mais Recente';
    }
  }

  Category getCategoryFromString(String categoryString) {
    switch (categoryString) {
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
        throw Exception('Categoria desconhecida: $categoryString');
    }
  }

  String getStringFromCategory(Category category) {
    switch (category) {
      case Category.HEALTH:
        return 'Saúde';
      case Category.HOUSING:
        return 'Casa';
      case Category.INVESTMENTS:
        return 'Investimentos';
      case Category.FOOD:
        return 'Comida';
      case Category.INSURE:
        return 'Entretenimento';
      case Category.OTHER:
        return 'Outro';
    }
  }
}
