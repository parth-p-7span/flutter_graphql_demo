import 'package:flutter_graphql/base/base_ui_state.dart';
import 'package:flutter_graphql/screens/searchable_dropdown/model/item_data.dart';

class GetItemsState extends BaseUiState<ItemsData> {
  GetItemsState.loading() : super.loading();

  GetItemsState.completed(ItemsData data) : super.completed(data: data);

  GetItemsState.error(dynamic error) : super.error(error);
}
