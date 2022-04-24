import 'package:flutter_graphql/base/base_mapper.dart';
import 'package:flutter_graphql/screens/searchable_dropdown/model/item_data.dart';
import 'package:flutter_graphql/screens/searchable_dropdown/model/response/get_items_graphql_response.dart';

import 'item_graphql_entity_mapper.dart';

class ItemsGraphQlResponseMapper
    extends BaseMapper<GetItemsGraphQlResponse, ItemsData> {
  final _itemGraphQlEntityMapper = ItemGraphQlEntityMapper();

  @override
  ItemsData map(GetItemsGraphQlResponse t) {
    return ItemsData(
        items: t.items?.map((e) => _itemGraphQlEntityMapper.map(e)).toList() ??
            []);
  }
}
