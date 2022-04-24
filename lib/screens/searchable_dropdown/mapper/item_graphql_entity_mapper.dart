import 'package:flutter_graphql/base/base_mapper.dart';
import 'package:flutter_graphql/screens/searchable_dropdown/model/entity/item_graphql_entity.dart';
import 'package:flutter_graphql/screens/searchable_dropdown/model/item.dart';

class ItemGraphQlEntityMapper extends BaseMapper<ItemGraphQlEntity, Item> {
  @override
  Item map(ItemGraphQlEntity t) {
    return Item(
      id: t.id,
      name: t.name,
      type: t.type,
      status: t.status,
    );
  }
}
