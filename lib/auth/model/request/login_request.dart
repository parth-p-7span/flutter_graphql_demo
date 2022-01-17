import 'package:flutter/material.dart';

class LoginRequest {
  String? email;
  String? password;

  LoginRequest({@required this.email, @required this.password});

  Map<String, dynamic> toJSON() {
    return {
      'email': email,
      'password': password,
    };
  }
}
