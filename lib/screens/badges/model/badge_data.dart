import 'package:flutter_graphql/screens/badges/model/response/applied_badge_filter.dart';
import 'badge.dart';

class BadgesData {
  List<Badge>? badges;
  bool isEndReached;
  int? currentPage;
  int? totalCount;
  String? search;
  AppliedBadgeFilter? filter;

  BadgesData(
      {this.badges,
      this.isEndReached = false,
      this.currentPage,
      this.totalCount,
      this.search,
      this.filter});

  BadgesData copyWith(
      {List<Badge>? badges,
      bool? isEndReached,
      int? currentPage,
      int? totalCount,
      String? search,
      AppliedBadgeFilter? filter}) {
    return BadgesData(
      badges: badges ?? this.badges,
      isEndReached: isEndReached ?? this.isEndReached,
      currentPage: currentPage ?? this.currentPage,
      totalCount: totalCount ?? this.totalCount,
      search: search ?? this.search,
      filter: filter ?? this.filter,
    );
  }

  /// Check if this data is of first request
  bool get isInitialData => currentPage == 1;
}
