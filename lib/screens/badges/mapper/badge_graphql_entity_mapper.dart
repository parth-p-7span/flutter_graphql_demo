import 'package:flutter_graphql/base/base_mapper.dart';
import 'package:flutter_graphql/screens/badges/model/badge.dart';
import 'package:flutter_graphql/screens/badges/model/entity/badge_graphql_entity.dart';

class BadgeGraphQlEntityMapper extends BaseMapper<BadgeGraphQlEntity, Badge> {
  @override
  Badge map(BadgeGraphQlEntity t) {
    return Badge(
      id: t.id,
      name: t.name,
      type: t.type,
      status: t.status,
    );
  }
}
