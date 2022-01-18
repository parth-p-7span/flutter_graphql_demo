import 'package:flutter_graphql/di/app_module.dart';
import 'package:flutter_graphql/session/mapper/session_entity_mapper.dart';
import 'package:flutter_graphql/session/mapper/user_entity_mapper.dart';
import 'package:flutter_graphql/session/repo/session_repo.dart';
import 'package:flutter_graphql/session/source/session_local_source.dart';
import 'package:flutter_graphql/user/mapper/user_graphql_entity_mapper.dart';

class SessionModule {
  static SessionModule _instance = SessionModule._internal();

  SessionModule._internal();

  factory SessionModule() {
    return _instance;
  }

  /// Get session repository
  SessionRepo getSessionRepo() {
    return SessionRepo(
      _getSessionLocalSource(),
      getSessionEntityMapper(),
    );
  }

  SessionLocalSource _getSessionLocalSource() {
    return SessionLocalSource(
      AppModule().sharedPreferenceManager,
      getSessionEntityMapper(),
      getUserEntityMapper(),
    );
  }

  SessionEntityMapper getSessionEntityMapper() {
    return SessionEntityMapper();
  }

  UserGraphqlEntityMapper getUserEntityMapper() {
    return UserGraphqlEntityMapper();
  }
}
