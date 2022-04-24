import 'package:flutter_graphql/graphql/app_graphql_client_close.dart';
import 'package:flutter_graphql/main_dev.dart';
import 'package:flutter_graphql/screens/searchable_dropdown/bloc/items_bloc.dart';
import 'package:flutter_graphql/screens/searchable_dropdown/mapper/items_graphql_response_mapper.dart';
import 'package:flutter_graphql/screens/searchable_dropdown/repo/item_repo.dart';
import 'package:flutter_graphql/screens/searchable_dropdown/source/items_graphql_source.dart';
import 'package:flutter_graphql/screens/searchable_dropdown/state/items_ui_state_manager.dart';

class ItemModule {
  static ItemModule _instance = ItemModule._internal();
  AppGraphqlClientClose appGraphqlClientClose =
      AppGraphqlClientClose(apiVepaar);

  ItemModule._internal();

  factory ItemModule() {
    return _instance;
  }

  ItemsBloc getItemsBloc() {
    return ItemsBloc(
      getItemsUiStateManager(),
    );
  }

  ItemsUiStateManager getItemsUiStateManager() {
    return ItemsUiStateManager(getItemsRepo());
  }

  ItemsRepo getItemsRepo() {
    return ItemsRepo(
      _getItemsGraphQlSource(),
      ItemsGraphQlResponseMapper(),
    );
  }

  ItemsGraphQlSource _getItemsGraphQlSource() {
    return ItemsGraphQlSource(appGraphqlClientClose);
  }
}
