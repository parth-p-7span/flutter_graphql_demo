import 'package:flutter/material.dart';

class UserLocalEntity {
  String? name;
  String? email;

  UserLocalEntity({
    @required this.name,
    @required this.email,
  }) : assert(name != null);

  factory UserLocalEntity.fromJSON(Map<String, dynamic> map) => UserLocalEntity(
        name: map['name'] ?? "",
        email: map['email'] ?? "",
      );

  Map<String, dynamic> toJSON() {
    return {'name': name, 'email': email};
  }
}
