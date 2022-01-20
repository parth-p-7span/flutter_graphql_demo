import 'package:flutter_graphql/base/base_bloc.dart';
import 'package:flutter_graphql/screens/badges/model/badge.dart';
import 'package:flutter_graphql/screens/badges/model/badge_data.dart';
import 'package:flutter_graphql/screens/badges/model/request/get_badge_request.dart';
import 'package:flutter_graphql/screens/badges/model/response/applied_badge_filter.dart';
import 'package:flutter_graphql/screens/badges/state/badges_ui_state_manager.dart';
import 'package:flutter_graphql/screens/badges/state/get_badges_state.dart';
import 'package:rxdart/rxdart.dart';

class BadgesBloc extends BaseBloc {
  /// Ui state manager
  final BadgesUiStateManager _badgesUiStateManager;

  /// Rx-Stream which will notify about various states while fetching
  /// social links
  final getBadgesStateStream = BehaviorSubject<GetBadgesState>();

  /// Rx-Stream which will notify about social links data
  final badgesDataStream = BehaviorSubject<BadgesData>();

  /// Rx-Stream which will hold and notify about the search query changes
  final searchQueryStream = BehaviorSubject<String>();

  final searchEnableStream = BehaviorSubject<bool>();

  BadgesBloc(
    this._badgesUiStateManager,
  ) {
    getBadges(
        request: GetBadgesRequest(businessId: 131026.toString(), page: 1));
  }

  void getBadges({required GetBadgesRequest request}) {
    subscriptions.add(_getBadges(request).listen((state) {
      if (state.isCompleted()) {
        _handleData(state.data);
      }
      getBadgesStateStream.add(state);
    }));
  }

  void loadMore() {
    final currentData = badgesDataStream.value;

    // if we have reached the end already, ignore the request
    if (currentData.isEndReached) return;

    final currentPage = currentData.currentPage ?? -1;

    // If current page is not handled, it's safe to assume pagination isn't
    // implemented with current source, so we should return
    if (currentPage == -1) return;

    getBadges(
        request: GetBadgesRequest(
            businessId: 131026.toString(),
            page: currentPage + 1,
            search: badgesDataStream.value.search,
            filter: badgesDataStream.value.filter));
  }

  Stream<GetBadgesState> _getBadges(GetBadgesRequest request) {
    return _badgesUiStateManager.getBadges(request);
  }

  void applyFilter(AppliedBadgeFilter filter) {
    // Raise event

    getBadges(
        request: GetBadgesRequest(
      businessId: 131026.toString(),
      page: 1,
      filter: filter,
      search: badgesDataStream.value.search,
    ));
  }

  void _handleData(BadgesData? newData) {
    final existingData = badgesDataStream.valueOrNull;
    final existingList = existingData?.badges ?? [];
    final newList = newData?.badges ?? [];

    final all = <Badge>[];
    if (newData?.isInitialData == true)
      all.addAll(newList);
    else
      all.addAll(existingList + newList);

    badgesDataStream.add(newData!.copyWith(
      badges: all,
    ));
  }

  @override
  void dispose() {
    super.dispose();
    getBadgesStateStream.close();
    badgesDataStream.close();
    searchQueryStream.close();
    searchEnableStream.close();
  }
}
