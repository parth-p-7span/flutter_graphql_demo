import 'package:flutter/material.dart';

class SignUpRequest {
  String? name;
  String? email;
  String? password;

  SignUpRequest({
    @required this.name,
    @required this.email,
    @required this.password,
  });

  Map<String, dynamic> toJSON() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'configure_campaign': 1,
      'return_token': 1,
    };
  }
}
