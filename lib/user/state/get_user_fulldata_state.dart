
import 'package:flutter_graphql/base/base_ui_state.dart';
import 'package:flutter_graphql/user/model/user_full_data.dart';

class GetUserFullDataState extends BaseUiState<UserFullData> {
  GetUserFullDataState.loading() : super.loading();

  GetUserFullDataState.completed(UserFullData data)
      : super.completed(data: data);

  GetUserFullDataState.error(dynamic error) : super.error();
}