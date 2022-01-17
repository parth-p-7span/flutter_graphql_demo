import 'package:flutter/material.dart';
import 'package:flutter_graphql/session/model/entity/user_local_entity.dart';

class SessionLocalEntity {
  String? token;
  UserLocalEntity? userLocalEntity;

  SessionLocalEntity({
    @required this.token,
    @required this.userLocalEntity,
  }) : assert(token != null);

  factory SessionLocalEntity.fromJSON(Map<String, dynamic> map) =>
      SessionLocalEntity(
        token: map['token'],
        userLocalEntity: UserLocalEntity.fromJSON(map['user'] ?? {}),
      );

  Map<String, dynamic> toJSON() {
    return {
      'token': token,
      'user': userLocalEntity?.toJSON(),
    };
  }
}
