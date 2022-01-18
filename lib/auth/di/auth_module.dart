import 'package:flutter_graphql/auth/bloc/login_bloc.dart';
import 'package:flutter_graphql/auth/bloc/signup_bloc.dart';
import 'package:flutter_graphql/auth/mapper/login_entity_mapper.dart';
import 'package:flutter_graphql/auth/mapper/signup_entity_mapper.dart';
import 'package:flutter_graphql/auth/repo/auth_repo.dart';
import 'package:flutter_graphql/auth/source/auth_graphql_source.dart';
import 'package:flutter_graphql/di/app_module.dart';
import 'package:flutter_graphql/graphql/client.dart';
import 'package:flutter_graphql/helper/validator.dart';
import 'package:flutter_graphql/main_dev.dart';
import 'package:flutter_graphql/session/di/session_module.dart';
import 'package:flutter_graphql/session/repo/session_repo.dart';

class AuthModule {
  static AuthModule _instance = AuthModule._internal();
  AppGraphqlClient appGraphqlClient = AppGraphqlClient(apiVepaarOpen);

  AuthModule._internal();

  factory AuthModule() {
    return _instance;
  }

  LoginBloc getLoginBloc() {
    return LoginBloc(
        Validator(), getAuthRepo(), SessionModule().getSessionRepo());
  }

  SignupBloc getSignUpBloc() {
    return SignupBloc(
        Validator(), getAuthRepo(), SessionModule().getSessionRepo());
  }

  AuthRepo getAuthRepo() {
    return AuthRepo(
      LoginEntityMapper(),
      SignUpEntityMapper(),
      _getAuthGraphQlSource(),
    );
  }

  AuthGraphQlSource _getAuthGraphQlSource() {
    return AuthGraphQlSource(
      appGraphqlClient,
    );
  }
}
