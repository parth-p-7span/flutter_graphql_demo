import 'package:flutter_graphql/base/base_mapper.dart';
import 'package:flutter_graphql/screens/get_continent/model/continent.dart';
import 'package:flutter_graphql/screens/get_continent/model/entity/continent_graphql_entity.dart';

class ContinentEntityMapper
    extends BaseMapper<ContinentGraphqlEntity, Continent> {
  Continent map(ContinentGraphqlEntity t) {
    return Continent(code: t.code, name: t.name);
  }
}
