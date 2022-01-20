import 'package:flutter_graphql/base/base_ui_state.dart';
import 'package:flutter_graphql/screens/badges/model/badge_data.dart';

class GetBadgesState extends BaseUiState<BadgesData> {
  bool isInitialRequest;
  bool isFilterRequest;

  GetBadgesState.loading({
    this.isInitialRequest = true,
    required this.isFilterRequest,
  }) : super.loading();

  GetBadgesState.completed(
    BadgesData data, {
    this.isInitialRequest = true,
    required this.isFilterRequest,
  }) : super.completed(data: data);

  GetBadgesState.error(
    dynamic error, {
    this.isInitialRequest = true,
    required this.isFilterRequest,
  }) : super.error(error);
}
