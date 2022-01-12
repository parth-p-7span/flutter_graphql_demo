import 'package:flutter_graphql/screens/get_countries/model/request/get_country_request.dart';
import 'package:flutter_graphql/screens/get_countries/repo/country_repo.dart';
import 'package:flutter_graphql/screens/get_countries/state/get_countries_state.dart';
import 'package:rxdart/rxdart.dart';

class CountryUiStateManager {
  final CountryRepo _countryRepo;
  CountryUiStateManager(
    this._countryRepo,
  );

  Stream<GetCountriesState> getCountries(GetCountryRequest request) {
    return _countryRepo
        .getCountries(request)
        .map((data) {
          return GetCountriesState.completed(
            data,
          );
        })
        .onErrorReturnWith((error, dynamic) => GetCountriesState.error(
              error,
            ))
        .startWith(GetCountriesState.loading());
  }
}
