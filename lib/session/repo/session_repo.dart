import 'package:flutter_graphql/session/mapper/session_entity_mapper.dart';
import 'package:flutter_graphql/session/model/request/save_session_request.dart';
import 'package:flutter_graphql/session/model/request/user_session_request.dart';
import 'package:flutter_graphql/session/model/session.dart';
import 'package:flutter_graphql/session/source/session_local_source.dart';

class SessionRepo {
  /// Source which stores the session information locally
  final SessionLocalSource? _sessionLocalSource;

  /// Mapper
  final SessionEntityMapper? _sessionEntityMapper;

  SessionRepo(this._sessionLocalSource, this._sessionEntityMapper);

  /// Save current session
  ///
  /// returns the stored session entity
  Stream<Session>? saveSession(SaveSessionRequest request) {
    return _sessionLocalSource!
        .saveSession(request)
        .map((entity) => _sessionEntityMapper!.map(entity));
  }

  Stream<Session>? updateSession(UpdateSessionRequest request) {
    return _sessionLocalSource!
        .updateUserSessionData(request)
        .map((entity) => _sessionEntityMapper!.map(entity));
  }

  /// Get current session
  ///
  /// returns null if no active session found
  Stream<Session> getSession() {
    return _sessionLocalSource!
        .getSession()
        .map((entity) => _sessionEntityMapper!.map(entity));
  }

  Stream<bool>? clearSession() {
    return _sessionLocalSource!.clearSession();
  }
}
