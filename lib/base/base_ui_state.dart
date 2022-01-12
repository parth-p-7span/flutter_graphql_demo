class BaseUiState<T> {
  dynamic error;
  T? data;
  UiState? _state;

  BaseUiState();

  BaseUiState.loading() : this._state = UiState.loading;
  BaseUiState.completed({this.data}) : this._state = UiState.completed;
  BaseUiState.error() : this._state = UiState.error;

  bool isLoading() => this._state == UiState.loading;
  bool isCompleted() => this._state == UiState.completed;
  bool isError() => this._state == UiState.error;

  @override
  String toString() {
    return 'State is $_state';
  }
}

enum UiState {
  loading,
  completed,
  error,
}
