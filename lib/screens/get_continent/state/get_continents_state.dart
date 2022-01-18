import 'package:flutter_graphql/base/base_ui_state.dart';
import 'package:flutter_graphql/screens/get_continent/model/continent_data.dart';

class GetContinentsState extends BaseUiState<ContinentData> {
  GetContinentsState.loading() : super.loading();
  GetContinentsState.completed(ContinentData data)
      : super.completed(data: data);
  GetContinentsState.error(dynamic error) : super.error(error);
}
