import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Convenient wrapper on the [SharedPreferences] which
/// exposes methods returning [Stream] instead of [Future]
class SharedPreferenceManager {
  /// Controls if the logs should be printed.
  static const _DEBUG = true;

  Future<SharedPreferences> _sharedPreferences =
      SharedPreferences.getInstance();

  Future<String> getStringFuture(String key) {
    return _sharedPreferences.then((preference) => preference.getString(key));
  }

  void removeKey(String key) {
    _sharedPreferences.then((preference) => preference.remove(key));
  }

  /// Get [String] from the [SharedPreferences]
  Stream<String> getString(String key) {
    return _getSharedPreference()
        .map((preference) => preference.getString(key));
  }

  /// Set [String] to the [SharedPreferences]
  Stream<bool>? setString(String key, String? value) {
    if (_DEBUG) print('Writing key: $key value: $value');
    return _getSharedPreference().flatMap(
        (preference) => _convertToRx(preference.setString(key, value)));
  }

  /// Get [int] from the [SharedPreferences]
  Stream<int> getInt(String key) {
    return _getSharedPreference().map((preference) => preference.getInt(key));
  }

  /// Set [int] to the [SharedPreferences]
  Stream<bool> setInt(String key, int value) {
    return _getSharedPreference()
        .flatMap((preference) => _convertToRx(preference.setInt(key, value)));
  }

  /// Get [double] from the [SharedPreferences]
  Stream<double> getDouble(String key) {
    return _getSharedPreference()
        .map((preference) => preference.getDouble(key));
  }

  /// Set [double] to the [SharedPreferences]
  Stream<bool> setDouble(String key, double value) {
    return _getSharedPreference().flatMap(
        (preference) => _convertToRx(preference.setDouble(key, value)));
  }

  /// Get [bool] from the [SharedPreferences]
  Stream<bool> getBool(String key) {
    return _getSharedPreference().map((preference) => preference.getBool(key));
  }

  /// Set [bool] to the [SharedPreferences]
  Stream<bool> setBool(String key, bool value) {
    return _getSharedPreference()
        .flatMap((preference) => _convertToRx(preference.setBool(key, value)));
  }

  Stream<SharedPreferences> _getSharedPreference() {
    return _convertToRx(_sharedPreferences);
  }

  Stream<T> _convertToRx<T>(Future<T> future) {
    return future.asStream();
  }
}
