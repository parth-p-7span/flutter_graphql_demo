import 'package:flutter/material.dart';
import 'package:flutter_graphql/screens/badges/model/response/applied_badge_filter.dart';

class GetBadgesRequest {
  String? businessId;
  int? page;
  String? search;
  AppliedBadgeFilter? filter;

  GetBadgesRequest(
      {required this.businessId, required this.page, this.search, this.filter});

  /// Indicates if this request is for the initial/first data
  bool get isInitialRequest => page == 1;

  bool get isFilterRequest =>
      search?.isNotEmpty == true || !(filter?.isEmpty ?? true);
}
