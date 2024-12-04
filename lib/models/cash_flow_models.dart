// ignore_for_file: constant_identifier_names

enum Category {
  HEALTH,
  HOUSING,
  INVESTMENTS,
  FOOD,
  INSURE,
  OTHER,
}

class CashFlow {
  String id;
  String? reason;
  String? description;
  Category? category;
  double? amount;
  bool? isCashIn;
  DateTime? createdAt;
  String userId;

  CashFlow({
    required this.id,
    this.reason,
    this.description,
    required this.category,
    required this.amount,
    required this.isCashIn,
    required this.createdAt,
    required this.userId,
  });
  
  factory CashFlow.fromJson(Map<String, dynamic> json) {
    return CashFlow(
      id: json['id'] as String,
      reason: json['reason'] as String?,
      description: json['description'] as String?,
      category: _getCategoryFromString(json['category'] as String?),
      amount: (json['amount'] as num?)?.toDouble(),
      isCashIn: json['isCashIn'] as bool?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      userId: json['userId'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'reason': reason,
      'description': description,
      'category': category?.name,
      'amount': amount,
      'isCashIn': isCashIn,
      'createdAt': createdAt?.toIso8601String(),
      'userId': userId,
    };
  }
  static Category? _getCategoryFromString(String? categoryString) {
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
        return Category.OTHER;
    }
  }
}
