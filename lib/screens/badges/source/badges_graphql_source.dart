import 'package:flutter_graphql/graphql/app_graphql_client_close.dart';
import 'package:flutter_graphql/graphql/client.dart';
import 'package:flutter_graphql/screens/badges/model/request/get_badge_request.dart';
import 'package:flutter_graphql/screens/badges/model/response/get_badges_graphql_response.dart';

import 'badges_graphql_request.dart';

class BadgesGraphQlSource {
  final AppGraphqlClientClose _client;

  BadgesGraphQlSource(
    this._client,
  );

  Stream<GetBadgesGraphQlResponse> getBadges(GetBadgesRequest request) {
    return _client.queryString(BadgesGraphQlRequests.badgesQuery, variables: {
      'businessId': 131026,
      'page': request.page,
      'filters': request.filter?.toJson(),
      'search': request.search,
      'type': 4,
    }).map((response) => GetBadgesGraphQlResponse.fromJson(response!,
        page: request.page, filter: request.filter, search: request.search));
  }
}
