import 'package:intl/intl.dart';

class Transaction {
  int? id;
  String name;
  double amount;
  int icon;
  String createdAt = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

  Transaction(
      {this.id,
      required this.name,
      required this.amount,
      required this.icon});

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
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
      "Transaction(id:$id, name: $name, amount: $amount, icon: $icon)";
}
