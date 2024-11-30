// ignore_for_file: constant_identifier_names

import 'package:finance/models/user_models.dart';

enum Category {
  HEALTH,
  HOUSING,
  INVESTMENTS,
  FOOD,
  INSURE,
  OTHER,
}

class CashFlow {
  int id = 1;
  String? reason;
  String? description;
  Category? category;
  bool? isCashIn;
  DateTime? createdAt;
  int userId = UserProfile().id;

  CashFlow({
    this.reason,
    this.description,
    this.category,
    this.isCashIn,
    this.createdAt,
  });

  CashFlow.fromJson(Map<String, dynamic> json) {
    reason = json['reason'];
    description = json['description'];
    category = json['category'];
    isCashIn = json['isCashIn'];
    createdAt = DateTime.parse(json['created_at']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['reason'] = reason;
    data['description'] = description;
    data['category'] = category;
    data['isCashIn'] = isCashIn;
    data['created_at'] = createdAt?.toIso8601String();
    return data;
  }
}
