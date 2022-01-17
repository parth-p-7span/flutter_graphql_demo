import 'base_ui_state.dart';

class ValidationExceptionState extends BaseUiState<Map<String, bool>> {
  ValidationExceptionState(Map<String, bool>? error)
      : super.completed(data: error);
}
