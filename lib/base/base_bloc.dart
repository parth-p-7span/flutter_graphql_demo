import 'package:rxdart/rxdart.dart';

import 'base_event.dart';
import 'base_ui_state.dart';

abstract class BaseBloc {
  final subscriptions = CompositeSubscription();
  final hideKeyboardSubject = PublishSubject<bool>();
  final event = PublishSubject<BaseEvent>();
  final state = PublishSubject<BaseUiState>();

  void hideKeyboard() {
    print('/// hide called');
    hideKeyboardSubject.add(true);
  }

  void dispose() {
    subscriptions.clear();
    hideKeyboardSubject.close();
    event.close();
    state.close();
  }
}
