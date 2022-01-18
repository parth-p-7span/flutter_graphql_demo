import 'package:flutter/material.dart';
import 'package:flutter_graphql/user/model/entity/user_graphql_entit.dart';
import 'package:flutter_graphql/user/model/user.dart';

class UpdateSessionRequest {
  UserGraphQlEntity? user;

  UpdateSessionRequest({@required this.user});
}
