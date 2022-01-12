import 'package:flutter_graphql/screens/get_continent/model/continent.dart';

class ContinentData {
  List<Continent>? continents;

  ContinentData({this.continents});

  ContinentData copyWith({List<Continent>? continents}) {
    return ContinentData(continents: continents);
  }
}
