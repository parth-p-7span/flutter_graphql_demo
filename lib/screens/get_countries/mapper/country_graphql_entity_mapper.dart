import 'package:flutter_graphql/base/base_mapper.dart';
import 'package:flutter_graphql/screens/get_countries/model/country.dart';
import 'package:flutter_graphql/screens/get_countries/model/entity/country_graphql_entity.dart';

class CountryGraphQlEntityMapper
    extends BaseMapper<CountryGraphQlEntity, Country> {
  Country map(CountryGraphQlEntity t) {
    return Country(
        code: t.code,
        name: t.name,
        phone: t.phone,
        capital: t.capital,
        currency: t.currency);
  }
}
