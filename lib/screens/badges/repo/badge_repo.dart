import 'package:flutter_graphql/screens/badges/mapper/badge_graphql_entity_mapper.dart';
import 'package:flutter_graphql/screens/badges/mapper/badges_graphql_response_mapper.dart';
import 'package:flutter_graphql/screens/badges/model/badge_data.dart';
import 'package:flutter_graphql/screens/badges/model/request/get_badge_request.dart';
import 'package:flutter_graphql/screens/badges/source/badges_graphql_source.dart';

class BadgesRepo {
  final BadgesGraphQlSource _badgesGraphQlSource;

  /// Mappers
  final BadgesGraphQlResponseMapper _badgesGraphQlResponseMapper;

  BadgesRepo(
    this._badgesGraphQlSource,
    this._badgesGraphQlResponseMapper,
  );

  /// Get all tags
  Stream<BadgesData> getBadges(GetBadgesRequest request) {
    return _badgesGraphQlSource
        .getBadges(request)
        .map((data) => _badgesGraphQlResponseMapper.map(data));
  }
}
