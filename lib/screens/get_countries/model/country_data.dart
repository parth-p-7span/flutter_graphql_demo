import 'package:flutter_graphql/screens/get_countries/model/country.dart';

class CountryData {
  List<Country>? countries;

  CountryData({
    this.countries,
  });

  CountryData copyWith({List<Country>? countries}) {
    return CountryData(
      countries: countries,
    );
  }
}
