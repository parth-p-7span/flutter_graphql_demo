import 'package:flutter_graphql/screens/badges/model/entity/badge_graphql_entity.dart';

import 'applied_badge_filter.dart';

class GetBadgesGraphQlResponse {
  List<BadgeGraphQlEntity>? badges;
  int? page;
  bool? hasMoreData;
  int? totalCount;
  String? search;
  AppliedBadgeFilter? filter;

  GetBadgesGraphQlResponse.fromJson(Map<String, dynamic> map,
      {int? page, String? search, AppliedBadgeFilter? filter}) {
    badges = [];
    hasMoreData = true;
    final tagsJson = map['tags'];
    if (tagsJson != null && tagsJson is Map) {
      final itemJson = tagsJson['data'];
      if (itemJson != null && itemJson is List) {
        badges!.addAll(
            itemJson.map((e) => BadgeGraphQlEntity.fromJson(e)).toList());
      }
      final paginationJson = tagsJson['pagination'];
      if (paginationJson != null)
        hasMoreData = paginationJson['hasMorePages'] ?? true;
      totalCount = paginationJson['total'];
    }
    this.page = page;
    this.search = search;
    this.filter = filter;
  }
}
