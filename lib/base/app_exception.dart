import 'package:flutter/material.dart';

class AppException implements Exception {
  String? message;

  AppException({
    this.message,
  });

  @override
  String toString() {
    return 'Error: $message';
  }
}

class ValidationException extends AppException {
  Map<String, bool>? error;

  ValidationException({
    @required this.error,
  });
}
