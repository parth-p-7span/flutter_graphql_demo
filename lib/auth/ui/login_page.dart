import 'package:flutter/material.dart';
import 'package:flutter_graphql/auth/bloc/login_bloc.dart';
import 'package:flutter_graphql/auth/di/auth_module.dart';
import 'package:flutter_graphql/auth/state/login_state.dart';
import 'package:flutter_graphql/auth/ui/signup_page.dart';
import 'package:flutter_graphql/base/base_bloc.dart';
import 'package:flutter_graphql/screens/get_continent/ui/continent_page.dart';
import 'package:flutter_graphql/base/base_state.dart';
import 'package:flutter_graphql/utils/app_utils.dart';
import '../../theme_data.dart';
import 'package:rxdart/rxdart.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends BaseState<LoginPage> {
  late LoginBloc _loginBloc;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _loginBloc = AuthModule().getLoginBloc();
    _observeForLoginStates();
  }

  final titleStyle = TextStyle(
    color: MyTheme.appbarTitleColor,
    fontSize: 24,
  );

  final subTitleStyle = TextStyle(
    fontSize: 13,
    color: Colors.black54,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Container(
          color: MyTheme.listTileColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 100,
              ),
              Center(
                child: Text(
                  "Login",
                  style: titleStyle,
                ),
              ),

              ///email
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: Container(
                  child: Text(
                    "Email",
                    style: subTitleStyle,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 8),
                child: Container(
                  height: 30,
                  child: TextField(
                    onChanged: (text) {
                      _loginBloc.email.add(text.trim() ?? '');
                    },
                    style: TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.only(top: 5, bottom: 5, left: 10),
                      filled: true,
                      fillColor: MyTheme.dropDownColor,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: BorderSide.none),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: Text(
                  "Password",
                  style: subTitleStyle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 8),
                child: Container(
                  height: 30,
                  child: TextField(
                    onChanged: (text) {
                      _loginBloc.password.add(text.trim() ?? '');
                    },
                    obscureText: true,
                    style: TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.only(top: 5, bottom: 5, left: 10),
                      filled: true,
                      fillColor: MyTheme.dropDownColor,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: BorderSide.none),
                    ),
                  ),
                ),
              ),
              StreamBuilder<LoginState>(
                stream: _loginBloc.loginStateStream,
                builder: (context, snapshot) {
                  final stateData = snapshot.data;
                  if (stateData?.isLoading() ?? false) {
                    print("state is loading");
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.all(15),
                    child: InkWell(
                      onTap: () {
                        _loginBloc.onLoginTapped();
                      },
                      child: Container(
                        height: 30,
                        width: double.infinity,
                        child: Center(
                            child: Text(
                          "Login",
                          style: TextStyle(color: Colors.white),
                        )),
                        decoration: BoxDecoration(
                          color: MyTheme.appbarTitleColor,
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                    ),
                  );
                },
              ),

              Padding(
                padding: const EdgeInsets.all(15),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignupPage()));
                  },
                  child: Container(
                    height: 30,
                    width: double.infinity,
                    child: Center(
                        child: Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.white),
                    )),
                    decoration: BoxDecoration(
                      color: MyTheme.appbarTitleColor,
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  BaseBloc getBaseBloc() {
    return _loginBloc;
  }

  void _observeForLoginStates() {
    subscriptions.add(_loginBloc.loginStateStream.listen((state) {
      print('/// state is: $state');
      if (state.isError()) {
        print("Error State!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        // AppUtils.showSnackBar(
        //   state.error?.toString() ?? 'Something went wrong, please try again!',
        //   _scaffoldKey,
        //   isError: true,
        // );
      } else if (state.isCompleted()) {
        // navigateRemoveUntil(ContinentPage());
      }
    }));
  }
}