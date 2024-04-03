class User {
  User({
    required this.id,
    required this.name,
    required this.balance,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int,
      name: map['name'] as String,
      balance: map['balance'] as double,
    );
  }
  int id;
  String name;
  double balance;

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'balance': balance,
      };

  @override
  String toString() => 'User(id: $id, name: $name, balance: $balance)';

  User copyWith({
    int? id,
    String? name,
    double? balance,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      balance: balance ?? this.balance,
    );
  }
}
