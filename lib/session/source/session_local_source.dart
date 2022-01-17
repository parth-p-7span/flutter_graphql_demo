import 'dart:convert';
import 'package:flutter_graphql/helper/shared_preference_manager.dart';
import 'package:flutter_graphql/session/mapper/session_entity_mapper.dart';
import 'package:flutter_graphql/session/mapper/user_entity_mapper.dart';
import 'package:flutter_graphql/session/model/entity/session_local_entity.dart';
import 'package:flutter_graphql/session/model/request/save_session_request.dart';
import 'package:flutter_graphql/session/model/request/user_session_request.dart';
import 'package:rxdart/rxdart.dart';

class SessionLocalSource {
  /// [SharedPreferenceManager] for storing session
  final SharedPreferenceManager? _preferenceManager;

  /// Mapper
  final SessionEntityMapper? _sessionEntityMapper;
  final UserEntityMapper? _userEntityMapper;

  SessionLocalSource(
    this._preferenceManager,
    this._sessionEntityMapper,
    this._userEntityMapper,
  );

  /// Save current session
  ///
  /// returns the stored session entity
  Stream<SessionLocalEntity?> saveSession(SaveSessionRequest request) {
    final entity = _sessionEntityMapper?.reverseMap(request.session);
    return _preferenceManager!
        .setString('session', json.encode(entity?.toJSON()))!
        .map((_) => entity);
  }

  Stream<SessionLocalEntity?> updateUserSessionData(
      UpdateSessionRequest request) {
    final userEntity = _userEntityMapper?.reverseMap(request.user);

    return getSession().flatMap((event) {
      event?.userLocalEntity = userEntity;
      return saveSession(
          SaveSessionRequest(session: _sessionEntityMapper?.map(event)));
    });
  }

  /// Get current session
  ///
  /// Returns null if no active session found
  Stream<SessionLocalEntity?> getSession() {
    return _preferenceManager!.getString('session')!.map((sessionStr) {
      if (sessionStr.isEmpty) return null;
      return SessionLocalEntity.fromJSON(json.decode(sessionStr));
    });
  }

  Stream<bool>? clearSession() {
    return _preferenceManager!.setString('session', '');
  }
}
