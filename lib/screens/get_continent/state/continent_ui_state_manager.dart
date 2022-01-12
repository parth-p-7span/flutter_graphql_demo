import 'package:flutter_graphql/screens/get_continent/model/request/get_continent_request.dart';
import 'package:flutter_graphql/screens/get_continent/repo/continent_repo.dart';
import 'package:flutter_graphql/screens/get_continent/state/get_continents_state.dart';
import 'package:rxdart/rxdart.dart';

class ContinentUiStateManager {
  final ContinentRepo continentRepo;

  ContinentUiStateManager({
    required this.continentRepo,
  });

  Stream<GetContinentsState> getContinents(GetContinentRequest request) {
    return continentRepo
        .getContinents(request)
        .map((data) {
          return GetContinentsState.completed(data);
        })
        .onErrorReturnWith((error, dynamic) => GetContinentsState.error(error))
        .startWith(GetContinentsState.loading());
  }
}
