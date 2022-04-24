import 'package:flutter_graphql/base/base_bloc.dart';
import 'package:flutter_graphql/screens/get_countries/model/country.dart';
import 'package:flutter_graphql/screens/get_countries/model/country_data.dart';
import 'package:flutter_graphql/screens/get_countries/model/request/get_country_request.dart';
import 'package:flutter_graphql/screens/get_countries/state/country_ui_state_manager.dart';
import 'package:flutter_graphql/screens/get_countries/state/get_countries_state.dart';
import 'package:rxdart/rxdart.dart';

class CountryBloc extends BaseBloc {
  final CountryUiStateManager _countryUiStateManager;
  final getCountryStateStream = BehaviorSubject<GetCountriesState>();
  final countryDataStream = BehaviorSubject<CountryData?>();
  final String? continent;

  CountryBloc(this._countryUiStateManager, this.continent) {
    getCountries(request: GetCountryRequest(continent: continent));
  }

  void getCountries({required GetCountryRequest request}) {
    subscriptions.add(_getCountriesList(request).listen((state) {
      if (state.isCompleted()) {
        _handleData(state.data);
      }
      getCountryStateStream.add(state);
    }));
  }

  void _handleData(CountryData? newData) {
    final existingData = countryDataStream.valueOrNull;
    final existingList = existingData?.countries ?? [];
    final newList = newData?.countries ?? [];
    final all = <Country>[];
    all.addAll(existingList + newList);
    countryDataStream.add(newData?.copyWith(
      countries: all,
    ));
  }

  Stream<GetCountriesState> _getCountriesList(GetCountryRequest request) {
    var temp = _countryUiStateManager.getCountries(request);
    // print(temp.toString());
    return temp;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    getCountryStateStream.close();
    countryDataStream.close();
  }
}
