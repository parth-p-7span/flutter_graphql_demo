import 'package:flutter_graphql/base/base_bloc.dart';
import 'package:flutter_graphql/screens/badges/event/search_event.dart';
import 'package:flutter_graphql/screens/searchable_dropdown/model/item.dart';
import 'package:flutter_graphql/screens/searchable_dropdown/model/item_data.dart';
import 'package:flutter_graphql/screens/searchable_dropdown/model/request/get_item_request.dart';
import 'package:flutter_graphql/screens/searchable_dropdown/state/get_items_state.dart';
import 'package:flutter_graphql/screens/searchable_dropdown/state/items_ui_state_manager.dart';
import 'package:rxdart/rxdart.dart';

class ItemsBloc extends BaseBloc {
  final ItemsUiStateManager _itemsUiStateManager;
  final getItemsStateStream = BehaviorSubject<GetItemsState>();
  final itemsDataStream = BehaviorSubject<ItemsData>();

  final searchQueryStream = BehaviorSubject<String>();

  final searchEnableStream = BehaviorSubject<bool>();

  ItemsBloc(this._itemsUiStateManager) {
    getItems(
        request:
            GetItemsRequest(businessId: 131026.toString(), page: 1, limit: 20));
    _observeForEvents();
    _observeForSearchQueryChanges();
  }

  void getItems({required GetItemsRequest request}) {
    subscriptions.add(_getItems(request).listen((state) {
      if (state.isCompleted()) {
        _handleData(state.data);
      }
      getItemsStateStream.add(state);
    }));
  }

  Stream<GetItemsState> _getItems(GetItemsRequest request) {
    return _itemsUiStateManager.getItems(request);
  }

  void _observeForSearchQueryChanges() {
    subscriptions.add(searchQueryStream.listen((query) {
      event.add(SearchEvent(query.trim()));
    }));
  }

  void _handleData(ItemsData? newData) {
    final existingData = itemsDataStream.valueOrNull;
    final existingList = existingData?.items ?? [];
    final newList = newData?.items ?? [];

    final all = <Item>[];
    all.addAll(existingList + newList);

    itemsDataStream.add(newData!.copyWith(
      items: all,
    ));
  }

  void _observeForEvents() {
    subscriptions.add(event.listen((event) {
      if (event is SearchEvent) _handleSearchEvent(event);
    }));
  }

  void _handleSearchEvent(SearchEvent event) {
    var currentData = itemsDataStream.value;
    getItems(
        request: GetItemsRequest(
      businessId: 131026.toString(),
      page: 1,
      search: event.data,
    ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    getItemsStateStream.close();
    itemsDataStream.close();
    searchQueryStream.close();
    searchEnableStream.close();
  }
}
