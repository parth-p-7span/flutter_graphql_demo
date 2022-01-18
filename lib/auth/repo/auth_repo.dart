import 'package:flutter_graphql/auth/mapper/login_entity_mapper.dart';
import 'package:flutter_graphql/auth/mapper/signup_entity_mapper.dart';
import 'package:flutter_graphql/auth/model/auth_data.dart';
import 'package:flutter_graphql/auth/model/request/login_request.dart';
import 'package:flutter_graphql/auth/model/request/signup_request.dart';
import 'package:flutter_graphql/auth/source/auth_graphql_source.dart';
import 'package:flutter_graphql/session/di/session_module.dart';

/// Authentication repository which holds auth related functions
class AuthRepo {
  /// GraphQl data source
  final AuthGraphQlSource _authGraphQlSource;

  /// Mappers
  final SignUpEntityMapper _signUpEntityMapper;
  final LoginEntityMapper _loginEntityMapper;

  AuthRepo(
    this._loginEntityMapper,
    this._signUpEntityMapper,
    this._authGraphQlSource,
  );

  /// Login
  Stream<AuthData> login(LoginRequest request) {
    return _authGraphQlSource
        .login(request)
        .map((entity) => _loginEntityMapper.map(entity));
  }

  /// Sign up
  Stream<AuthData> signUp(SignUpRequest request) {
    return _authGraphQlSource
        .signUp(request)
        .map((entity) => _signUpEntityMapper.map(entity));
  }

  Stream<bool>? logout(){
    return SessionModule().getSessionRepo().clearSession();
  }
}
