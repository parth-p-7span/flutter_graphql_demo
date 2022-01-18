import 'package:flutter_graphql/base/app_exception.dart';
import 'package:flutter_graphql/screens/get_countries/model/entity/country_graphql_entity.dart';

class CountryGraphqlResponse {
  List<CountryGraphQlEntity> countries = [];

  CountryGraphqlResponse.fromJson(Map<String, dynamic>? map) {
    // countries = [];
    final storeJson = map?['continent'];

    if (storeJson != null) {
      final itemJson = storeJson['countries'];
      if (itemJson != null && itemJson is List) {
        var temp =
            itemJson.map((e) => CountryGraphQlEntity.fromJson(e)).toList();
        countries.addAll(temp);
      }
    } else {
      throw AppException(message: "Continent code does not match!");
    }
  }
}
