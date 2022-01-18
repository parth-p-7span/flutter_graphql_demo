import 'package:flutter/material.dart';

class UserGraphQlEntity {
  String? id;
  String? uuid;
  String? name;
  String? email;

  UserGraphQlEntity({
    @required this.id,
    @required this.uuid,
    @required this.name,
    @required this.email,
  });

  factory UserGraphQlEntity.fromJson(Map<String, dynamic> map) =>
      UserGraphQlEntity(
          id: map['id']?.toString(),
          uuid: map['uuid'],
          name: map['name'],
          email: map['email']);

  Map<String, dynamic> toJSON() {
    return {'id': id, 'uuid': uuid, 'name': name, 'email': email};
  }
}
