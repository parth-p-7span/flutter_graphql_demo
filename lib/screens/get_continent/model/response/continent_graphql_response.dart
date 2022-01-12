import 'package:flutter_graphql/screens/get_continent/model/entity/continent_graphql_entity.dart';

class ContinentGraphqlResponse {
  List<ContinentGraphqlEntity> continents = [];

  ContinentGraphqlResponse.fromJson(Map<String, dynamic>? map) {
    final itemJson = map?['continents'];
    if (itemJson != null && itemJson is List) {
      var temp =
          itemJson.map((e) => ContinentGraphqlEntity.fromJson(e)).toList();
      continents.addAll(temp);
    }
  }
}
