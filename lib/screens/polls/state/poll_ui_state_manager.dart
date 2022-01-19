import 'package:flutter_graphql/screens/polls/model/request/get_poll_request.dart';
import 'package:flutter_graphql/screens/polls/repo/poll_repo.dart';
import 'package:rxdart/rxdart.dart';
import 'get_poll_state.dart';

class PollUiStateManager {
  final PollRepo _pollRepo;

  PollUiStateManager(this._pollRepo);

  Stream<GetPollsState> getPollsState(GetPollRequest request) {
    return _pollRepo.getPolls(request).map((data) {
      return GetPollsState.completed(data,
          isInitialRequest: request.isInitialRequest);
    }).onErrorReturnWith((error, dynamic) {
      print("-----Error state : " + error.toString());
      return GetPollsState.error(
        error,
      );
    }).startWith(GetPollsState.loading(
      isInitialRequest: request.isInitialRequest,
    ));
  }
}
