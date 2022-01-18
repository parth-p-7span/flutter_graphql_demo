import 'package:flutter/material.dart';
import 'package:flutter_graphql/user/model/entity/user_graphql_entit.dart';
import 'package:flutter_graphql/user/model/user.dart';

class Session {
  String? token;
  UserGraphQlEntity? user;

  Session({
    @required this.token,
    this.user,
  }) : assert(
          token != null,
        );
}
