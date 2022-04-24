import 'package:flutter_graphql/graphql/app_graphql_client_close.dart';
import 'package:flutter_graphql/graphql/client.dart';
import 'package:flutter_graphql/screens/badges/model/request/get_badge_request.dart';
import 'package:flutter_graphql/screens/badges/model/response/get_badges_graphql_response.dart';
import 'package:flutter_graphql/screens/searchable_dropdown/model/request/get_item_request.dart';
import 'package:flutter_graphql/screens/searchable_dropdown/model/response/get_items_graphql_response.dart';

import 'items_graphql_request.dart';

class ItemsGraphQlSource {
  final AppGraphqlClientClose _client;

  ItemsGraphQlSource(
    this._client,
  );

  Stream<GetItemsGraphQlResponse> getItems(GetItemsRequest request) {
    return _client.queryString(ItemsGraphQlRequests.itemsQuery, variables: {
      'businessId': 131026,
      'page': 1,
      'limit': 20,
      'search': request.search,
    }).map((response) => GetItemsGraphQlResponse.fromJson(response!));
  }
}
