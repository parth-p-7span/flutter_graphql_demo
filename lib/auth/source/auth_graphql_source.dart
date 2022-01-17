import 'package:flutter_graphql/auth/model/request/login_request.dart';
import 'package:flutter_graphql/auth/model/request/signup_request.dart';
import 'package:flutter_graphql/auth/model/response/get_login_graphql_response.dart';
import 'package:flutter_graphql/auth/model/response/get_signup_graphql_response.dart';
import 'package:flutter_graphql/graphql/client.dart';

import 'auth_graphql_request.dart';

class AuthGraphQlSource {
  final AppGraphqlClient _client;

  AuthGraphQlSource(this._client);

  /// Login
  Stream<GetLoginGraphQlResponse> login(LoginRequest request) {
    return _client.mutateString(AuthGraphQlRequests.loginQuery, variables: {
      'email': request.email,
      'password': request.password,
    }).map((response) {
      return GetLoginGraphQlResponse.fromJson(response);
    });
  }

  /// SignUp
  Stream<GetSignUpGraphQlResponse> signUp(SignUpRequest request) {
    return _client.mutateString(AuthGraphQlRequests.signUpQuery, variables: {
      'email': request.email,
      'password': request.password,
      'name': request.name,
    }).map((response) => GetSignUpGraphQlResponse.fromJson(response));
  }
}
