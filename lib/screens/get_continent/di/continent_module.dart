import 'package:flutter_graphql/graphql/client.dart';
import 'package:flutter_graphql/main_dev.dart';
import 'package:flutter_graphql/screens/get_continent/bloc/continent_bloc.dart';
import 'package:flutter_graphql/screens/get_continent/mapper/continent_graphql_entity_mapper.dart';
import 'package:flutter_graphql/screens/get_continent/mapper/continent_graphql_response_mapper.dart';
import 'package:flutter_graphql/screens/get_continent/repo/continent_repo.dart';
import 'package:flutter_graphql/screens/get_continent/source/continent_graphql_source.dart';
import 'package:flutter_graphql/screens/get_continent/state/continent_ui_state_manager.dart';

class ContinentModule {
  static ContinentModule _instance = ContinentModule._internal();
  AppGraphqlClient appGraphqlClient = AppGraphqlClient(apiEnd);

  ContinentModule._internal();

  factory ContinentModule() {
    return _instance;
  }

  ContinentBloc getContinents() {
    return ContinentBloc(getContinentUiStateManager());
  }

  ContinentUiStateManager getContinentUiStateManager() {
    return ContinentUiStateManager(continentRepo: getContinentRepo());
  }

  ContinentRepo getContinentRepo() {
    return ContinentRepo(getContinentGraphqlSource(), ContinentEntityMapper(),
        ContinentResponseMapper());
  }

  ContinentGraphqlSource getContinentGraphqlSource() {
    return ContinentGraphqlSource(appGraphqlClient);
  }
}
