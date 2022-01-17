import 'package:flutter_graphql/user/model/entity/user_graphql_entit.dart';

class UserFullDataGraphQlEntity {
  UserGraphQlEntity? user;

  UserFullDataGraphQlEntity.fromJson(Map<String, dynamic> map) {
    var userJson = map['user'];
    if (userJson != null) {
      user = UserGraphQlEntity.fromJson(userJson);
    }
  }
}
