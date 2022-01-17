import 'package:flutter_graphql/base/base_mapper.dart';
import 'package:flutter_graphql/session/mapper/user_entity_mapper.dart';
import 'package:flutter_graphql/session/model/entity/session_local_entity.dart';
import 'package:flutter_graphql/session/model/session.dart';

class SessionEntityMapper extends BaseMapper<SessionLocalEntity, Session> {
  final _userEntityMapper = UserEntityMapper();

  @override
  Session map(SessionLocalEntity? t) {
    return Session(
        token: t?.token, user: _userEntityMapper.map(t?.userLocalEntity));
  }

  SessionLocalEntity reverseMap(Session? session) {
    return SessionLocalEntity(
        token: session?.token,
        userLocalEntity: _userEntityMapper.reverseMap(session?.user));
  }
}
