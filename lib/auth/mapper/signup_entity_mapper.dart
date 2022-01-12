import 'package:flutter_graphql/auth/model/auth_data.dart';
import 'package:flutter_graphql/auth/model/response/get_signup_graphql_response.dart';
import 'package:flutter_graphql/base/base_mapper.dart';

class SignUpEntityMapper
    extends BaseMapper<GetSignUpGraphQlResponse, AuthData> {
  @override
  AuthData map(GetSignUpGraphQlResponse t) {
    return AuthData(
      token: t.authEntity?.token,
    );
  }
}
