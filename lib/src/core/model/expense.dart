import 'package:intl/intl.dart';

class Expense {
  int? id;
  String name;
  double amount;
  int icon;
  String createdAt = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

  Expense(
      {this.id,
      required this.name,
      required this.amount,
      required this.icon});

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
        id: map["id"],
        name: map["name"],
        amount: map["amount"],
        icon: map["icon"]);
  }

  Map<String, Object?> toMap() {
    var map = {
      "name": name,
      "amount": amount,
      "icon": icon,
      "createdAt": createdAt
    };
    if (id != null) {
      map["id"] = id!;
    }
    return map;
  }

  @override
  String toString() =>
      "Expense(id:$id, name: $name, amount: $amount, icon: $icon)";
}
