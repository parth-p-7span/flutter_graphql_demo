import 'package:flutter_graphql/base/base_bloc.dart';
import 'package:flutter_graphql/screens/polls/model/poll.dart';
import 'package:flutter_graphql/screens/polls/model/poll_data.dart';
import 'package:flutter_graphql/screens/polls/model/request/get_poll_request.dart';
import 'package:flutter_graphql/screens/polls/state/get_poll_state.dart';
import 'package:flutter_graphql/screens/polls/state/poll_ui_state_manager.dart';
import 'package:rxdart/rxdart.dart';

class PollBloc extends BaseBloc {
  final PollUiStateManager _pollUiStateManager;

  /// Rx-Stream which will notify about various states while fetching
  /// Poll state
  final getPollStateStream = BehaviorSubject<GetPollsState>();

  /// Rx-Stream which will notify about poll data
  final pollDataStream = BehaviorSubject<PollData>();

  PollBloc(this._pollUiStateManager) {
    getPolls(request: GetPollRequest(page: 1, perPage: 10));
  }

  void getPolls({required GetPollRequest request}) {
    subscriptions.add(_getPolls(request).listen((state) {
      if (state.isCompleted()) {
        _handleData(state.data);
      }
      getPollStateStream.add(state);
    }));
  }

  void loadMore() {
    final currentData = pollDataStream.value;

    // if we have reached the end already, ignore the request
    if (currentData.isEndReached ?? false) return;

    final currentPage = currentData.currentPage;

    // If current page is not handled, it's safe to assume pagination isn't
    // implemented with current source, so we should return
    if (currentPage == -1) return;

    getPolls(request: GetPollRequest(page: currentPage + 1, perPage: 10));
  }

  Stream<GetPollsState> _getPolls(GetPollRequest request) {
    return _pollUiStateManager.getPollsState(request);
  }

  void _handleData(PollData? newData) {
    final existingData = pollDataStream.valueOrNull;
    final existingList = existingData?.polls ?? [];
    final newList = newData?.polls ?? [];
    print(newList);
    print(newList.length);

    final all = <Poll>[];
    print(newData?.isInitialData);
    if (newData?.isInitialData == true)
      all.addAll(newList);
    else
      all.addAll(existingList + newList);

    pollDataStream.add(newData!.copyWith(
      polls: all,
    ));
  }

  @override
  void dispose() {
    super.dispose();
    getPollStateStream.close();
    pollDataStream.close();
  }
}
