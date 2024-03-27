import 'package:intl/intl.dart';

class Loan {
  int? id;
  String name;
  double amount;
  String date;
  String createdAt = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

  Loan({this.id, required this.name, required this.amount, required this.date});

  factory Loan.fromMap(Map<String, dynamic> map) {
    return Loan(
        id: map["id"],
        name: map["name"],
        amount: map["amount"],
        date: map["date"]);
  }

  Map<String, Object?> toMap() {
    var map = {
      "name": name,
      "amount": amount,
      "date": date,
      "createdAt": createdAt
    };
    if (id != null) {
      map["id"] = id!;
    }
    return map;
  }

  @override
  String toString() =>
      "Loan(id:$id, name: $name, amount: $amount, date: $date)";
}
