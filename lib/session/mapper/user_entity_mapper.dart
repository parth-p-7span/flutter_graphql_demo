import 'package:flutter_graphql/base/base_mapper.dart';
import 'package:flutter_graphql/session/model/entity/user_local_entity.dart';
import 'package:flutter_graphql/user/model/user.dart';

class UserEntityMapper extends BaseMapper<UserLocalEntity, User> {
  @override
  User map(UserLocalEntity? t) {
    return User(name: t?.name, email: t?.email);
  }

  UserLocalEntity reverseMap(User? user) {
    return UserLocalEntity(name: user?.name, email: user?.email);
  }
}
