import 'package:flutter_graphql/base/base_mapper.dart';
import 'package:flutter_graphql/user/model/entity/user_graphql_entit.dart';
import 'package:flutter_graphql/user/model/user.dart';

class UserGraphqlEntityMapper extends BaseMapper<UserGraphQlEntity, UserGraphQlEntity> {
  @override
  UserGraphQlEntity map(UserGraphQlEntity? t) {
    return UserGraphQlEntity(
      id: t?.id,
      uuid: t?.uuid,
      name: t?.name,
      email: t?.email,
    );
  }

  UserGraphQlEntity reverseMap(UserGraphQlEntity? user) {
    return UserGraphQlEntity(
        id: user?.id, uuid: user?.id, name: user?.name, email: user?.email);
  }
}
