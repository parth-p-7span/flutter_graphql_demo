import 'package:flutter_graphql/base/base_mapper.dart';
import 'package:flutter_graphql/user/mapper/user_graphql_entity_mapper.dart';
import 'package:flutter_graphql/user/model/entity/user_fulldata_graphql_entity.dart';
import 'package:flutter_graphql/user/model/user_full_data.dart';

class UserFullDataGraphQlEntityMapper
    extends BaseMapper<UserFullDataGraphQlEntity, UserFullData> {
  final _userGraphqlEntityMapper = UserGraphqlEntityMapper();

  @override
  UserFullData map(UserFullDataGraphQlEntity? t) {
    return UserFullData(
      user: _userGraphqlEntityMapper.map(t?.user),
    );
  }
}
