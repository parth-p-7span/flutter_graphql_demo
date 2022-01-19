import 'package:flutter_graphql/base/base_ui_state.dart';
import 'package:flutter_graphql/screens/polls/model/poll_data.dart';

class GetPollsState extends BaseUiState<PollData> {
  bool? isInitialRequest;

  GetPollsState.loading({
    this.isInitialRequest,
  }) : super.loading();

  GetPollsState.completed(
    PollData data, {
    this.isInitialRequest,
  }) : super.completed(data: data);

  GetPollsState.error(
    dynamic error, {
    this.isInitialRequest,
  }) : super.error(error);
}
