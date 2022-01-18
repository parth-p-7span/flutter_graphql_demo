import 'package:flutter/material.dart';
import 'package:flutter_graphql/session/model/entity/user_local_entity.dart';
import 'package:flutter_graphql/user/model/entity/user_graphql_entit.dart';

class SessionLocalEntity {
  String? token;
  UserGraphQlEntity? userGraphQlEntity;

  SessionLocalEntity({
    @required this.token,
    @required this.userGraphQlEntity,
  }) : assert(token != null);

  factory SessionLocalEntity.fromJSON(Map<String, dynamic> map) =>
      SessionLocalEntity(
        token: map['token'],
        userGraphQlEntity: UserGraphQlEntity.fromJson(map['user'] ?? {}),
      );

  Map<String, dynamic> toJSON() {
    return {
      'token': token,
      'user': userGraphQlEntity?.toJSON(),
    };
  }
}
