import 'package:flutter_graphql/screens/get_continent/mapper/continent_graphql_entity_mapper.dart';
import 'package:flutter_graphql/screens/get_continent/mapper/continent_graphql_response_mapper.dart';
import 'package:flutter_graphql/screens/get_continent/model/continent_data.dart';
import 'package:flutter_graphql/screens/get_continent/model/request/get_continent_request.dart';
import 'package:flutter_graphql/screens/get_continent/source/continent_graphql_source.dart';

class ContinentRepo {
  final ContinentGraphqlSource _continentGraphqlSource;

  final ContinentEntityMapper _continentEntityMapper;
  final ContinentResponseMapper _continentResponseMapper;

  ContinentRepo(
    this._continentGraphqlSource,
    this._continentEntityMapper,
    this._continentResponseMapper,
  );

  Stream<ContinentData> getContinents(GetContinentRequest request) {
    return _continentGraphqlSource
        .getContinents(request)
        .map((event) => _continentResponseMapper.map(event));
  }
}
