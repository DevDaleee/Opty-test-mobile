import 'dart:convert';
import 'package:finance/models/cash_flow_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CashFlowDatabase {
  static const String _cashFlowKey = 'cashFlow_data';

  static Future<void> initialize() async {
    await SharedPreferences.getInstance();
  }

  static Future<void> updateAll(List<CashFlow> cashFlows) async {
    final prefs = await SharedPreferences.getInstance();
    String cashFlowJson = jsonEncode(cashFlows.map((e) => e.toJson()).toList());
    await prefs.setString(_cashFlowKey, cashFlowJson);
  }

  static Future<List<CashFlow>> getAll() async {
    final prefs = await SharedPreferences.getInstance();
    String? cashFlowJson = prefs.getString(_cashFlowKey);

    if (cashFlowJson != null) {
      List<dynamic> cashFlowList = jsonDecode(cashFlowJson);
      return cashFlowList.map((item) => CashFlow.fromJson(item)).toList();
    }
    return [];
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cashFlowKey);
  }
}

