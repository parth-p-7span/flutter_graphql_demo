import 'package:flutter_graphql/base/base_mapper.dart';
import 'package:flutter_graphql/screens/badges/model/badge_data.dart';
import 'package:flutter_graphql/screens/badges/model/response/get_badges_graphql_response.dart';

import 'badge_graphql_entity_mapper.dart';

class BadgesGraphQlResponseMapper
    extends BaseMapper<GetBadgesGraphQlResponse, BadgesData> {
  final _tagGraphQlEntityMapper = BadgeGraphQlEntityMapper();

  @override
  BadgesData map(GetBadgesGraphQlResponse t) {
    return BadgesData(
      totalCount: t.totalCount,
      isEndReached: t.hasMoreData == true ? true : false,
      currentPage: t.page,
      filter: t.filter,
      search: t.search,
      badges:
          t.badges?.map((e) => _tagGraphQlEntityMapper.map(e)).toList() ?? [],
    );
  }
}
