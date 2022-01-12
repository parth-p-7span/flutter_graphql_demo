import 'package:flutter_graphql/auth/model/entity/auth_entity.dart';

class GetSignUpGraphQlResponse {
  AuthEntity? authEntity;

  GetSignUpGraphQlResponse.fromJson(Map<String, dynamic>? map) {
    final json = map?['signup'];
    if (json != null) authEntity = AuthEntity.fromJson(json);
  }
}
