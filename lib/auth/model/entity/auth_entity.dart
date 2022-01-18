import 'package:flutter_graphql/user/model/entity/user_graphql_entit.dart';

class AuthEntity {
  String? token;
  UserGraphQlEntity? user;

  AuthEntity.fromJson(Map<String, dynamic> map) {
    token = map['token'];
    var userJson = map['user'];
    if (userJson != null) {
      user = UserGraphQlEntity.fromJson(userJson);
    }
  }
}
