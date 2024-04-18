import 'package:intl/intl.dart';

class Goal {
  Goal({
    required this.name,
    required this.amount,
    required this.icon,
    required this.traAmount,
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
      traAmount: map['traAmount'] as double,
    );
  }
  int? id;
  String name;
  double amount;
  double traAmount;
  int color;
  int icon;
  String createdAt = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

  Map<String, Object?> toMap() {
    final map = {
      'name': name,
      'amount': amount,
      'color': color,
      'icon': icon,
      'traAmount': traAmount,
      'createdAt': createdAt,
    };
    if (id != null) {
      map['id'] = id!;
    }
    return map;
  }

  @override
  String toString() =>
      'Goal(id:$id, name: $name, amount: $amount, color: $color, icon: $icon,traAmount: $traAmount)';

  Goal copyWith({
    int? id,
    String? name,
    double? amount,
    double? traAmount,
    int? color,
    int? icon,
  }) =>
      Goal(
        id: id ?? this.id,
        name: name ?? this.name,
        amount: amount ?? this.amount,
        traAmount: traAmount ?? this.traAmount,
        color: color ?? this.color,
        icon: icon ?? this.icon,
      );
}
