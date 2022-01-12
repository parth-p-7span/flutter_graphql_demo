import 'package:flutter_graphql/graphql/client.dart';
import 'package:flutter_graphql/screens/get_continent/model/request/get_continent_request.dart';
import 'package:flutter_graphql/screens/get_continent/model/response/continent_graphql_response.dart';
import 'package:flutter_graphql/screens/get_continent/source/continent_graphql_request.dart';

class ContinentGraphqlSource {
  final AppGraphqlClient _client;
  ContinentGraphqlSource(this._client);

  Stream<ContinentGraphqlResponse> getContinents(GetContinentRequest request) {
    return _client.queryString(ContinentGraphqlRequest.continentsQuery,
        variables: {"code": "null"}).map((response) {
      return ContinentGraphqlResponse.fromJson(response);
    });
  }
}
