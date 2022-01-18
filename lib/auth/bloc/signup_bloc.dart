import 'package:flutter_graphql/auth/event/signup_event.dart';
import 'package:flutter_graphql/auth/model/auth_data.dart';
import 'package:flutter_graphql/auth/model/request/signup_request.dart';
import 'package:flutter_graphql/auth/repo/auth_repo.dart';
import 'package:flutter_graphql/auth/state/sign_up_state.dart';
import 'package:flutter_graphql/auth/state/validation_passed_state.dart';
import 'package:flutter_graphql/base/app_exception.dart';
import 'package:flutter_graphql/base/base_bloc.dart';
import 'package:flutter_graphql/base/validation_exception_state.dart';
import 'package:flutter_graphql/helper/validator.dart';
import 'package:flutter_graphql/session/model/request/save_session_request.dart';
import 'package:flutter_graphql/session/model/session.dart';
import 'package:flutter_graphql/session/repo/session_repo.dart';
import 'package:rxdart/rxdart.dart';

class SignupBloc extends BaseBloc {
  /// Holds user entered name
  final name = BehaviorSubject<String>();

  /// Holds user entered email
  final email = BehaviorSubject<String>();

  /// Holds user entered password
  final password = BehaviorSubject<String>();

  /// Stream which will notify when name validation error occurs
  final nameError = PublishSubject<bool?>();

  /// Stream which will notify when email validation error occurs
  final emailError = PublishSubject<bool>();

  /// Stream which will notify when password validation error occurs
  final passwordError = PublishSubject<bool>();

  /// Validator
  final Validator _validator;

  /// Authentication repo
  final AuthRepo _authRepo;

  final SessionRepo _sessionRepo;

  /// Rx-Stream which will notify about sign up states.
  final signUpStateStream = PublishSubject<SignUpState>();

  SignupBloc(this._validator, this._authRepo, this._sessionRepo) {
    _observeForEvents();
    _observeForStates();
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

  Stream<SignUpState> _signUp(SignUpRequest request) {
    hideKeyboard();

    return _authRepo
        .signUp(request)
        .flatMap((data) {
          return _sessionRepo
              .saveSession(
                  SaveSessionRequest(session: Session(token: data.token)))!
              .map((_) => SignUpState.completed(data));
        })
        .onErrorReturnWith((error, dynamic) => SignUpState.error(error))
        .startWith(SignUpState.loading());
  }

  /// Observe for events
  void _observeForEvents() {
    subscriptions.add(event.listen((event) {
      if (event is SignUpEvent) {
        _handleSignUpEvent(event);
      }
    }));
  }

  /// Observe for states
  void _observeForStates() {
    subscriptions.add(state.listen((state) {
      if (state is ValidationExceptionState) {
        _handleValidationErrorState(state);
      }
      if (state is SignUpState) {
        _handleSignUpState(state);
      }

      if (state is ValidationPassedState) {
        // Notify UI that there are no more validation errors
        nameError.add(false);
        emailError.add(false);
        passwordError.add(false);
      }
    }));
  }

  /// Handle sign up event
  void _handleSignUpEvent(SignUpEvent event) {
    String? name = event.data.name;
    String? email = event.data.email;
    String? password = event.data.password;

    subscriptions.add(Rx.zip([
      _validator.isValidName(name),
      _validator.isValidEmail(email),
      _validator.isValidPassword(password),
    ], (values) {
      final errorMap = Map<String, bool>();

      if (values[0] == false) errorMap['name'] = true;
      if (values[1] == false) errorMap['email'] = true;
      if (values[2] == false) errorMap['password'] = true;

      if (errorMap.isNotEmpty) throw ValidationException(error: errorMap);

      return event.data;
    }).flatMap((signUpRequest) => _signUp(signUpRequest)).listen((state) {
      this.state.add(state);
    }, onError: (e) {
      if (e is ValidationException) {
        // Notify about validation exception state
        state.add(ValidationExceptionState(e.error));
      }
    }));
  }

  /// Handle validation exception state
  void _handleValidationErrorState(ValidationExceptionState state) {
    final errors = state.data;
    nameError.add(errors!.containsKey('name'));
    emailError.add(errors.containsKey('email'));
    passwordError.add(errors.containsKey('password'));
  }

  /// Handle sign up state
  void _handleSignUpState(SignUpState state) {
    // SignUp API is being called, that means we passed client side
    // validations. Inform UI about this state.
    if (state.isLoading()) {
      this.state.add(ValidationPassedState());
    }
    signUpStateStream.add(state);
  }

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
