import 'package:intl/intl.dart';

class Transaction {
  Transaction({
    required this.name,
    required this.amount,
    required this.icon,
    required this.type,
    this.id,
  });

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'] as int,
      name: map['name'] as String,
      amount: map['amount'] as double,
      type: map['type'] as String,
      icon: map['icon'] as int,
    );
  }
  int? id;
  String name;
  double amount;
  int icon;
  String type;
  String createdAt = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

  Map<String, Object?> toMap() {
    final map = {
      'name': name,
      'amount': amount,
      'icon': icon,
      'type': type,
      'createdAt': createdAt,
    };
    if (id != null) {
      map['id'] = id!;
    }
    return map;
  }

  @override
  String toString() =>
      'Transaction(id:$id, name: $name, amount: $amount, icon: $icon, type: $type)';
}
