import 'package:flutter_graphql/auth/model/auth_data.dart';
import 'package:flutter_graphql/base/base_ui_state.dart';

class SignUpState extends BaseUiState<AuthData> {
  SignUpState.loading() : super.loading();

  SignUpState.completed(AuthData data) : super.completed(data: data);

  SignUpState.error(dynamic error) : super.error(error);
}
