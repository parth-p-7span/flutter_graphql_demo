import 'package:flutter/material.dart';
import 'package:flutter_graphql/user/model/user.dart';

class UpdateSessionRequest {
  User? user;

  UpdateSessionRequest({@required this.user});
}
