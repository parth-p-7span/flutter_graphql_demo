import 'package:flutter_graphql/auth/event/login_event.dart';
import 'package:flutter_graphql/auth/model/request/login_request.dart';
import 'package:flutter_graphql/auth/repo/auth_repo.dart';
import 'package:flutter_graphql/auth/state/login_state.dart';
import 'package:flutter_graphql/auth/state/validation_passed_state.dart';
import 'package:flutter_graphql/base/app_exception.dart';
import 'package:flutter_graphql/base/base_bloc.dart';
import 'package:flutter_graphql/base/validation_exception_state.dart';
import 'package:flutter_graphql/helper/validator.dart';
import 'package:flutter_graphql/session/model/request/save_session_request.dart';
import 'package:flutter_graphql/session/model/session.dart';
import 'package:flutter_graphql/session/repo/session_repo.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends BaseBloc {
  /// Holds user entered email
  final email = BehaviorSubject<String>();

  /// Holds user entered password
  final password = BehaviorSubject<String>();

  /// Stream which will notify when email validation error occurs
  final emailError = PublishSubject<bool>();

  /// Stream which will notify when password validation error occurs
  final passwordError = PublishSubject<bool>();

  /// Validator
  final Validator _validator;

  /// Authentication repo
  final AuthRepo _authRepo;

  final SessionRepo _sessionRepo;

  /// Rx-Stream which will notify about login states.
  final loginStateStream = PublishSubject<LoginState>();

  LoginBloc(this._validator, this._authRepo, this._sessionRepo) {
    _observeForEvents();
    _observeForStates();
  }

  /// Handle login click
  void onLoginTapped() async {
    // Create login event
    event.add(LoginEvent(
      LoginRequest(
        email: email.value,
        password: password.value,
      ),
    ));
  }

  /// Converts login process into representable [LoginState]
  Stream<LoginState> _login(LoginRequest request) {
    hideKeyboard();

    return _authRepo.login(request).flatMap((data) {
      return _sessionRepo
          .saveSession(SaveSessionRequest(
              session: Session(token: data.token, user: data.user)))!
          .map((_) => LoginState.completed(data));
    }).onErrorReturnWith((error, dynamic) {
      print("---------------Error : " + error.toString());
      return LoginState.error(error);
    }).startWith(LoginState.loading());
  }

  /// Observe for events
  void _observeForEvents() {
    subscriptions.add(event.listen((event) {
      if (event is LoginEvent) {
        _handleLoginEvent(event);
      }
    }));
  }

  /// Observe for states
  void _observeForStates() {
    subscriptions.add(state.listen((state) {
      if (state is ValidationExceptionState) {
        _handleValidationErrorState(state);
      }
      if (state is LoginState) {
        _handleLoginState(state);
      }

      if (state is ValidationPassedState) {
        // Notify UI that there are no more validation errors
        emailError.add(false);
        passwordError.add(false);
      }
    }));
  }

  /// Handle login event
  void _handleLoginEvent(LoginEvent event) {
    String? email = event.data.email;
    String? password = event.data.password;

    subscriptions.add(Rx.zip(
        [_validator.isValidEmail(email), _validator.isValidPassword(password)],
        (values) {
      final errorMap = Map<String, bool>();

      if (values[0] == false) errorMap['email'] = true;
      if (values[1] == false) errorMap['password'] = true;

      if (errorMap.isNotEmpty) throw ValidationException(error: errorMap);

      return event.data;
    }).flatMap((loginRequest) => _login(loginRequest)).listen((state) {
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
    emailError.add(errors!.containsKey('email'));
    passwordError.add(errors.containsKey('password'));
  }

  /// Handle login state
  void _handleLoginState(LoginState state) {
    // Login API is being called, that means we passed client side
    // validations. Inform UI about this state.
    if (state.isLoading()) {
      this.state.add(ValidationPassedState());
    }
    loginStateStream.add(state);
  }

  @override
  void dispose() {
    super.dispose();
    email.close();
    password.close();
    emailError.close();
    passwordError.close();
    loginStateStream.close();
  }
}
