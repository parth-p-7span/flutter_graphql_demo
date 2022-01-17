import 'package:flutter_graphql/auth/model/auth_data.dart';
import 'package:flutter_graphql/base/base_ui_state.dart';

class LoginState extends BaseUiState<AuthData> {
  LoginState.loading() : super.loading();

  LoginState.completed(AuthData data) : super.completed(data: data);

  LoginState.error(dynamic error) : super.error(error: error);
}
