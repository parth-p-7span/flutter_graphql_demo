import 'package:flutter_graphql/user/model/entity/user_graphql_entit.dart';

class AuthData {
  String? token;
  UserGraphQlEntity? user;

  AuthData({this.token, this.user});
}
