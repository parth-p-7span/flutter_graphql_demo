import 'package:rxdart/rxdart.dart';

// ignore_for_file: close_sinks
class SessionExpirationHelper {
  static final _instance = SessionExpirationHelper._internal();

  SessionExpirationHelper._internal();

  factory SessionExpirationHelper() {
    return _instance;
  }

  /// Rx-Stream which notifies whenever user session is expired.
  final sessionExpirationStream = PublishSubject<bool>();
}
