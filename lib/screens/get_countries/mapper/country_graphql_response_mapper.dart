import 'package:flutter_graphql/base/base_mapper.dart';
import 'package:flutter_graphql/screens/get_countries/mapper/country_graphql_entity_mapper.dart';
import 'package:flutter_graphql/screens/get_countries/model/country_data.dart';
import 'package:flutter_graphql/screens/get_countries/model/response/country_graphql_response.dart';

class CountryGraphQlResponseMapper
    extends BaseMapper<CountryGraphqlResponse, CountryData> {
  final _countryGraphQlEntityMapper = CountryGraphQlEntityMapper();

  CountryData map(CountryGraphqlResponse t) {
    return CountryData(
        countries: t.countries
            .map((e) => _countryGraphQlEntityMapper.map(e))
            .toList());
  }
}
