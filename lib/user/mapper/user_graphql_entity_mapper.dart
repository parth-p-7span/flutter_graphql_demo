import 'package:flutter_graphql/base/base_mapper.dart';
import 'package:flutter_graphql/user/model/entity/user_graphql_entit.dart';
import 'package:flutter_graphql/user/model/user.dart';

class UserGraphqlEntityMapper extends BaseMapper<UserGraphQlEntity, User> {
  @override
  User map(UserGraphQlEntity? t) {
    return User(
      id: t?.id,
      uuid: t?.uuid,
      name: t?.name,
      email: t?.email,
    );
  }
}
