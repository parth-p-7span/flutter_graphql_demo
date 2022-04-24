import 'package:flutter_graphql/screens/searchable_dropdown/model/entity/item_graphql_entity.dart';

class GetItemsGraphQlResponse {
  List<ItemGraphQlEntity>? items;

  GetItemsGraphQlResponse.fromJson(Map<String, dynamic> map) {
    items = [];
    final tagsJson = map['tags'];
    if (tagsJson != null && tagsJson is Map) {
      final itemJson = tagsJson['data'];
      if (itemJson != null && itemJson is List) {
        items!.addAll(
            itemJson.map((e) => ItemGraphQlEntity.fromJson(e)).toList());
      }
    }
  }
}
