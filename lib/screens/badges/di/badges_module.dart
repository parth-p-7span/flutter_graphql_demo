import 'package:flutter_graphql/graphql/app_graphql_client_close.dart';
import 'package:flutter_graphql/main_dev.dart';
import 'package:flutter_graphql/screens/badges/bloc/badges_bloc.dart';
import 'package:flutter_graphql/screens/badges/mapper/badges_graphql_response_mapper.dart';
import 'package:flutter_graphql/screens/badges/model/response/applied_badge_filter.dart';
import 'package:flutter_graphql/screens/badges/repo/badge_repo.dart';
import 'package:flutter_graphql/screens/badges/source/badges_graphql_source.dart';
import 'package:flutter_graphql/screens/badges/state/badges_ui_state_manager.dart';
import 'package:flutter_graphql/screens/badges/bloc/badge_filter_bloc.dart';

class BadgesModule {
  static BadgesModule _instance = BadgesModule._internal();
  AppGraphqlClientClose appGraphqlClientClose =
      AppGraphqlClientClose(apiVepaar);

  BadgesModule._internal();

  factory BadgesModule() {
    return _instance;
  }

  BadgesBloc getBadgesBloc() {
    return BadgesBloc(
      getBadgesUiStateManager(),
    );
  }

  BadgesRepo getBadgesRepo() {
    return BadgesRepo(
      _getBadgesGraphQlSource(),
      BadgesGraphQlResponseMapper(),
    );
  }

  BadgeFilterBloc getBadgeFilterBloc(AppliedBadgeFilter? appliedBadgeFilter) {
    return BadgeFilterBloc(
      appliedBadgeFilter,
    );
  }

  BadgesUiStateManager getBadgesUiStateManager() {
    return BadgesUiStateManager(getBadgesRepo());
  }

  BadgesGraphQlSource _getBadgesGraphQlSource() {
    return BadgesGraphQlSource(appGraphqlClientClose);
  }
}
