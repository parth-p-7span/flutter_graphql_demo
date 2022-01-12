import 'package:flutter_graphql/screens/get_countries/mapper/country_graphql_entity_mapper.dart';
import 'package:flutter_graphql/screens/get_countries/mapper/country_graphql_response_mapper.dart';
import 'package:flutter_graphql/screens/get_countries/model/country_data.dart';
import 'package:flutter_graphql/screens/get_countries/model/request/get_country_request.dart';
import 'package:flutter_graphql/screens/get_countries/source/country_graphql_source.dart';

class CountryRepo {
  final CountryGraohqlSource _countryGraohqlSource;

  final CountryGraphQlEntityMapper _countryGraphQlEntityMapper;
  final CountryGraphQlResponseMapper _countryGraphQlResponseMapper;

  CountryRepo(
    this._countryGraohqlSource,
    this._countryGraphQlEntityMapper,
    this._countryGraphQlResponseMapper,
  );

  Stream<CountryData> getCountries(GetCountryRequest request) {
    var temp = _countryGraohqlSource.getCountries(request).map((event) {
      return _countryGraphQlResponseMapper.map(event);
    });
    return temp;
  }
}
