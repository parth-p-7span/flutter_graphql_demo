import 'package:flutter/material.dart';
import 'package:flutter_graphql/auth/bloc/signup_bloc.dart';
import 'package:flutter_graphql/auth/di/auth_module.dart';
import 'package:flutter_graphql/auth/state/sign_up_state.dart';
import 'package:flutter_graphql/auth/ui/login_page.dart';
import 'package:flutter_graphql/base/base_bloc.dart';
import 'package:flutter_graphql/base/base_state.dart';
import 'package:flutter_graphql/screens/get_continent/ui/continent_page.dart';
import 'package:flutter_graphql/theme_data.dart';
import 'package:flutter_graphql/utils/app_utils.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends BaseState<SignupPage> {
  late SignupBloc _signupBloc;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _signupBloc = AuthModule().getSignUpBloc();
    _observeForSignupStates();
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
            children: [
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    Center(
                      child: Text(
                        "Sign Up",
                        style: titleStyle,
                      ),
                    ),

                    ///name
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 20),
                      child: Container(
                        child: Text(
                          "Name",
                          style: subTitleStyle,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15, right: 15, top: 8),
                      child: Container(
                        height: 30,
                        child: TextField(
                          onChanged: (text) {
                            _signupBloc.name.add(text.trim());
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
                      child: Container(
                        child: Text(
                          "Email",
                          style: subTitleStyle,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15, right: 15, top: 8),
                      child: Container(
                        height: 30,
                        child: TextField(
                          onChanged: (text) {
                            _signupBloc.email.add(text.trim());
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
                      padding:
                          const EdgeInsets.only(left: 15, right: 15, top: 8),
                      child: Container(
                        height: 30,
                        child: TextField(
                          onChanged: (text) {
                            _signupBloc.password.add(text.trim());
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
                    StreamBuilder<SignUpState>(
                      stream: _signupBloc.signUpStateStream,
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
                          child: Container(
                            height: 30,
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () {
                                  _signupBloc.onSignUpTapped();
                                },
                                child: Text("Sign Up"),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      MyTheme.appbarTitleColor),
                                )),
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15, left: 15),
                      child: Container(
                        width: double.infinity,
                        height: 30,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          },
                          child: Text("Login"),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                MyTheme.appbarTitleColor),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  @override
  BaseBloc getBaseBloc() {
    return _signupBloc;
  }

  void _observeForSignupStates() {
    subscriptions.add(_signupBloc.signUpStateStream.listen((state) {
      print('/// state is: $state');
      if (state.isError()) {
        print("Error State!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        AppUtils.showSnackBar(
          state.error?.toString() ?? 'Something went wrong, please try again!',
          _scaffoldKey,
          isError: true,
        );
      }
      if (state.isCompleted()) {
        navigateRemoveUntil(ContinentPage());
      }
    }));
  }
}
