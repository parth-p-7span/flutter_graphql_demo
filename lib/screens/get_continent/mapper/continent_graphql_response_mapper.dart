import 'package:flutter_graphql/base/base_mapper.dart';
import 'package:flutter_graphql/screens/get_continent/mapper/continent_graphql_entity_mapper.dart';
import 'package:flutter_graphql/screens/get_continent/model/continent_data.dart';
import 'package:flutter_graphql/screens/get_continent/model/response/continent_graphql_response.dart';

class ContinentResponseMapper
    extends BaseMapper<ContinentGraphqlResponse, ContinentData> {
  final _continentEntityMapper = ContinentEntityMapper();

  ContinentData map(ContinentGraphqlResponse t) {
    return ContinentData(
        continents:
            t.continents.map((e) => _continentEntityMapper.map(e)).toList());
  }
}
