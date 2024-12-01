import 'package:finance/models/cash_flow_models.dart';
import 'package:flutter/material.dart';

class CashFlowProvider extends ChangeNotifier {
  List<CashFlow> _cashFlow = [];
  List<CashFlow> _filteredCashFlow = [];
  double totalBalance = 0.00;
  double cashIn = 0.00;
  double cashOut = 0.00;
  int lenght = 0;
  final List<bool> _selectedFilterValues = [false, false, true, false, false];
  int _selectedFilterIndex = 3;

  List<CashFlow> get cashFlow => _cashFlow;
  List<CashFlow> get filteredCashFlow => _filteredCashFlow;
  int get selectedFilterIndex => _selectedFilterIndex;

  set cashFlow(List<CashFlow> cashFlows) {
    _cashFlow = cashFlows;
    totalBalance = _calculateTotalBalance();
    _cashInAndCashOut();
    notifyListeners();
  }

  void _cashInAndCashOut() {
    for (var element in _cashFlow) {
      if (element.isCashIn! == true) {
        cashIn = element.amount!;
      } else {
        cashOut = element.amount!;
      }
      lenght++;
    }
  }

  double _calculateTotalBalance() {
    return _cashFlow.fold(0.0, (sum, item) {
      return item.isCashIn! ? sum + item.amount! : sum - item.amount!;
    });
  }

  filter(int filterIndex) {
    for (int i = 0; i < _selectedFilterValues.length; i++) {
      _selectedFilterValues[i] = i == filterIndex;
    }

    _selectedFilterIndex = filterIndex;

    switch (filterIndex) {
      case 0:
        _filteredCashFlow =
            _cashFlow.where((value) => value.isCashIn == true).toList();
        break;

      case 1:
        _filteredCashFlow =
            _cashFlow.where((value) => value.isCashIn == false).toList();
        break;

      case 2:
        _filteredCashFlow = _cashFlow
            .where(
              (value) => value.createdAt != null,
            )
            .toList()
          ..sort((a, b) {
            return a.createdAt!.difference(DateTime.now()).abs().compareTo(
                  b.createdAt!.difference(DateTime.now()).abs(),
                );
          });

        break;

      case 3:
        _filteredCashFlow =
            _cashFlow.where((value) => value.createdAt != null).toList()
              ..sort((a, b) {
                return b.createdAt!.difference(DateTime.now()).compareTo(
                      a.createdAt!.difference(DateTime.now()),
                    );
              });

        break;

      default:
        _filteredCashFlow = [];
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
}
