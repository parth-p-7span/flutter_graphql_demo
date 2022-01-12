import 'package:flutter_graphql/di/app_module.dart';
import 'package:flutter_graphql/graphql/client.dart';
import 'package:flutter_graphql/main_dev.dart';
import 'package:flutter_graphql/screens/get_countries/bloc/country_bloc.dart';
import 'package:flutter_graphql/screens/get_countries/mapper/country_graphql_entity_mapper.dart';
import 'package:flutter_graphql/screens/get_countries/mapper/country_graphql_response_mapper.dart';
import 'package:flutter_graphql/screens/get_countries/repo/country_repo.dart';
import 'package:flutter_graphql/screens/get_countries/source/country_graphql_source.dart';
import 'package:flutter_graphql/screens/get_countries/state/country_ui_state_manager.dart';

class CountryModule {
  static CountryModule _instance = CountryModule._internal();
  AppGraphqlClient appGraphqlClient = AppGraphqlClient(apiEnd);

  CountryModule._internal();

  factory CountryModule() {
    return _instance;
  }

  CountryBloc geCountries(String? continent) {
    return CountryBloc(getCountryUiStateManager(), continent);
  }

  CountryUiStateManager getCountryUiStateManager() {
    return CountryUiStateManager(getCountryRepo());
  }

  CountryRepo getCountryRepo() {
    return CountryRepo(
      getCountryGraphQlSource(),
      CountryGraphQlEntityMapper(),
      CountryGraphQlResponseMapper(),
    );
  }

  CountryGraohqlSource getCountryGraphQlSource() {
    return CountryGraohqlSource(
      appGraphqlClient,
    );
  }
}
