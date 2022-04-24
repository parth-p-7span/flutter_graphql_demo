import 'package:flutter_graphql/screens/searchable_dropdown/mapper/items_graphql_response_mapper.dart';
import 'package:flutter_graphql/screens/searchable_dropdown/model/item_data.dart';
import 'package:flutter_graphql/screens/searchable_dropdown/model/request/get_item_request.dart';
import 'package:flutter_graphql/screens/searchable_dropdown/source/items_graphql_source.dart';

class ItemsRepo {
  final ItemsGraphQlSource _itemsGraphQlSource;

  /// Mappers
  final ItemsGraphQlResponseMapper _itemsGraphQlResponseMapper;

  ItemsRepo(
    this._itemsGraphQlSource,
    this._itemsGraphQlResponseMapper,
  );

  /// Get all tags
  Stream<ItemsData> getItems(GetItemsRequest request) {
    return _itemsGraphQlSource
        .getItems(request)
        .map((data) => _itemsGraphQlResponseMapper.map(data));
  }
}
