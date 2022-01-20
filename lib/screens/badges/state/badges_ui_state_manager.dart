import 'package:flutter_graphql/screens/badges/model/request/get_badge_request.dart';
import 'package:flutter_graphql/screens/badges/repo/badge_repo.dart';
import 'package:rxdart/rxdart.dart';

import 'get_badges_state.dart';

class BadgesUiStateManager {
  final BadgesRepo _badgesRepo;

  BadgesUiStateManager(this._badgesRepo);

  Stream<GetBadgesState> getBadges(GetBadgesRequest request) {
    return _badgesRepo
        .getBadges(request)
        .map((data) => GetBadgesState.completed(
              data,
              isInitialRequest: request.isInitialRequest,
              isFilterRequest: request.isFilterRequest,
            ))
        .onErrorReturnWith((error, dynamic) => GetBadgesState.error(
              error,
              isInitialRequest: request.isInitialRequest,
              isFilterRequest: request.isFilterRequest,
            ))
        .startWith(GetBadgesState.loading(
          isInitialRequest: request.isInitialRequest,
          isFilterRequest: request.isFilterRequest,
        ));
  }
}
