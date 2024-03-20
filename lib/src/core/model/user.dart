
class User {
  int id;
  String name;
  double balance;

  User({
    required this.id,
    required this.name,
    required this.balance,
  });

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "balance": balance,
      };

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map["id"],
      name: map["name"],
      balance: map["balance"],
    );
  }

  @override
  String toString() => "User(id: $id, name: $name, balance: $balance)";

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
