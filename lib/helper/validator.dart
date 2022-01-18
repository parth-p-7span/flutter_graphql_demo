import 'email_validator.dart';

class Validator {
  Stream<bool> isValidEmail(String? email) {
    return Stream.value(email != null && EmailValidator.validate(email));
  }

  Stream<bool> isValidPassword(String? password) {
    return Stream.value((password?.trim().length ?? 0) > 3);
  }

  Stream<bool> isValidName(String? firstName) {
    return Stream.value((firstName?.trim().isNotEmpty ?? false));
  }

  Stream<bool> isValidMobile(String mobile) {
    return Stream.value((mobile.trim().length) > 4);
  }

  Stream<bool> isValidPassCode(String passCode) {
    return Stream.value((passCode.trim().length) > 3);
  }

  Stream<bool> isValidDoubleValue(double value) {
    return Stream.value((value > 0));
  }

  Stream<bool> isValidValue(double value) {
    return Stream.value((value != null));
  }

  Stream<bool> isValidIntValue(int value) {
    return Stream.value((value != null));
  }
}
