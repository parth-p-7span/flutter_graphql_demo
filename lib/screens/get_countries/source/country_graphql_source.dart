import 'package:flutter_graphql/graphql/client.dart';
import 'package:flutter_graphql/screens/get_countries/model/request/get_country_request.dart';
import 'package:flutter_graphql/screens/get_countries/model/response/country_graphql_response.dart';
import 'package:flutter_graphql/screens/get_countries/source/country_graphql_request.dart';

class CountryGraohqlSource {
  final AppGraphqlClient _client;
  CountryGraohqlSource(this._client);

  Stream<CountryGraphqlResponse> getCountries(GetCountryRequest request) {
    return _client
        .queryString(CountryGraphQlRequest.countriesQuery, variables: {
      "code": request.continent,
    }).map((response) {
      print("response" + response.toString());
      var temp = CountryGraphqlResponse.fromJson(response);
      return temp;
    });
  }
}
