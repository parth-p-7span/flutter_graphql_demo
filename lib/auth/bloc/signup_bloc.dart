import 'package:flutter_graphql/auth/event/signup_event.dart';
import 'package:flutter_graphql/auth/model/request/signup_request.dart';
import 'package:flutter_graphql/auth/repo/auth_repo.dart';
import 'package:flutter_graphql/auth/state/sign_up_state.dart';
import 'package:flutter_graphql/base/base_bloc.dart';
import 'package:flutter_graphql/helper/validator.dart';
import 'package:rxdart/rxdart.dart';

class SignupBloc extends BaseBloc {
  /// Holds user entered name
  final name = BehaviorSubject<String>();

  /// Holds user entered email
  final email = BehaviorSubject<String>();

  /// Holds user entered password
  final password = BehaviorSubject<String>();

  /// Stream which will notify when name validation error occurs
  final nameError = PublishSubject<bool>();

  /// Stream which will notify when email validation error occurs
  final emailError = PublishSubject<bool>();

  /// Stream which will notify when password validation error occurs
  final passwordError = PublishSubject<bool>();

  /// Validator
  final Validator _validator;

  /// Authentication repo
  final AuthRepo _authRepo;

  /// Rx-Stream which will notify about sign up states.
  final signUpStateStream = PublishSubject<SignUpState>();

  SignupBloc(
    this._validator,
    this._authRepo,
  ) {
    // _observeForEvents();
    // _observeForStates();
  }

  /// Handle sign up click
  void onSignUpTapped() async {
    // Create sign up event
    event.add(SignUpEvent(
      SignUpRequest(
        name: name.value,
        email: email.value,
        password: password.value,
      ),
    ));
  }

  // Stream<SignUpState> _signUp(SignUpRequest request) {
  //   hideKeyboard();
  //
  //   return _authRepo
  //       .signUp(request)
  //       .flatMap((value) => SignUpState.completed(value))
  //       .onErrorReturnWith((error, dynamic) => SignUpState.error(error))
  //       .startWith(SignUpState.loading());
  // }

  @override
  void dispose() {
    super.dispose();
    name.close();
    email.close();
    password.close();
    nameError.close();
    emailError.close();
    passwordError.close();
    signUpStateStream.close();
  }
}
