import 'package:flutter_graphql/auth/model/auth_data.dart';
import 'package:flutter_graphql/auth/model/response/get_login_graphql_response.dart';
import 'package:flutter_graphql/base/base_mapper.dart';

class LoginEntityMapper extends BaseMapper<GetLoginGraphQlResponse, AuthData> {
  @override
  AuthData map(GetLoginGraphQlResponse t) {
    return AuthData(
      token: t.authEntity?.token,
      user: t.authEntity?.user,
    );
  }
}
