import 'package:finance/models/cashFlow_models.dart';

class UserProfile {
  int id = 1;
  String? name;
  String? email;
  CashFlow? cashFlow;

  UserProfile({
    this.name,
    this.email,
    this.cashFlow,
  });

  UserProfile.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    cashFlow = json['cashFlow_data'] != null
        ? CashFlow.fromJson(json['cashFlow_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    if (cashFlow != null) {
      data['cashFlow_data'] = cashFlow!.toJson();
    }
    return data;
  }
}
