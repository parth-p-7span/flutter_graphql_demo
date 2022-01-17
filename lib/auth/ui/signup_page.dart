import 'package:flutter/material.dart';
import 'package:flutter_graphql/auth/bloc/signup_bloc.dart';
import 'package:flutter_graphql/auth/di/auth_module.dart';
import 'package:flutter_graphql/auth/state/sign_up_state.dart';
import 'package:flutter_graphql/auth/ui/login_page.dart';
import 'package:flutter_graphql/screens/get_continent/ui/continent_page.dart';
import 'package:flutter_graphql/theme_data.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  late SignupBloc _signupBloc;

  @override
  void initState() {
    super.initState();
    _signupBloc = AuthModule().getSignUpBloc();
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
                padding: const EdgeInsets.only(left: 15, right: 15, top: 8),
                child: Container(
                  height: 30,
                  child: TextField(
                    onChanged: (text) {
                      _signupBloc.name.add(text.trim() ?? '');
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
                padding: const EdgeInsets.only(left: 15, right: 15, top: 8),
                child: Container(
                  height: 30,
                  child: TextField(
                    onChanged: (text) {
                      _signupBloc.email.add(text.trim() ?? '');
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
                      _signupBloc.password.add(text.trim() ?? '');
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
                    child: InkWell(
                      onTap: () {
                        _signupBloc.onSignUpTapped();
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
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
