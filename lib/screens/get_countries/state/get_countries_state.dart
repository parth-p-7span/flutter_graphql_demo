import 'package:flutter_graphql/base/base_ui_state.dart';
import 'package:flutter_graphql/screens/get_countries/model/country_data.dart';

class GetCountriesState extends BaseUiState<CountryData> {
  GetCountriesState.loading() : super.loading();

  GetCountriesState.completed(CountryData data) : super.completed(data: data);

  GetCountriesState.error(dynamic error) : super.error();
}
