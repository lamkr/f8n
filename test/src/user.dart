import 'dart:convert';

class User {
  final String name;
  final int age;

  User(this.name, this.age);

  static User fromJson(Map<String, dynamic> json) {
    return User(
      json['name'],
      json['age'],
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'age': age,
      };

  @override
  String toString() => jsonEncode(this);
}
