import 'dart:convert';
import 'package:finance/models/cash_flow_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CashFlowDatabase {
  static const String _cashFlowKey = 'cashFlow_data';

  static Future<void> initialize() async {
    await SharedPreferences.getInstance();
  }

  static Future<void> update(CashFlow cashFlow) async {
    final prefs = await SharedPreferences.getInstance();
    String cashFlowJson = jsonEncode(cashFlow.toJson());
    await prefs.setString(_cashFlowKey, cashFlowJson);
  }

  static Future<CashFlow?> get() async {
    final prefs = await SharedPreferences.getInstance();
    String? cashFlowJson = prefs.getString(_cashFlowKey);

    if (cashFlowJson != null) {
      return CashFlow.fromJson(jsonDecode(cashFlowJson));
    }
    return null;
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cashFlowKey);
  }
}
