import 'package:flutter_graphql/auth/model/entity/auth_entity.dart';

class GetLoginGraphQlResponse {
  AuthEntity? authEntity;

  GetLoginGraphQlResponse.fromJson(Map<String, dynamic>? map) {
    final json = map?['login'];
    if (json != null) {
      authEntity = AuthEntity.fromJson(json);
    }
  }
}
