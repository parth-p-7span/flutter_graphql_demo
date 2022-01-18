import 'package:flutter_graphql/base/base_mapper.dart';
import 'package:flutter_graphql/session/mapper/user_entity_mapper.dart';
import 'package:flutter_graphql/session/model/entity/session_local_entity.dart';
import 'package:flutter_graphql/session/model/session.dart';
import 'package:flutter_graphql/user/mapper/user_graphql_entity_mapper.dart';

class SessionEntityMapper extends BaseMapper<SessionLocalEntity, Session> {
  final _userEntityMapper = UserGraphqlEntityMapper();

  @override
  Session map(SessionLocalEntity? t) {
    return Session(
        token: t?.token, user: _userEntityMapper.map(t?.userGraphQlEntity));
  }

  SessionLocalEntity reverseMap(Session? session) {
    return SessionLocalEntity(
        token: session?.token,
        userGraphQlEntity: _userEntityMapper.reverseMap(session?.user));
  }
}
