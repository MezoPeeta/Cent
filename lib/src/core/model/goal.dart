import 'package:intl/intl.dart';

class Goal {
  Goal({
    required this.name,
    required this.amount,
    required this.icon,
    this.id,
    this.color = 4294967295,
  });

  factory Goal.fromMap(Map<String, dynamic> map) {
    return Goal(
      id: map['id'] as int,
      name: map['name'] as String,
      amount: map['amount'] as double,
      color: map['color'] as int,
      icon: map['icon'] as int,
    );
  }
  int? id;
  String name;
  double amount;
  int color;
  int icon;
  String createdAt = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

  Map<String, Object?> toMap() {
    final map = {
      'name': name,
      'amount': amount,
      'color': color,
      'icon': icon,
      'createdAt': createdAt,
    };
    if (id != null) {
      map['id'] = id!;
    }
    return map;
  }

  @override
  String toString() =>
      'Goal(id:$id, name: $name, amount: $amount, color: $color, icon: $icon)';
}
