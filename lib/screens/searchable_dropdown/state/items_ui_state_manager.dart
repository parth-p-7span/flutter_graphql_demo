import 'package:flutter_graphql/screens/searchable_dropdown/model/request/get_item_request.dart';
import 'package:flutter_graphql/screens/searchable_dropdown/repo/item_repo.dart';
import 'package:rxdart/rxdart.dart';

import 'get_items_state.dart';

class ItemsUiStateManager {
  final ItemsRepo _itemsRepo;

  ItemsUiStateManager(this._itemsRepo);

  Stream<GetItemsState> getItems(GetItemsRequest request) {
    return _itemsRepo
        .getItems(request)
        .map((data) => GetItemsState.completed(data))
        .onErrorReturnWith((error, dynamic) => GetItemsState.error(
              error,
            ))
        .startWith(GetItemsState.loading());
  }
}
