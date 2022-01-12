import 'package:flutter_graphql/base/base_bloc.dart';
import 'package:flutter_graphql/screens/get_continent/model/continent.dart';
import 'package:flutter_graphql/screens/get_continent/model/continent_data.dart';
import 'package:flutter_graphql/screens/get_continent/model/request/get_continent_request.dart';
import 'package:flutter_graphql/screens/get_continent/state/continent_ui_state_manager.dart';
import 'package:flutter_graphql/screens/get_continent/state/get_continents_state.dart';
import 'package:rxdart/rxdart.dart';

class ContinentBloc extends BaseBloc {
  final ContinentUiStateManager _continentUiStateManager;
  final getContinentStateStream = BehaviorSubject<GetContinentsState>();
  final continentDataStream = BehaviorSubject<ContinentData?>();
  final List<String> continentsList = [];

  ContinentBloc(this._continentUiStateManager) {
    getContinents();
  }

  void getContinents({GetContinentRequest? request}) {
    subscriptions.add(
        _getContinentsList(request ?? GetContinentRequest()).listen((event) {
      if (event.isCompleted()) {
        _handleData(event.data);
      }
      getContinentStateStream.add(event);
    }));
  }

  void _handleData(ContinentData? newdata) {
    final existingData = continentDataStream.valueOrNull;
    final existingList = existingData?.continents ?? [];
    final newList = newdata?.continents ?? [];
    final all = <Continent>[];
    all.addAll(existingList + newList);
    continentsList.addAll(all.map((e) => e.name.toString()).toList());
    continentDataStream.add(newdata?.copyWith(continents: all));
  }

  Stream<GetContinentsState> _getContinentsList(GetContinentRequest request) {
    return _continentUiStateManager.getContinents(request);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    continentDataStream.close();
  }
}
