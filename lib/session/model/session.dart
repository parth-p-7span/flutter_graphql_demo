import 'package:flutter/material.dart';
import 'package:flutter_graphql/user/model/user.dart';

class Session {
  String? token;
  User? user;

  Session({
    @required this.token,
    this.user,
  }) : assert(
          token != null,
        );
}
