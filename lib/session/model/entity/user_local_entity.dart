import 'package:flutter/material.dart';

class UserLocalEntity {
  String? id;
  String? uuid;
  String? name;
  String? email;

  UserLocalEntity({
    @required this.id,
    @required this.uuid,
    @required this.name,
    @required this.email,
  }) : assert(name != null);

  factory UserLocalEntity.fromJSON(Map<String, dynamic> map) => UserLocalEntity(
        id: map['id'] ?? "",
        uuid: map['uuid'] ?? "",
        name: map['name'] ?? "",
        email: map['email'] ?? "",
      );

  Map<String, dynamic> toJSON() {
    return {'id': id, 'uuid': uuid, 'name': name, 'email': email};
  }
}
