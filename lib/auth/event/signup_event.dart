import 'package:flutter_graphql/auth/model/request/signup_request.dart';
import 'package:flutter_graphql/base/base_event.dart';

class SignUpEvent extends BaseEvent<SignUpRequest> {
  SignUpEvent(SignUpRequest data) : super(data: data);
}
