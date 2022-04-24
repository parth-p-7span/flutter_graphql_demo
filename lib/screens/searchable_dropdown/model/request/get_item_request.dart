import 'package:flutter/material.dart';
import 'package:flutter_graphql/screens/badges/model/response/applied_badge_filter.dart';

class GetItemsRequest {
  String? businessId;
  int? page;
  int? limit;
  String? search;

  GetItemsRequest({required this.businessId, required this.page, this.search, this.limit});

  /// Indicates if this request is for the initial/first data
  bool get isInitialRequest => page == 1;
}
