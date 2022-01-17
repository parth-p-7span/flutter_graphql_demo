import 'package:flutter_graphql/auth/model/request/login_request.dart';
import 'package:flutter_graphql/base/base_event.dart';

class LoginEvent extends BaseEvent<LoginRequest> {
  LoginEvent(LoginRequest data) : super(data: data);
}
