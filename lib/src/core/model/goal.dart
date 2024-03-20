import 'package:intl/intl.dart';

class Goal {
  int? id;
  String name;
  double amount;
  int color;
  int icon;
  String createdAt = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

  Goal(
      {this.id,
      required this.name,
      required this.amount,
      required this.color,
      required this.icon});

  factory Goal.fromMap(Map<String, dynamic> map) {
    return Goal(
        id: map["id"],
        name: map["name"],
        amount: map["amount"],
        color: map["color"],
        icon: map["icon"]);
  }

  Map<String, Object?> toMap() {
    var map = {
      "name": name,
      "amount": amount,
      "color": color,
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
      "Goal(id:$id, name: $name, amount: $amount, color: $color, icon: $icon)";
}
